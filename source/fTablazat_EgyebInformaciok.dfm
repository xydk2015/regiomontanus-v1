inherited frmTablazat_EgyebInformaciok: TfrmTablazat_EgyebInformaciok
  Left = 383
  Top = 114
  Caption = 'Egy'#233'b inform'#225'ci'#243'k'
  ClientHeight = 367
  ClientWidth = 412
  OldCreateOrder = True
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBottom: TPanel
    Top = 326
    Width = 412
  end
  inherited pnlClient: TPanel
    Width = 412
    Height = 326
    object GroupBox1: TGroupBox
      Left = 6
      Top = 6
      Width = 400
      Height = 134
      Caption = ' Alapadatok '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object Label1: TLabel
        Left = 10
        Top = 25
        Width = 28
        Height = 13
        Caption = 'N'#233'v:'
      end
      object Label2: TLabel
        Left = 10
        Top = 45
        Width = 77
        Height = 13
        Caption = 'Sz'#252'let'#233'si id'#337':'
      end
      object Label3: TLabel
        Left = 10
        Top = 65
        Width = 87
        Height = 13
        Caption = 'Sz'#252'let'#233's helye:'
      end
      object Label4: TLabel
        Left = 10
        Top = 85
        Width = 50
        Height = 13
        Caption = 'Id'#337'z'#243'na:'
      end
      object Label5: TLabel
        Left = 10
        Top = 105
        Width = 88
        Height = 13
        Caption = 'Sz'#252'let'#233's napja:'
      end
      object lblNev: TLabel
        Left = 110
        Top = 25
        Width = 23
        Height = 13
        Caption = 'N'#233'v:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblSzulIdo: TLabel
        Left = 110
        Top = 45
        Width = 62
        Height = 13
        Caption = 'Sz'#252'let'#233'si id'#337':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblSzulHelye: TLabel
        Left = 110
        Top = 65
        Width = 71
        Height = 13
        Caption = 'Sz'#252'let'#233's helye:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblIdozona: TLabel
        Left = 110
        Top = 85
        Width = 41
        Height = 13
        Caption = 'Id'#337'z'#243'na:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblSzulNapja: TLabel
        Left = 110
        Top = 105
        Width = 72
        Height = 13
        Caption = 'Sz'#252'let'#233's napja:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
    end
    object GroupBox2: TGroupBox
      Left = 6
      Top = 143
      Width = 400
      Height = 176
      Caption = ' Csillag'#225'szati '#233's asztrol'#243'giai adatok '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object Label6: TLabel
        Left = 10
        Top = 25
        Width = 108
        Height = 13
        Caption = 'Ekliptika elhajl'#225'sa:'
      end
      object Label7: TLabel
        Left = 10
        Top = 45
        Width = 117
        Height = 13
        Caption = 'Univerz'#225'lis id'#337' (UT):'
      end
      object Label8: TLabel
        Left = 10
        Top = 65
        Width = 128
        Height = 13
        Caption = 'Szider'#225'lis (csillag) id'#337':'
      end
      object Label9: TLabel
        Left = 10
        Top = 85
        Width = 62
        Height = 13
        Caption = 'Ayanamsa:'
      end
      object Label10: TLabel
        Left = 10
        Top = 102
        Width = 14
        Height = 21
        Caption = 'a'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'KeplerFont70'
        Font.Style = []
        ParentFont = False
      end
      object Label11: TLabel
        Left = 10
        Top = 122
        Width = 12
        Height = 21
        Caption = 's'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'KeplerFont70'
        Font.Style = []
        ParentFont = False
      end
      object Label12: TLabel
        Left = 10
        Top = 142
        Width = 15
        Height = 21
        Caption = 'S'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'KeplerFont70'
        Font.Style = []
        ParentFont = False
      end
      object Label13: TLabel
        Left = 28
        Top = 106
        Width = 35
        Height = 13
        Caption = 'jegye:'
      end
      object Label14: TLabel
        Left = 28
        Top = 126
        Width = 35
        Height = 13
        Caption = 'jegye:'
      end
      object Label15: TLabel
        Left = 28
        Top = 146
        Width = 35
        Height = 13
        Caption = 'jegye:'
      end
      object lblEkliptika: TLabel
        Left = 150
        Top = 25
        Width = 87
        Height = 13
        Caption = 'Ekliptika elhajl'#225'sa:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblUT: TLabel
        Left = 150
        Top = 45
        Width = 95
        Height = 13
        Caption = 'Univerz'#225'lis id'#337' (UT):'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblSidTime: TLabel
        Left = 150
        Top = 65
        Width = 102
        Height = 13
        Caption = 'Szider'#225'lis (csillag) id'#337':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblAyanamsa: TLabel
        Left = 150
        Top = 85
        Width = 52
        Height = 13
        Caption = 'Ayanamsa:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblSUNSign: TLabel
        Left = 170
        Top = 106
        Width = 28
        Height = 13
        Caption = 'jegye:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblMoonSign: TLabel
        Left = 170
        Top = 126
        Width = 28
        Height = 13
        Caption = 'jegye:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblASCSign: TLabel
        Left = 170
        Top = 146
        Width = 28
        Height = 13
        Caption = 'jegye:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblSUNSignKepler: TLabel
        Left = 150
        Top = 102
        Width = 14
        Height = 21
        Caption = 'a'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'KeplerFont70'
        Font.Style = []
        ParentFont = False
      end
      object lblMoonSignKepler: TLabel
        Left = 150
        Top = 122
        Width = 12
        Height = 21
        Caption = 's'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'KeplerFont70'
        Font.Style = []
        ParentFont = False
      end
      object lblASCSignKepler: TLabel
        Left = 150
        Top = 142
        Width = 15
        Height = 21
        Caption = 'S'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'KeplerFont70'
        Font.Style = []
        ParentFont = False
      end
    end
  end
end
