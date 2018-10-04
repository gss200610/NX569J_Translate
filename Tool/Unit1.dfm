object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 496
  ClientWidth = 953
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 16
    Top = 104
    Width = 377
    Height = 329
    Lines.Strings = (
      'Memo1')
    ScrollBars = ssBoth
    TabOrder = 0
  end
  object Memo2: TMemo
    Left = 424
    Top = 104
    Width = 377
    Height = 329
    Lines.Strings = (
      'Memo1')
    ScrollBars = ssBoth
    TabOrder = 1
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
    TabOrder = 2
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
    TabOrder = 3
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
    Left = 807
    Top = 102
    Width = 106
    Height = 25
    Caption = 'Button1'
    TabOrder = 4
    OnClick = Button1Click
  end
end
