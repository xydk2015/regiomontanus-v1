inherited frmSelfMarkers: TfrmSelfMarkers
  Caption = #201'n'#225'llapotok a sz'#252'let'#233'si k'#233'pletben'
  ClientHeight = 144
  ClientWidth = 455
  OldCreateOrder = True
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBottom: TPanel
    Top = 103
    Width = 455
    inherited BitBtn1: TBitBtn
      Left = 185
    end
  end
  inherited pnlClient: TPanel
    Width = 455
    Height = 103
    object Label2: TLabel
      Left = 13
      Top = 12
      Width = 24
      Height = 13
      Caption = 'Jele'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Bevel3: TBevel
      Left = 50
      Top = 0
      Width = 7
      Height = 102
      Anchors = [akLeft, akTop, akBottom]
      Shape = bsLeftLine
    end
    object Label3: TLabel
      Left = 69
      Top = 12
      Width = 31
      Height = 13
      Caption = 'Neve'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Bevel4: TBevel
      Left = 122
      Top = 0
      Width = 7
      Height = 102
      Anchors = [akLeft, akTop, akBottom]
      Shape = bsLeftLine
    end
    object Bevel2: TBevel
      Left = 0
      Top = 35
      Width = 454
      Height = 4
      Anchors = [akLeft, akTop, akRight]
      Shape = bsTopLine
    end
    object Label4: TLabel
      Left = 136
      Top = 12
      Width = 33
      Height = 13
      Caption = 'Helye'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
end
