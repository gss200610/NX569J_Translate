unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, AdvEdit, AdvEdBtn,
  AdvFileNameEdit;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Memo2: TMemo;
    edtA: TAdvFileNameEdit;
    edtB: TAdvFileNameEdit;
    Button1: TButton;
    procedure edtAChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  Winapi.ShellAPI;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  tag, tag2, tagDiff, linha, linha2 : string;
  I, X: Integer;
  wLista : TStrings;
  wListaEx1, wListaEx2 : TStringList;
begin
  if not FileExists(edta.Text) then
  begin
    ShowMessage('arquivo inexistente.');
    Exit;
  end;
  Memo1.Lines.LoadFromFile(edtA.Text);

  wListaEx1 := TStringList.Create;
  wListaEx2 := TStringList.Create;
  wLista := TStringList.Create;
  wLista.LoadFromFile(edtB.Text);
  for I := 0 to wLista.Count -1 do
  begin
    linha := wLista[i];
    tag := Copy(linha, Pos('"', linha)+1, Pos('">', linha)-Pos('"', linha)-1  );
    tagDiff := '';
    if tag.Trim <> '' then
      wListaEx2.Add(tag);
  end;
  wListaEx2.Sort;


  for I := 0 to Memo1.Lines.Count -1 do
  begin
    linha := Memo1.Lines[i];
    tag := Copy(linha, Pos('"', linha)+1, Pos('">', linha)-Pos('"', linha)-1  );
    tagDiff := '';
    if Pos(tag, wListaEx2.Text) = 0 then
    begin
      if tag.Trim <> '' then
      begin
        wListaEx1.Add(linha);
        Memo2.Lines.Add(linha);
      end;
    end;

  end;
  wListaEx1.Sort;
  wListaEx1.SaveToFile('DIFF.xml');


  wListaEx2.Sort;
  wListaEx2.SaveToFile('listaB.txt');
  wLista.Free;
  wListaEx1.Free;
  wListaEx2.Free;

  ShellExecute(Application.Handle, PChar('open'), PChar('notepad++.exe'), PChar(GetCurrentDir +  '\DIFF.xml'), nil, SW_NORMAL);
  //WinExec(PAnsiChar('notepad.exe '+ GetCurrentDir +  '\DIFF.txt'), SW_SHOWNORMAL);

end;

procedure TForm1.edtAChange(Sender: TObject);
begin
  if FileExists(edta.Text) then
    Memo1.Lines.LoadFromFile(edtA.Text);

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Memo1.Clear;
  Memo2.Clear;
end;

end.
