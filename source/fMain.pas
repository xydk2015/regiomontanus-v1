unit fMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ComCtrls, CommCtrl, ExtCtrls, AppEvnts, Buttons, ToolWin, ImgList,
  ActnList, uAstro4AllMain, Grids, DBGrids, DB, Contnrs, StdCtrls,
  NBPageControl;

type
  TfrmMain = class(TForm)
    mnuMain: TMainMenu;
    File_Main: TMenuItem;
    File_AktKepletAdatai: TMenuItem;
    N4: TMenuItem;
    File_Uj: TMenuItem;
    File_Megnyitas: TMenuItem;
    N1: TMenuItem;
    File_Mentes: TMenuItem;
    File_MentesMaskent: TMenuItem;
    File_Bezar: TMenuItem;
    File_Mindbezar: TMenuItem;
    N2: TMenuItem;
    File_Export: TMenuItem;
    File_Nyomtat: TMenuItem;
    N3: TMenuItem;
    File_Kilepes: TMenuItem;
    Tablazatok_Main: TMenuItem;
    Tablazatok_Bolygok: TMenuItem;
    Tablazatok_hazak: TMenuItem;
    Tablazatok_Fenyszogek: TMenuItem;
    Tablazatok_JartJaratlan: TMenuItem;
    Tablazatok_Enjelolok: TMenuItem;
    N6: TMenuItem;
    Tablazatok_Allocsillagpoz: TMenuItem;
    Specialis_Nezet_BolygokACsillagkepekben: TMenuItem;
    Specialis_Main: TMenuItem;
    Specialis_KepletLepteto: TMenuItem;
    Bolygmozgsok1: TMenuItem;
    N8: TMenuItem;
    Specialis_Kereses: TMenuItem;
    N12: TMenuItem;
    Specialis_Csillagora: TMenuItem;
    Egyebek_Main: TMenuItem;
    Holdfzisa1: TMenuItem;
    Napkeltenyugta1: TMenuItem;
    Bolygkeltenyugta1: TMenuItem;
    N11: TMenuItem;
    Holdfzisnaptr1: TMenuItem;
    Efemerisznaptr1: TMenuItem;
    N7: TMenuItem;
    Napfogyatkozsok1: TMenuItem;
    Holdfogyatkozsok1: TMenuItem;
    Bioritmus1: TMenuItem;
    Egyni1: TMenuItem;
    Csoportos1: TMenuItem;
    EgyszeruSzam_Main: TMenuItem;
    Ascendensszmts1: TMenuItem;
    Napjegyszmts1: TMenuItem;
    Holdjegyszmts1: TMenuItem;
    Szletsnknapja1: TMenuItem;
    Beall_Main: TMenuItem;
    eleplslista1: TMenuItem;
    Idznalista1: TMenuItem;
    N13: TMenuItem;
    Belltsok2: TMenuItem;
    Belltsokmentse1: TMenuItem;
    Segitseg_Main: TMenuItem;
    Segitseg_Programrol: TMenuItem;
    Segitseg_Alapfogalmak: TMenuItem;
    N9: TMenuItem;
    Segitseg_Nevjegy: TMenuItem;
    statBar: TStatusBar;
    appEvents: TApplicationEvents;
    tbrMenu: TToolBar;
    tbtnAktKepletadatai: TToolButton;
    actListMain: TActionList;
    actExit: TAction;
    ToolButton1: TToolButton;
    tbtnUj: TToolButton;
    tbtnMegnyitas: TToolButton;
    tbtnMentes: TToolButton;
    tbtbBezar: TToolButton;
    tbtnExport: TToolButton;
    tbtnnyomtat: TToolButton;
    ToolButton10: TToolButton;
    actAktKepletAdatai: TAction;
    actUj: TAction;
    actMegnyitas: TAction;
    actMentes: TAction;
    actMentesMaskent: TAction;
    actBezar: TAction;
    actMindBezar: TAction;
    actExport: TAction;
    actNyomtatas: TAction;
    actBolygok: TAction;
    actHazak: TAction;
    actFenyszogek: TAction;
    actJartJaratlan: TAction;
    actEnjelolok: TAction;
    actAllocsillagPoz: TAction;
    actBolygoACsillagkepben: TAction;
    actKepletLepteto: TAction;
    actBolygomozgasGrafikon: TAction;
    actKereses: TAction;
    actCsillagora: TAction;
    tbtnKilepes: TToolButton;
    actHoldFazis: TAction;
    actNapKeltenyugta: TAction;
    actBolygoKelteNyugta: TAction;
    actHoldfazisNaptar: TAction;
    actEfemeriszNaptar: TAction;
    actNapfogyatkozas: TAction;
    actHoldfogyatkozasok: TAction;
    actBioritmusEgyeni: TAction;
    actBioritmusParos: TAction;
    actASCSzamitas: TAction;
    actNapjegySzamitas: TAction;
    actHoldjegySzamitas: TAction;
    actSzuletesunkNapja: TAction;
    N14: TMenuItem;
    Szmmisztika1: TMenuItem;
    N15: TMenuItem;
    ToolButton24: TToolButton;
    Nvszm1: TMenuItem;
    Keltafahoroszkp1: TMenuItem;
    Indiaihoroszkp1: TMenuItem;
    Indinhoroszkp1: TMenuItem;
    Indinszerelmihoroszkp1: TMenuItem;
    Karmaacsillagjegyszerint1: TMenuItem;
    Csillagjegysasport1: TMenuItem;
    Csillagjegysank1: TMenuItem;
    Csillagjegysabn1: TMenuItem;
    Csillagjegysajeggyr1: TMenuItem;
    Csillagjegysagyengesgei1: TMenuItem;
    Csillagjegykarmikusfeladata1: TMenuItem;
    Csillagjegyerssgei1: TMenuItem;
    Csillagjegyrnyoldalai1: TMenuItem;
    Csillagjegysapnz1: TMenuItem;
    Csillagjegysadivat1: TMenuItem;
    Csillagjegysasrtresszzs1: TMenuItem;
    Csillagjegysaspiritualits1: TMenuItem;
    Szemlyesv1: TMenuItem;
    Csillagjegysasznek1: TMenuItem;
    Csillagjegyekvgyakozsai1: TMenuItem;
    Csillagjegysazregsg1: TMenuItem;
    Csillagjegyeksagygynvnyek1: TMenuItem;
    Csillagjegyplantrisszma1: TMenuItem;
    Csillagjegysacsbts1: TMenuItem;
    Csillagjegysazsvnyok1: TMenuItem;
    Csillagjegysatpllkozs1: TMenuItem;
    CsillagjegysazAngyalsegti1: TMenuItem;
    Csillagjegysakarmaltaltlttest1: TMenuItem;
    Csillagjegysasznek21: TMenuItem;
    Csillagjegysazajzszere1: TMenuItem;
    Csillagjegysahozzillprja1: TMenuItem;
    Csillagjegynegatvumai1: TMenuItem;
    Csillagjegyekmitnemszeretnek1: TMenuItem;
    Csillagjegyekamitszeretnek1: TMenuItem;
    Csillagjegyekkarcsonyiajndktippjei1: TMenuItem;
    Csillagjegyajndktippek1: TMenuItem;
    Csillagjegymintszl1: TMenuItem;
    Milyenvirgvagy1: TMenuItem;
    Csillagjegysadrgakvek1: TMenuItem;
    Csillagjegymeghdtsa1: TMenuItem;
    Csillagjegysasofrsg1: TMenuItem;
    Knaihoroszkp1: TMenuItem;
    Csillagjegys1: TMenuItem;
    N10: TMenuItem;
    Karma1: TMenuItem;
    N16: TMenuItem;
    vszakok1: TMenuItem;
    Csillagkpek1: TMenuItem;
    letszm1: TMenuItem;
    AsztrokalkultorZET81: TMenuItem;
    N17: TMenuItem;
    Megjelens1: TMenuItem;
    Fnyszgek2: TMenuItem;
    Szneksszimblumok1: TMenuItem;
    Lersok1: TMenuItem;
    NyriTliidszmtsbelltsok1: TMenuItem;
    Pontszmok1: TMenuItem;
    Hzrendszer1: TMenuItem;
    hrendsz_Placidus1_P_: TMenuItem;
    hrendsz_Regiomontanus1_R_: TMenuItem;
    hrendsz_Campanus1_C_: TMenuItem;
    hrendsz_Koch1_K_: TMenuItem;
    hrendsz_Egyenl1_A_: TMenuItem;
    Automatikusments1: TMenuItem;
    Segitseg_Kisokos: TMenuItem;
    Specialis_AsztroikerKereso: TMenuItem;
    Specialis_TobbKeplet: TMenuItem;
    Specialis_NezetMenu: TMenuItem;
    Specialis_Nezet_Kordiagram: TMenuItem;
    actCountryAndTimeZone: TAction;
    actNyariTeliIdoszamitas: TAction;
    actProgrLepteto: TAction;
    Specialis_ProgrLepteto: TMenuItem;
    actDrakon: TAction;
    N5: TMenuItem;
    Specialis_Drakonikus: TMenuItem;
    Progr_Main: TMenuItem;
    actIvdirekciok: TAction;
    actSzekunderDirekciok: TAction;
    actTercierDirekciok: TAction;
    actTranzitok: TAction;
    actRevoluciok: TAction;
    actNapAthaladasok: TAction;
    Progr_Ivdirekcio: TMenuItem;
    Progr_SzekDir: TMenuItem;
    Progr_TercierDir: TMenuItem;
    Progr_Trazitok: TMenuItem;
    Progr_Revoluciok: TMenuItem;
    Progr_Napathalad: TMenuItem;
    N18: TMenuItem;
    N19: TMenuItem;
    Bulvar_Main: TMenuItem;
    actBulvar_KaracsonyiAjandektippek: TAction;
    N20: TMenuItem;
    actBulvar_JegyEsEgeszseg: TAction;
    azegszsg1: TMenuItem;
    actBulvar_JegyEsKoveik: TAction;
    actBulvar_JegyArnyoldalai: TAction;
    actBulvar_JegyAmitSzeretnek: TAction;
    actBulvar_JegyAmitNemSzeretnek: TAction;
    actBulvar_JegyErossegei: TAction;
    actBulvar_JegyBun: TAction;
    actBulvar_JegyDivat: TAction;
    actNevjegy: TAction;
    N21: TMenuItem;
    Tablazatok_EgyebInfok: TMenuItem;
    actTablazatok_EgyebInfo: TAction;
    Holdnaptr1: TMenuItem;
    N22: TMenuItem;
    Progr_Idopontok: TMenuItem;
    N23: TMenuItem;
    Segitseg_Regisztracio: TMenuItem;
    actBeallitasok_Megjelenites: TAction;
    N24: TMenuItem;
    Arabpontok1: TMenuItem;
    N30osszalag1: TMenuItem;
    Plantaperspektva1: TMenuItem;
    Napazaszcendensen1: TMenuItem;
    Bolygazaszcendensen1: TMenuItem;
    Normlnzet1: TMenuItem;
    Hold1: TMenuItem;
    Merkur1: TMenuItem;
    Vnusz1: TMenuItem;
    Mars1: TMenuItem;
    Jupiter1: TMenuItem;
    Szaturnusz1: TMenuItem;
    Urnusz1: TMenuItem;
    Neptunusz1: TMenuItem;
    Plut1: TMenuItem;
    actBeallitasok_Szinek: TAction;
    hrendsz_Porphyrius1_O_: TMenuItem;
    Zodikus1: TMenuItem;
    zodiac_Sziderlis1_S_: TMenuItem;
    zodiac_ropikus1_T_: TMenuItem;
    pcWorkSpace: TNBPageControl;
    N25: TMenuItem;
    Egybek1: TMenuItem;
    actBeallitasok_Egyebek: TAction;
    procedure FormCreate(Sender: TObject);
    procedure appEventsHint(Sender: TObject);
    procedure actExitExecute(Sender: TObject);
    procedure actAktKepletAdataiExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actCountryAndTimeZoneExecute(Sender: TObject);
    procedure actMegnyitasExecute(Sender: TObject);
    procedure actUjExecute(Sender: TObject);
    procedure actNyariTeliIdoszamitasExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure actBolygokExecute(Sender: TObject);
    procedure actBulvar_KaracsonyiAjandektippekExecute(Sender: TObject);
    procedure actBulvar_JegyEsEgeszsegExecute(Sender: TObject);
    procedure actBulvar_JegyEsKoveikExecute(Sender: TObject);
    procedure actBulvar_JegyArnyoldalaiExecute(Sender: TObject);
    procedure actBulvar_JegyAmitSzeretnekExecute(Sender: TObject);
    procedure actBulvar_JegyAmitNemSzeretnekExecute(Sender: TObject);
    procedure actBulvar_JegyErossegeiExecute(Sender: TObject);
    procedure actBulvar_JegyBunExecute(Sender: TObject);
    procedure actBulvar_JegyDivatExecute(Sender: TObject);
    procedure actMentesExecute(Sender: TObject);
    procedure actMentesMaskentExecute(Sender: TObject);
    procedure actBezarExecute(Sender: TObject);
    procedure actMindBezarExecute(Sender: TObject);
    procedure actExportExecute(Sender: TObject);
    procedure actNyomtatasExecute(Sender: TObject);
    procedure actFenyszogekExecute(Sender: TObject);
    procedure actJartJaratlanExecute(Sender: TObject);
    procedure actEnjelolokExecute(Sender: TObject);
    procedure actHazakExecute(Sender: TObject);
    procedure actNevjegyExecute(Sender: TObject);
    procedure pcWorkSpaceMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pcWorkSpaceDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure pcWorkSpaceDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure pcWorkSpaceChange(Sender: TObject);
    procedure actTablazatok_EgyebInfoExecute(Sender: TObject);
    procedure actKepletLeptetoExecute(Sender: TObject);
    procedure actBeallitasok_MegjelenitesExecute(Sender: TObject);
    procedure actBeallitasok_SzinekExecute(Sender: TObject);
    procedure hrendszMenuItemClick(Sender: TObject);
    procedure zodiacMenuItemClick(Sender: TObject);
    procedure LastOpenedItemClick(Sender: TObject);
    procedure pcWorkSpaceMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure actBeallitasok_EgyebekExecute(Sender: TObject);
    procedure actDrakonExecute(Sender: TObject);
    procedure statBarDblClick(Sender: TObject);
  private
    { Private declarations }
    FobjAstro4AllMain : TAstro4AllMain;
    FSourceIndex: integer;

    procedure UpdateStatusBar;
    procedure MenuPontokBeallitasa;
    procedure CheckBoxMenuBeallitas(APrefix, AValue: String);
    procedure LastOpenedBeallitas;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses Math, fBaseSzulKepletForm, dAstro4All, uAstro4AllConsts, uSegedUtils;

{$R *.dfm}

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  Self.Height := Round(Screen.DesktopHeight * 0.8);
  Self.Width := Min(Round(Self.Height * 1.1), Round(Screen.DesktopWidth * 0.7));

  if IsCmdLineArg('SMALL') then
    begin
      Self.Height := 570;
      Self.Width := 800;
    end;

  statBar.Panels[0].Text := '';
  statBar.Panels[1].Text := '';  

  statBar.Panels[0].Width := Self.ClientWidth div 2;

  Application.HintPause := 100; //def 500
  Application.HintHidePause := 4000; //def 2500

  FobjAstro4AllMain := TAstro4AllMain.Create(pcWorkSpace);

  if FobjAstro4AllMain.SettingsProvider.GetInditasTeljesMeretben then
    Self.WindowState := wsMaximized;

  MenuPontokBeallitasa;
end;

procedure TfrmMain.appEventsHint(Sender: TObject);
begin
  UpdateStatusBar;
end;

procedure TfrmMain.actExitExecute(Sender: TObject);
begin
//  if MessageDlg('Valóban ki szeretne lépni a programból?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
//    Application.Terminate;
  frmMain.Close;
end;

procedure TfrmMain.actAktKepletAdataiExecute(Sender: TObject);
begin
  FobjAstro4AllMain.SzulKeplet_LetezoMegnyitModositasra;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FobjAstro4AllMain);
  inherited;
end;

procedure TfrmMain.actCountryAndTimeZoneExecute(Sender: TObject);
begin
  FobjAstro4AllMain.Beallitasok_CountryAndTimeZone;
end;

procedure TfrmMain.actMegnyitasExecute(Sender: TObject);
begin
  if FobjAstro4AllMain.SzulKeplet_Betolt then
    UpdateStatusBar; // rajzol;
end;

procedure TfrmMain.actUjExecute(Sender: TObject);
begin
  FobjAstro4AllMain.SzulKeplet_UjFelvitel;
end;

procedure TfrmMain.actNyariTeliIdoszamitasExecute(Sender: TObject);
begin
  // Nyári Téli idõszámítás beállítások...
  FobjAstro4AllMain.Beallitasok_TeliNyariIdoszamitas;
end;

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
//  CanClose := MessageDlg('Valóban ki szeretne lépni a programból?', mtConfirmation, [mbYes, mbNo], 0) = mrYes;
  CanClose := FobjAstro4AllMain.SzulKeplet_Bezar(true, false);
end;

procedure TfrmMain.actBolygokExecute(Sender: TObject);
begin
  FobjAstro4AllMain.Tablazatok_Bolygok;
end;

procedure TfrmMain.actBulvar_KaracsonyiAjandektippekExecute(
  Sender: TObject);
begin
  FobjAstro4AllMain.Bulvar_KaracsonyiAjandektippek();
end;

procedure TfrmMain.actBulvar_JegyEsEgeszsegExecute(Sender: TObject);
begin
  FobjAstro4AllMain.Bulvar_JegyEsEgeszseg();
end;

procedure TfrmMain.actBulvar_JegyEsKoveikExecute(Sender: TObject);
begin
  FobjAstro4AllMain.Bulvar_JegyEsKoveik();
end;

procedure TfrmMain.actBulvar_JegyArnyoldalaiExecute(Sender: TObject);
begin
  FobjAstro4AllMain.Bulvar_JegyArnyoldalai();
end;

procedure TfrmMain.actBulvar_JegyAmitSzeretnekExecute(Sender: TObject);
begin
  FobjAstro4AllMain.Bulvar_JegyAmitSzeretnek();
end;

procedure TfrmMain.actBulvar_JegyAmitNemSzeretnekExecute(Sender: TObject);
begin
  FobjAstro4AllMain.Bulvar_JegyAmitNemSzeretnek();
end;

procedure TfrmMain.actBulvar_JegyErossegeiExecute(Sender: TObject);
begin
  FobjAstro4AllMain.Bulvar_JegyErossegei();
end;

procedure TfrmMain.actBulvar_JegyBunExecute(Sender: TObject);
begin
  FobjAstro4AllMain.Bulvar_JegyBunok();
end;

procedure TfrmMain.actBulvar_JegyDivatExecute(Sender: TObject);
begin
  FobjAstro4AllMain.Bulvar_JegyDivat();
end;

procedure TfrmMain.actMentesExecute(Sender: TObject);
begin
  FobjAstro4AllMain.SzulKeplet_Mentes();
end;

procedure TfrmMain.actMentesMaskentExecute(Sender: TObject);
begin
  FobjAstro4AllMain.SzulKeplet_Mentes(true);
end;

procedure TfrmMain.actBezarExecute(Sender: TObject);
begin
  FobjAstro4AllMain.SzulKeplet_Bezar();
  LastOpenedBeallitas;
end;

procedure TfrmMain.actMindBezarExecute(Sender: TObject);
begin
  FobjAstro4AllMain.SzulKeplet_Bezar(true);
  LastOpenedBeallitas;
end;

procedure TfrmMain.actExportExecute(Sender: TObject);
begin
  FobjAstro4AllMain.File_Exportalas;
end;

procedure TfrmMain.actNyomtatasExecute(Sender: TObject);
begin
  FobjAstro4AllMain.SzulKeplet_PrintPreview;
end;

procedure TfrmMain.actFenyszogekExecute(Sender: TObject);
begin
  FobjAstro4AllMain.Tablazatok_FenyszogAdatok;
end;

procedure TfrmMain.actJartJaratlanExecute(Sender: TObject);
begin
  FobjAstro4AllMain.Tablazatok_EletStrategiaJaratlanUt;
end;

procedure TfrmMain.actEnjelolokExecute(Sender: TObject);
begin
  FobjAstro4AllMain.Tablazatok_Enjelolok;
end;

procedure TfrmMain.actHazakExecute(Sender: TObject);
begin
  FobjAstro4AllMain.Tablazatok_HazsarokPoz;
end;

procedure TfrmMain.actNevjegyExecute(Sender: TObject);
begin
  FobjAstro4AllMain.Segitseg_Nevjegy;
end;

procedure TfrmMain.pcWorkSpaceMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var hti: TTCHitTestInfo;
begin

  hti.pt := Point(X, Y);
  FSourceIndex := SendMessage(pcWorkSpace.Handle, TCM_HITTEST, 0, LPARAM(@hti));
  if FSourceIndex <> -1 then
    begin
      if ssCtrl in Shift then
        pcWorkSpace.Pages[FSourceIndex].BeginDrag(false);
    end;
end;

procedure TfrmMain.pcWorkSpaceDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := Source is TTabSheet;
end;

procedure TfrmMain.pcWorkSpaceDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var ind: Integer;
    hti: TTCHitTestInfo;
begin
  if FSourceIndex<>-1 then
    begin
      hti.pt := Point(X, Y);
      ind := SendMessage(pcWorkSpace.Handle, TCM_HITTEST, 0, LPARAM(@hti));
      if ind <> -1 then
        begin
          pcWorkSpace.Pages[FSourceIndex].PageIndex := ind;
        end;
    end;
end;

procedure TfrmMain.pcWorkSpaceChange(Sender: TObject);
begin
  UpdateStatusBar;
end;

procedure TfrmMain.UpdateStatusBar;
begin
  // Az akt szülképlet
  statBar.Panels[0].Text := '';
  if Assigned(pcWorkSpace.ActivePage) then
    begin
      statBar.Panels[0].Text := pcWorkSpace.ActivePage.Hint;
      statBar.Panels[0].Width := Round(statBar.Canvas.TextWidth(statBar.Panels[0].Text) * 1.2);
      Application.Title := 'Regiomontanus' + ' - ' + Trim(pcWorkSpace.ActivePage.Caption);
    end
  else
    begin
      statBar.Panels[0].Text := '';
      Application.Title := 'Regiomontanus';
    end;
  statBar.Panels[statBar.Panels.Count - 1].Text := GetLongHint(Application.Hint);
end;

procedure TfrmMain.actTablazatok_EgyebInfoExecute(Sender: TObject);
begin
  FobjAstro4AllMain.Tablazatok_EgyebAdatok;
end;

procedure TfrmMain.actKepletLeptetoExecute(Sender: TObject);
begin
  FobjAstro4AllMain.Specialis_KepletLeptetoShow;
end;

procedure TfrmMain.MenuPontokBeallitasa;
const cREGALL  =  0; // és minden más KIVÉVE -> 99
      cREGBASE =  1;
      cREGNONE = 99; // és File_Main, Segitseg_Main

  procedure SetMenuItems(AValues: TByteSet);
  var i : integer;
  begin
    for i := 0 to Self.ComponentCount - 1 do
      if Self.Components[i] is TMenuItem then
        begin
          if not (TMenuItem(Self.Components[i]).Tag in AValues) then
            begin
              TMenuItem(Self.Components[i]).Enabled := False;
              TMenuItem(Self.Components[i]).Visible := False;
            end;
        end
      else
        if Self.Components[i] is TToolButton then
          begin
            if not (TToolButton(Self.Components[i]).Tag in AValues) then
              begin
                TToolButton(Self.Components[i]).Enabled := False;
                TToolButton(Self.Components[i]).Visible := False;
              end;
          end;
  end;

var iMenuTagID : TByteSet;
begin
  iMenuTagID := [];
  if not FobjAstro4AllMain.RegistrationSettings.Registered then // nincs regisztrálva
    begin
      case FobjAstro4AllMain.RegistrationSettings.RegState of
      regNone : iMenuTagID := [cREGNONE, cREGBASE];
      regBase : iMenuTagID := [cREGNONE, cREGBASE];
      end;
    end
  else
    if (FobjAstro4AllMain.RegistrationSettings.Registered) then // regisztrált
      begin
        case FobjAstro4AllMain.RegistrationSettings.RegState of
        regBase : iMenuTagID := [cREGBASE];
        regAll  : iMenuTagID := [cREGALL, cREGBASE];
        end;
      end;

  SetMenuItems(iMenuTagID);
  CheckBoxMenuBeallitas('hrendsz_', FobjAstro4AllMain.SettingsProvider.GetHouseCuspSystem);
  CheckBoxMenuBeallitas('zodiac_', FobjAstro4AllMain.SettingsProvider.GetZodiacType);

  LastOpenedBeallitas;
end;

procedure TfrmMain.actBeallitasok_MegjelenitesExecute(Sender: TObject);
begin
  FobjAstro4AllMain.Beallitasok_Megjelenites;
end;

procedure TfrmMain.actBeallitasok_SzinekExecute(Sender: TObject);
begin
  FobjAstro4AllMain.Beallitasok_Szinek;
end;

procedure TfrmMain.CheckBoxMenuBeallitas(APrefix, AValue: String);
var i : integer;
begin
  // Házrendszer - zodiákus beállítása - TComponent -> TMenuItem
  for i := 0 to Self.ComponentCount - 1 do
    if (Self.Components[i] is TMenuItem) and (pos(UpperCase(APrefix), UpperCase(TMenuItem(Self.Components[i]).Name)) > 0) then
      begin
        TMenuItem(Self.Components[i]).Checked := false;
        if pos(AValue + '_', TMenuItem(Self.Components[i]).Name) > 0 then
          TMenuItem(Self.Components[i]).Checked := true;
      end;
end;

procedure TfrmMain.hrendszMenuItemClick(Sender: TObject);
begin
  if Sender is TMenuItem then
    begin
      FobjAstro4AllMain.Beallitasok_Hazrendszer(TMenuItem(Sender).Name);

      CheckBoxMenuBeallitas('hrendsz_', FobjAstro4AllMain.SettingsProvider.GetHouseCuspSystem);
    end;
end;

procedure TfrmMain.LastOpenedBeallitas;
var //slLastOpened : TStringList;
    i, iStart : integer;
    bLastItemStarted : boolean;
    mnuItem : TMenuItem;
    sLastOpenedFiles : string;
begin
  //slLastOpened := TStringList.Create;
  try
    sLastOpenedFiles := FobjAstro4AllMain.ObjLastOpenedFiles.GetLastOpenedFiles;
    //slLastOpened.Delimiter := ';';
    //slLastOpened.DelimitedText := FobjAstro4AllMain.ObjLastOpenedFiles.GetLastOpenedFiles;

    iStart := -1;
    bLastItemStarted := false;
    i := File_Main.Count - 1;
    while i <> 0 do
      begin
        File_Main.Items[i].Hint := IntToStr(File_Main.Items[i].Tag) + ' ' + File_Main.Items[i].Name;
        if bLastItemStarted and (File_Main.Items[i].Tag <> 999) then
          begin
            File_Main.Delete(i);
            dec(i);
          end
        else
          begin
            if File_Main.Items[i].Tag = 999 then
              bLastItemStarted := not bLastItemStarted;
            if File_Main.Items[i].Name = 'N25' then iStart := i + 1;
            dec(i);
          end;
      end;

    //for i := slLastOpened.Count - 1 downto 0 do
    for i := WordCount(sLastOpenedFiles, [';']) downto 1 do
      begin
        mnuItem := TMenuItem.Create(File_Main);
        mnuItem.AutoHotkeys := maManual;
        //mnuItem.Caption := '&' + IntToStr(i + 1) + ': ' + slLastOpened.Strings[i];
        mnuItem.Caption := '&' + IntToStr(i) + ': ' + ExtractWord(i, sLastOpenedFiles, [';']);
        mnuItem.OnClick := LastOpenedItemClick;

        File_Main.Insert(iStart, mnuItem);
      end;

  finally
    //FreeAndNil(slLastOpened);
  end;
end;

procedure TfrmMain.zodiacMenuItemClick(Sender: TObject);
begin
  if Sender is TMenuItem then
    begin
      FobjAstro4AllMain.Beallitasok_Zodiakus(TMenuItem(Sender).Name);

      CheckBoxMenuBeallitas('zodiac_', FobjAstro4AllMain.SettingsProvider.GetZodiacType);
    end;
end;

procedure TfrmMain.LastOpenedItemClick(Sender: TObject);
var sValue : string;
begin
  // Betöltés...
  sValue := TMenuItem(Sender).Caption;
  Delete(sValue, 1, pos(':', sValue) + 1);
  FobjAstro4AllMain.File_LastOpened(sValue);
  FobjAstro4AllMain.ObjLastOpenedFiles.RemoveOpenedFileName(sValue);
  LastOpenedBeallitas;
end;

procedure TfrmMain.pcWorkSpaceMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (Button = mbLeft) and (pcWorkSpace.IsMouseOverCloseButton(X,Y)) then
    begin
      FobjAstro4AllMain.SzulKeplet_Bezar();
      LastOpenedBeallitas;
    end;
end;

procedure TfrmMain.actBeallitasok_EgyebekExecute(Sender: TObject);
begin
  FobjAstro4AllMain.Beallitasok_EgyebBeallitasok;
end;

procedure TfrmMain.actDrakonExecute(Sender: TObject);
begin
  FobjAstro4AllMain.Specialis_DrakonikusAbra;
end;

procedure TfrmMain.statBarDblClick(Sender: TObject);
begin
//
end;

end.
