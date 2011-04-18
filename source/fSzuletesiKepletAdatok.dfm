inherited frmSzuletesiKepletAdatok: TfrmSzuletesiKepletAdatok
  Caption = ''
  ClientHeight = 433
  ClientWidth = 589
  OldCreateOrder = True
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlClient: TPanel
    Width = 589
    Height = 383
    object grpSzemAdatok: TGroupBox
      Left = 4
      Top = 4
      Width = 342
      Height = 373
      Caption = ' Szem'#233'lyes adatok '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object Label1: TLabel
        Left = 10
        Top = 22
        Width = 28
        Height = 13
        Caption = 'N'#233'v:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edtNev: TEdit
        Left = 42
        Top = 18
        Width = 289
        Height = 21
        Color = clWhite
        TabOrder = 0
        Text = 'edtNev'
      end
      object rgpEset: TRadioGroup
        Left = 203
        Top = 46
        Width = 132
        Height = 105
        Caption = ' Eset '
        Color = clBtnFace
        Items.Strings = (
          'F'#233'rfi'
          'N'#337
          'Egy'#233'b')
        ParentColor = False
        TabOrder = 2
      end
      object rgpSzulIdo: TGroupBox
        Left = 6
        Top = 46
        Width = 192
        Height = 105
        Caption = ' Esem'#233'ny id'#337'pontja '
        TabOrder = 1
        object Label2: TLabel
          Left = 10
          Top = 35
          Width = 41
          Height = 13
          Caption = 'D'#225'tum:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label3: TLabel
          Left = 10
          Top = 78
          Width = 48
          Height = 13
          Caption = 'Id'#337'pont:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label17: TLabel
          Left = 70
          Top = 15
          Width = 16
          Height = 13
          Caption = #201'v'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label18: TLabel
          Left = 114
          Top = 15
          Width = 17
          Height = 13
          Caption = 'H'#243
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label19: TLabel
          Left = 151
          Top = 15
          Width = 24
          Height = 13
          Caption = 'Nap'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label20: TLabel
          Left = 93
          Top = 58
          Width = 21
          Height = 13
          Caption = #211'ra'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label21: TLabel
          Left = 123
          Top = 58
          Width = 27
          Height = 13
          Caption = 'Perc'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label22: TLabel
          Left = 159
          Top = 58
          Width = 18
          Height = 13
          Caption = 'Mp'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edtSzhEv: TEdit
          Left = 55
          Top = 32
          Width = 45
          Height = 21
          Color = clWhite
          MaxLength = 4
          TabOrder = 0
          Text = 'edtSzhEv'
          OnExit = edtSzhEvExit
        end
        object edtSzhHo: TEdit
          Left = 102
          Top = 32
          Width = 40
          Height = 21
          Color = clWhite
          MaxLength = 2
          TabOrder = 1
          Text = 'edtSzhHo'
          OnExit = edtSzhEvExit
        end
        object edtSzhNap: TEdit
          Left = 144
          Top = 32
          Width = 40
          Height = 21
          Color = clWhite
          MaxLength = 2
          TabOrder = 2
          Text = 'edtSzhNap'
          OnExit = edtSzhEvExit
        end
        object edtSzhOra: TEdit
          Left = 89
          Top = 75
          Width = 30
          Height = 21
          Color = clWhite
          MaxLength = 2
          TabOrder = 3
          Text = 'edtSzhOra'
          OnExit = edtSzhEvExit
        end
        object edtSzhPerc: TEdit
          Left = 121
          Top = 75
          Width = 30
          Height = 21
          Color = clWhite
          MaxLength = 2
          TabOrder = 4
          Text = 'edtSzhPerc'
          OnExit = edtSzhEvExit
        end
        object edtSzhMp: TEdit
          Left = 153
          Top = 75
          Width = 30
          Height = 21
          Color = clWhite
          MaxLength = 2
          TabOrder = 5
          Text = 'edtSzhMp'
          OnExit = edtSzhEvExit
        end
      end
      object rgpSzulHely: TGroupBox
        Left = 6
        Top = 151
        Width = 329
        Height = 215
        Caption = ' Esem'#233'ny helye '
        TabOrder = 3
        object lblTelepulesCimke: TLabel
          Left = 10
          Top = 21
          Width = 60
          Height = 13
          Caption = 'Telep'#252'l'#233's:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label13: TLabel
          Left = 11
          Top = 41
          Width = 44
          Height = 13
          Caption = 'Orsz'#225'g:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblOrszag: TLabel
          Left = 76
          Top = 41
          Width = 43
          Height = 13
          Caption = 'lblOrszag'
        end
        object edtTelepules: TEdit
          Left = 75
          Top = 18
          Width = 245
          Height = 21
          Color = clWhite
          TabOrder = 0
          Text = 'edtTelepules'
          OnChange = edtTelepulesChange
          OnEnter = edtTelepulesEnter
          OnExit = edtTelepulesExit
          OnKeyDown = edtTelepulesKeyDown
        end
        object rgpFoldRajzHelyzet: TGroupBox
          Left = 6
          Top = 59
          Width = 316
          Height = 66
          Caption = ' F'#246'ldrajzi helyzet '
          TabOrder = 1
          object Label5: TLabel
            Left = 10
            Top = 17
            Width = 66
            Height = 13
            Caption = 'Hossz'#250's'#225'g:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label6: TLabel
            Left = 10
            Top = 41
            Width = 62
            Height = 13
            Caption = 'Sz'#233'less'#233'g:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label7: TLabel
            Left = 126
            Top = 17
            Width = 4
            Height = 13
            Caption = #176
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label8: TLabel
            Left = 126
            Top = 40
            Width = 4
            Height = 13
            Caption = #176
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label9: TLabel
            Left = 177
            Top = 16
            Width = 2
            Height = 13
            Caption = #39
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label10: TLabel
            Left = 177
            Top = 40
            Width = 2
            Height = 13
            Caption = #39
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object edtHosszFok: TEdit
            Left = 82
            Top = 14
            Width = 40
            Height = 21
            Color = clWhite
            TabOrder = 0
            Text = 'edtHosszFok'
          end
          object edtSzelFok: TEdit
            Left = 82
            Top = 38
            Width = 40
            Height = 21
            Color = clWhite
            TabOrder = 3
            Text = 'edtSzelFok'
          end
          object edtHosszPerc: TEdit
            Left = 135
            Top = 14
            Width = 40
            Height = 21
            Color = clWhite
            TabOrder = 1
            Text = 'edtHosszPerc'
          end
          object edtSzelPerc: TEdit
            Left = 135
            Top = 38
            Width = 40
            Height = 21
            Color = clWhite
            TabOrder = 4
            Text = 'edtSzelPerc'
          end
          object pnlHosszusag: TPanel
            Left = 185
            Top = 16
            Width = 67
            Height = 19
            BevelOuter = bvNone
            Caption = '.'
            TabOrder = 2
            object rgbKeleti: TRadioButton
              Left = 2
              Top = 2
              Width = 30
              Height = 15
              Caption = 'K'
              TabOrder = 0
            end
            object rgbNyugati: TRadioButton
              Left = 32
              Top = 2
              Width = 35
              Height = 15
              Caption = 'Ny'
              TabOrder = 1
            end
          end
          object pnlSzelesseg: TPanel
            Left = 185
            Top = 38
            Width = 68
            Height = 19
            BevelOuter = bvNone
            Caption = '.'
            TabOrder = 5
            object rgbEszaki: TRadioButton
              Left = 2
              Top = 3
              Width = 30
              Height = 15
              Caption = #201
              TabOrder = 0
            end
            object rgbDeli: TRadioButton
              Left = 32
              Top = 3
              Width = 30
              Height = 15
              Caption = 'D'
              TabOrder = 1
            end
          end
        end
        object rgpIdozona: TGroupBox
          Left = 6
          Top = 126
          Width = 316
          Height = 82
          Caption = ' Id'#337'z'#243'na '
          TabOrder = 2
          object Label11: TLabel
            Left = 10
            Top = 16
            Width = 89
            Height = 13
            Caption = 'Id'#337'z'#243'na t'#237'pusa:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label12: TLabel
            Left = 10
            Top = 37
            Width = 51
            Height = 13
            Caption = 'Z'#243'naid'#337':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label14: TLabel
            Left = 10
            Top = 59
            Width = 115
            Height = 13
            Caption = 'Ny'#225'ri id'#337'sz'#225'm'#237't'#225's? :'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblIdozonaTipusa: TLabel
            Left = 102
            Top = 16
            Width = 80
            Height = 13
            Caption = 'lblIdozonaTipusa'
          end
          object chkNyariIdoszamitas: TCheckBox
            Left = 130
            Top = 58
            Width = 15
            Height = 17
            Caption = ' '
            Color = clBtnFace
            ParentColor = False
            TabOrder = 0
            OnClick = chkNyariIdoszamitasClick
          end
          object edtZonaOra: TEdit
            Left = 66
            Top = 34
            Width = 40
            Height = 21
            Color = clWhite
            Enabled = False
            TabOrder = 1
            Text = 'edtZonaOra'
          end
          object edtZonaPerc: TEdit
            Left = 108
            Top = 34
            Width = 40
            Height = 21
            Color = clWhite
            Enabled = False
            TabOrder = 2
            Text = 'edtZonaPerc'
          end
          object cmbTimeZoneSettings: TComboBox
            Left = 176
            Top = 34
            Width = 87
            Height = 21
            Style = csDropDownList
            Color = clWhite
            ItemHeight = 13
            ItemIndex = 1
            TabOrder = 3
            Text = 'Z'#243'na'
            OnChange = cmbTimeZoneSettingsChange
            Items.Strings = (
              'K'#233'zi'
              'Z'#243'na'
              'LMT')
          end
          object btnTimeZoneSelector: TBitBtn
            Left = 151
            Top = 33
            Width = 23
            Height = 25
            Caption = '...'
            TabOrder = 4
            OnClick = btnTimeZoneSelectorClick
          end
        end
        object dbgCityes: TDBGrid
          Left = 212
          Top = 8
          Width = 71
          Height = 21
          Color = clWhite
          DataSource = dsCity
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
          TabOrder = 3
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          OnCellClick = dbgCityesCellClick
          OnDblClick = dbgCityesDblClick
          OnExit = dbgCityesExit
          OnKeyDown = dbgCityesKeyDown
          Columns = <
            item
              Expanded = False
              FieldName = 'CityName'
              Title.Caption = 'V'#225'ros'
              Width = 125
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CountryCode'
              Title.Alignment = taCenter
              Title.Caption = 'Orsz.'
              Width = 37
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'TimeZoneCode'
              Title.Alignment = taCenter
              Title.Caption = 'Z'#243'na'
              Width = 37
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Longitude'
              Title.Alignment = taCenter
              Title.Caption = 'Hossz.'
              Width = 45
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Latitude'
              Title.Alignment = taCenter
              Title.Caption = 'Sz'#233'l.'
              Width = 45
              Visible = True
            end>
        end
      end
    end
    object rgpMegjegyz: TGroupBox
      Left = 352
      Top = 3
      Width = 232
      Height = 374
      Caption = ' Megjegyz'#233'sek / Feljegyz'#233'sek '
      TabOrder = 1
      object memNotes: TMemo
        Left = 7
        Top = 18
        Width = 218
        Height = 347
        BevelInner = bvLowered
        BevelKind = bkFlat
        BorderStyle = bsNone
        Color = clWhite
        Lines.Strings = (
          'memNotes')
        TabOrder = 0
      end
    end
  end
  inherited pnlBottom: TPanel
    Top = 383
    Width = 589
    inherited btnRendben: TBitBtn
      Left = 401
    end
    inherited btnMegsem: TBitBtn
      Left = 491
    end
    object btnMost: TBitBtn
      Left = 12
      Top = 12
      Width = 85
      Height = 25
      Caption = 'Most'
      TabOrder = 2
      TabStop = False
      Visible = False
      Glyph.Data = {
        76050000424D7605000000000000360000002800000015000000150000000100
        1800000000004005000000000000000000000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFCACACAB8B8B8FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFF858585000000A9A9A9FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFF2828280000002B2B2BFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD3D3
        D3000000707070000000EEEEEEFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8080800000
        0000FFFF565656636363FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF2E2E2E1F1F1F00FF
        FF00FFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1F1F1F00000000FF
        FF020202B4B4B4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD0D0D00000006E6E6E00FF
        FF000000EDEDEDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8A8A8A000000AFAFAF00FFFF00FF
        FF0101016F6F6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF4141410C0C0C00FFFF00FFFF00FFFF7272
        72131313FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF55555507070700FFFF00FFFFB2B2B20000
        00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF80808000000000FFFF00FFFF000000DDDD
        DDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFF29292916161600FFFF00FFFFACACAC000000B7B7
        B7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFDADADA01010164646400FFFF00FFFF00FFFF00FFFF000000E2E2
        E2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFF0404040D0D0D00FFFF00FFFF00FFFF00FFFF666666484848FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFF5B5B5B0000009A9A9A00FFFF00FFFF000000FFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFE0E0E00B0B0B1C1C1C333333717171FFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9C9C9C0A0A0AFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00}
    end
  end
  object dsCity: TDataSource
    Left = 298
    Top = 70
  end
end
