inherited frmBeallitasok_Egyebek: TfrmBeallitasok_Egyebek
  Caption = 'Egy'#233'b be'#225'll'#237't'#225'sok a program m'#369'k'#246'd'#233's'#233'hez'
  ClientHeight = 445
  ClientWidth = 373
  OldCreateOrder = True
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlClient: TPanel
    Width = 373
    Height = 395
    Caption = ' '
    object chkgrpTelepulesDB: TRadioGroup
      Left = 8
      Top = 6
      Width = 357
      Height = 76
      Caption = ' Telep'#252'l'#233's-adatb'#225'zis haszn'#225'lata '
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ItemIndex = 0
      Items.Strings = (
        'Kis adatb'#225'zis (Mo. '#233's k'#246'rny'#233'ke)'
        'Nagy adatb'#225'zis (Teljes vil'#225'g)')
      ParentFont = False
      TabOrder = 0
    end
    object GroupBox1: TGroupBox
      Left = 8
      Top = 84
      Width = 357
      Height = 203
      Caption = ' Alap'#233'rtelmezett telep'#252'l'#233's megad'#225'sa ('#250'j k'#233'plet felvitelekor)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object Label3: TLabel
        Left = 9
        Top = 26
        Width = 76
        Height = 13
        Caption = 'Telep'#252'l'#233's neve:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = 163
        Top = 156
        Width = 186
        Height = 38
        Alignment = taCenter
        AutoSize = False
        Caption = 
          '<--- Erre a gombra kattintva er'#337's'#237'theted meg az alap'#233'rtelmezett ' +
          'telep'#252'l'#233's kiv'#225'laszt'#225's'#225't!'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        WordWrap = True
      end
      object edtTelepules: TEdit
        Left = 90
        Top = 24
        Width = 255
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        Text = 'edtTelepules'
        OnChange = edtTelepulesChange
        OnKeyDown = edtTelepulesKeyDown
      end
      object dbgCityes: TDBGrid
        Left = 8
        Top = 54
        Width = 341
        Height = 97
        DataSource = dsCity
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
        ParentFont = False
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'CityName'
            Title.Caption = 'V'#225'ros'
            Width = 140
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
      object btnKivalasztas: TButton
        Left = 8
        Top = 163
        Width = 150
        Height = 25
        Caption = 'Kiv'#225'laszt'#225's meger'#337's'#237't'#233'se'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnClick = btnKivalasztasClick
      end
    end
    object GroupBox2: TGroupBox
      Left = 8
      Top = 290
      Width = 357
      Height = 95
      Anchors = [akLeft, akBottom]
      Caption = ' Utolj'#225'ra megnyitott f'#225'jlok elt'#225'rol'#225'sa '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      object Label1: TLabel
        Left = 9
        Top = 26
        Width = 64
        Height = 13
        Caption = 'F'#225'jlok sz'#225'ma:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label2: TLabel
        Left = 9
        Top = 54
        Width = 340
        Height = 26
        AutoSize = False
        Caption = 
          'Amennyiben a "F'#225'jlok sz'#225'ma" '#233'rt'#233'ke "0", akkor nem ker'#252'l ment'#233'sre' +
          ' az utolj'#225'ra megnyitott f'#225'jlok list'#225'ja!'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        WordWrap = True
      end
      object edtFileokSzama: TEdit
        Left = 78
        Top = 24
        Width = 30
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        Text = '0'
      end
      object UpDown1: TUpDown
        Left = 108
        Top = 24
        Width = 16
        Height = 21
        Associate = edtFileokSzama
        Min = 0
        Max = 10
        Position = 0
        TabOrder = 1
        Wrap = False
      end
    end
  end
  inherited pnlBottom: TPanel
    Top = 395
    Width = 373
    inherited btnRendben: TBitBtn
      Left = 185
    end
    inherited btnMegsem: TBitBtn
      Left = 275
    end
  end
  object dsCity: TDataSource
    Left = 24
    Top = 90
  end
end
