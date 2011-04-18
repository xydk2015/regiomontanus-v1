inherited frmBulvarItemShow: TfrmBulvarItemShow
  Caption = 'CAPTION...'
  ClientHeight = 399
  ClientWidth = 466
  OldCreateOrder = True
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBottom: TPanel
    Top = 358
    Width = 466
    object lblForras: TQzHtmlLabel2 [0]
      Left = 12
      Top = 9
      Width = 171
      Height = 20
      AutoSize = False
      Caption = 'lblForras'
      AutoHeight = False
    end
    inherited BitBtn1: TBitBtn
      Left = 190
    end
    object cmbZodiacSign: TComboBox
      Left = 307
      Top = 10
      Width = 148
      Height = 21
      Style = csDropDownList
      DropDownCount = 12
      ItemHeight = 13
      TabOrder = 1
      OnCloseUp = cmbZodiacSignCloseUp
      Items.Strings = (
        'Kos'
        'Bika'
        'Ikrek'
        'R'#225'k'
        'Oroszl'#225'n'
        'Sz'#369'z'
        'M'#233'rleg'
        'Skorpi'#243
        'Nyilas'
        'Bak'
        'V'#237'z'#246'nt'#337
        'Halak')
    end
  end
  inherited pnlClient: TPanel
    Width = 466
    Height = 358
    object imgZodiacSign: TImage
      Left = 12
      Top = 14
      Width = 102
      Height = 102
      ParentShowHint = False
      ShowHint = True
    end
    object lblTitle: TQzHtmlLabel2
      Left = 128
      Top = 14
      Width = 329
      Height = 20
      AutoSize = False
      Caption = 'lblTitle'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      WordWrap = True
      AutoHeight = False
    end
    object lblDescription: TQzHtmlLabel2
      Left = 12
      Top = 126
      Width = 441
      Height = 222
      AutoSize = False
      Caption = 'lblDescription'
      AutoHeight = False
    end
    object lblLongTitle: TQzHtmlLabel2
      Left = 128
      Top = 34
      Width = 329
      Height = 92
      AutoSize = False
      Caption = 'lblLongTitle'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      WordWrap = True
      AutoHeight = False
    end
    object edtSzulDatum: TDateTimePicker
      Left = 2
      Top = 335
      Width = 95
      Height = 21
      CalAlignment = dtaLeft
      Date = 40160.8274133681
      Time = 40160.8274133681
      DateFormat = dfShort
      DateMode = dmComboBox
      Enabled = False
      Kind = dtkDate
      ParseInput = False
      TabOrder = 0
      Visible = False
    end
  end
end
