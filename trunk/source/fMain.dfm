object frmMain: TfrmMain
  Left = 294
  Top = 113
  Width = 698
  Height = 741
  Caption = 'Regiomontanus'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = mnuMain
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object statBar: TStatusBar
    Left = 0
    Top = 668
    Width = 690
    Height = 19
    Panels = <
      item
        Width = 300
      end
      item
        Text = 'EGYEB INF'#211'K & HINT'
        Width = 240
      end>
    SimplePanel = False
    OnDblClick = statBarDblClick
  end
  object tbrMenu: TToolBar
    Left = 0
    Top = 0
    Width = 690
    Height = 28
    ButtonHeight = 24
    ButtonWidth = 27
    Caption = 'tbrMenu'
    Flat = True
    Images = dmAstro4All.imgListMain
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    object tbtnAktKepletadatai: TToolButton
      Tag = 1
      Left = 0
      Top = 0
      Action = actAktKepletAdatai
    end
    object ToolButton1: TToolButton
      Tag = 1
      Left = 27
      Top = 0
      Width = 8
      Caption = 'ToolButton1'
      ImageIndex = 8
      Style = tbsSeparator
    end
    object tbtnUj: TToolButton
      Tag = 1
      Left = 35
      Top = 0
      Action = actUj
    end
    object tbtnMegnyitas: TToolButton
      Tag = 1
      Left = 62
      Top = 0
      Action = actMegnyitas
    end
    object tbtnMentes: TToolButton
      Left = 89
      Top = 0
      Action = actMentes
    end
    object tbtbBezar: TToolButton
      Tag = 1
      Left = 116
      Top = 0
      Action = actBezar
      Visible = False
    end
    object ToolButton24: TToolButton
      Tag = 1
      Left = 143
      Top = 0
      Width = 8
      Caption = 'ToolButton24'
      ImageIndex = 14
      Style = tbsSeparator
    end
    object tbtnExport: TToolButton
      Left = 151
      Top = 0
      Action = actExport
    end
    object tbtnnyomtat: TToolButton
      Left = 178
      Top = 0
      Action = actNyomtatas
    end
    object ToolButton10: TToolButton
      Left = 205
      Top = 0
      Width = 8
      Caption = 'ToolButton10'
      ImageIndex = 14
      Style = tbsSeparator
    end
    object tbtnKilepes: TToolButton
      Tag = 1
      Left = 213
      Top = 0
      Action = actExit
    end
  end
  object pcWorkSpace: TNBPageControl
    Left = 0
    Top = 28
    Width = 690
    Height = 640
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    OwnerDraw = True
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnChange = pcWorkSpaceChange
    OnDragDrop = pcWorkSpaceDragDrop
    OnDragOver = pcWorkSpaceDragOver
    OnMouseDown = pcWorkSpaceMouseDown
    OnMouseUp = pcWorkSpaceMouseUp
    NBActTabBgColor = clSkyBlue
    NBCloseButtonIndex = 24
    NBImageList = dmAstro4All.imgListMain
    NBInActTabBgColor = clBtnFace
  end
  object mnuMain: TMainMenu
    Images = dmAstro4All.imgListMain
    Left = 94
    Top = 92
    object File_Main: TMenuItem
      Tag = 1
      Caption = 'File'
      object File_AktKepletAdatai: TMenuItem
        Tag = 1
        Action = actAktKepletAdatai
      end
      object N4: TMenuItem
        Tag = 1
        Caption = '-'
      end
      object File_Uj: TMenuItem
        Tag = 1
        Action = actUj
      end
      object File_Megnyitas: TMenuItem
        Tag = 1
        Action = actMegnyitas
      end
      object N1: TMenuItem
        Tag = 1
        Caption = '-'
      end
      object File_Mentes: TMenuItem
        Action = actMentes
      end
      object File_MentesMaskent: TMenuItem
        Action = actMentesMaskent
      end
      object File_Bezar: TMenuItem
        Tag = 1
        Action = actBezar
      end
      object File_Mindbezar: TMenuItem
        Tag = 1
        Action = actMindBezar
      end
      object N2: TMenuItem
        Tag = 1
        Caption = '-'
      end
      object File_Export: TMenuItem
        Action = actExport
      end
      object File_Nyomtat: TMenuItem
        Action = actNyomtatas
      end
      object N25: TMenuItem
        Tag = 999
        Caption = '-'
      end
      object N3: TMenuItem
        Tag = 999
        Caption = '-'
      end
      object File_Kilepes: TMenuItem
        Tag = 1
        Action = actExit
      end
    end
    object Tablazatok_Main: TMenuItem
      Tag = 1
      Caption = 'T'#225'bl'#225'zatok'
      object Tablazatok_Bolygok: TMenuItem
        Tag = 1
        Action = actBolygok
      end
      object Tablazatok_hazak: TMenuItem
        Tag = 1
        Action = actHazak
      end
      object Tablazatok_Fenyszogek: TMenuItem
        Tag = 1
        Action = actFenyszogek
      end
      object Tablazatok_JartJaratlan: TMenuItem
        Tag = 1
        Action = actJartJaratlan
      end
      object Tablazatok_Enjelolok: TMenuItem
        Tag = 1
        Action = actEnjelolok
      end
      object N21: TMenuItem
        Tag = 1
        Caption = '-'
      end
      object Tablazatok_EgyebInfok: TMenuItem
        Tag = 1
        Action = actTablazatok_EgyebInfo
      end
      object N6: TMenuItem
        Caption = '-'
        Visible = False
      end
      object Tablazatok_Allocsillagpoz: TMenuItem
        Action = actAllocsillagPoz
        Enabled = False
        Visible = False
      end
      object N30osszalag1: TMenuItem
        Caption = '30'#176'-os szalag'
        Enabled = False
        Visible = False
      end
    end
    object Specialis_Main: TMenuItem
      Caption = 'Speci'#225'lis'
      object Specialis_KepletLepteto: TMenuItem
        Action = actKepletLepteto
      end
      object Specialis_ProgrLepteto: TMenuItem
        Action = actProgrLepteto
        Enabled = False
      end
      object N19: TMenuItem
        Caption = '-'
      end
      object Specialis_Drakonikus: TMenuItem
        Action = actDrakon
      end
      object Plantaperspektva1: TMenuItem
        Caption = 'Plan'#233'taperspekt'#237'va'
        object Normlnzet1: TMenuItem
          Caption = '"Norm'#225'l" n'#233'zet'
          Enabled = False
        end
        object Napazaszcendensen1: TMenuItem
          Caption = 'Nap az aszcendensen'
          Enabled = False
        end
        object Bolygazaszcendensen1: TMenuItem
          Caption = 'Bolyg'#243' az aszcendensen...'
          Enabled = False
          object Hold1: TMenuItem
            Caption = 'Hold'
          end
          object Merkur1: TMenuItem
            Caption = 'Merkur'
          end
          object Vnusz1: TMenuItem
            Caption = 'V'#233'nusz'
          end
          object Mars1: TMenuItem
            Caption = 'Mars'
          end
          object Jupiter1: TMenuItem
            Caption = 'Jupiter'
          end
          object Szaturnusz1: TMenuItem
            Caption = 'Szaturnusz'
          end
          object Urnusz1: TMenuItem
            Caption = 'Ur'#225'nusz'
          end
          object Neptunusz1: TMenuItem
            Caption = 'Neptunusz'
          end
          object Plut1: TMenuItem
            Caption = 'Plut'#243
          end
        end
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object Specialis_TobbKeplet: TMenuItem
        Caption = 'T'#246'bb k'#233'plet egym'#225'sra...'
        Enabled = False
      end
      object Specialis_NezetMenu: TMenuItem
        Caption = 'N'#233'zet'
        Enabled = False
        Visible = False
        object Specialis_Nezet_Kordiagram: TMenuItem
          Caption = 'K'#246'rdiagram'
          Checked = True
          Default = True
        end
        object Specialis_Nezet_BolygokACsillagkepekben: TMenuItem
          Action = actBolygoACsillagkepben
        end
      end
      object N8: TMenuItem
        Caption = '-'
        Visible = False
      end
      object Specialis_Kereses: TMenuItem
        Action = actKereses
        Enabled = False
        Visible = False
      end
      object Specialis_AsztroikerKereso: TMenuItem
        Caption = 'Asztroiker keres'#337'...'
        Enabled = False
        Visible = False
      end
      object N12: TMenuItem
        Caption = '-'
      end
      object Specialis_Csillagora: TMenuItem
        Action = actCsillagora
        Enabled = False
      end
    end
    object Progr_Main: TMenuItem
      Caption = 'Progresszi'#243'k'
      object Progr_Ivdirekcio: TMenuItem
        Action = actIvdirekciok
      end
      object Progr_SzekDir: TMenuItem
        Action = actSzekunderDirekciok
      end
      object Progr_TercierDir: TMenuItem
        Action = actTercierDirekciok
        Enabled = False
        Visible = False
      end
      object Progr_Trazitok: TMenuItem
        Action = actTranzitok
      end
      object N18: TMenuItem
        Caption = '-'
      end
      object Progr_Revoluciok: TMenuItem
        Action = actRevoluciok
        Enabled = False
      end
      object Progr_Napathalad: TMenuItem
        Action = actNapAthaladasok
        Enabled = False
      end
      object N22: TMenuItem
        Caption = '-'
        Visible = False
      end
      object Progr_Idopontok: TMenuItem
        Caption = 'Id'#337'pontok meghat'#225'roz'#225'sa...'
        Enabled = False
        Hint = 'M'#369't'#233't, h'#225'zass'#225'g, ...'
        Visible = False
      end
    end
    object Egyebek_Main: TMenuItem
      Caption = 'Egyebek'
      Visible = False
      object Holdfzisa1: TMenuItem
        Action = actHoldFazis
        Enabled = False
      end
      object Napkeltenyugta1: TMenuItem
        Action = actNapKeltenyugta
        Enabled = False
      end
      object Bolygkeltenyugta1: TMenuItem
        Action = actBolygoKelteNyugta
        Enabled = False
      end
      object N11: TMenuItem
        Caption = '-'
      end
      object Bolygmozgsok1: TMenuItem
        Action = actBolygomozgasGrafikon
        Caption = 'Bolyg'#243'mozg'#225's-grafikon...'
        Enabled = False
      end
      object Holdnaptr1: TMenuItem
        Caption = 'Holdnapt'#225'r'
        Enabled = False
      end
      object Holdfzisnaptr1: TMenuItem
        Action = actHoldfazisNaptar
        Caption = 'Holdf'#225'zis-napt'#225'r...'
        Enabled = False
      end
      object Efemerisznaptr1: TMenuItem
        Action = actEfemeriszNaptar
        Caption = 'Efemerida-napt'#225'r...'
        Enabled = False
      end
      object N7: TMenuItem
        Caption = '-'
      end
      object Napfogyatkozsok1: TMenuItem
        Action = actNapfogyatkozas
        Enabled = False
      end
      object Holdfogyatkozsok1: TMenuItem
        Action = actHoldfogyatkozasok
        Enabled = False
      end
      object N16: TMenuItem
        Caption = '-'
      end
      object vszakok1: TMenuItem
        Caption = #201'vszakok id'#337'pontjai'
        Enabled = False
      end
      object Csillagkpek1: TMenuItem
        Caption = 'Csillagk'#233'pek katal'#243'gusa'
        Enabled = False
      end
      object AsztrokalkultorZET81: TMenuItem
        Caption = 'Asztrokalkul'#225'tor (ZET8 Lite)'
        Enabled = False
      end
      object N24: TMenuItem
        Caption = '-'
      end
      object Arabpontok1: TMenuItem
        Caption = 'Arab pontok'
        Enabled = False
      end
    end
    object EgyszeruSzam_Main: TMenuItem
      Caption = 'Egyszer'#369' sz'#225'm'#237't'#225'sok'
      Visible = False
      object Ascendensszmts1: TMenuItem
        Action = actASCSzamitas
        Enabled = False
      end
      object Napjegyszmts1: TMenuItem
        Action = actNapjegySzamitas
        Enabled = False
      end
      object Holdjegyszmts1: TMenuItem
        Action = actHoldjegySzamitas
        Enabled = False
      end
      object Szletsnknapja1: TMenuItem
        Action = actSzuletesunkNapja
        Enabled = False
      end
      object N14: TMenuItem
        Caption = '-'
      end
      object Bioritmus1: TMenuItem
        Caption = 'Bioritmus'
        Enabled = False
        object Egyni1: TMenuItem
          Action = actBioritmusEgyeni
        end
        object Csoportos1: TMenuItem
          Action = actBioritmusParos
        end
      end
      object Szmmisztika1: TMenuItem
        Caption = 'Sz'#225'mmisztika'
        Enabled = False
        object N15: TMenuItem
          Caption = 'N'#233'vsz'#225'm / Sorssz'#225'm'
        end
        object Nvszm1: TMenuItem
          Caption = 'Bels'#337' '#233's K'#252'ls'#337' szem'#233'lyis'#233'g sz'#225'ma'
        end
        object Szemlyesv1: TMenuItem
          Caption = 'Szem'#233'lyes '#233'v...'
        end
        object letszm1: TMenuItem
          Caption = #201'letsz'#225'm / '#201'let'#250't'
        end
      end
    end
    object Bulvar_Main: TMenuItem
      Caption = 'Bulv'#225'r'
      Visible = False
      object Knaihoroszkp1: TMenuItem
        Caption = 'K'#237'nai horoszk'#243'p'
        Enabled = False
      end
      object Keltafahoroszkp1: TMenuItem
        Caption = 'Kelta fa horoszk'#243'p'
        Enabled = False
      end
      object Indiaihoroszkp1: TMenuItem
        Caption = 'Indiai horoszk'#243'p'
        Enabled = False
      end
      object Indinhoroszkp1: TMenuItem
        Caption = 'Indi'#225'n horoszk'#243'p'
        Enabled = False
      end
      object Indinszerelmihoroszkp1: TMenuItem
        Caption = 'Indi'#225'n szerelmi horoszk'#243'p'
        Enabled = False
      end
      object N10: TMenuItem
        Caption = '-'
      end
      object Karma1: TMenuItem
        Caption = 'Karma...'
        Enabled = False
        object Karmaacsillagjegyszerint1: TMenuItem
          Caption = '... a holdcsom'#243'pont szerint'
        end
        object Csillagjegysakarmaltaltlttest1: TMenuItem
          Caption = 'Csillagjegy karma '#225'ltal '#237't'#233'lt teste'
        end
        object Csillagjegykarmikusfeladata1: TMenuItem
          Caption = 'Csillagjegy karmikus feladata'
        end
      end
      object Csillagjegys1: TMenuItem
        Caption = 'Csillagjegyek '#233's ...'
        object Csillagjegyekkarcsonyiajndktippjei1: TMenuItem
          Action = actBulvar_KaracsonyiAjandektippek
        end
        object azegszsg1: TMenuItem
          Action = actBulvar_JegyEsEgeszseg
        end
        object Csillagjegysazsvnyok1: TMenuItem
          Action = actBulvar_JegyEsKoveik
        end
        object Csillagjegyrnyoldalai1: TMenuItem
          Action = actBulvar_JegyArnyoldalai
        end
        object Csillagjegyekamitszeretnek1: TMenuItem
          Action = actBulvar_JegyAmitSzeretnek
        end
        object Csillagjegyekmitnemszeretnek1: TMenuItem
          Action = actBulvar_JegyAmitNemSzeretnek
        end
        object Csillagjegyerssgei1: TMenuItem
          Action = actBulvar_JegyErossegei
        end
        object Csillagjegysabn1: TMenuItem
          Action = actBulvar_JegyBun
        end
        object Csillagjegysadivat1: TMenuItem
          Action = actBulvar_JegyDivat
        end
        object N20: TMenuItem
          Caption = '-'
        end
        object Csillagjegysagyengesgei1: TMenuItem
          Caption = '... a gyenges'#233'gei'
          Enabled = False
        end
        object CsillagjegysazAngyalsegti1: TMenuItem
          Caption = '... az Angyal seg'#237't'#337'i'
          Enabled = False
        end
        object Csillagjegysaspiritualits1: TMenuItem
          Caption = '... a spiritualit'#225's'
          Enabled = False
        end
        object Csillagjegyplantrisszma1: TMenuItem
          Caption = '... planet'#225'ris sz'#225'muk'
          Enabled = False
        end
        object Csillagjegysasrtresszzs1: TMenuItem
          Caption = '... a stressz'#369'z'#233's'
          Enabled = False
        end
        object Csillagjegymintszl1: TMenuItem
          Caption = '... sz'#252'l'#337'i mivoltuk'
          Enabled = False
        end
        object Csillagjegysahozzillprja1: TMenuItem
          Caption = '... a hozz'#225' ill'#337' p'#225'rja'
          Enabled = False
        end
        object Csillagjegysank1: TMenuItem
          Caption = '... a n'#337'k'
          Enabled = False
        end
        object Csillagjegysajeggyr1: TMenuItem
          Caption = '... a jegygy'#369'r'#369
          Enabled = False
        end
        object Csillagjegysacsbts1: TMenuItem
          Caption = '... a cs'#225'b'#237't'#225's'
          Enabled = False
        end
        object Csillagjegymeghdtsa1: TMenuItem
          Caption = '... a megh'#243'd'#237't'#225'sa'
          Enabled = False
        end
        object Csillagjegysazajzszere1: TMenuItem
          Caption = '... az ajz'#243'szere'
          Enabled = False
        end
        object Csillagjegyekvgyakozsai1: TMenuItem
          Caption = '... a v'#225'gyakoz'#225'saik'
          Enabled = False
        end
        object Csillagjegysatpllkozs1: TMenuItem
          Caption = '... a t'#225'pl'#225'lkoz'#225's'
          Enabled = False
        end
        object Csillagjegyeksagygynvnyek1: TMenuItem
          Caption = '... a gy'#243'gyn'#246'v'#233'nyek'
          Enabled = False
        end
        object Csillagjegysadrgakvek1: TMenuItem
          Caption = '... a dr'#225'gak'#246'vek'
          Enabled = False
        end
        object Csillagjegysazregsg1: TMenuItem
          Caption = '... az '#246'regs'#233'g'
          Enabled = False
        end
        object Csillagjegynegatvumai1: TMenuItem
          Caption = '... a negat'#237'vumai'
          Enabled = False
        end
        object Csillagjegysasport1: TMenuItem
          Caption = '... a sport'
          Enabled = False
        end
        object Csillagjegysapnz1: TMenuItem
          Caption = '... a p'#233'nz'
          Enabled = False
        end
        object Csillagjegyajndktippek1: TMenuItem
          Caption = '... egy'#233'b aj'#225'nd'#233'ktippek'
          Enabled = False
        end
        object Csillagjegysasznek1: TMenuItem
          Caption = '... a sz'#237'nek'
          Enabled = False
        end
        object Csillagjegysasznek21: TMenuItem
          Caption = '... a sz'#237'nek 2.'
          Enabled = False
        end
        object Csillagjegysasofrsg1: TMenuItem
          Caption = '... a sof'#337'rs'#233'g'
          Enabled = False
        end
      end
      object Milyenvirgvagy1: TMenuItem
        Caption = 'Milyen vir'#225'g vagy?!'
        Enabled = False
      end
    end
    object Beall_Main: TMenuItem
      Tag = 1
      Caption = 'Be'#225'll'#237't'#225'sok'
      object Megjelens1: TMenuItem
        Tag = 1
        Action = actBeallitasok_Megjelenites
      end
      object Egybek1: TMenuItem
        Action = actBeallitasok_Egyebek
      end
      object Fnyszgek2: TMenuItem
        Tag = 1
        Caption = 'F'#233'nysz'#246'gek '#233's orbisok'
        Enabled = False
      end
      object Szneksszimblumok1: TMenuItem
        Action = actBeallitasok_Szinek
      end
      object Hzrendszer1: TMenuItem
        Caption = 'H'#225'zrendszer'
        object hrendsz_Placidus1_P_: TMenuItem
          Caption = 'Placidus'
          OnClick = hrendszMenuItemClick
        end
        object hrendsz_Regiomontanus1_R_: TMenuItem
          Caption = 'Regiomontanus'
          OnClick = hrendszMenuItemClick
        end
        object hrendsz_Campanus1_C_: TMenuItem
          Caption = 'Campanus'
          OnClick = hrendszMenuItemClick
        end
        object hrendsz_Koch1_K_: TMenuItem
          Caption = 'Koch'
          OnClick = hrendszMenuItemClick
        end
        object hrendsz_Porphyrius1_O_: TMenuItem
          Caption = 'Porphyrius'
          OnClick = hrendszMenuItemClick
        end
        object hrendsz_Egyenl1_A_: TMenuItem
          Caption = 'Egyenl'#337
          OnClick = hrendszMenuItemClick
        end
      end
      object Zodikus1: TMenuItem
        Caption = 'Zodi'#225'kus'
        object zodiac_Sziderlis1_S_: TMenuItem
          Caption = 'Sziderikus'
          OnClick = zodiacMenuItemClick
        end
        object zodiac_ropikus1_T_: TMenuItem
          Caption = 'Tropikus'
          OnClick = zodiacMenuItemClick
        end
      end
      object Pontszmok1: TMenuItem
        Caption = 'Pontsz'#225'mok...'
        Enabled = False
        Visible = False
      end
      object Lersok1: TMenuItem
        Caption = 'Le'#237'r'#225'sok...'
        Enabled = False
        Visible = False
      end
      object N17: TMenuItem
        Caption = '-'
      end
      object Idznalista1: TMenuItem
        Action = actCountryAndTimeZone
      end
      object eleplslista1: TMenuItem
        Caption = 'Orsz'#225'gok '#233's telep'#252'l'#233'seik...'
      end
      object NyriTliidszmtsbelltsok1: TMenuItem
        Action = actNyariTeliIdoszamitas
      end
      object N13: TMenuItem
        Caption = '-'
      end
      object Automatikusments1: TMenuItem
        Caption = 'Automatikus ment'#233's'
        Checked = True
        Enabled = False
      end
      object Belltsokmentse1: TMenuItem
        Caption = 'Be'#225'll'#237't'#225'sok ment'#233'se...'
        Enabled = False
      end
      object Belltsok2: TMenuItem
        Caption = 'Be'#225'll'#237't'#225'sok visszat'#246'lt'#233'se...'
        Enabled = False
      end
    end
    object Segitseg_Main: TMenuItem
      Tag = 1
      Caption = 'Seg'#237'ts'#233'g'
      object Segitseg_Alapfogalmak: TMenuItem
        Tag = 1
        Caption = 'Asztrol'#243'giai alapfogalmak'
        Enabled = False
      end
      object Segitseg_Kisokos: TMenuItem
        Tag = 1
        Caption = 'Asztrol'#243'giai kisokos'
        Enabled = False
      end
      object N9: TMenuItem
        Tag = 1
        Caption = '-'
      end
      object Segitseg_Regisztracio: TMenuItem
        Tag = 99
        Caption = 'Regisztr'#225'ci'#243
        Enabled = False
      end
      object N23: TMenuItem
        Caption = '-'
      end
      object Segitseg_Programrol: TMenuItem
        Tag = 1
        Caption = 'A programr'#243'l'
        Enabled = False
      end
      object Segitseg_Nevjegy: TMenuItem
        Tag = 1
        Action = actNevjegy
      end
    end
  end
  object appEvents: TApplicationEvents
    OnHint = appEventsHint
    Left = 44
    Top = 58
  end
  object actListMain: TActionList
    Images = dmAstro4All.imgListMain
    Left = 92
    Top = 146
    object actAktKepletAdatai: TAction
      Caption = 'Aktu'#225'lis k'#233'plet adatai'
      Hint = 
        'Aktu'#225'lis k'#233'plet adatai|Az aktu'#225'lis k'#233'plethez tartoz'#243' adatokat tu' +
        'djuk szerkeszteni'
      ImageIndex = 7
      ShortCut = 16449
      OnExecute = actAktKepletAdataiExecute
    end
    object actUj: TAction
      Caption = #218'j...'
      Hint = #218'j...|'#218'j sz'#252'let'#233'si k'#233'plet felvitele'
      ImageIndex = 0
      ShortCut = 16462
      OnExecute = actUjExecute
    end
    object actMegnyitas: TAction
      Caption = 'Megnyit'#225's'
      Hint = 'Megnyit'#225's|Sz'#252'let'#233'si k'#233'plet megnyit'#225'sa'
      ImageIndex = 1
      ShortCut = 16463
      OnExecute = actMegnyitasExecute
    end
    object actMentes: TAction
      Caption = 'Ment'#233's'
      Hint = 'Ment'#233's|Sz'#252'let'#233'si k'#233'plet ment'#233'se'
      ImageIndex = 2
      ShortCut = 16467
      OnExecute = actMentesExecute
    end
    object actMentesMaskent: TAction
      Caption = 'Ment'#233's m'#225'sk'#233'nt...'
      Hint = 'Ment'#233's m'#225'sk'#233'nt|Sz'#252'let'#233'si k'#233'plet ment'#233'se m'#225's n'#233'ven'
      OnExecute = actMentesMaskentExecute
    end
    object actBezar: TAction
      Caption = 'Bez'#225'r'
      Hint = 'Bez'#225'r|Sz'#252'let'#233'si k'#233'plet bez'#225'r'#225'sa'
      ImageIndex = 3
      ShortCut = 16499
      OnExecute = actBezarExecute
    end
    object actMindBezar: TAction
      Caption = 'Mind bez'#225'r'
      Hint = 'Mind bez'#225'r|Az '#246'sszes megnyitott sz'#252'let'#233'si k'#233'plet bez'#225'r'#225'sa'
      ImageIndex = 4
      OnExecute = actMindBezarExecute
    end
    object actExport: TAction
      Caption = 'Export'#225'l'#225's...'
      Hint = 'Export'#225'l'#225's|Sz'#252'let'#233'si k'#233'plet export'#225'l'#225'sa f'#225'jlba'
      ImageIndex = 12
      OnExecute = actExportExecute
    end
    object actNyomtatas: TAction
      Caption = 'Nyomtat'#225's...'
      Hint = 'Nyomtat'#225's|Sz'#252'let'#233'si k'#233'plet nyomtat'#225'sa'
      ImageIndex = 5
      ShortCut = 16464
      OnExecute = actNyomtatasExecute
    end
    object actExit: TAction
      Caption = 'Kil'#233'p'#233's'
      Hint = 'Kil'#233'p'#233's | Kil'#233'p'#233's a programb'#243'l'
      ImageIndex = 6
      ShortCut = 32856
      OnExecute = actExitExecute
    end
    object actBolygok: TAction
      Caption = 'Plan'#233't'#225'k'
      Hint = 'Plan'#233't'#225'k|Plan'#233't'#225'k helyzete a k'#233'pletben'
      ImageIndex = 8
      ShortCut = 16450
      OnExecute = actBolygokExecute
    end
    object actHazak: TAction
      Caption = 'H'#225'zak'
      Hint = 'H'#225'zak|H'#225'zak helyzete a k'#233'pletben'
      ImageIndex = 10
      ShortCut = 16456
      OnExecute = actHazakExecute
    end
    object actFenyszogek: TAction
      Caption = 'F'#233'nysz'#246'gek'
      Hint = 'F'#233'nysz'#246'gek|F'#233'nysz'#246'gkapcsolatok a bolyg'#243'k k'#246'zt'
      ImageIndex = 15
      ShortCut = 16454
      OnExecute = actFenyszogekExecute
    end
    object actJartJaratlan: TAction
      Caption = #201'letstrat'#233'gia, j'#225'ratlan '#250't'
      Hint = 
        #201'letstrat'#233'gia, j'#225'ratlan '#250't|'#201'letstrat'#233'gia, j'#225'ratlan '#250't t'#225'bl'#225'zat s' +
        'eg'#237'ts'#233'g'#233'vel'
      ImageIndex = 16
      ShortCut = 16458
      OnExecute = actJartJaratlanExecute
    end
    object actEnjelolok: TAction
      Caption = #201'n'#225'llapotok'
      Hint = #201'n'#225'llapotok|'#201'n'#225'llapotok a sz'#252'let'#233'si k'#233'pletben'
      ImageIndex = 17
      ShortCut = 16453
      OnExecute = actEnjelolokExecute
    end
    object actAllocsillagPoz: TAction
      Caption = #193'll'#243'csillag poz'#237'ci'#243'k...'
      Hint = #193'll'#243'csillag poz'#237'ci'#243'k...|'#193'll'#243'csillag poz'#237'ci'#243'k...'
      ImageIndex = 18
      OnExecute = actAktKepletAdataiExecute
    end
    object actBolygoACsillagkepben: TAction
      Caption = 'Bolyg'#243'k a csillagk'#233'pekben'
      Hint = 
        'Bolyg'#243'k a csillagk'#233'pekben|Bolyg'#243'k a csillagk'#233'pekben asztr'#243'z'#243'fiai' +
        ' szempontb'#243'l'
      ImageIndex = 19
      ShortCut = 16459
      OnExecute = actAktKepletAdataiExecute
    end
    object actKepletLepteto: TAction
      Caption = 'K'#233'pletl'#233'ptet'#337
      Hint = 'K'#233'pletl'#233'ptet'#337'|K'#233'plet l'#233'ptet'#233's'
      ImageIndex = 20
      ShortCut = 16460
      OnExecute = actKepletLeptetoExecute
    end
    object actBolygomozgasGrafikon: TAction
      Caption = 'Bolyg'#243'mozg'#225's grafikon...'
      Hint = 
        'Bolyg'#243'mozg'#225's grafikon...|Bolyg'#243'mozg'#225'sok a jegyekben adott id'#337'sza' +
        'kban'
      ImageIndex = 13
      OnExecute = actAktKepletAdataiExecute
    end
    object actKereses: TAction
      Caption = 'Keres'#233's...'
      Hint = 'Keres'#233's...|Keres'#233's a k'#233'pletek k'#246'zt...'
      ImageIndex = 9
      OnExecute = actAktKepletAdataiExecute
    end
    object actCsillagora: TAction
      Caption = 'Csillag'#243'ra...'
      Hint = 'Csillag'#243'ra...|Real-time idej'#369' csillaghelyzetek'
      ImageIndex = 14
      OnExecute = actAktKepletAdataiExecute
    end
    object actHoldFazis: TAction
      Caption = 'Hold f'#225'zisa'
      Hint = 'Hold f'#225'zisa|A Hold aktu'#225'lis f'#225'zisa'
      ImageIndex = 11
      OnExecute = actAktKepletAdataiExecute
    end
    object actNapKeltenyugta: TAction
      Caption = 'Nap kelte, nyugta'
      Hint = 'Nap kelte, nyugta|Nap kelte, nyugta'
      OnExecute = actAktKepletAdataiExecute
    end
    object actBolygoKelteNyugta: TAction
      Caption = 'Bolyg'#243' kelte, nyugta...'
      Hint = 'Bolyg'#243' kelte, nyugta...|Bolyg'#243' kelte, nyugta a F'#246'ldr'#337'l n'#233'zve'
      OnExecute = actAktKepletAdataiExecute
    end
    object actHoldfazisNaptar: TAction
      Caption = 'Holdf'#225'zis napt'#225'r...'
      Hint = 'Holdf'#225'zis napt'#225'r|Holdf'#225'zis napt'#225'r'
      OnExecute = actAktKepletAdataiExecute
    end
    object actEfemeriszNaptar: TAction
      Caption = 'Efemerida napt'#225'r...'
      Hint = 'Efemerisz napt'#225'r|Efemerisz napt'#225'r'
      OnExecute = actAktKepletAdataiExecute
    end
    object actNapfogyatkozas: TAction
      Caption = 'Napfogyatkoz'#225'sok...'
      Hint = 'Napfogyatkoz'#225'sok...|Napfogyatkoz'#225'sok ideje, f'#246'ldrajzi helye'
      OnExecute = actAktKepletAdataiExecute
    end
    object actHoldfogyatkozasok: TAction
      Caption = 'Holdfogyatkoz'#225'sok...'
      Hint = 'Holdfogyatkoz'#225'sok...|Holdfogyatkoz'#225'sok ideje, f'#246'ldrajzi helye'
      OnExecute = actAktKepletAdataiExecute
    end
    object actBioritmusEgyeni: TAction
      Caption = 'Egy'#233'ni'
      Hint = 'Egy'#233'ni bioritmus|Egy'#233'ni bioritmus'
      OnExecute = actAktKepletAdataiExecute
    end
    object actBioritmusParos: TAction
      Caption = 'P'#225'ros bioritmus...'
      Hint = 'P'#225'ros bioritmus|K'#233't szem'#233'ly bioritmusa egy '#225'br'#225'ban'
      OnExecute = actAktKepletAdataiExecute
    end
    object actASCSzamitas: TAction
      Caption = 'Aszcendens-sz'#225'm'#237't'#225's...'
      Hint = 'Aszcendens-sz'#225'm'#237't'#225's...|Aszcendens-sz'#225'm'#237't'#225's'
      OnExecute = actAktKepletAdataiExecute
    end
    object actNapjegySzamitas: TAction
      Caption = 'Napjegy-sz'#225'm'#237't'#225's...'
      Hint = 'Napjegy-sz'#225'm'#237't'#225's...|Napjegy-sz'#225'm'#237't'#225's'
      OnExecute = actAktKepletAdataiExecute
    end
    object actHoldjegySzamitas: TAction
      Caption = 'Holdjegy-sz'#225'm'#237't'#225's...'
      Hint = 'Holdjegy-sz'#225'm'#237't'#225's...|Holdjegy-sz'#225'm'#237't'#225's'
      OnExecute = actAktKepletAdataiExecute
    end
    object actSzuletesunkNapja: TAction
      Caption = 'Sz'#252'let'#233's'#252'nk napja...'
      Hint = 'Sz'#252'let'#233's'#252'nk napja...|Sz'#252'let'#233's'#252'nk napja a h'#233't mely napj'#225'ra esett'
      OnExecute = actAktKepletAdataiExecute
    end
    object actCountryAndTimeZone: TAction
      Caption = 'Orsz'#225'gok '#233's id'#337'z'#243'n'#225'ik...'
      OnExecute = actCountryAndTimeZoneExecute
    end
    object actNyariTeliIdoszamitas: TAction
      Caption = 'Ny'#225'ri / T'#233'li id'#337'sz'#225'm'#237't'#225's-be'#225'll'#237't'#225'sok...'
      OnExecute = actNyariTeliIdoszamitasExecute
    end
    object actProgrLepteto: TAction
      Caption = 'Progresszi'#243' l'#233'ptet'#337'...'
      Hint = 'Progresszi'#243' l'#233'ptet'#337'...'
      ImageIndex = 23
      OnExecute = actAktKepletAdataiExecute
    end
    object actDrakon: TAction
      Caption = 'Holdcsom'#243'pont horoszk'#243'p'
      Hint = 'Holdcsom'#243'pont horoszk'#243'p - El'#337'z'#337' '#233'let'
      OnExecute = actDrakonExecute
    end
    object actIvdirekciok: TAction
      Caption = #205'vdirekci'#243'k...'
      Hint = #205'vdirekci'#243'k...'
      OnExecute = actAktKepletAdataiExecute
    end
    object actSzekunderDirekciok: TAction
      Caption = 'Szekunder direkci'#243'k...'
      Hint = 'Szekunder direkci'#243'k...'
      OnExecute = actAktKepletAdataiExecute
    end
    object actTercierDirekciok: TAction
      Caption = 'Tercier direkci'#243'k...'
      Hint = 'Tercier direkci'#243'k...'
      OnExecute = actAktKepletAdataiExecute
    end
    object actTranzitok: TAction
      Caption = 'Tranzitok...'
      Hint = 'Tranzitok...'
      OnExecute = actAktKepletAdataiExecute
    end
    object actRevoluciok: TAction
      Caption = 'Revol'#250'ci'#243'k...'
      Hint = 'Revol'#250'ci'#243'k...'
      OnExecute = actAktKepletAdataiExecute
    end
    object actNapAthaladasok: TAction
      Caption = 'Nap - '#225'thalad'#225'sok...'
      Hint = 'Nap - '#225'thalad'#225'sok...'
      OnExecute = actAktKepletAdataiExecute
    end
    object actBulvar_KaracsonyiAjandektippek: TAction
      Caption = '... kar'#225'csonyi aj'#225'nd'#233'ktippek'
      OnExecute = actBulvar_KaracsonyiAjandektippekExecute
    end
    object actBulvar_JegyEsEgeszseg: TAction
      Caption = '... az eg'#233'szs'#233'g'
      OnExecute = actBulvar_JegyEsEgeszsegExecute
    end
    object actBulvar_JegyEsKoveik: TAction
      Caption = '... a k'#246'veik'
      OnExecute = actBulvar_JegyEsKoveikExecute
    end
    object actBulvar_JegyArnyoldalai: TAction
      Caption = '... az '#225'rnyoldalai'
      OnExecute = actBulvar_JegyArnyoldalaiExecute
    end
    object actBulvar_JegyAmitSzeretnek: TAction
      Caption = '... amit szeretnek'
      OnExecute = actBulvar_JegyAmitSzeretnekExecute
    end
    object actBulvar_JegyAmitNemSzeretnek: TAction
      Caption = '... amit nem szeretnek'
      OnExecute = actBulvar_JegyAmitNemSzeretnekExecute
    end
    object actBulvar_JegyErossegei: TAction
      Caption = '... az er'#337'ss'#233'gei'
      OnExecute = actBulvar_JegyErossegeiExecute
    end
    object actBulvar_JegyBun: TAction
      Caption = '... a b'#369'n'
      OnExecute = actBulvar_JegyBunExecute
    end
    object actBulvar_JegyDivat: TAction
      Caption = '... a divat'
      OnExecute = actBulvar_JegyDivatExecute
    end
    object actNevjegy: TAction
      Caption = 'N'#233'vjegy'
      Hint = 'N'#233'vjegy'
      OnExecute = actNevjegyExecute
    end
    object actTablazatok_EgyebInfo: TAction
      Caption = 'Egy'#233'b inform'#225'ci'#243'k...'
      Hint = 'Egy'#233'b inform'#225'ci'#243'k a sz'#252'let'#233'si id'#337'vel kapcsolatosan'
      OnExecute = actTablazatok_EgyebInfoExecute
    end
    object actBeallitasok_Megjelenites: TAction
      Caption = 'Megjelen'#237't'#233's'
      OnExecute = actBeallitasok_MegjelenitesExecute
    end
    object actBeallitasok_Szinek: TAction
      Caption = 'Sz'#237'nek '#233's szimb'#243'lumok'
      OnExecute = actBeallitasok_SzinekExecute
    end
    object actBeallitasok_Egyebek: TAction
      Caption = 'Egyebek...'
      OnExecute = actBeallitasok_EgyebekExecute
    end
  end
end
