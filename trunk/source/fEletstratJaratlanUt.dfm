inherited frmEletstratJaratlanUt: TfrmEletstratJaratlanUt
  Left = 297
  Top = 121
  Caption = #201'letstrat'#233'gia, j'#225'ratlan '#250't'
  ClientHeight = 278
  ClientWidth = 350
  OldCreateOrder = True
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBottom: TPanel
    Top = 237
    Width = 350
    inherited BitBtn1: TBitBtn
      Left = 133
    end
  end
  inherited pnlClient: TPanel
    Width = 350
    Height = 237
    object GroupBox1: TGroupBox
      Left = 3
      Top = 1
      Width = 343
      Height = 230
      Caption = ' '#201'letstrat'#233'gia, j'#225'ratlan '#250't '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object Label1: TLabel
        Left = 10
        Top = 184
        Width = 76
        Height = 13
        Caption = #201'letstrat'#233'gia:'
      end
      object Label2: TLabel
        Left = 10
        Top = 205
        Width = 65
        Height = 13
        Caption = 'J'#225'ratlan '#250't:'
      end
      object lblEletstrat: TLabel
        Left = 90
        Top = 184
        Width = 48
        Height = 13
        Caption = 'lblEletstrat'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblJaratlanUt: TLabel
        Left = 90
        Top = 205
        Width = 58
        Height = 13
        Caption = 'lblJaratlanUt'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object gridStrat: TStringGrid
        Left = 8
        Top = 22
        Width = 326
        Height = 151
        Ctl3D = False
        RowCount = 6
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine]
        ParentCtl3D = False
        ScrollBars = ssNone
        TabOrder = 0
      end
    end
  end
end
