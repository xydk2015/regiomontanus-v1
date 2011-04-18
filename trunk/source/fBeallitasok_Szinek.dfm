inherited frmBeallitasok_Szinek: TfrmBeallitasok_Szinek
  Left = 677
  Top = 121
  Caption = 'Megjelen'#237'tend'#337' sz'#237'nek'
  ClientHeight = 485
  ClientWidth = 366
  OldCreateOrder = True
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlClient: TPanel
    Width = 366
    Height = 435
    object pcBeallitasok: TPageControl
      Left = 1
      Top = 1
      Width = 364
      Height = 433
      ActivePage = tsSheet01
      Align = alClient
      TabIndex = 0
      TabOrder = 0
      TabStop = False
      object tsSheet01: TTabSheet
        Caption = 'Sz'#237'nek I.'
        object GroupBox1: TGroupBox
          Left = 0
          Top = 0
          Width = 175
          Height = 102
          Caption = ' Elemek sz'#237'nei '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object Label1: TLabel
            Left = 16
            Top = 19
            Width = 39
            Height = 13
            Caption = 'T'#252'zes:'
          end
          object Label2: TLabel
            Left = 16
            Top = 38
            Width = 42
            Height = 13
            Caption = 'F'#246'ldes:'
          end
          object Label3: TLabel
            Left = 16
            Top = 56
            Width = 53
            Height = 13
            Caption = 'Leveg'#337's:'
          end
          object Label4: TLabel
            Left = 16
            Top = 74
            Width = 35
            Height = 13
            Caption = 'Vizes:'
          end
          object pnlTuzes: TPanel
            Left = 77
            Top = 16
            Width = 86
            Height = 20
            Cursor = crHandPoint
            BevelInner = bvLowered
            Color = 1770491
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnClick = pnlTuzesClick
          end
          object pnlFoldes: TPanel
            Left = 77
            Top = 34
            Width = 86
            Height = 20
            Cursor = crHandPoint
            BevelInner = bvLowered
            Color = 182795
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            OnClick = pnlTuzesClick
          end
          object pnlVizes: TPanel
            Left = 77
            Top = 71
            Width = 86
            Height = 20
            Cursor = crHandPoint
            BevelInner = bvLowered
            Color = 16738858
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            OnClick = pnlTuzesClick
          end
          object pnlLevegos: TPanel
            Left = 77
            Top = 52
            Width = 86
            Height = 20
            Cursor = crHandPoint
            BevelInner = bvLowered
            Color = 5636095
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
            OnClick = pnlTuzesClick
          end
        end
        object GroupBox2: TGroupBox
          Left = 2
          Top = 103
          Width = 353
          Height = 298
          Caption = ' F'#233'nysz'#246'gek sz'#237'nei '#233's jel'#246'l'#233'sek '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          object Label5: TLabel
            Left = 16
            Top = 19
            Width = 67
            Height = 13
            Caption = 'Egy'#252'tt'#225'll'#225's:'
          end
          object Label6: TLabel
            Left = 16
            Top = 88
            Width = 75
            Height = 13
            Caption = 'Nyolcadf'#233'ny:'
          end
          object Label7: TLabel
            Left = 16
            Top = 67
            Width = 72
            Height = 13
            Caption = 'Negyedf'#233'ny:'
          end
          object Label8: TLabel
            Left = 16
            Top = 46
            Width = 82
            Height = 13
            Caption = 'Szemben'#225'll'#225's:'
          end
          object Label9: TLabel
            Left = 16
            Top = 109
            Width = 113
            Height = 13
            Caption = 'H'#225'rom-nyolcadf'#233'ny:'
          end
          object Label10: TLabel
            Left = 16
            Top = 179
            Width = 96
            Height = 13
            Caption = 'Tizenkettedf'#233'ny:'
          end
          object Label11: TLabel
            Left = 16
            Top = 157
            Width = 63
            Height = 13
            Caption = 'Hatodf'#233'ny:'
          end
          object Label12: TLabel
            Left = 16
            Top = 136
            Width = 72
            Height = 13
            Caption = 'Harmadf'#233'ny:'
          end
          object Label13: TLabel
            Left = 16
            Top = 200
            Width = 109
            Height = 13
            Caption = #214't-tizenkettedf'#233'ny:'
          end
          object Label14: TLabel
            Left = 16
            Top = 271
            Width = 77
            Height = 13
            Caption = 'K'#233't-'#246't'#246'df'#233'ny:'
          end
          object Label15: TLabel
            Left = 16
            Top = 248
            Width = 60
            Height = 13
            Caption = 'Tizedf'#233'ny:'
          end
          object Label16: TLabel
            Left = 16
            Top = 227
            Width = 56
            Height = 13
            Caption = #214't'#246'df'#233'ny:'
          end
          object pnl01: TPanel
            Left = 135
            Top = 16
            Width = 86
            Height = 22
            Cursor = crHandPoint
            BevelInner = bvLowered
            Color = 1770491
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnClick = pnlTuzesClick
          end
          object pnl02: TPanel
            Left = 135
            Top = 43
            Width = 86
            Height = 22
            Cursor = crHandPoint
            BevelInner = bvLowered
            Color = 182795
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            OnClick = pnlTuzesClick
          end
          object pnl03: TPanel
            Left = 135
            Top = 64
            Width = 86
            Height = 22
            Cursor = crHandPoint
            BevelInner = bvLowered
            Color = 5636095
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            OnClick = pnlTuzesClick
          end
          object pnl04: TPanel
            Left = 135
            Top = 85
            Width = 86
            Height = 22
            Cursor = crHandPoint
            BevelInner = bvLowered
            Color = 16738858
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
            OnClick = pnlTuzesClick
          end
          object pnl05: TPanel
            Left = 135
            Top = 106
            Width = 86
            Height = 22
            Cursor = crHandPoint
            BevelInner = bvLowered
            Color = 1770491
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 4
            OnClick = pnlTuzesClick
          end
          object pnl06: TPanel
            Left = 135
            Top = 133
            Width = 86
            Height = 22
            Cursor = crHandPoint
            BevelInner = bvLowered
            Color = 182795
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 5
            OnClick = pnlTuzesClick
          end
          object pnl07: TPanel
            Left = 135
            Top = 154
            Width = 86
            Height = 22
            Cursor = crHandPoint
            BevelInner = bvLowered
            Color = 5636095
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 6
            OnClick = pnlTuzesClick
          end
          object pnl08: TPanel
            Left = 135
            Top = 176
            Width = 86
            Height = 22
            Cursor = crHandPoint
            BevelInner = bvLowered
            Color = 16738858
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 7
            OnClick = pnlTuzesClick
          end
          object pnl09: TPanel
            Left = 135
            Top = 197
            Width = 86
            Height = 22
            Cursor = crHandPoint
            BevelInner = bvLowered
            Color = 1770491
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 8
            OnClick = pnlTuzesClick
          end
          object pnl10: TPanel
            Left = 135
            Top = 224
            Width = 86
            Height = 22
            Cursor = crHandPoint
            BevelInner = bvLowered
            Color = 182795
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 9
            OnClick = pnlTuzesClick
          end
          object pnl11: TPanel
            Left = 135
            Top = 245
            Width = 86
            Height = 22
            Cursor = crHandPoint
            BevelInner = bvLowered
            Color = 5636095
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 10
            OnClick = pnlTuzesClick
          end
          object pnl12: TPanel
            Left = 135
            Top = 267
            Width = 86
            Height = 22
            Cursor = crHandPoint
            BevelInner = bvLowered
            Color = 16738858
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 11
            OnClick = pnlTuzesClick
          end
          object cmb01: TComboBox
            Left = 230
            Top = 16
            Width = 94
            Height = 22
            AutoComplete = False
            Style = csOwnerDrawFixed
            DropDownCount = 3
            ItemHeight = 16
            ItemIndex = 0
            TabOrder = 12
            Text = 'Sima'
            OnDrawItem = cmb01DrawItem
            Items.Strings = (
              'Sima'
              'Szaggatott'
              'Pettyezett')
          end
          object cmb02: TComboBox
            Left = 230
            Top = 43
            Width = 94
            Height = 22
            AutoComplete = False
            Style = csOwnerDrawFixed
            DropDownCount = 3
            ItemHeight = 16
            ItemIndex = 0
            TabOrder = 13
            Text = 'Sima'
            OnDrawItem = cmb01DrawItem
            Items.Strings = (
              'Sima'
              'Szaggatott'
              'Pettyezett')
          end
          object cmb03: TComboBox
            Left = 230
            Top = 64
            Width = 94
            Height = 22
            AutoComplete = False
            Style = csOwnerDrawFixed
            DropDownCount = 3
            ItemHeight = 16
            ItemIndex = 0
            TabOrder = 14
            Text = 'Sima'
            OnDrawItem = cmb01DrawItem
            Items.Strings = (
              'Sima'
              'Szaggatott'
              'Pettyezett')
          end
          object cmb04: TComboBox
            Left = 230
            Top = 85
            Width = 94
            Height = 22
            AutoComplete = False
            Style = csOwnerDrawFixed
            DropDownCount = 3
            ItemHeight = 16
            ItemIndex = 0
            TabOrder = 15
            Text = 'Sima'
            OnDrawItem = cmb01DrawItem
            Items.Strings = (
              'Sima'
              'Szaggatott'
              'Pettyezett')
          end
          object cmb06: TComboBox
            Left = 230
            Top = 133
            Width = 94
            Height = 22
            AutoComplete = False
            Style = csOwnerDrawFixed
            DropDownCount = 3
            ItemHeight = 16
            ItemIndex = 0
            TabOrder = 16
            Text = 'Sima'
            OnDrawItem = cmb01DrawItem
            Items.Strings = (
              'Sima'
              'Szaggatott'
              'Pettyezett')
          end
          object cmb08: TComboBox
            Left = 230
            Top = 176
            Width = 94
            Height = 22
            AutoComplete = False
            Style = csOwnerDrawFixed
            DropDownCount = 3
            ItemHeight = 16
            ItemIndex = 0
            TabOrder = 17
            Text = 'Sima'
            OnDrawItem = cmb01DrawItem
            Items.Strings = (
              'Sima'
              'Szaggatott'
              'Pettyezett')
          end
          object cmb10: TComboBox
            Left = 230
            Top = 224
            Width = 94
            Height = 22
            AutoComplete = False
            Style = csOwnerDrawFixed
            DropDownCount = 3
            ItemHeight = 16
            ItemIndex = 0
            TabOrder = 18
            Text = 'Sima'
            OnDrawItem = cmb01DrawItem
            Items.Strings = (
              'Sima'
              'Szaggatott'
              'Pettyezett')
          end
          object cmb12: TComboBox
            Left = 230
            Top = 267
            Width = 94
            Height = 22
            AutoComplete = False
            Style = csOwnerDrawFixed
            DropDownCount = 3
            ItemHeight = 16
            ItemIndex = 0
            TabOrder = 19
            Text = 'Sima'
            OnDrawItem = cmb01DrawItem
            Items.Strings = (
              'Sima'
              'Szaggatott'
              'Pettyezett')
          end
          object cmb05: TComboBox
            Left = 230
            Top = 106
            Width = 94
            Height = 22
            AutoComplete = False
            Style = csOwnerDrawFixed
            DropDownCount = 3
            ItemHeight = 16
            ItemIndex = 0
            TabOrder = 20
            Text = 'Sima'
            OnDrawItem = cmb01DrawItem
            Items.Strings = (
              'Sima'
              'Szaggatott'
              'Pettyezett')
          end
          object cmb07: TComboBox
            Left = 230
            Top = 154
            Width = 94
            Height = 22
            AutoComplete = False
            Style = csOwnerDrawFixed
            DropDownCount = 3
            ItemHeight = 16
            ItemIndex = 0
            TabOrder = 21
            Text = 'Sima'
            OnDrawItem = cmb01DrawItem
            Items.Strings = (
              'Sima'
              'Szaggatott'
              'Pettyezett')
          end
          object cmb09: TComboBox
            Left = 230
            Top = 197
            Width = 94
            Height = 22
            AutoComplete = False
            Style = csOwnerDrawFixed
            DropDownCount = 3
            ItemHeight = 16
            ItemIndex = 0
            TabOrder = 22
            Text = 'Sima'
            OnDrawItem = cmb01DrawItem
            Items.Strings = (
              'Sima'
              'Szaggatott'
              'Pettyezett')
          end
          object cmb11: TComboBox
            Left = 230
            Top = 245
            Width = 94
            Height = 22
            AutoComplete = False
            Style = csOwnerDrawFixed
            DropDownCount = 3
            ItemHeight = 16
            ItemIndex = 0
            TabOrder = 23
            Text = 'Sima'
            OnDrawItem = cmb01DrawItem
            Items.Strings = (
              'Sima'
              'Szaggatott'
              'Pettyezett')
          end
        end
        object GroupBox3: TGroupBox
          Left = 179
          Top = 0
          Width = 174
          Height = 102
          Caption = ' Tov'#225'bbi sz'#237'nek '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
          object Label17: TLabel
            Left = 5
            Top = 29
            Width = 69
            Height = 29
            AutoSize = False
            Caption = 'F'#233'nysz'#246'gek h'#225'tt'#233'rsz'#237'ne:'
            WordWrap = True
          end
          object pnlAspectBackground: TPanel
            Left = 79
            Top = 34
            Width = 86
            Height = 20
            Cursor = crHandPoint
            BevelInner = bvLowered
            Color = 1770491
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnClick = pnlTuzesClick
          end
        end
      end
    end
  end
  inherited pnlBottom: TPanel
    Top = 435
    Width = 366
    inherited btnRendben: TBitBtn
      Left = 178
    end
    inherited btnMegsem: TBitBtn
      Left = 268
    end
  end
  object dlgColor: TColorDialog
    Ctl3D = True
    Options = [cdFullOpen, cdPreventFullOpen, cdAnyColor]
    Left = 328
    Top = 2
  end
end
