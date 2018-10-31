unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, AdvEdit, AdvEdBtn,
  AdvFileNameEdit, ComObj, MSXML, AdvDirectoryEdit, Xml.xmldom, Xml.XMLDoc,
  Xml.XMLIntf, AdvMemo, Advmxml, Vcl.Clipbrd, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Datasnap.DBClient, Vcl.Mask, DBCtrlsEh, Vcl.DBCtrls, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, IdIOHandler,
  IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL, MSHTML,
  Winapi.ActiveX, Vcl.OleCtrls, SHDocVw, Vcl.ExtCtrls, Winapi.WinInet, IdURI;

type
  TForm1 = class(TForm)
    edtA: TAdvFileNameEdit;
    edtB: TAdvFileNameEdit;
    Button1: TButton;
    Button2: TButton;
    AdvDirectoryEdit1: TAdvDirectoryEdit;
    Label1: TLabel;
    XMLDocument1: TXMLDocument;
    Button3: TButton;
    Button4: TButton;
    DBGrid1: TDBGrid;
    cdsTranslate: TClientDataSet;
    DSTranslate: TDataSource;
    edtPesquisaTag: TAdvEdit;
    edtPesquisaTexto: TAdvEdit;
    cdsTranslatetagorig: TStringField;
    cdsTranslatevalororig: TStringField;
    DBMemo1: TDBMemo;
    IdHTTP1: TIdHTTP;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    Memo1: TMemo;
    WebBrowser1: TWebBrowser;
    DBNavigator1: TDBNavigator;
    Button5: TButton;
    OpenDialog1: TOpenDialog;
    Button6: TButton;
    procedure edtAChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button4Click(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure edtPesquisaTagChange(Sender: TObject);
    procedure edtPesquisaTextoChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
  private
    wListaOrig, wListaPT, wListaDiff, wListaFinal : TStringList ;
    procedure ListValues(const FileName: string; Strings: TStrings; flag : Integer = 0);
    procedure RemoverDuplicados;
    procedure CompareStringLists(List1, List2: TStringList; Missing1:TStrings);
    procedure ListFinalValues(const FileName: string; Strings: TStrings);
    function TranslateViaGoogle(textToTranslate: string): string;
    function GetElementById(const Doc: IDispatch; const Id: string): IDispatch;
    function MD5(const fileName: string): string;
    function TranslateViaMS(textToTranslate: string): string;
    { Private declarations }
  public
    { Public declarations }
    procedure WinInet_HttpGet(const Url: string; Stream: TStream); overload;
    function WinInet_HttpGet(const Url: string): string; overload;
  end;

var
  Form1: TForm1;
  const VALUES_DEFAUL = 'values';
  const VALUES_PTBR = 'values-pt-rBR';
  const RESOURCE_NAME = 'strings.xml';
  const URL_YANDEX_TRANSLATE = 'https://translate.yandex.net/api/v1.5/tr/translate?key=';
  const URL_GOOGLE_TRANSLATE = 'http://translate.google.com.br/'+
                               'translate_t?&ie=UTF8&text=%s&langpair=%s';
  const CHAVE_API = '9f04fb1daa2644869bf19e5ccac4243e';

implementation

uses
  Winapi.ShellAPI, Web.HTTPApp, System.StrUtils, ACBrUtil, IdHashMessageDigest, idHash;

{$R *.dfm}

procedure TForm1.WinInet_HttpGet(const Url: string;Stream:TStream);
const
BuffSize = 1024*1024;
var
  hInter   : HINTERNET;
  UrlHandle: HINTERNET;
  BytesRead: DWORD;
  Buffer   : Pointer;
begin
  hInter := InternetOpen('', INTERNET_OPEN_TYPE_PRECONFIG, nil, nil, 0);
  if Assigned(hInter) then
    try
      Stream.Seek(0,0);
      GetMem(Buffer,BuffSize);
      try
          UrlHandle := InternetOpenUrl(hInter, PChar(Url), nil, 0, INTERNET_FLAG_RELOAD, 0);
          if Assigned(UrlHandle) then
          begin
            repeat
              InternetReadFile(UrlHandle, Buffer, BuffSize, BytesRead);
              if BytesRead>0 then
               Stream.WriteBuffer(Buffer^,BytesRead);
            until BytesRead = 0;
            InternetCloseHandle(UrlHandle);
          end;
      finally
        FreeMem(Buffer);
      end;
    finally
     InternetCloseHandle(hInter);
    end;
end;

function TForm1.WinInet_HttpGet(const Url: string): string;
Var
  StringStream : TStringStream;
begin
  Result:='';
    StringStream:=TStringStream.Create('',TEncoding.UTF8);
    try
        WinInet_HttpGet(Url,StringStream);
        if StringStream.Size>0 then
        begin
          StringStream.Seek(0,0);
          Result:=StringStream.ReadString(StringStream.Size);
        end;
    finally
      StringStream.Free;
    end;
end;

function TForm1.TranslateViaMS(textToTranslate: string):string;
const
  MicrosoftTranslatorTranslateUri = 'http://api.microsofttranslator.com/v2/'+
          'Http.svc/Translate?appId=%s&text=%s&from=%s&to=%s';
var
   XmlDoc : OleVariant;
   Node   : OleVariant;
begin
 //Make the http request


 Result:=WinInet_HttpGet(Format(MicrosoftTranslatorTranslateUri,
                     ['Gilmar', textToTranslate ,'en', 'pt' ]));
 //Create  a XML object o parse the result
  XmlDoc:= CreateOleObject('Msxml2.DOMDocument.6.0');
  try
    XmlDoc.Async := False;
    //load the XML retuned string
    XmlDoc.LoadXML(Result);
    if (XmlDoc.parseError.errorCode <> 0) then
     raise Exception.CreateFmt('Error in Xml Data %s',[XmlDoc.parseError]);
    Node:= XmlDoc.documentElement;
    if not VarIsClear(Node) then
     Result:=XmlDoc.Text;
  finally
     XmlDoc:=Unassigned;
  end;
end;

function TForm1.MD5(const fileName : string) : string;
var
  IdMD5: TIdHashMessageDigest5;
  FS: TFileStream;
begin
  IdMD5 := nil;
  FS := nil;
  try
    IdMD5 := TIdHashMessageDigest5.Create;
    FS := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
    Result := IdMD5.HashStreamAsHex(FS)
  finally
    FS.Free;
    IdMD5.Free;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  cdsTranslate.EmptyDataSet;
  cdsTranslate.Close;
  if FileExists( ExtractFilePath(Application.ExeName) + 'TRADUZIR.XML' ) then
    DeleteFile( ExtractFilePath(Application.ExeName) + 'TRADUZIR.XML' );

  cdsTranslate.CreateDataSet;
  cdsTranslate.Open;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  FilePathName, FilePathName1 : string;
  I: Integer;

begin
  cdsTranslate.EmptyDataSet;
  wListaOrig.Clear;
  wListaPT.Clear;
  wListaDiff.Clear;

  FilePathName := IncludeTrailingPathDelimiter(AdvDirectoryEdit1.Text)+
                 'res\' + VALUES_DEFAUL + '\' + RESOURCE_NAME;

  if FileExists(FilePathName) then
    ListValues(FilePathName, wListaOrig);

  FilePathName1 := IncludeTrailingPathDelimiter(AdvDirectoryEdit1.Text)+
                 'res\' + VALUES_PTBR + '\' + RESOURCE_NAME;
  if FileExists(FilePathName1) then
    ListValues(FilePathName1, wListaPT, 1);

 // RemoverDuplicados();

  wListaOrig.Sort;
  wListaPT.Sort;

  wListaOrig.SaveToFile( ExtractFilePath(Application.ExeName)+ 'original.txt');
  wListaPT.SaveToFile( ExtractFilePath(Application.ExeName)+ 'traducao.txt');

  Label1.Caption := 'original: ' + (wListaOrig.Count -1 ).ToString + '  ' +
  'traducao: ' + (wListaPT.Count -1 ).ToString ;

  wListaOrig.Duplicates := dupIgnore;
  wListaPT.Duplicates := dupIgnore;
  CompareStringLists(wListaOrig, wListaPT, wListaDiff);
  wListaDiff.Duplicates := dupIgnore;
  try
    cdsTranslate.DisableControls;
    ListFinalValues(FilePathName, wListaDiff);
  finally
    cdsTranslate.EnableControls;
    DBGrid1.Width := DBGrid1.Width + 1;
    DBGrid1.Width := DBGrid1.Width - 1;
    Application.ProcessMessages;
  end;



end;

procedure TForm1.Button3Click(Sender: TObject);
var
  texto : string;
  bookmark : TBookmark;
begin

  if Application.MessageBox('selecionados', 'pergunta', MB_YESNO + MB_ICONQUESTION) = IDNO then
  begin
    DBGrid1.Options := DBGrid1.Options -[dgMultiSelect];
    texto := TranslateViaGoogle( cdsTranslatevalororig.AsString );
    Sleep(100);
    Application.ProcessMessages;
    Memo1.Lines.Text := texto;

    if not texto.IsEmpty then
    begin
      cdsTranslate.Edit;
      cdsTranslatevalororig.AsAnsiString := texto;
      cdsTranslate.Post;
    end;
    DBGrid1.Options := DBGrid1.Options +[dgMultiSelect];
    Exit;
  end;


  cdsTranslate.DisableControls;
  cdsTranslate.First;
  label1.Caption := 'Traduzindo.....';
  try
    while not cdsTranslate.Eof do
    begin
      if DBGrid1.SelectedRows.CurrentRowSelected then
      begin
        texto := TranslateViaGoogle( cdsTranslatevalororig.AsString );
        Sleep(100);
        Memo1.Lines.Text := texto;

        if not texto.IsEmpty then
        begin
          cdsTranslate.Edit;
          cdsTranslatevalororig.AsAnsiString := texto;
          cdsTranslate.Post;
        end;

      end;
      Application.ProcessMessages;
      cdsTranslate.Next;
    end;

  finally
    cdsTranslate.EnableControls;
    label1.Caption := 'finalizado';
  end;


end;

procedure TForm1.Button4Click(Sender: TObject);
var
  Documento: IXMLDOMDocument;
  AttributeNode: IXMLDOMAttribute;
  Elemento: IXMLDOMElement;
  novoCampo : IXMLDOMElement;
begin
  Documento := CoDOMDocument.Create();
  Documento.async := False;
  Documento.documentElement := Documento.createElement('resources');
 // Documento.documentElement.appendChild(Elemento);
  cdsTranslate.DisableControls;
  cdsTranslate.First;
  try
    while not cdsTranslate.Eof do
    begin
      novoCampo     := Documento.createElement('string');
      novoCampo.setAttribute('name', cdsTranslatetagorig.AsString);
      novoCampo.text := cdsTranslatevalororig.AsAnsiString;
      Documento.documentElement.appendChild(novoCampo);
      cdsTranslate.Next;
    end;


    XMLDocument1.Active := False;
    XMLDocument1.LoadFromXML( Xml.XMLDoc.FormatXMLData(Documento.xml) );
    XMLDocument1.Active := True;
    XMLDocument1.Options := [doNodeAutoIndent];
    XMLDocument1.Encoding := 'utf-16';
    XMLDocument1.Version  := '1.0';

    XMLDocument1.SaveToFile(ExtractFilePath(Application.ExeName) + 'ARQUIVOS.XML' );
    Clipboard.AsText := Xml.XMLDoc.FormatXMLData(XMLDocument1.XML.Text);
    XMLDocument1.Active := False;


  finally
   // Memo1.Lines.Text := Documento.xml;
    cdsTranslate.First;
    cdsTranslate.EnableControls;
    Documento := nil;
  end;
  ShowMessage('Arquivo salvo com sucesso e copiado para área de transferência!');
end;

procedure TForm1.Button5Click(Sender: TObject);
var
  sfileSave : string;
begin
  sfileSave := Copy(AdvDirectoryEdit1.Text, System.SysUtils.LastDelimiter('\', AdvDirectoryEdit1.Text)+1  );
  sfileSave := ExtractFilePath(Application.ExeName) + sfileSave + '.XML';


  if cdsTranslate.State in [dsEdit] then
    cdsTranslate.Post;

  cdsTranslate.SaveToFile(ExtractFilePath(Application.ExeName) + 'TRADUZIR.XML', dfXML);
  cdsTranslate.SaveToFile(sfileSave);
end;

function translate(sText, sFrom, sTo: string): string;
const
  URIToken = 'https://api.cognitive.microsoft.com/sts/v1.0/issueToken';
  URITranslate =
  'https://api.microsofttranslator.com/v2/http.svc/Translate';
  SubscriptionKey = '<key of service in azure>';
  COMPLETED = 4;
  OK = 200;
  n10min: real = 1 / 24 / 6;
var
  XMLHTTPRequest: IXMLHTTPRequest;
  sToken: string;
  Uri: string;
  XMLDOMDocument: IXMLDOMDocument;
  sActiveToken: string;
  dtTokenDate: TDateTime;

begin
  Result := '';
  try
    XMLHTTPRequest := CreateOleObject('MSXML2.XMLHTTP') as
    IXMLHTTPRequest;
    if (sActiveToken = '') or (Now - dtTokenDate >= n10min) then
    begin
      dtTokenDate:=Now;
      XMLHTTPRequest.Open('POST', URIToken, False, '', '');
      XMLHTTPRequest.setRequestHeader('Ocp-Apim-Subscription-Key',
      CHAVE_API);
      XMLHTTPRequest.send('');
      if (XMLHTTPRequest.readyState = COMPLETED) and
      (XMLHTTPRequest.status = OK) then
      begin
        sActiveToken := XMLHTTPRequest.responseText;
      end else begin
        sActiveToken := '';
      end;
    end;

    Uri := UriTranslate + '?appid=Bearer ' + sActiveToken + '&text=' +
    sText + '&from=' + sFrom + '&to=' + sTo;
    Uri := TIdURI.PathEncode(Uri);
    XMLHTTPRequest.Open('GET', URI, False, '', '');
    XMLHTTPRequest.send('');
    if (XMLHTTPRequest.readyState = COMPLETED) and
    (XMLHTTPRequest.status = OK) then
    begin
      sToken := XMLHTTPRequest.responseText;
      try
        XMLDOMDocument := CoDOMDocument.Create;
        XMLDOMDocument.loadXML(sToken);
        sToken := XMLDOMDocument.Text;
        Result := sToken;
      finally
        XMLDOMDocument := nil;
      end;
    end;
  finally
  end;
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  translate(cdsTranslatevalororig.AsString, 'en', 'pt');
end;

procedure TForm1.edtAChange(Sender: TObject);
begin
//  if FileExists(edta.Text) then
  //  Memo1.Lines.LoadFromFile(edtA.Text);

end;

procedure TForm1.edtPesquisaTagChange(Sender: TObject);
begin
  cdsTranslate.Locate('tagorig', edtPesquisaTag.Text, [loPartialKey]);
end;

procedure TForm1.edtPesquisaTextoChange(Sender: TObject);
begin
  cdsTranslate.Locate('valororig', edtPesquisaTexto.Text, [loPartialKey]);

end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  wListaOrig.Free;
  wListaPT.Free;
  wListaFinal.Free;
  wListaDiff.Free;

end;

procedure TForm1.FormCreate(Sender: TObject);
begin

  cdsTranslate.CreateDataSet;
  if FileExists(ExtractFilePath(Application.ExeName) + 'traduzir.xml' ) then
  begin
    cdsTranslate.LoadFromFile( ExtractFilePath(Application.ExeName) + 'traduzir.xml'  );
  end;
  cdsTranslate.Open;

  wListaOrig := TStringList.Create;
  wListaPT := TStringList.Create;
  wListaFinal := TStringList.Create;
  wListaDiff := TStringList.Create;
  wListaDiff.Sorted := True;
end;

procedure TForm1.ListValues(const FileName: string; Strings: TStrings; flag : Integer = 0);
var
  I, J: Integer;
  Document: IXMLDOMDocument;
  AttributeNode: IXMLDOMNode;
  ReportSubnodes: IXMLDOMNodeList;
  OperationNodes: IXMLDOMNodeList;
  ParameterNodes: IXMLDOMNodeList;
begin

  Document := CoDOMDocument.Create;
  if Assigned(Document) and Document.load(FileName) then
  begin
    // select all direct child nodes of the redlineaudit/report/ node
    ReportSubnodes := Document.selectSingleNode('resources').childNodes;
    // check if the redlineaudit/report/ node was found and if so, then...
    if Assigned(ReportSubnodes) then
    begin
      // lock the output string list for update
      Strings.BeginUpdate;
      try
        // iterate all direct children of the redlineaudit/report/ node
        for I := 0 to ReportSubnodes.length - 1 do
        begin
          // try to find the "index" attribute of the iterated child node
          if ReportSubnodes[I].attributes <> nil then
            AttributeNode := ReportSubnodes[I].attributes.item[0];
          // and if the "index" attribute is found, add a line to the list

          if Assigned(AttributeNode) then
          begin
            if ( AttributeNode.nodeValue <> '' ) then
            begin
              Strings.Add( AttributeNode.nodeValue );
            end;

          // select all "operation" child nodes of the iterated child node
          end;
        end;
      finally
        // unlock the output string list for update
        Strings.EndUpdate;
      end;
    end;
    Document := nil;
  end;

end;

procedure TForm1.ListFinalValues(const FileName: string; Strings: TStrings);
var
  I, J: Integer;
  Document, Documentfinal: IXMLDOMDocument;
  AttributeNode: IXMLDOMNode;
  ReportSubnodes: IXMLDOMNodeList;
  OperationNodes: IXMLDOMNodeList;
  ParameterNodes: IXMLDOMNodeList;
  elemento: IXMLDOMElement;
  comentario: IXMLDOMComment;
  valor : string;
begin

  Documentfinal := CoDOMDocument.Create;

  Documentfinal.async := False;

  Documentfinal.documentElement := Documentfinal.createElement('resources');
  Document := CoDOMDocument.Create;
  if Assigned(Document) and Document.load(FileName) then
  begin
    // select all direct child nodes of the redlineaudit/report/ node
    ReportSubnodes := Document.selectSingleNode('resources').childNodes;
    // check if the redlineaudit/report/ node was found and if so, then...
    if Assigned(ReportSubnodes) then
    begin
      // lock the output string list for update
      try
        // iterate all direct children of the redlineaudit/report/ node
        for I := 0 to ReportSubnodes.length - 1 do
        begin
          // try to find the "index" attribute of the iterated child node
          if ReportSubnodes[I].attributes <> nil then
            AttributeNode := ReportSubnodes[I].attributes.item[0];
          // and if the "index" attribute is found, add a line to the list

          if Assigned(AttributeNode) then
          begin
            if ( AttributeNode.nodeValue <> '' ) then
            begin
              if Strings.IndexOf( AttributeNode.nodeValue ) > 0 then
              begin
               // element := Documentfinal.createElement('string');

                elemento := Documentfinal.createElement('string');
                elemento.setAttribute('name', AttributeNode.nodeValue);
                elemento.text := ReportSubnodes[I].text;

                Documentfinal.documentElement.appendChild(elemento);

                cdsTranslate.Append;
                cdsTranslatetagorig.AsAnsiString := AttributeNode.nodeValue;
                cdsTranslatevalororig.AsAnsiString :=ReportSubnodes[I].text;
                cdsTranslate.Post;
              end;
             // wListaPT.Add(AttributeNode.nodeValue);
            end;

          // select all "operation" child nodes of the iterated child node
          end;
        end;
      finally
        // unlock the output string list for update
      end;
    end;
   // Memo5.Lines.Text := Documentfinal.xml;
   // Documentfinal.save(ExtractFilePath(Application.ExeName)+ ' final.xml' );
   // Documentfinal := nil;
    Document := nil;
    XMLDocument1.Active := False;
    XMLDocument1.LoadFromXML(Documentfinal.xml);
    XMLDocument1.Active := True;
    XMLDocument1.Options := [doNodeAutoIndent];
    XMLDocument1.Encoding := 'utf-16';
    XMLDocument1.Version  := '1.0';



    XMLDocument1.SaveToFile(ExtractFilePath(Application.ExeName) + 'ARQUIVOS.XML' );

    Clipboard.AsText := Xml.XMLDoc.FormatXMLData(XMLDocument1.XML.Text);
    Documentfinal := nil;
    XMLDocument1.Active := False;
    cdsTranslate.SaveToFile(ExtractFilePath(Application.ExeName) + 'TRADUZIR.XML', dfXML);
  end;

end;



procedure AddAttr (iNode: IDOMNode; Name, Value: string);
var
  iAttr: IDOMNode;
begin
  iAttr := iNode.ownerDocument.createAttribute (name);
  iAttr.nodeValue := Value;
  iNode.attributes.setNamedItem (iAttr);
end;

procedure TForm1.RemoverDuplicados;
var
  I, K: Integer;
  wlista : TStrings;
begin

  for I := 0 to wListaOrig.Count - 1 do //Compare to everything on the right
  for K := wListaOrig.Count - 1 downto I+1 do //Reverse loop allows to Remove items safely
    if wListaOrig[K] = wListaOrig[I] then
    begin
      wListaOrig.Delete(K);
    end;

  for I := 0 to wListaPT.Count - 1 do //Compare to everything on the right
  for K := wListaPT.Count - 1 downto I+1 do //Reverse loop allows to Remove items safely
    if wListaPT[K] = wListaPT[I] then
    begin
      wListaPT.Delete(K);
    end;


end;


procedure TForm1.CompareStringLists(List1, List2: TStringList;
  Missing1: TStrings);
var
  I: Integer;
  J: Integer;
begin
  List1.Sort;
  List2.Sort;
  I := 0;
  J := 0;
  while (I < List1.Count) and (J < List2.Count) do
  begin
    if List1[I] < List2[J] then
    begin
      Missing1.Add(List1[I]);
      Inc(I);
    end
    else if List1[I] > List2[J] then
    begin
      Missing1.Add(List2[J]);
      Inc(J);
    end
    else
    begin
      Inc(I);
      Inc(J);
    end;
  end;
  for I := I to List1.Count - 1 do
    Missing1.Add(List1[I]);

  for J := J to List2.Count - 1 do
    Missing1.Add(List2[J]);

end;

procedure TForm1.DBGrid1TitleClick(Column: TColumn);
begin
  cdsTranslate.IndexFieldNames := Column.FieldName;
end;

function TForm1.TranslateViaGoogle(textToTranslate: string ):string;
var
  elemento : IHTMLElement;
  url_consulta : string;
begin

  result := '';
//  IdHTTP1.Request.Accept := 'text/html, */*';
//  IdHTTP1.Request.UserAgent := 'Mozilla/3.0 (compatible; IndyLibrary)';
//  IdHTTP1.Request.ContentType := 'application/x-www-form-urlencoded';
  IdHTTP1.HandleRedirects := True;
//  IdHTTP1.Request.

  url_consulta := Format(URL_GOOGLE_TRANSLATE, [ Web.HTTPApp.HTTPEncode( textToTranslate), 'pt']);

  //result := IdHTTP1.Get(Format(URL_GOOGLE_TRANSLATE, [ Web.HTTPApp.HTTPEncode( textToTranslate), 'pt']) );
  WebBrowser1.Navigate(url_consulta  );
  while WebBrowser1.ReadyState <> READYSTATE_COMPLETE do
  Application.ProcessMessages;

  elemento := (WebBrowser1.Document as IHTMLDocument3).getElementById('result_box');
  //elemento := GetElementById(WebBrowser1.Document, 'result_box') as IHTMLElement;
  Result := elemento.innerText ;


end;

function TForm1.GetElementById(const Doc: IDispatch; const Id: string): IDispatch;
var
  Document: IHTMLDocument2;     // IHTMLDocument2 interface of Doc
  Body: IHTMLElement2;          // document body element
  Tags: IHTMLElementCollection; // all tags in document body
  Tag: IHTMLElement;            // a tag in document body
  I: Integer;                   // loops thru tags in document body
begin
  Result := nil;
  // Check for valid document: require IHTMLDocument2 interface to it
  if not Supports(Doc, IHTMLDocument2, Document) then
    raise Exception.Create('Invalid HTML document');
  // Check for valid body element: require IHTMLElement2 interface to it
  if not Supports(Document.body, IHTMLElement2, Body) then
    raise Exception.Create('Can''t find <body> element');
  // Get all tags in body element ('*' => any tag name)
  Tags := Body.getElementsByTagName('*');
  // Scan through all tags in body
  for I := 0 to Pred(Tags.length) do
  begin
    // Get reference to a tag
    Tag := Tags.item(I, EmptyParam) as IHTMLElement;
    // Check tag's id and return it if id matches
    if AnsiSameText(Tag.id, Id) then
    begin
      Result := Tag;
      Break;
    end;
  end;
end;

end.
