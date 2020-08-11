object Form4: TForm4
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Xyenu - '#1057#1074#1086#1081#1089#1090#1074#1072' '#1089#1089#1099#1083#1082#1080
  ClientHeight = 300
  ClientWidth = 554
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Edit1: TEdit
    Left = 8
    Top = 32
    Width = 441
    Height = 21
    TabOrder = 0
    Text = 'Edit1'
  end
  object Button1: TButton
    Left = 456
    Top = 30
    Width = 41
    Height = 25
    Caption = 'Copy'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Edit2: TEdit
    Left = 8
    Top = 95
    Width = 441
    Height = 21
    TabOrder = 2
    Text = 'Edit2'
  end
  object StaticText1: TStaticText
    Left = 16
    Top = 8
    Width = 46
    Height = 17
    Caption = #1057#1089#1099#1083#1082#1072':'
    TabOrder = 3
  end
  object StaticText2: TStaticText
    Left = 16
    Top = 72
    Width = 56
    Height = 17
    Caption = #1048#1089#1090#1086#1095#1085#1080#1082':'
    TabOrder = 4
  end
  object Button2: TButton
    Left = 456
    Top = 93
    Width = 41
    Height = 25
    Caption = 'Copy'
    TabOrder = 5
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 503
    Top = 30
    Width = 42
    Height = 25
    Caption = 'Go >'
    TabOrder = 6
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 503
    Top = 93
    Width = 41
    Height = 25
    Caption = 'Go >'
    TabOrder = 7
    OnClick = Button4Click
  end
end
