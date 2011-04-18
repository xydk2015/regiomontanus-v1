inherited frmCestSettings: TfrmCestSettings
  Left = 588
  Top = 115
  Caption = 'Ny'#225'ri / T'#233'li id'#337'sz'#225'm'#237't'#225's-be'#225'll'#237't'#225'sok'
  ClientHeight = 477
  ClientWidth = 446
  OldCreateOrder = True
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlClient: TPanel
    Width = 446
    Height = 427
    Caption = 'Ny'#225'ri / T'#233'li id'#337'sz'#225'm'#237't'#225's be'#225'll'#237't'#225'sok...'
    object GroupBox1: TGroupBox
      Left = 3
      Top = 1
      Width = 439
      Height = 421
      Caption = ' Orsz'#225'g adatok '
      TabOrder = 0
      object Label4: TLabel
        Left = 130
        Top = 185
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
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
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
        Top = 206
        Width = 429
        Height = 208
        Caption = ' T'#233'li / Ny'#225'ri id'#337'sz'#225'm'#237't'#225's-adatok '
        TabOrder = 1
        object dbgCestData: TDBGrid
          Left = 6
          Top = 20
          Width = 417
          Height = 150
          DataSource = dsCest
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              Width = 23
              Visible = True
            end
            item
              Expanded = False
              Width = 40
              Visible = True
            end
            item
              Expanded = False
              Width = 40
              Visible = True
            end
            item
              Expanded = False
              Width = 40
              Visible = True
            end
            item
              Expanded = False
              Width = 55
              Visible = True
            end
            item
              Expanded = False
              Width = 40
              Visible = True
            end
            item
              Expanded = False
              Width = 40
              Visible = True
            end
            item
              Expanded = False
              Width = 40
              Visible = True
            end
            item
              Expanded = False
              Width = 55
              Visible = True
            end>
        end
        object DBNavigator1: TDBNavigator
          Left = 7
          Top = 174
          Width = 116
          Height = 25
          DataSource = dsCest
          VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast]
          TabOrder = 1
        end
      end
      object dbNavCountry: TDBNavigator
        Left = 7
        Top = 179
        Width = 116
        Height = 25
        DataSource = dsCountry
        VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast]
        TabOrder = 2
      end
      object edtKereses: TEdit
        Left = 176
        Top = 182
        Width = 256
        Height = 21
        TabOrder = 3
        Text = 'edtKereses'
      end
    end
  end
  inherited pnlBottom: TPanel
    Top = 427
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
  object dsCest: TDataSource
    Left = 158
    Top = 236
  end
end
