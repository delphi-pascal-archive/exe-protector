object Form1: TForm1
  Left = 294
  Top = 118
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'EXE Protector'
  ClientHeight = 192
  ClientWidth = 384
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
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 369
    Height = 177
    TabOrder = 0
    object Label2: TLabel
      Left = 16
      Top = 152
      Width = 231
      Height = 13
      Caption = 'Exe Protector V1 - www.mrcl0ck.wordpress.com'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 7368816
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Edit2: TEdit
      Left = 8
      Top = 20
      Width = 281
      Height = 21
      TabOrder = 0
    end
    object Btn1: TButton
      Left = 296
      Top = 16
      Width = 65
      Height = 25
      Caption = '...'
      TabOrder = 1
      OnClick = Btn1Click
    end
    object Btn2: TButton
      Left = 284
      Top = 144
      Width = 75
      Height = 25
      Caption = 'Creer'
      TabOrder = 2
      OnClick = Btn2Click
    end
    object GroupBox2: TGroupBox
      Left = 8
      Top = 48
      Width = 353
      Height = 89
      Caption = 'Mot de passe'
      TabOrder = 3
      object Image1: TImage
        Left = 8
        Top = 16
        Width = 64
        Height = 64
        AutoSize = True
        Center = True
      end
      object Label1: TLabel
        Left = 96
        Top = 56
        Width = 240
        Height = 13
        Caption = 'Eviter les mots de passe trop courts, trop simples.'
      end
      object Edit1: TEdit
        Left = 88
        Top = 24
        Width = 177
        Height = 21
        CharCase = ecUpperCase
        TabOrder = 0
      end
      object Button1: TButton
        Left = 270
        Top = 24
        Width = 75
        Height = 25
        Caption = 'Generer'
        TabOrder = 1
        OnClick = Button1Click
      end
    end
  end
  object Open: TOpenDialog
    Filter = '*.exe|*.exe'
    Left = 112
    Top = 112
  end
  object XPManifest1: TXPManifest
    Left = 176
    Top = 112
  end
  object Save: TSaveDialog
    DefaultExt = 'exe'
    FileName = 'APP_Prot.exe'
    Filter = '*.exe|*.exe'
    Left = 144
    Top = 112
  end
end
