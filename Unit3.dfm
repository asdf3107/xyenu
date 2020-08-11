object Form3: TForm3
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Xyenu - '#1053#1072#1089#1090#1088#1086#1081#1082#1080
  ClientHeight = 383
  ClientWidth = 622
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
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 130
    Height = 13
    Caption = #1050#1086#1083#1083#1080#1095#1077#1089#1090#1074#1086' '#1087#1086#1090#1086#1082#1086#1074': 10'
  end
  object TrackBar1: TTrackBar
    Left = 0
    Top = 24
    Width = 161
    Height = 45
    Max = 100
    Min = 1
    PageSize = 5
    Frequency = 5
    Position = 10
    TabOrder = 0
    TickMarks = tmBoth
    OnChange = TrackBar1Change
  end
  object Button1: TButton
    Left = 528
    Top = 350
    Width = 75
    Height = 25
    Caption = #1055#1088#1080#1084#1077#1085#1080#1090#1100
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 432
    Top = 350
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 2
    OnClick = Button2Click
  end
end
