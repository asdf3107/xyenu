object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Xyenu'
  ClientHeight = 638
  ClientWidth = 1364
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  TextHeight = 13
  object ListView1: TListView
    Left = 0
    Top = 52
    Width = 1364
    Height = 563
    Align = alClient
    BevelInner = bvSpace
    Columns = <
      item
        Caption = 'URL'
        Width = 600
      end
      item
        Caption = #1057#1090#1072#1090#1091#1089
        Width = 80
      end
      item
        Caption = 'Type'
        Width = 80
      end
      item
        Caption = #1056#1072#1079#1084#1077#1088
        Width = 80
      end
      item
        Caption = 'Title'
        Width = 150
      end
      item
        Caption = #1044#1083#1080#1090#1077#1083#1100#1085#1086#1089#1090#1100
        Width = 70
      end
      item
        Caption = #1054#1096#1080#1073#1082#1072
      end
      item
        Caption = #1057#1090#1088#1072#1085#1080#1094#1072' '#1080#1089#1090#1086#1095#1085#1080#1082
        Width = 200
      end
      item
        Caption = #1059#1088#1086#1074#1077#1085#1100
      end>
    GridLines = True
    Groups = <
      item
        GroupID = 0
        State = [lgsNormal]
        HeaderAlign = taLeftJustify
        FooterAlign = taLeftJustify
        TitleImage = -1
      end
      item
        GroupID = 1
        State = [lgsNormal]
        HeaderAlign = taLeftJustify
        FooterAlign = taLeftJustify
        TitleImage = -1
      end>
    ReadOnly = True
    TabOrder = 0
    ViewStyle = vsReport
    OnAdvancedCustomDrawItem = ListView1AdvancedCustomDrawItem
    OnAdvancedCustomDrawSubItem = ListView1AdvancedCustomDrawSubItem
    OnClick = ListView1Click
    OnColumnClick = ListView1ColumnClick
    OnDblClick = ListView1DblClick
    OnMouseDown = ListView1MouseDown
    ExplicitWidth = 980
    ExplicitHeight = 562
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1364
    Height = 52
    Align = alTop
    TabOrder = 1
    ExplicitWidth = 980
    object Edit1: TEdit
      Left = 16
      Top = 14
      Width = 214
      Height = 21
      TabOrder = 0
      Text = 'https://topvisor.com/'
    end
    object Button1: TButton
      Left = 535
      Top = 9
      Width = 75
      Height = 37
      Caption = 'Start'
      TabOrder = 1
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 640
      Top = 9
      Width = 75
      Height = 37
      Caption = 'Stop'
      TabOrder = 2
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 936
      Top = 3
      Width = 75
      Height = 21
      Caption = 'Save'
      TabOrder = 3
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 960
      Top = 27
      Width = 75
      Height = 21
      Caption = 'Load'
      TabOrder = 4
      OnClick = Button4Click
    end
    object Button6: TButton
      Left = 841
      Top = 3
      Width = 75
      Height = 21
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100
      TabOrder = 5
      OnClick = Button6Click
    end
    object Button7: TButton
      Left = 256
      Top = 12
      Width = 75
      Height = 25
      Caption = 'Settings'
      TabOrder = 6
      OnClick = Button7Click
    end
    object Button9: TButton
      Left = 1017
      Top = 1
      Width = 60
      Height = 25
      Caption = 'links save'
      TabOrder = 7
      OnClick = Button9Click
    end
    object Button10: TButton
      Left = 737
      Top = 12
      Width = 75
      Height = 25
      Caption = 'Button10'
      TabOrder = 8
      OnClick = Button10Click
    end
    object ComboBox1: TComboBox
      Left = 360
      Top = 17
      Width = 161
      Height = 21
      TabOrder = 9
      Text = #1055#1072#1088#1089#1080#1090#1100' '#1089#1072#1081#1090
      Items.Strings = (
        #1055#1072#1088#1089#1080#1090#1100' '#1089#1072#1081#1090
        #1057#1086#1079#1076#1072#1090#1100' '#1079#1077#1088#1082#1072#1083#1086' '#1089#1072#1081#1090#1072
        #1063#1077#1082#1072#1090#1100' '#1089#1089#1099#1083#1082#1080' '#1080#1079' '#1083#1080#1089#1090#1072)
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 615
    Width = 1364
    Height = 23
    Align = alBottom
    TabOrder = 2
    ExplicitTop = 614
    ExplicitWidth = 980
    DesignSize = (
      1364
      23)
    object Label1: TLabel
      Left = 67
      Top = 5
      Width = 31
      Height = 13
      Anchors = [akLeft]
      BiDiMode = bdLeftToRight
      Caption = 'Label1'
      ParentBiDiMode = False
    end
    object Label2: TLabel
      Left = 227
      Top = 5
      Width = 31
      Height = 13
      Anchors = [akLeft]
      BiDiMode = bdLeftToRight
      Caption = 'Label2'
      ParentBiDiMode = False
    end
    object Label3: TLabel
      Left = 399
      Top = 5
      Width = 31
      Height = 13
      Anchors = [akLeft]
      BiDiMode = bdLeftToRight
      Caption = 'Label3'
      ParentBiDiMode = False
    end
    object Label4: TLabel
      Left = 594
      Top = 5
      Width = 31
      Height = 13
      Anchors = [akLeft]
      BiDiMode = bdLeftToRight
      Caption = 'Label4'
      ParentBiDiMode = False
    end
    object StaticText1: TStaticText
      Left = 16
      Top = 4
      Width = 45
      Height = 17
      Anchors = [akLeft]
      BiDiMode = bdLeftToRight
      Caption = #1055#1086#1090#1086#1082#1080':'
      ParentBiDiMode = False
      TabOrder = 0
    end
    object StaticText2: TStaticText
      Left = 163
      Top = 4
      Width = 54
      Height = 17
      Anchors = [akLeft]
      BiDiMode = bdLeftToRight
      Caption = #1055#1088#1086#1075#1088#1077#1089#1089':'
      ParentBiDiMode = False
      TabOrder = 1
    end
    object StaticText3: TStaticText
      Left = 348
      Top = 4
      Width = 47
      Height = 17
      Anchors = [akLeft]
      BiDiMode = bdLeftToRight
      Caption = #1055#1088#1086#1096#1083#1086':'
      ParentBiDiMode = False
      TabOrder = 2
    end
    object StaticText4: TStaticText
      Left = 523
      Top = 4
      Width = 56
      Height = 17
      Anchors = [akLeft]
      BiDiMode = bdLeftToRight
      Caption = #1054#1089#1090#1072#1083#1086#1089#1100':'
      ParentBiDiMode = False
      TabOrder = 3
    end
    object Button5: TButton
      Left = 896
      Top = 1
      Width = 75
      Height = 20
      Caption = 'Button5'
      TabOrder = 4
      OnClick = Button5Click
    end
    object Button8: TButton
      Left = 818
      Top = 1
      Width = 72
      Height = 20
      Caption = #1059#1076#1072#1083#1080#1090#1100
      TabOrder = 5
      OnClick = Button8Click
    end
    object Edit2: TEdit
      Left = 744
      Top = 0
      Width = 68
      Height = 21
      TabOrder = 6
      Text = 'Edit2'
    end
  end
  object IdHTTP1: TIdHTTP
    IOHandler = IdSSLIOHandlerSocketOpenSSL1
    HandleRedirects = True
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
    Left = 178
    Top = 424
  end
  object MainMenu1: TMainMenu
    Left = 130
    Top = 424
    object N1: TMenuItem
      Caption = #1060#1072#1081#1083
      object N2: TMenuItem
        Caption = #1042#1099#1093#1086#1076
        OnClick = N2Click
      end
      object N11: TMenuItem
        Caption = #1057#1086#1079#1076#1072#1090#1100' '#1086#1090#1095#1077#1090
        OnClick = N11Click
      end
      object N12: TMenuItem
        Caption = #1050#1072#1088#1090#1072' '#1089#1072#1081#1090#1072
        OnClick = N12Click
      end
    end
    object N3: TMenuItem
      Caption = #1054#1087#1094#1080#1080
      object N6: TMenuItem
        Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
        OnClick = N6Click
      end
    end
    object N4: TMenuItem
      Caption = #1057#1087#1088#1072#1074#1082#1072
      object N5: TMenuItem
        Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
        OnClick = N5Click
      end
      object N7: TMenuItem
        Caption = #1044#1086#1082#1091#1084#1077#1085#1090#1072#1094#1080#1103
        OnClick = N7Click
      end
    end
  end
  object IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL
    MaxLineAction = maException
    Port = 0
    DefaultPort = 0
    SSLOptions.Method = sslvSSLv23
    SSLOptions.SSLVersions = [sslvTLSv1, sslvTLSv1_1, sslvTLSv1_2]
    SSLOptions.Mode = sslmBoth
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 224
    Top = 432
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 500
    OnTimer = Timer1Timer
    Left = 272
    Top = 424
  end
  object PopupMenu1: TPopupMenu
    Left = 320
    Top = 416
    object URL1: TMenuItem
      Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100' URL'
      OnClick = URL1Click
    end
    object N8: TMenuItem
      Caption = #1054#1090#1082#1088#1099#1090#1100' '#1074' '#1073#1088#1072#1091#1079#1077#1088#1077
      OnClick = N8Click
    end
    object N9: TMenuItem
      Caption = #1054#1090#1082#1088#1099#1090#1100' '#1080#1089#1090#1086#1095#1085#1080#1082' '
      OnClick = N9Click
    end
    object N10: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100
      OnClick = N10Click
    end
    object URL2: TMenuItem
      Caption = #1057#1074#1086#1081#1089#1090#1074#1072' URL'
      OnClick = URL2Click
    end
  end
end
