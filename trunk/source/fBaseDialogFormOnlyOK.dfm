object frmBaseDialogFormOnlyOK: TfrmBaseDialogFormOnlyOK
  Left = 310
  Top = 115
  BorderStyle = bsToolWindow
  Caption = 'frmBaseDialogFormOnlyOK'
  ClientHeight = 390
  ClientWidth = 420
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object pnlBottom: TPanel
    Left = 0
    Top = 349
    Width = 420
    Height = 41
    Align = alBottom
    Caption = 'pnlBottom'
    TabOrder = 0
    object BitBtn1: TBitBtn
      Left = 167
      Top = 8
      Width = 85
      Height = 25
      Caption = 'Rendben'
      TabOrder = 0
      Kind = bkOK
    end
  end
  object pnlClient: TPanel
    Left = 0
    Top = 0
    Width = 420
    Height = 349
    Align = alClient
    Caption = 'pnlClient'
    TabOrder = 1
  end
end
