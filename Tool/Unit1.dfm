object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 744
  ClientWidth = 1339
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 424
    Top = 14
    Width = 40
    Height = 19
    Caption = '****'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object edtA: TAdvFileNameEdit
    Left = 24
    Top = 56
    Width = 369
    Height = 21
    EmptyTextStyle = []
    Flat = False
    LabelCaption = 'Arquivo A'
    LabelPosition = lpTopLeft
    LabelFont.Charset = DEFAULT_CHARSET
    LabelFont.Color = clWindowText
    LabelFont.Height = -11
    LabelFont.Name = 'Tahoma'
    LabelFont.Style = []
    Lookup.Font.Charset = DEFAULT_CHARSET
    Lookup.Font.Color = clWindowText
    Lookup.Font.Height = -11
    Lookup.Font.Name = 'Arial'
    Lookup.Font.Style = []
    Lookup.Separator = ';'
    Color = clWindow
    ReadOnly = False
    TabOrder = 0
    Text = 
      'D:\Nubia-Z17-mini\Traducao\global_212\NX569J_Translate\Settings\' +
      'res\values\strings.xml'
    Visible = True
    OnChange = edtAChange
    Version = '1.3.6.0'
    ButtonStyle = bsButton
    ButtonWidth = 18
    Etched = False
    Glyph.Data = {
      CE000000424DCE0000000000000076000000280000000C0000000B0000000100
      0400000000005800000000000000000000001000000000000000000000000000
      8000008000000080800080000000800080008080000080808000C0C0C0000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00D00000000DDD
      00000077777770DD00000F077777770D00000FF07777777000000FFF00000000
      00000FFFFFFF0DDD00000FFF00000DDD0000D000DDDDD0000000DDDDDDDDDD00
      0000DDDDD0DDD0D00000DDDDDD000DDD0000}
    FilterIndex = 0
    DialogOptions = []
    DialogKind = fdOpen
  end
  object edtB: TAdvFileNameEdit
    Left = 424
    Top = 56
    Width = 369
    Height = 21
    EmptyTextStyle = []
    Flat = False
    LabelCaption = 'Arquivo B'
    LabelPosition = lpTopLeft
    LabelFont.Charset = DEFAULT_CHARSET
    LabelFont.Color = clWindowText
    LabelFont.Height = -11
    LabelFont.Name = 'Tahoma'
    LabelFont.Style = []
    Lookup.Font.Charset = DEFAULT_CHARSET
    Lookup.Font.Color = clWindowText
    Lookup.Font.Height = -11
    Lookup.Font.Name = 'Arial'
    Lookup.Font.Style = []
    Lookup.Separator = ';'
    Color = clWindow
    ReadOnly = False
    TabOrder = 1
    Text = 
      'D:\Nubia-Z17-mini\Traducao\global_212\NX569J_Translate\Settings\' +
      'res\values-pt-rBR\strings.xml'
    Visible = True
    Version = '1.3.6.0'
    ButtonStyle = bsButton
    ButtonWidth = 18
    Etched = False
    Glyph.Data = {
      CE000000424DCE0000000000000076000000280000000C0000000B0000000100
      0400000000005800000000000000000000001000000000000000000000000000
      8000008000000080800080000000800080008080000080808000C0C0C0000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00D00000000DDD
      00000077777770DD00000F077777770D00000FF07777777000000FFF00000000
      00000FFFFFFF0DDD00000FFF00000DDD0000D000DDDDD0000000DDDDDDDDDD00
      0000DDDDD0DDD0D00000DDDDDD000DDD0000}
    FilterIndex = 0
    DialogOptions = []
    DialogKind = fdOpen
  end
  object Button1: TButton
    Left = 1040
    Top = 54
    Width = 106
    Height = 25
    Caption = 'Button1'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 818
    Top = 54
    Width = 105
    Height = 25
    Caption = 'Carregar'
    TabOrder = 3
    OnClick = Button2Click
  end
  object AdvDirectoryEdit1: TAdvDirectoryEdit
    Left = 24
    Top = 16
    Width = 369
    Height = 21
    EmptyTextStyle = []
    Flat = False
    LabelFont.Charset = DEFAULT_CHARSET
    LabelFont.Color = clWindowText
    LabelFont.Height = -11
    LabelFont.Name = 'Tahoma'
    LabelFont.Style = []
    Lookup.Font.Charset = DEFAULT_CHARSET
    Lookup.Font.Color = clWindowText
    Lookup.Font.Height = -11
    Lookup.Font.Name = 'Arial'
    Lookup.Font.Style = []
    Lookup.Separator = ';'
    Color = clWindow
    ReadOnly = False
    TabOrder = 4
    Text = 'C:\BatchApkTool\_INPUT_APK\Settings'
    Visible = True
    Version = '1.3.6.0'
    ButtonStyle = bsButton
    ButtonWidth = 18
    Etched = False
    Glyph.Data = {
      CE000000424DCE0000000000000076000000280000000C0000000B0000000100
      0400000000005800000000000000000000001000000000000000000000000000
      8000008000000080800080000000800080008080000080808000C0C0C0000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00F00000000FFF
      00000088888880FF00000B088888880F00000BB08888888000000BBB00000000
      00000BBBBBBB0B0F00000BBB00000B0F0000F000BBBBBB0F0000FF0BBBBBBB0F
      0000FF0BBB00000F0000FFF000FFFFFF0000}
    BrowseDialogText = 'Select Directory'
  end
  object Button3: TButton
    Left = 1152
    Top = 54
    Width = 75
    Height = 25
    Caption = 'Button3'
    TabOrder = 5
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 929
    Top = 54
    Width = 105
    Height = 25
    Caption = 'Exportar XML'
    TabOrder = 6
    OnClick = Button4Click
  end
  object DBGrid1: TDBGrid
    Left = 24
    Top = 83
    Width = 769
    Height = 561
    DataSource = DSTranslate
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgMultiSelect, dgTitleClick, dgTitleHotTrack]
    TabOrder = 7
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnTitleClick = DBGrid1TitleClick
    Columns = <
      item
        Expanded = False
        FieldName = 'tagorig'
        Width = 300
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'valororig'
        Width = 400
        Visible = True
      end>
  end
  object edtPesquisaTag: TAdvEdit
    Left = 24
    Top = 672
    Width = 345
    Height = 21
    EmptyTextStyle = []
    LabelCaption = 'Pesquisar'
    LabelPosition = lpTopLeft
    LabelFont.Charset = DEFAULT_CHARSET
    LabelFont.Color = clWindowText
    LabelFont.Height = -11
    LabelFont.Name = 'Tahoma'
    LabelFont.Style = []
    Lookup.Font.Charset = DEFAULT_CHARSET
    Lookup.Font.Color = clWindowText
    Lookup.Font.Height = -11
    Lookup.Font.Name = 'Arial'
    Lookup.Font.Style = []
    Lookup.Separator = ';'
    Color = clWindow
    TabOrder = 8
    Text = ''
    Visible = True
    OnChange = edtPesquisaTagChange
    Version = '3.4.1.1'
  end
  object edtPesquisaTexto: TAdvEdit
    Left = 448
    Top = 672
    Width = 345
    Height = 21
    EmptyTextStyle = []
    LabelCaption = 'Pesquisar Texto'
    LabelPosition = lpTopLeft
    LabelFont.Charset = DEFAULT_CHARSET
    LabelFont.Color = clWindowText
    LabelFont.Height = -11
    LabelFont.Name = 'Tahoma'
    LabelFont.Style = []
    Lookup.Font.Charset = DEFAULT_CHARSET
    Lookup.Font.Color = clWindowText
    Lookup.Font.Height = -11
    Lookup.Font.Name = 'Arial'
    Lookup.Font.Style = []
    Lookup.Separator = ';'
    Color = clWindow
    TabOrder = 9
    Text = ''
    Visible = True
    OnChange = edtPesquisaTextoChange
    Version = '3.4.1.1'
  end
  object DBMemo1: TDBMemo
    Left = 799
    Top = 208
    Width = 514
    Height = 436
    DataField = 'valororig'
    DataSource = DSTranslate
    TabOrder = 10
  end
  object Memo1: TMemo
    Left = 799
    Top = 88
    Width = 514
    Height = 114
    Lines.Strings = (
      'Memo1')
    ScrollBars = ssBoth
    TabOrder = 11
  end
  object WebBrowser1: TWebBrowser
    Left = 888
    Top = 568
    Width = 300
    Height = 150
    TabOrder = 12
    ControlData = {
      4C000000021F0000810F00000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E12620A000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object DBNavigator1: TDBNavigator
    Left = 818
    Top = 23
    Width = 400
    Height = 25
    DataSource = DSTranslate
    TabOrder = 13
  end
  object Button5: TButton
    Left = 1233
    Top = 54
    Width = 75
    Height = 25
    Caption = 'Gravar'
    TabOrder = 14
    OnClick = Button5Click
  end
  object XMLDocument1: TXMLDocument
    Options = [doNodeAutoCreate, doNodeAutoIndent, doAttrNull, doAutoPrefix, doNamespaceDecl]
    Left = 624
    Top = 232
  end
  object cdsTranslate: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'tagorig'
        DataType = ftString
        Size = 200
      end
      item
        Name = 'valororig'
        DataType = ftString
        Size = 5000
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 520
    Top = 224
    object cdsTranslatetagorig: TStringField
      FieldName = 'tagorig'
      Size = 200
    end
    object cdsTranslatevalororig: TStringField
      FieldName = 'valororig'
      Size = 5000
    end
  end
  object DSTranslate: TDataSource
    DataSet = cdsTranslate
    Left = 520
    Top = 304
  end
  object IdHTTP1: TIdHTTP
    IOHandler = IdSSLIOHandlerSocketOpenSSL1
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 288
    Top = 200
  end
  object IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL
    MaxLineAction = maException
    Port = 0
    DefaultPort = 0
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 384
    Top = 376
  end
end
