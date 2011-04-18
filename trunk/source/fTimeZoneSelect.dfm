inherited frmTimeZoneSelect: TfrmTimeZoneSelect
  Caption = 'Id'#337'z'#243'na v'#225'laszt'#243
  ClientWidth = 443
  OldCreateOrder = True
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlClient: TPanel
    Width = 443
    object grpIdozonak: TGroupBox
      Left = 1
      Top = 1
      Width = 441
      Height = 368
      Align = alClient
      Caption = ' Id'#337'z'#243'n'#225'k... '
      TabOrder = 0
      object trvTimeZone: TTreeView
        Left = 6
        Top = 16
        Width = 428
        Height = 345
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        Indent = 19
        ParentFont = False
        TabOrder = 0
        Items.Data = {
          01000000220000000000000000000000FFFFFFFFFFFFFFFF0000000001000000
          09456C73F520456C656D2500000000000000000000007B000000FFFFFFFF0000
          0000000000000C4DE1736F64696B20456C656D}
      end
    end
  end
  inherited pnlBottom: TPanel
    Width = 443
    inherited btnRendben: TBitBtn
      Left = 255
    end
    inherited btnMegsem: TBitBtn
      Left = 345
    end
  end
end
