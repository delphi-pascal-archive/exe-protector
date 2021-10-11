object Form1: TForm1
  Left = 664
  Top = 592
  Align = alCustom
  AlphaBlend = True
  AlphaBlendValue = 220
  BorderStyle = bsToolWindow
  ClientHeight = 87
  ClientWidth = 310
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 80
    Top = 9
    Width = 134
    Height = 13
    Caption = 'Entrez votre mot de passe :'
  end
  object Image1: TImage
    Left = 8
    Top = 16
    Width = 64
    Height = 64
    AutoSize = True
  end
  object Password: TEdit
    Left = 80
    Top = 27
    Width = 217
    Height = 21
    CharCase = ecUpperCase
    PasswordChar = '*'
    TabOrder = 0
  end
  object OKBtn: TButton
    Left = 222
    Top = 54
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
    OnClick = OKBtnClick
  end
end
