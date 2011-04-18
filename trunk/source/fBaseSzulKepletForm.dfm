object frmBaseSzulKepletForm: TfrmBaseSzulKepletForm
  Left = 348
  Top = 149
  Width = 470
  Height = 392
  Caption = 'Sz'#252'let'#233'si k'#233'plet'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object tbrRight: TToolBar
    Left = 439
    Top = 0
    Width = 23
    Height = 358
    Align = alRight
    ButtonHeight = 23
    Caption = 'tbrRight'
    Color = clWhite
    EdgeBorders = []
    EdgeInner = esLowered
    EdgeOuter = esRaised
    Flat = True
    Images = dmAstro4All.imgListMain
    ParentColor = False
    TabOrder = 0
    Visible = False
    object ToolButton1: TToolButton
      Left = 0
      Top = 0
      Action = actHozzaad
      ParentShowHint = False
      Wrap = True
      ShowHint = True
      Visible = False
    end
    object ToolButton2: TToolButton
      Left = 0
      Top = 23
      Action = actElvesz
      ParentShowHint = False
      Wrap = True
      ShowHint = True
      Visible = False
    end
    object ToolButton8: TToolButton
      Left = 0
      Top = 46
      Action = actKepletLepteto
      ParentShowHint = False
      Wrap = True
      ShowHint = True
    end
    object ToolButton9: TToolButton
      Left = 0
      Top = 69
      Action = actProgrLepteto
      ParentShowHint = False
      Wrap = True
      ShowHint = True
      Visible = False
    end
  end
  object tbrLeft: TToolBar
    Left = 0
    Top = 0
    Width = 119
    Height = 358
    Align = alLeft
    AutoSize = True
    ButtonHeight = 39
    ButtonWidth = 119
    Caption = 'ToolBar1'
    Color = clWhite
    EdgeBorders = []
    EdgeInner = esLowered
    EdgeOuter = esRaised
    Flat = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    Images = dmAstro4All.imgListMain
    ParentColor = False
    ParentFont = False
    ParentShowHint = False
    ShowCaptions = True
    ShowHint = True
    TabOrder = 1
    object ToolButton3: TToolButton
      Left = 0
      Top = 0
      Action = actBolygok
      ParentShowHint = False
      Wrap = True
      ShowHint = True
    end
    object ToolButton4: TToolButton
      Left = 0
      Top = 39
      Action = actHazak
      ParentShowHint = False
      Wrap = True
      ShowHint = True
    end
    object ToolButton5: TToolButton
      Left = 0
      Top = 78
      Action = actFenyszogek
      ParentShowHint = False
      Wrap = True
      ShowHint = True
    end
    object ToolButton6: TToolButton
      Left = 0
      Top = 117
      Action = actJartJaratlanUt
      ParentShowHint = False
      Wrap = True
      ShowHint = True
    end
    object ToolButton7: TToolButton
      Left = 0
      Top = 156
      Action = actEnjelolok
      ParentShowHint = False
      Wrap = True
      ShowHint = True
      Style = tbsCheck
    end
    object ToolButton10: TToolButton
      Left = 0
      Top = 195
      Action = actKepletLepteto
    end
  end
  object pnlDrawRegion: TPanel
    Left = 119
    Top = 0
    Width = 320
    Height = 358
    Align = alClient
    BevelOuter = bvNone
    Caption = 'pnlDrawRegion'
    TabOrder = 2
    object imgSzulKeplet: TImage
      Left = 0
      Top = 0
      Width = 320
      Height = 358
      Align = alClient
    end
  end
  object actSzulKeplet: TActionList
    Images = dmAstro4All.imgListMain
    Left = 96
    Top = 48
    object actHozzaad: TAction
      Caption = 'Hozz'#225'ad'
      Hint = #218'j sz'#252'let'#233'si k'#233'plet hozz'#225'ad'#225'sa'
      ImageIndex = 21
      OnExecute = actHozzaadExecute
    end
    object actElvesz: TAction
      Caption = 'Elvesz'
      Hint = 'Sz'#252'let'#233'si k'#233'plet elt'#225'vol'#237't'#225'sa'
      ImageIndex = 22
      OnExecute = actHozzaadExecute
    end
    object actBolygok: TAction
      Caption = 'Plan'#233't'#225'k'
      Hint = 'Plan'#233't'#225'k'
      ImageIndex = 8
      OnExecute = actBolygokExecute
    end
    object actHazak: TAction
      Caption = 'H'#225'zak'
      Hint = 'H'#225'zak'
      ImageIndex = 10
      OnExecute = actHazakExecute
    end
    object actFenyszogek: TAction
      Caption = 'F'#233'nysz'#246'gek'
      Hint = 'F'#233'nysz'#246'gek'
      ImageIndex = 15
      OnExecute = actFenyszogekExecute
    end
    object actJartJaratlanUt: TAction
      Caption = #201'letstrat'#233'gia'
      Hint = #201'letstrat'#233'gia, j'#225'ratlan '#250't'
      ImageIndex = 16
      OnExecute = actJartJaratlanUtExecute
    end
    object actEnjelolok: TAction
      Caption = #201'n'#225'llapotok (Be/Ki)'
      Hint = #201'n'#225'llapotok'
      ImageIndex = 17
      OnExecute = actEnjelolokExecute
    end
    object actKepletLepteto: TAction
      Caption = 'K'#233'pletl'#233'ptet'#337
      Hint = 'K'#233'pletl'#233'ptet'#337'|K'#233'plet l'#233'ptet'#233's'
      ImageIndex = 20
      ShortCut = 16460
      OnExecute = actKepletLeptetoExecute
    end
    object actProgrLepteto: TAction
      Caption = 'Progresszi'#243' l'#233'ptet'#337'...'
      Hint = 'Progresszi'#243' l'#233'ptet'#337'...'
      ImageIndex = 23
      OnExecute = actHozzaadExecute
    end
    object actSzemelyisegRajz: TAction
      Caption = 'Szem'#233'lyis'#233'grajz'
      Hint = 'Szem'#233'lyis'#233'grajz Be/Ki'
    end
  end
end
