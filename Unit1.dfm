object Form1: TForm1
  Left = 736
  Top = 214
  Width = 912
  Height = 470
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 904
    Height = 41
    Align = alTop
    TabOrder = 0
    object Edit1: TEdit
      Left = 16
      Top = 8
      Width = 73
      Height = 21
      TabOrder = 0
      Text = '100000'
    end
    object btngen: TButton
      Left = 104
      Top = 8
      Width = 105
      Height = 25
      Caption = 'Generate Array'
      TabOrder = 1
      OnClick = btngenClick
    end
    object btn1: TButton
      Left = 816
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Bublle Sort'
      TabOrder = 2
      OnClick = btn1Click
    end
    object btn2: TButton
      Left = 696
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Fast Sort'
      TabOrder = 3
      OnClick = btn2Click
    end
    object btn3: TButton
      Left = 584
      Top = 8
      Width = 75
      Height = 25
      Caption = 'FlipFlop Sort'
      TabOrder = 4
      OnClick = btn3Click
    end
  end
  object Log: TMemo
    Left = 0
    Top = 41
    Width = 904
    Height = 398
    Align = alClient
    ScrollBars = ssVertical
    TabOrder = 1
  end
end
