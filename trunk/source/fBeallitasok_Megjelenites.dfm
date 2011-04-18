inherited frmBeallitasok_Megjelenites: TfrmBeallitasok_Megjelenites
  Left = 284
  Top = 125
  Caption = 'Megjelen'#237'tend'#337' elemek a sz'#252'let'#233'si k'#233'pleten'
  ClientHeight = 437
  ClientWidth = 373
  OldCreateOrder = True
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlClient: TPanel
    Width = 373
    Height = 387
    object pcBeallitasok: TPageControl
      Left = 1
      Top = 1
      Width = 371
      Height = 385
      ActivePage = tsSheet04
      Align = alClient
      TabOrder = 0
      TabStop = False
      object tsSheet01: TTabSheet
        Caption = #193'ltal'#225'nos I.'
        object GroupBox1: TGroupBox
          Left = 0
          Top = 0
          Width = 105
          Height = 200
          Caption = ' Zodi'#225'kusjelek '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object chkbZodiakusJelek: TCheckListBox
            Left = 8
            Top = 16
            Width = 83
            Height = 157
            BevelInner = bvNone
            BevelOuter = bvRaised
            BorderStyle = bsNone
            Color = clBtnFace
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ItemHeight = 13
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
            ParentFont = False
            TabOrder = 0
          end
          object chkbKellAnalogPlaneta: TCheckListBox
            Left = 8
            Top = 179
            Width = 89
            Height = 14
            BevelInner = bvNone
            BevelOuter = bvRaised
            BorderStyle = bsNone
            Color = clBtnFace
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ItemHeight = 13
            Items.Strings = (
              'Anal'#243'g plan'#233'ta')
            ParentFont = False
            TabOrder = 1
          end
        end
        object GroupBox2: TGroupBox
          Left = 239
          Top = 0
          Width = 122
          Height = 200
          Caption = ' Tengelyek '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          object chkbTengelyek: TCheckListBox
            Left = 8
            Top = 16
            Width = 105
            Height = 157
            BevelInner = bvNone
            BevelOuter = bvRaised
            BorderStyle = bsNone
            Color = clBtnFace
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ItemHeight = 13
            Items.Strings = (
              'Ascendens'
              'Medium Coeli'
              'Descendens'
              'Imum Coeli'
              'Vertex'
              'Keletpont'
              'Koascendens'
              'Sarki ascendens')
            ParentFont = False
            TabOrder = 0
          end
        end
        object GroupBox3: TGroupBox
          Left = 108
          Top = 0
          Width = 128
          Height = 200
          Caption = ' H'#225'zak '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
          object Label1: TLabel
            Left = 10
            Top = 179
            Width = 106
            Height = 13
            Caption = 'Hat'#225'rai     Sz'#225'mok'
          end
          object chkbHazHatarok: TCheckListBox
            Left = 8
            Top = 16
            Width = 53
            Height = 157
            BevelInner = bvNone
            BevelOuter = bvRaised
            BorderStyle = bsNone
            Color = clBtnFace
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ItemHeight = 13
            Items.Strings = (
              '1'
              '2'
              '3'
              '4'
              '5'
              '6'
              '7'
              '8'
              '9'
              '10'
              '11'
              '12')
            ParentFont = False
            TabOrder = 0
          end
          object chkbHazSzamok: TCheckListBox
            Left = 70
            Top = 16
            Width = 48
            Height = 157
            BevelInner = bvNone
            BevelOuter = bvRaised
            BorderStyle = bsNone
            Color = clBtnFace
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ItemHeight = 13
            Items.Strings = (
              '1'
              '2'
              '3'
              '4'
              '5'
              '6'
              '7'
              '8'
              '9'
              '10'
              '11'
              '12')
            ParentFont = False
            TabOrder = 1
          end
        end
        object GroupBox4: TGroupBox
          Left = 0
          Top = 200
          Width = 105
          Height = 154
          Caption = ' Bolyg'#243'k '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 3
          object chkbBolygok: TCheckListBox
            Left = 8
            Top = 16
            Width = 83
            Height = 133
            BevelInner = bvNone
            BevelOuter = bvRaised
            BorderStyle = bsNone
            Color = clBtnFace
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ItemHeight = 13
            Items.Strings = (
              'Nap'
              'Hold'
              'Merk'#250'r'
              'V'#233'nusz'
              'Mars'
              'Jupiter'
              'Szaturnusz'
              'Ur'#225'nusz'
              'Neptunusz'
              'Pl'#250't'#243)
            ParentFont = False
            TabOrder = 0
          end
        end
        object GroupBox5: TGroupBox
          Left = 108
          Top = 200
          Width = 105
          Height = 154
          Caption = ' Kisbolyg'#243'k '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 4
          object chkbKisBolygok: TCheckListBox
            Left = 8
            Top = 16
            Width = 83
            Height = 109
            BevelInner = bvNone
            BevelOuter = bvRaised
            BorderStyle = bsNone
            Color = clBtnFace
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ItemHeight = 13
            Items.Strings = (
              'Chiron'
              'Pholus'
              'Ceres'
              'Pallas Athene'
              'Juno'
              'Vesta'
              'Eris'
              'Lilith')
            ParentFont = False
            TabOrder = 0
          end
        end
        object GroupBox7: TGroupBox
          Left = 216
          Top = 200
          Width = 145
          Height = 154
          Caption = ' Csom'#243'pontok '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 5
          object chkbHoldcsomo: TCheckListBox
            Left = 8
            Top = 16
            Width = 129
            Height = 29
            BevelInner = bvNone
            BevelOuter = bvRaised
            BorderStyle = bsNone
            Color = clBtnFace
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ItemHeight = 13
            Items.Strings = (
              'Felsz'#225'll'#243' Holdcsom'#243
              'Lesz'#225'll'#243' Holdcsom'#243)
            ParentFont = False
            TabOrder = 0
          end
          object chkbHoldocsomoTipus: TCheckListBox
            Left = 8
            Top = 52
            Width = 129
            Height = 29
            BevelInner = bvNone
            BevelOuter = bvRaised
            BorderStyle = bsNone
            Color = clBtnFace
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ItemHeight = 13
            Items.Strings = (
              'k'#246'zepes'
              'val'#243'di')
            ParentFont = False
            TabOrder = 1
          end
        end
      end
      object tsSheet04: TTabSheet
        Caption = #193'ltal'#225'nos II.'
        ImageIndex = 3
        object GroupBox18: TGroupBox
          Left = 0
          Top = 1
          Width = 173
          Height = 103
          Caption = ' Fokjel'#246'l'#337' kijelz'#233'se '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          object chkbFokjelolok: TCheckListBox
            Left = 8
            Top = 19
            Width = 156
            Height = 67
            BevelInner = bvNone
            BevelOuter = bvRaised
            BorderStyle = bsNone
            Color = clBtnFace
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ItemHeight = 13
            Items.Strings = (
              'Zodi'#225'kusk'#246'r k'#252'ls'#337
              'Zodi'#225'kusk'#246'r bels'#337
              'F'#233'nysz'#246'g k'#246'r bels'#337
              'H'#225'z foksz'#225'm'#225'nak kijelz'#233'se'
              'Foksz'#225'm kijelz'#233'se k'#252'l'#246'n '#237'ven')
            ParentFont = False
            TabOrder = 0
          end
        end
        object GroupBox19: TGroupBox
          Left = 176
          Top = 0
          Width = 185
          Height = 39
          Caption = ' Program ind'#237't'#225'sa '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
          object chkInditasTeljesMeret: TCheckListBox
            Left = 8
            Top = 16
            Width = 168
            Height = 14
            BevelInner = bvNone
            BevelOuter = bvRaised
            BorderStyle = bsNone
            Color = clBtnFace
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ItemHeight = 13
            Items.Strings = (
              'Ind'#237't'#225's teljes m'#233'retben?')
            ParentFont = False
            TabOrder = 0
          end
        end
        object rgrpEnallapotJelolesMod: TRadioGroup
          Left = 176
          Top = 39
          Width = 185
          Height = 65
          Caption = ' '#201'n'#225'llapot jel'#246'l'#233'si m'#243'dja '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ItemIndex = 0
          Items.Strings = (
            'K'#246'r'
            'H'#225'romsz'#246'g')
          ParentFont = False
          TabOrder = 3
        end
        object GroupBox9: TGroupBox
          Left = 0
          Top = 104
          Width = 215
          Height = 107
          Caption = ' Egy'#233'b megjelen'#237't'#233'sek '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object chkbEgyebMegjelenitesek: TCheckListBox
            Left = 8
            Top = 19
            Width = 199
            Height = 81
            BevelInner = bvNone
            BevelOuter = bvRaised
            BorderStyle = bsNone
            Color = clBtnFace
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ItemHeight = 13
            Items.Strings = (
              #201'n'#225'llapotok megjelen'#237't'#233'se'
              'Retrogr'#225'd-jelz'#337
              'Bolyg'#243' foksz'#225'm kijelz'#233's'
              'H'#225'zurak kijelz'#233'se'
              'Sarokh'#225'zak arab sz'#225'mokkal'
              #201'n'#225'llapot a bolyg'#243' eredeti helyzet'#233'n'#233'l')
            ParentFont = False
            TabOrder = 0
          end
        end
        object GroupBox20: TGroupBox
          Left = 219
          Top = 104
          Width = 142
          Height = 107
          Caption = ' Bet'#369'm'#233'ret n'#246'vel'#233'se '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 4
          object Label8: TLabel
            Left = 8
            Top = 24
            Width = 42
            Height = 13
            Caption = 'M'#233'rt'#233'ke:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label10: TLabel
            Left = 8
            Top = 46
            Width = 126
            Height = 52
            Alignment = taCenter
            AutoSize = False
            Caption = 
              'Ezzel az '#233'rt'#233'kkel tudjuk az eredeti m'#233'rethez k'#233'pest n'#246'velni, vag' +
              'y cs'#246'kkenteni a megjelen'#337' bet'#369'm'#233'retet!'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            WordWrap = True
          end
          object edtBetumeretSzorzo: TMaskEdit
            Left = 54
            Top = 21
            Width = 31
            Height = 21
            EditMask = '0.0'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            MaxLength = 3
            ParentFont = False
            TabOrder = 0
            Text = ' . '
          end
        end
      end
      object tsSheet02: TTabSheet
        Caption = 'F'#233'nysz'#246'gek'
        ImageIndex = 1
        object GroupBox6: TGroupBox
          Left = 0
          Top = 0
          Width = 173
          Height = 201
          Caption = ' F'#233'nysz'#246'gek '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object Label2: TLabel
            Left = 10
            Top = 176
            Width = 156
            Height = 13
            Caption = 'Megnevez'#233'sek          Symb'
          end
          object chkbFenyszogek: TCheckListBox
            Left = 8
            Top = 16
            Width = 144
            Height = 157
            BevelInner = bvNone
            BevelOuter = bvRaised
            BorderStyle = bsNone
            Color = clBtnFace
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ItemHeight = 13
            Items.Strings = (
              'Egy'#252'tt'#225'll'#225's'
              'Szemben'#225'll'#225's'
              'Negyedf'#233'ny'
              'Nyolcadf'#233'ny'
              'H'#225'rom-nyolcadf'#233'ny'
              'Harmadf'#233'ny'
              'Hatodf'#233'ny'
              'Tizenkettedf'#233'ny'
              #214't-tizenkettedf'#233'ny'
              #214't'#246'df'#233'ny'
              'Tizedf'#233'ny'
              'K'#233't-'#246't'#246'df'#233'ny')
            ParentFont = False
            TabOrder = 0
          end
          object chkbFenyszogJelek: TCheckListBox
            Left = 152
            Top = 16
            Width = 15
            Height = 157
            BevelInner = bvNone
            BevelOuter = bvRaised
            BorderStyle = bsNone
            Color = clBtnFace
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ItemHeight = 13
            Items.Strings = (
              ' '
              ' '
              ' '
              ' '
              ' '
              ' '
              ' '
              ' '
              ' '
              ' '
              ' '
              ' ')
            ParentFont = False
            TabOrder = 1
          end
        end
        object GroupBox8: TGroupBox
          Left = 176
          Top = 0
          Width = 185
          Height = 354
          Caption = ' F'#233'nysz'#246'gelt elemek '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          object Label3: TLabel
            Left = 10
            Top = 16
            Width = 60
            Height = 13
            Caption = 'Tengelyek'
          end
          object Label4: TLabel
            Left = 10
            Top = 63
            Width = 37
            Height = 13
            Caption = 'H'#225'zak'
          end
          object Label5: TLabel
            Left = 96
            Top = 63
            Width = 46
            Height = 13
            Caption = 'Bolyg'#243'k'
          end
          object Label6: TLabel
            Left = 96
            Top = 217
            Width = 62
            Height = 13
            Caption = 'Kisbolyg'#243'k'
          end
          object Label7: TLabel
            Left = 96
            Top = 16
            Width = 77
            Height = 13
            Caption = 'Csom'#243'pontok'
          end
          object chkbFenyszogeltTengelyek: TCheckListBox
            Left = 8
            Top = 31
            Width = 85
            Height = 30
            BevelInner = bvNone
            BevelOuter = bvRaised
            BorderStyle = bsNone
            Color = clBtnFace
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ItemHeight = 13
            Items.Strings = (
              'Ascendens'
              'Medium Coeli')
            ParentFont = False
            TabOrder = 0
          end
          object chkbFenyszogeltHazak: TCheckListBox
            Left = 8
            Top = 80
            Width = 53
            Height = 157
            BevelInner = bvNone
            BevelOuter = bvRaised
            BorderStyle = bsNone
            Color = clBtnFace
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ItemHeight = 13
            Items.Strings = (
              '1'
              '2'
              '3'
              '4'
              '5'
              '6'
              '7'
              '8'
              '9'
              '10'
              '11'
              '12')
            ParentFont = False
            TabOrder = 1
          end
          object chkbFenyszogeltBolygok: TCheckListBox
            Left = 95
            Top = 80
            Width = 84
            Height = 133
            BevelInner = bvNone
            BevelOuter = bvRaised
            BorderStyle = bsNone
            Color = clBtnFace
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ItemHeight = 13
            Items.Strings = (
              'Nap'
              'Hold'
              'Merk'#250'r'
              'V'#233'nusz'
              'Mars'
              'Jupiter'
              'Szaturnusz'
              'Ur'#225'nusz'
              'Neptunusz'
              'Pl'#250't'#243)
            ParentFont = False
            TabOrder = 2
          end
          object chkbFenyszogeltKisBolygok: TCheckListBox
            Left = 95
            Top = 236
            Width = 84
            Height = 106
            BevelInner = bvNone
            BevelOuter = bvRaised
            BorderStyle = bsNone
            Color = clBtnFace
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ItemHeight = 13
            Items.Strings = (
              'Chiron'
              'Pholus'
              'Ceres'
              'Pallas Athene'
              'Juno'
              'Vesta'
              'Eris'
              'Lilith')
            ParentFont = False
            TabOrder = 3
          end
          object chkbFenyszogeltCsompontok: TCheckListBox
            Left = 95
            Top = 32
            Width = 84
            Height = 29
            BevelInner = bvNone
            BevelOuter = bvRaised
            BorderStyle = bsNone
            Color = clBtnFace
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ItemHeight = 13
            Items.Strings = (
              'Felsz. Holdcs.'
              'Lesz. Holdcs.')
            ParentFont = False
            TabOrder = 4
          end
        end
      end
      object tsSheet03: TTabSheet
        Caption = 'Nyomtat'#225's '#233's Export'#225'l'#225's'
        ImageIndex = 2
        object GroupBox10: TGroupBox
          Left = 0
          Top = 0
          Width = 361
          Height = 354
          Caption = ' Nyomtat'#225'si '#233's export'#225'l'#225'si be'#225'll'#237't'#225'sok '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object Label9: TLabel
            Left = 10
            Top = 16
            Width = 343
            Height = 27
            Alignment = taCenter
            AutoSize = False
            Caption = 
              'FONTOS! A nyomtat'#225'si '#233's az export'#225'land'#243' k'#233'p az el'#337'z'#337' f'#252'leken be'#225 +
              'll'#237'tottakat is figyelembe veszi!'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clHotLight
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            WordWrap = True
          end
          object GroupBox11: TGroupBox
            Left = 6
            Top = 44
            Width = 173
            Height = 94
            Caption = '     Bolyg'#243'k t'#225'bl'#225'zata '
            TabOrder = 0
            object chkbBolygoTablazat: TCheckListBox
              Left = 8
              Top = 17
              Width = 155
              Height = 53
              BevelInner = bvNone
              BevelOuter = bvRaised
              BorderStyle = bsNone
              Color = clBtnFace
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ItemHeight = 13
              Items.Strings = (
                'Foksz'#225'ma'
                'Zodi'#225'kusjegye'
                'Mely h'#225'zban van'
                'Mely h'#225'z(ak) ura(i)')
              ParentFont = False
              TabOrder = 0
            end
            object chkKellBolygoTablazat: TCheckListBox
              Left = 8
              Top = 1
              Width = 17
              Height = 14
              BevelInner = bvNone
              BevelOuter = bvRaised
              BorderStyle = bsNone
              Color = clBtnFace
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ItemHeight = 13
              Items.Strings = (
                ' ')
              ParentFont = False
              TabOrder = 1
            end
          end
          object GroupBox12: TGroupBox
            Left = 182
            Top = 44
            Width = 173
            Height = 54
            Caption = '     H'#225'zak t'#225'bl'#225'zata '
            TabOrder = 1
            object chkbHazTablazat: TCheckListBox
              Left = 8
              Top = 17
              Width = 157
              Height = 29
              BevelInner = bvNone
              BevelOuter = bvRaised
              BorderStyle = bsNone
              Color = clBtnFace
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ItemHeight = 13
              Items.Strings = (
                'Foksz'#225'ma'
                'Zodi'#225'kusjegye')
              ParentFont = False
              TabOrder = 0
            end
            object chkKellHazTablazat: TCheckListBox
              Left = 8
              Top = 1
              Width = 17
              Height = 14
              BevelInner = bvNone
              BevelOuter = bvRaised
              BorderStyle = bsNone
              Color = clBtnFace
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ItemHeight = 13
              Items.Strings = (
                ' ')
              ParentFont = False
              TabOrder = 1
            end
          end
          object GroupBox13: TGroupBox
            Left = 182
            Top = 98
            Width = 173
            Height = 39
            Caption = '     F'#233'nysz'#246'gek t'#225'bl'#225'zata '
            TabOrder = 2
            object chkKellFenyszogTablazat: TCheckListBox
              Left = 8
              Top = 1
              Width = 17
              Height = 14
              BevelInner = bvNone
              BevelOuter = bvRaised
              BorderStyle = bsNone
              Color = clBtnFace
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ItemHeight = 13
              Items.Strings = (
                'Kell t'#225'bl'#225'zat?')
              ParentFont = False
              TabOrder = 0
            end
          end
          object GroupBox14: TGroupBox
            Left = 6
            Top = 138
            Width = 173
            Height = 210
            Caption = '     Fejl'#233'c-kijelz'#233'sek '
            TabOrder = 3
            object chkKellFejlec: TCheckListBox
              Left = 8
              Top = 1
              Width = 17
              Height = 14
              BevelInner = bvNone
              BevelOuter = bvRaised
              BorderStyle = bsNone
              Color = clBtnFace
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ItemHeight = 13
              Items.Strings = (
                'Kell fejl'#233'c?')
              ParentFont = False
              TabOrder = 0
            end
            object chkbFejlecKijelzesek: TCheckListBox
              Left = 8
              Top = 17
              Width = 155
              Height = 156
              BevelInner = bvNone
              BevelOuter = bvRaised
              BorderStyle = bsNone
              Color = clBtnFace
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ItemHeight = 13
              Items.Strings = (
                'N'#233'v'
                'Sz'#252'let'#233's ideje ('#233#233#233#233'.hh.nn)'
                'Sz'#252'let'#233's ideje ('#243#243'.pp.mp)'
                'Sz'#252'let'#233's napja'
                'Id'#337'z'#243'na'
                'Ny'#225'ri id'#337'sz'#225'm'#237't'#225's'
                'Univerz'#225'lis id'#337' (UT)'
                'Csillagid'#337' (ST)'
                'Nyomtat'#225'si k'#233'p t'#237'pusa'
                'Sz'#252'let'#233's telep'#252'l'#233'se'
                'Telep'#252'l'#233's koordin'#225't'#225'i'
                'H'#225'zrendszer')
              ParentFont = False
              TabOrder = 1
            end
          end
          object GroupBox15: TGroupBox
            Left = 182
            Top = 177
            Width = 173
            Height = 132
            Caption = '     L'#225'bl'#233'c-kijelz'#233'sek '
            TabOrder = 4
            object chkKellLablec: TCheckListBox
              Left = 8
              Top = 1
              Width = 17
              Height = 14
              BevelInner = bvNone
              BevelOuter = bvRaised
              BorderStyle = bsNone
              Color = clBtnFace
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ItemHeight = 13
              Items.Strings = (
                'Kell l'#225'bl'#233'c?')
              ParentFont = False
              TabOrder = 0
            end
            object chkbLablecKijelzesek: TCheckListBox
              Left = 8
              Top = 17
              Width = 155
              Height = 51
              BevelInner = bvNone
              BevelOuter = bvRaised
              BorderStyle = bsNone
              Color = clBtnFace
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ItemHeight = 13
              Items.Strings = (
                'Program-alapinform'#225'ci'#243'k'
                'Regisztr'#225'ci'#243's adatok')
              ParentFont = False
              TabOrder = 1
            end
          end
          object GroupBox16: TGroupBox
            Left = 182
            Top = 138
            Width = 173
            Height = 39
            Caption = '     '#201'letstrat'#233'gia t'#225'bl'#225'zata '
            TabOrder = 5
            object chkKellEletstratTablazat: TCheckListBox
              Left = 8
              Top = 1
              Width = 17
              Height = 14
              BevelInner = bvNone
              BevelOuter = bvRaised
              BorderStyle = bsNone
              Color = clBtnFace
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ItemHeight = 13
              Items.Strings = (
                'Kell t'#225'bl'#225'zat?')
              ParentFont = False
              TabOrder = 0
            end
          end
          object GroupBox17: TGroupBox
            Left = 182
            Top = 309
            Width = 173
            Height = 39
            Caption = ' Nyomtat'#225's sz'#237'nesben '
            TabOrder = 6
            object chkNyomtatasSzinesben: TCheckListBox
              Left = 8
              Top = 16
              Width = 157
              Height = 14
              BevelInner = bvNone
              BevelOuter = bvRaised
              BorderStyle = bsNone
              Color = clBtnFace
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ItemHeight = 13
              Items.Strings = (
                'Nyomtat'#225's sz'#237'nesben?')
              ParentFont = False
              TabOrder = 0
            end
          end
        end
      end
    end
  end
  inherited pnlBottom: TPanel
    Top = 387
    Width = 373
    inherited btnRendben: TBitBtn
      Left = 185
    end
    inherited btnMegsem: TBitBtn
      Left = 275
    end
  end
end
