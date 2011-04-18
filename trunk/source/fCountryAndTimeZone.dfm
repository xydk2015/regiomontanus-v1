inherited frmCountryAndTimeZone: TfrmCountryAndTimeZone
  Left = 460
  Caption = 'Orsz'#225'gok '#233's id'#337'z'#243'n'#225'ik...'
  ClientHeight = 361
  ClientWidth = 446
  OldCreateOrder = True
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlClient: TPanel
    Width = 446
    Height = 311
    object GroupBox1: TGroupBox
      Left = 3
      Top = 1
      Width = 439
      Height = 304
      Caption = ' Orsz'#225'g adatok... '
      TabOrder = 0
      object Label4: TLabel
        Left = 130
        Top = 277
        Width = 41
        Height = 13
        Caption = 'Keres'#233's:'
      end
      object dbgCountryAndTimeZone: TDBGrid
        Left = 6
        Top = 20
        Width = 427
        Height = 155
        DataSource = dsCountry
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            Width = 70
            Visible = True
          end
          item
            Expanded = False
            Width = 250
            Visible = True
          end
          item
            Expanded = False
            Width = 70
            Visible = True
          end>
      end
      object GroupBox2: TGroupBox
        Left = 5
        Top = 178
        Width = 429
        Height = 87
        Caption = ' Id'#337'z'#243'na adatok '
        TabOrder = 1
        object Label1: TLabel
          Left = 10
          Top = 20
          Width = 82
          Height = 13
          Caption = 'Id'#337'z'#243'na neve:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblTimeZoneCodeAndName: TLabel
          Left = 125
          Top = 20
          Width = 130
          Height = 13
          Caption = 'lblTimeZoneCodeAndName'
        end
        object Label3: TLabel
          Left = 10
          Top = 40
          Width = 113
          Height = 13
          Caption = 'Id'#337'eltol'#243'd'#225's (GMT):'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblDelta: TLabel
          Left = 125
          Top = 40
          Width = 35
          Height = 13
          Caption = 'lblDelta'
        end
        object Label2: TLabel
          Left = 10
          Top = 60
          Width = 37
          Height = 13
          Caption = 'T'#237'pus:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblType: TLabel
          Left = 125
          Top = 60
          Width = 34
          Height = 13
          Caption = 'lblType'
        end
      end
      object dbNavCountry: TDBNavigator
        Left = 5
        Top = 271
        Width = 116
        Height = 25
        DataSource = dsCountry
        VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast]
        TabOrder = 2
      end
      object edtKereses: TEdit
        Left = 176
        Top = 274
        Width = 256
        Height = 21
        TabOrder = 3
        Text = 'edtKereses'
      end
    end
  end
  inherited pnlBottom: TPanel
    Top = 311
    Width = 446
    inherited btnRendben: TBitBtn
      Left = 258
    end
    inherited btnMegsem: TBitBtn
      Left = 348
    end
  end
  object dsCountry: TDataSource
    Left = 48
    Top = 82
  end
end
