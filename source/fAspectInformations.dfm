inherited frmAspectInformations: TfrmAspectInformations
  Left = 548
  Top = 110
  Caption = 'F'#233'nysz'#246'g-inform'#225'ci'#243'k'
  ClientHeight = 441
  ClientWidth = 446
  OldCreateOrder = True
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBottom: TPanel
    Top = 400
    Width = 446
    inherited BitBtn1: TBitBtn
      Left = 180
    end
  end
  inherited pnlClient: TPanel
    Width = 446
    Height = 400
    object grpAspects: TGroupBox
      Left = 6
      Top = 5
      Width = 435
      Height = 387
      Caption = ' F'#233'nysz'#246'g-inform'#225'ci'#243'k '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object lblAspectInfo: TLabel
        Left = 212
        Top = 12
        Width = 217
        Height = 65
        Alignment = taCenter
        AutoSize = False
        Caption = 'lblAspectInfo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        WordWrap = True
      end
    end
  end
end
