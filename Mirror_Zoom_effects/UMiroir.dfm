object frmMain: TfrmMain
  Left = 212
  Top = 128
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Mirror / Zoom effects'
  ClientHeight = 588
  ClientWidth = 847
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 120
  TextHeight = 16
  object pb_Display: TPaintBox
    Left = 0
    Top = 0
    Width = 847
    Height = 496
    Align = alClient
    OnPaint = pb_DisplayPaint
  end
  object Panel1: TPanel
    Left = 0
    Top = 496
    Width = 847
    Height = 92
    Align = alBottom
    ParentBackground = False
    TabOrder = 0
    object lbl_PosSize: TLabel
      Left = 136
      Top = 7
      Width = 71
      Height = 16
      Caption = 'lbl_PosSize'
    end
    object lbl_Zoom: TLabel
      Left = 496
      Top = 15
      Width = 74
      Height = 16
      Caption = 'Zoom: 100%'
    end
    object tb_Factor: TTrackBar
      Left = 488
      Top = 40
      Width = 353
      Height = 33
      Hint = 'Zoom'
      Max = 125
      ParentShowHint = False
      Frequency = 10
      Position = 100
      ShowHint = True
      TabOrder = 0
      ThumbLength = 12
      TickMarks = tmBoth
      OnChange = tb_FactorChange
    end
    object cb_VertFlip: TCheckBox
      Left = 344
      Top = 16
      Width = 105
      Height = 17
      Caption = 'Mirror vertical'
      TabOrder = 1
      OnClick = cb_VertFlipClick
    end
    object cb_180Degre: TCheckBox
      Tag = 2
      Left = 344
      Top = 64
      Width = 97
      Height = 17
      Caption = 'Both effects'
      TabOrder = 2
      OnClick = cb_VertFlipClick
    end
    object cb_HorzFlip: TCheckBox
      Tag = 1
      Left = 344
      Top = 40
      Width = 121
      Height = 17
      Caption = 'Mirror horizontal'
      TabOrder = 3
      OnClick = cb_VertFlipClick
    end
    object btn_LoadBitmap: TButton
      Left = 8
      Top = 40
      Width = 97
      Height = 25
      Caption = 'Load Bitmap'
      TabOrder = 4
      OnClick = btn_LoadBitmapClick
    end
    object cb_Center: TCheckBox
      Left = 224
      Top = 48
      Width = 105
      Height = 17
      Caption = 'Center image'
      TabOrder = 5
      OnClick = cb_CenterClick
    end
    object cb_UsePlgBlt: TCheckBox
      Left = 112
      Top = 48
      Width = 105
      Height = 17
      Caption = 'Utiliser PlgBlt'
      TabOrder = 6
      OnClick = cb_UsePlgBltClick
    end
  end
  object OPD: TOpenPictureDialog
    Filter = 'Bitmaps (*.bmp)|*.bmp'
    Left = 8
    Top = 8
  end
end
