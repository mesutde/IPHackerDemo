object FormMain: TFormMain
  Left = 0
  Top = 0
  Caption = 'IP-Hacker Viewer'
  ClientHeight = 612
  ClientWidth = 853
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 17
  object btnGetIPs: TButton
    Left = 8
    Top = 8
    Width = 200
    Height = 30
    Caption = 'Get IP-Hacker List'
    TabOrder = 0
    OnClick = btnGetIPsClick
  end
  object sgIPList: TStringGrid
    Left = 10
    Top = 124
    Width = 529
    Height = 468
    RowCount = 1
    FixedRows = 0
    TabOrder = 1
  end
  object sgIPListFalse: TStringGrid
    Left = 545
    Top = 124
    Width = 298
    Height = 468
    ColCount = 2
    RowCount = 1
    FixedRows = 0
    TabOrder = 2
  end
  object btnSaveTxt: TBitBtn
    Left = 129
    Top = 93
    Width = 115
    Height = 25
    Caption = 'SaveTxt'
    TabOrder = 3
    OnClick = btnSaveTxtClick
  end
  object btnSaveCsv: TBitBtn
    Left = 8
    Top = 93
    Width = 115
    Height = 25
    Caption = 'SaveCsv'
    TabOrder = 4
    OnClick = btnSaveCsvClick
  end
  object btnSaveTxtFalse: TBitBtn
    Left = 703
    Top = 93
    Width = 142
    Height = 25
    Caption = 'SaveTxt'
    TabOrder = 5
    OnClick = btnSaveTxtFalseClick
  end
  object btnSaveCsvFalse: TBitBtn
    Left = 545
    Top = 93
    Width = 152
    Height = 25
    Caption = 'SaveCsv'
    TabOrder = 6
    OnClick = btnSaveCsvFalseClick
  end
  object btnRunIPHackerWithInput: TBitBtn
    Left = 8
    Top = 44
    Width = 200
    Height = 30
    Caption = 'Run IP Hacker With Input'
    TabOrder = 7
    OnClick = btnRunIPHackerWithInputClick
  end
  object edtIPMask: TEdit
    Left = 214
    Top = 44
    Width = 280
    Height = 30
    Alignment = taCenter
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 8
    Text = '95.70.175.83'
  end
  object Memo1: TMemo
    Left = 500
    Top = 8
    Width = 345
    Height = 79
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = []
    Lines.Strings = (
      'Mesut Demirci'
      'https://www.linkedin.com/in/mesutdemirci/'
      ''
      'Thanks'
      'https://github.com/rsbench/IP-Hacker')
    ParentFont = False
    TabOrder = 9
  end
end
