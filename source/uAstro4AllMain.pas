{
  Egy osztály, ami mindent összefoglal!
}
unit uAstro4AllMain;

interface

uses Windows, uAstro4AllCalculator, uAstro4AllConsts, uAstro4AllFileHandling, Contnrs, uAstro4AllTypes, ComCtrls;

type
  //# Egy osztály, ami mindent visz! :)
  TAstro4AllMain = class(TObject)
  private
    FImageDLLHandle: THandle;
    FMainSzulKepletPageControl: TPageControl;
    FobjBulvarIniFileLoader: TBulvarIniFileLoader;
    FobjDataSetInfoProvider: TDataSetInfoProvider;
    FObjLastOpenedFiles: TLastOpenedFiles;
    FobjSettingsINIFileLoader: TSettingsINIFileLoader;
    FobjSWECalculator: TSWECalculator;
    FobjSzulKepletAdatokINIFileLoader: TSzuletesiKepletAdatokINIFileLoader;
    FRegistrationSettings: TRegistrationSettings;
    FSettingsProvider: TSettingsProvider;
    FSzulKepletFormsList: TObjectList;
    function GenerateSzulKepletFileAndSave(ASzulKepletInfo: TSzuletesiKepletInfo; AFileName: string): Boolean;
    function GetAktSzulKepletFormKepletInfoIDX: Integer;
    procedure CheckFonts;
    function DestroyPageByName(ATabSheetName: string;AChanged: boolean): Boolean;
    function Error_NincsSzulKeplet: string;
    procedure RedrawAllOpenedSzulKeplet(ARecalcValues: Boolean = False);
    procedure SzulKeplet_NewFormCreate(ASzulKeplet: TSzuletesiKepletInfo);
  public
    constructor Create(AMainSzulKepletPageControl: TPageControl);
    destructor Destroy; override;
    procedure Beallitasok_CountryAndTimeZone;
    procedure Beallitasok_Megjelenites;
    procedure Beallitasok_Szinek;
    procedure Beallitasok_EgyebBeallitasok;
    procedure Beallitasok_TeliNyariIdoszamitas;
    procedure Beallitasok_Hazrendszer(ANewHouseSystem: string);
    procedure Beallitasok_Zodiakus(AZodiacSystem: string);
    procedure Bulvar_JegyAmitNemSzeretnek;
    procedure Bulvar_JegyAmitSzeretnek;
    procedure Bulvar_JegyArnyoldalai;
    procedure Bulvar_JegyBunok;
    procedure Bulvar_JegyDivat;
    procedure Bulvar_JegyErossegei;
    procedure Bulvar_JegyEsEgeszseg;
    procedure Bulvar_JegyEsKoveik;
    procedure Bulvar_KaracsonyiAjandektippek;
    procedure CloseSWEFiles;
    procedure File_Exportalas;
    procedure File_LastOpened(AFileNamePath: string);
    function GetAktSzulKepletFormKepletInfo: TSzulKepletFormInfo;
    function GetAktSzulKepletInfo: TSzuletesiKepletInfo;
    function GetTimeZoneIDFromSelector(ATimeZoneID: string): string;
    procedure OpenSWEFiles;
    procedure Segitseg_Nevjegy;
    procedure SetAktSzulKepletInfo(ASzulKeplet : TSzuletesiKepletInfo);
    procedure Specialis_DrakonikusAbra;
    procedure Specialis_KepletLeptetoShow;
    function SzulKeplet_Betolt: Boolean;
    function SzulKeplet_Bezar(AMindBezar: boolean = false; AKellFigyelm: boolean = true): Boolean;
    procedure SzulKeplet_LetezoMegnyitModositasra;
    function SzulKeplet_Mentes(AMentesMaskent: boolean = false): Boolean;
    procedure SzulKeplet_PrintPreview;
    procedure SzulKeplet_UjFelvitel;
    procedure Tablazatok_Bolygok;
    procedure Tablazatok_EgyebAdatok;
    procedure Tablazatok_EletStrategiaJaratlanUt;
    procedure Tablazatok_Enjelolok;
    procedure Tablazatok_FenyszogAdatok;
    procedure Tablazatok_HazsarokPoz;
    procedure UpdateActiveSheetHint;
    property ImageDLLHandle: THandle read FImageDLLHandle write FImageDLLHandle;
    property objBulvarIniFileLoader: TBulvarIniFileLoader read FobjBulvarIniFileLoader write FobjBulvarIniFileLoader;
    property objDataSetInfoProvider: TDataSetInfoProvider read FobjDataSetInfoProvider;
    property ObjLastOpenedFiles: TLastOpenedFiles read FObjLastOpenedFiles write FObjLastOpenedFiles;
    property objSettingsINIFileLoader: TSettingsINIFileLoader read FobjSettingsINIFileLoader write
        FobjSettingsINIFileLoader;
    property objSWECalculator: TSWECalculator read FobjSWECalculator;
    property objSzulKepletAdatokINIFileLoader: TSzuletesiKepletAdatokINIFileLoader read FobjSzulKepletAdatokINIFileLoader;
    property RegistrationSettings: TRegistrationSettings read FRegistrationSettings;
    property SettingsProvider: TSettingsProvider read FSettingsProvider;
    property SzulKepletFormsList: TObjectList read FSzulKepletFormsList write FSzulKepletFormsList;
  end;

implementation

uses Graphics, Forms, SysUtils, Dialogs, Controls, Math, Classes, ExtCtrls, jpeg,
     swe_de32,
     fSzuletesiKepletAdatok, fCountryAndTimeZone, fBaseSzulKepletForm,
     uSegedUtils, fCestSettings, fPlanetPositions, fHouseCuspsPositions,
     fTimeZoneSelect, fBulvarItemShow, fNevjegy, fAspectInformations,
  uOtherTypes, fTablazat_EgyebInformaciok, fPrintChartPreview,
  fKepletLepteto, fSelfMarkers, fBeallitasok_Megjelenites,
  fEletstratJaratlanUt, fBeallitasok_Szinek, fBeallitasok_Egyebek,
  uAstro4AllPrinting;

constructor TAstro4AllMain.Create(AMainSzulKepletPageControl: TPageControl);
begin
  inherited Create;
  OpenSWEFiles;

  FRegistrationSettings := TRegistrationSettings.Create();

  FobjSettingsINIFileLoader := TSettingsINIFileLoader.Create();
  FobjSettingsINIFileLoader.LoadINIFile(ExtractFilePath(Application.ExeName) + cPATH_DATA + cFILENAME_SETTINGS);

  FSettingsProvider := TSettingsProvider.Create(FobjSettingsINIFileLoader);

  FobjDataSetInfoProvider := TDataSetInfoProvider.Create();

  FobjSWECalculator := TSWECalculator.Create(FobjDataSetInfoProvider, FSettingsProvider);

  FobjSzulKepletAdatokINIFileLoader := TSzuletesiKepletAdatokINIFileLoader.Create();

  FSzulKepletFormsList := TObjectList.Create();

  FobjBulvarIniFileLoader := TBulvarIniFileLoader.Create();
  FobjBulvarIniFileLoader.LoadINIFile(ExtractFilePath(Application.ExeName) + cPATH_DATA + cFILENAME_BULVARJELLEMZESEK);

  FImageDLLHandle := LoadLibrary(cFILENAME_IMAGEDLL);
  FMainSzulKepletPageControl := AMainSzulKepletPageControl;

  FObjLastOpenedFiles := TLastOpenedFiles.Create();
  FObjLastOpenedFiles.FMaxOpenedCount := 10;
  FObjLastOpenedFiles.LastOpenedCount := FSettingsProvider.GetLastOpenedCount;

  CheckFonts;
end;

destructor TAstro4AllMain.Destroy;
begin
  FreeAndNil(FObjLastOpenedFiles);
  FreeAndNil(FSettingsProvider);
  FreeAndNil(FobjSettingsINIFileLoader);
  FreeAndNil(FRegistrationSettings);
  FreeLibrary(FImageDLLHandle);
  FreeAndNil(FobjBulvarIniFileLoader);
//  FreeAndNil(FSzulKepletFormsList); // ha ez itt van akkor Exception ... utánanézni ... !!!
  FreeAndNil(FobjSzulKepletAdatokINIFileLoader);
  FreeAndNil(FobjSWECalculator);
  FreeAndNil(FobjDataSetInfoProvider);
  CloseSWEFiles;
  inherited;
end;

procedure TAstro4AllMain.Beallitasok_CountryAndTimeZone;
begin
  Application.CreateForm(TfrmCountryAndTimeZone, frmCountryAndTimeZone);
  frmCountryAndTimeZone.objDataSetInfoProvider := FobjDataSetInfoProvider;

  frmCountryAndTimeZone.ShowModal;

  FreeAndNil(frmCountryAndTimeZone);
end;

procedure TAstro4AllMain.Beallitasok_Megjelenites;
begin
  Application.CreateForm(TfrmBeallitasok_Megjelenites, frmBeallitasok_Megjelenites);
  frmBeallitasok_Megjelenites.objAstro4AllMain := Self;
  if frmBeallitasok_Megjelenites.ShowModal = mrOK then
    RedrawAllOpenedSzulKeplet;
  FreeAndNil(frmBeallitasok_Megjelenites);
end;

procedure TAstro4AllMain.Beallitasok_TeliNyariIdoszamitas;
begin
  Application.CreateForm(TfrmCestSettings, frmCestSettings);
  frmCestSettings.objDataSetInfoProvider := FobjDataSetInfoProvider;

  frmCestSettings.ShowModal;

  FreeAndNil(frmCestSettings);
end;

procedure TAstro4AllMain.Bulvar_JegyAmitNemSzeretnek;
begin
  ShowBulvarType(tbulv_JegyAmitNemSzeretnek, FobjSWECalculator, GetAktSzulKepletFormKepletInfo, FobjBulvarIniFileLoader, Self);
end;

procedure TAstro4AllMain.Bulvar_JegyAmitSzeretnek;
begin
  ShowBulvarType(tbulv_JegyAmitSzeretnek, FobjSWECalculator, GetAktSzulKepletFormKepletInfo, FobjBulvarIniFileLoader, Self);
end;

procedure TAstro4AllMain.Bulvar_JegyArnyoldalai;
begin
  ShowBulvarType(tbulv_JegyArnyoldalai, FobjSWECalculator, GetAktSzulKepletFormKepletInfo, FobjBulvarIniFileLoader, Self);
end;

procedure TAstro4AllMain.Bulvar_JegyBunok;
begin
  ShowBulvarType(tbulv_JegyBunok, FobjSWECalculator, GetAktSzulKepletFormKepletInfo, FobjBulvarIniFileLoader, Self);
end;

procedure TAstro4AllMain.Bulvar_JegyDivat;
begin
  ShowBulvarType(tbulv_JegyDivat, FobjSWECalculator, GetAktSzulKepletFormKepletInfo, FobjBulvarIniFileLoader, Self);
end;

procedure TAstro4AllMain.Bulvar_JegyErossegei;
begin
  ShowBulvarType(tbulv_JegyErossegei, FobjSWECalculator, GetAktSzulKepletFormKepletInfo, FobjBulvarIniFileLoader, Self);
end;

procedure TAstro4AllMain.Bulvar_JegyEsEgeszseg;
begin
  ShowBulvarType(tbulv_JegyEsEgeszseg, FobjSWECalculator, GetAktSzulKepletFormKepletInfo, FobjBulvarIniFileLoader, Self);
end;

procedure TAstro4AllMain.Bulvar_JegyEsKoveik;
begin
  ShowBulvarType(tbulv_JegyEsKoveik, FobjSWECalculator, GetAktSzulKepletFormKepletInfo, FobjBulvarIniFileLoader, Self);
end;

procedure TAstro4AllMain.Bulvar_KaracsonyiAjandektippek;
begin
  ShowBulvarType(tbulv_AjandekAJegySzulotteinek, FobjSWECalculator, GetAktSzulKepletFormKepletInfo, FobjBulvarIniFileLoader, Self);
end;

procedure TAstro4AllMain.CloseSWEFiles;
begin
  // Fájlok lezárása
  swe_close;
end;

function TAstro4AllMain.GenerateSzulKepletFileAndSave(ASzulKepletInfo: TSzuletesiKepletInfo; AFileName: string):
    Boolean;
var slSaveFile : TStringList;
    i : integer;
begin
  Result := true;

  slSaveFile := TStringList.Create;
  try
    slSaveFile.Add('');
    slSaveFile.Add('[' + cBIRTHINI_SECBIRTHINFO + ']');
    slSaveFile.Add(cBIRTHINI_Name + '=' + ASzulKepletInfo.Name);
    slSaveFile.Add(cBIRTHINI_Gender + '=' + IntToStr(ASzulKepletInfo.Gender));
    slSaveFile.Add(cBIRTHINI_Year + '=' + IntToStr(ASzulKepletInfo.Year));
    slSaveFile.Add(cBIRTHINI_Month + '=' + IntToStr(ASzulKepletInfo.Month));
    slSaveFile.Add(cBIRTHINI_Day + '=' + IntToStr(ASzulKepletInfo.Day));
    slSaveFile.Add(cBIRTHINI_Hour + '=' + IntToStr(ASzulKepletInfo.Hour));
    slSaveFile.Add(cBIRTHINI_Minute + '=' + IntToStr(ASzulKepletInfo.Minute));
    slSaveFile.Add(cBIRTHINI_Second + '=' + IntToStr(ASzulKepletInfo.Second));
    slSaveFile.Add(cBIRTHINI_TZoneCode + '=' + ASzulKepletInfo.TZoneCode);
    slSaveFile.Add(cBIRTHINI_TZoneWest + '=' + BoolToStrAstro(ASzulKepletInfo.TZoneWest, false));
    slSaveFile.Add(cBIRTHINI_TZoneHour + '=' + IntToStr(ASzulKepletInfo.TZoneHour));
    slSaveFile.Add(cBIRTHINI_TZoneMinute + '=' + IntToStr(ASzulKepletInfo.TZoneMinute));
    slSaveFile.Add(cBIRTHINI_LocCity + '=' + ASzulKepletInfo.LocCity);
    slSaveFile.Add(cBIRTHINI_LocCountry + '=' + ASzulKepletInfo.LocCountry);
    slSaveFile.Add(cBIRTHINI_LocCountryID + '=' + ASzulKepletInfo.LocCountryID);
    slSaveFile.Add(cBIRTHINI_LocAltitude + '=' + IntToStr(ASzulKepletInfo.LocAltitude));
    slSaveFile.Add(cBIRTHINI_LocLongDegree + '=' + IntToStr(ASzulKepletInfo.LocLongDegree));
    slSaveFile.Add(cBIRTHINI_LocLongMinute + '=' + IntToStr(ASzulKepletInfo.LocLongMinute));
    slSaveFile.Add(cBIRTHINI_LocLongSecond + '=' + IntToStr(ASzulKepletInfo.LocLongSecond));
    slSaveFile.Add(cBIRTHINI_LocLatDegree + '=' + IntToStr(ASzulKepletInfo.LocLatDegree));
    slSaveFile.Add(cBIRTHINI_LocLatMinute + '=' + IntToStr(ASzulKepletInfo.LocLatMinute));
    slSaveFile.Add(cBIRTHINI_LocLatSecond + '=' + IntToStr(ASzulKepletInfo.LocLatSecond));
    slSaveFile.Add(cBIRTHINI_IsDayLightSavingTime + '=' + BoolToStrAstro(ASzulKepletInfo.IsDayLightSavingTime, false));

    slSaveFile.Add('');
    slSaveFile.Add('[' + cBIRTHINI_SECNOTES + ']');
    for i := 0 to ASzulKepletInfo.Note.Count - 1 do
      slSaveFile.Add(cBIRTHINI_NoteBASE + PaddL(IntToStr(i+1), 2, '0') + '=' + ASzulKepletInfo.Note.Strings[i]);

    try
      slSaveFile.SaveToFile(AFileName);
    except
      raise;
    end;
  finally
    FreeAndNil(slSaveFile);
  end;
end;

function TAstro4AllMain.GetAktSzulKepletFormKepletInfo: TSzulKepletFormInfo;
var i : integer;
    sSheetName : string;
begin
  Result := nil;

  if Assigned(FMainSzulKepletPageControl) and (FMainSzulKepletPageControl.PageCount > 0) then
    begin
      sSheetName := FMainSzulKepletPageControl.ActivePage.Name;
      if Trim(sSheetName) <> '' then
        begin
          i := 0;
          while (i <= FSzulKepletFormsList.Count - 1) and (not Assigned(Result)) do
            begin
              if TfrmBaseSzulKepletForm(FSzulKepletFormsList.Items[i]).TabSheetName = sSheetName then
                Result := TfrmBaseSzulKepletForm(FSzulKepletFormsList.Items[i]).GetAktKepletInfo; // a legelsõ képlet infó
              inc(i);
            end;
        end;
    end;
end;

function TAstro4AllMain.GetAktSzulKepletFormKepletInfoIDX: Integer;
var i : integer;
    sSheetName : string;
begin
  Result := -1;

  if Assigned(FMainSzulKepletPageControl) and (FMainSzulKepletPageControl.PageCount > 0) then
    begin
      sSheetName := FMainSzulKepletPageControl.ActivePage.Name;
      if Trim(sSheetName) <> '' then
        begin
          i := 0;
          while (i <= FSzulKepletFormsList.Count - 1) and (Result = -1) do
            begin
              if TfrmBaseSzulKepletForm(FSzulKepletFormsList.Items[i]).TabSheetName = sSheetName then
                Result := i; // a legelsõ képlet infó
              inc(i);
            end;
        end;
    end;
end;

function TAstro4AllMain.GetAktSzulKepletInfo: TSzuletesiKepletInfo;
var ASzulKepletFormInfo : TSzulKepletFormInfo;
begin
  Result := nil;

  //ASzulKepletFormInfo := nil;

  ASzulKepletFormInfo := GetAktSzulKepletFormKepletInfo;

  if Assigned(ASzulKepletFormInfo) then
    Result := ASzulKepletFormInfo.FSzuletesiKepletInfo;
end;

function TAstro4AllMain.GetTimeZoneIDFromSelector(ATimeZoneID: string): string;
begin
  Result := '';
  Application.CreateForm(TfrmTimeZoneSelect, frmTimeZoneSelect);
  frmTimeZoneSelect.FAktSelectedTimeZonedCode := ATimeZoneID;
  frmTimeZoneSelect.objDataSetInfoProvider := FobjDataSetInfoProvider;
  if frmTimeZoneSelect.ShowModal = mrOK then
    Result := frmTimeZoneSelect.FAktSelectedTimeZonedCode;
  FreeAndNil(frmTimeZoneSelect);
end;

procedure TAstro4AllMain.OpenSWEFiles;
begin
  swe_set_ephe_path(PChar(ExtractFilePath(Application.ExeName) + cPATH_EPHE_DATA));
end;

procedure TAstro4AllMain.Segitseg_Nevjegy;
begin
  Application.CreateForm(TfrmNevjegy, frmNevjegy);
  frmNevjegy.ShowModal;
  FreeAndNil(frmNevjegy);
end;

procedure TAstro4AllMain.SetAktSzulKepletInfo(ASzulKeplet : TSzuletesiKepletInfo);
var iKepletIDX : integer;
begin
  iKepletIDX := GetAktSzulKepletFormKepletInfoIDX;

  if iKepletIDX <> -1 then
    begin
      TfrmBaseSzulKepletForm(FSzulKepletFormsList.Items[iKepletIDX]).ClearDrawingItems;
      TfrmBaseSzulKepletForm(FSzulKepletFormsList.Items[iKepletIDX]).SetAktKepletInfo(ASzulKeplet);
      TfrmBaseSzulKepletForm(FSzulKepletFormsList.Items[iKepletIDX]).RedrawSzulKeplet;
    end;
end;

function TAstro4AllMain.SzulKeplet_Betolt: Boolean;
var opdOpenSzuleKeplet : TOpenDialog;
    i : integer;
begin
  Result := false;
  
  opdOpenSzuleKeplet := TOpenDialog.Create(Application.MainForm);
  try
    opdOpenSzuleKeplet.Title := 'Születési képlet megnyitása';
    opdOpenSzuleKeplet.Filter := cSZULKEPLETFILEFILETER;
    opdOpenSzuleKeplet.InitialDir := ExtractFilePath(Application.ExeName) + cPATH_SZULKEPLET;
    opdOpenSzuleKeplet.DefaultExt := '*.szk';
    opdOpenSzuleKeplet.Options := opdOpenSzuleKeplet.Options + [ofNoChangeDir, ofEnableSizing, ofAllowMultiSelect];

    if opdOpenSzuleKeplet.Execute then
      begin
        try
          // több fájl betöltésének lehetõsége
          for i := 0 to opdOpenSzuleKeplet.Files.Count - 1 do
            SzulKeplet_NewFormCreate(FobjSzulKepletAdatokINIFileLoader.GetSzuletesiKepletFileInfo(opdOpenSzuleKeplet.Files[i]));

          //SzulKeplet_NewFormCreate(FobjSzulKepletAdatokINIFileLoader.GetSzuletesiKepletFileInfo(opdOpenSzuleKeplet.FileName));
          UpdateActiveSheetHint;
          Result := true;
        except
          on E : Exception do
            begin
              MessageDlg('Hiba a Születési képlet megnyitásakor!' + #13#10#13#10 + E.Message, mtError, [mbOK], 0);
              Result := false;
            end;
        end;
      end;

  finally
    FreeAndNil(opdOpenSzuleKeplet);
  end;
end;

function TAstro4AllMain.SzulKeplet_Bezar(AMindBezar: boolean = false; AKellFigyelm: boolean = true): Boolean;
var ASzulKeplet : TSzuletesiKepletInfo;
    sSeged : string;
    i : integer;
    bOK, bChanged{} : boolean;
begin
  Result := true;
  ASzulKeplet := GetAktSzulKepletInfo;

  if Assigned(ASzulKeplet) then
    begin
      if not AMindBezar then sSeged := 'aktuális' else sSeged := 'összes';

      bOK := true;
      bChanged := ASzulKeplet.KepletInfoChanged;

      //if AKellFigyelm or ASzulKeplet.Changed then
      //if bChanged then
      //  bOK := MessageDlg('Valóban be szeretné zárni az ' + sSeged + ' születési képlet?', mtConfirmation, [mbYes, mbNo], 0) = mrYes;

      // Erre is kellene valamikor figyelni: ASzulKeplet.Changed !!!
      if bOK then
        begin // Igen be akarjuk zárni
          if not AMindBezar then
            begin
              Result := DestroyPageByName(FMainSzulKepletPageControl.ActivePage.Name, bChanged);
              if Result then
                FMainSzulKepletPageControl.ActivePage.Destroy;

              FMainSzulKepletPageControl.ActivePageIndex := FMainSzulKepletPageControl.PageCount - 1;
              if FMainSzulKepletPageControl.PageCount > 0 then
                FMainSzulKepletPageControl.Invalidate;
            end
          else
            begin
              for i := FMainSzulKepletPageControl.PageCount - 1 downto 0 do
                begin
                  FMainSzulKepletPageControl.ActivePageIndex := i;
                  bChanged := GetAktSzulKepletInfo.KepletInfoChanged;
                  Result := Result and DestroyPageByName(FMainSzulKepletPageControl.ActivePage.Name, bChanged);
                  if Result then
                    FMainSzulKepletPageControl.ActivePage.Destroy;
                end;
            end;
        end;
    end
  else
    begin
      if AKellFigyelm then
        MessageDlg('Nincs bezárható Születési képlet!', mtError, [mbOK], 0);
    end;
end;

procedure TAstro4AllMain.SzulKeplet_LetezoMegnyitModositasra;
var ASzulKeplet : TSzuletesiKepletInfo;
begin
  ASzulKeplet := GetAktSzulKepletInfo;

  if Assigned(ASzulKeplet) then
    begin
      Application.CreateForm(TfrmSzuletesiKepletAdatok, frmSzuletesiKepletAdatok);
      frmSzuletesiKepletAdatok.objDataSetInfoProvider := FobjDataSetInfoProvider;
      frmSzuletesiKepletAdatok.FobjAstro4AllMain := Self;

      frmSzuletesiKepletAdatok.LetezoSzulKepletMegjelenit(ASzulKeplet);

       //TODO: Újra kellene számolni a megváltozott adatokat
      if frmSzuletesiKepletAdatok.ShowModal = mrOK then
        begin
          SetAktSzulKepletInfo(frmSzuletesiKepletAdatok.Result_SzulKeplet);
          UpdateActiveSheetHint;
        end;

      FreeAndNil(frmSzuletesiKepletAdatok);
    end
  else
    begin
      MessageDlg(Error_NincsSzulKeplet, mtError, [mbOK], 0);
    end;
end;

function TAstro4AllMain.SzulKeplet_Mentes(AMentesMaskent: boolean = false): Boolean;
var ASzulKeplet : TSzuletesiKepletInfo;
    svdSaveSzulKeplet : TSaveDialog;
begin
  Result := true;

  ASzulKeplet := GetAktSzulKepletInfo;

  if Assigned(ASzulKeplet) then
    begin
      if (Trim(ASzulKeplet.FileName) <> '') and (not AMentesMaskent) then
        begin // Létezõ mentése
          try
            Result := GenerateSzulKepletFileAndSave(ASzulKeplet, ASzulKeplet.FileName);
          except
            on E : Exception do
              begin
                MessageDlg('Hiba a Születési képlet mentésekor!' + #13#10#13#10 + E.Message, mtError, [mbOK], 0);
                Result := false;
              end;
          end;
        end
      else
        begin // Új képlet mentése
          svdSaveSzulKeplet := TSaveDialog.Create(Application.MainForm);
          try
            svdSaveSzulKeplet.Title := 'Születési képlet mentése';
            if AMentesMaskent then
              svdSaveSzulKeplet.Title := 'Születési képlet mentése másként...';
              
            svdSaveSzulKeplet.Filter := cSZULKEPLETFILEFILETER;
            svdSaveSzulKeplet.InitialDir := ExtractFilePath(Application.ExeName) + cPATH_SZULKEPLET;
            svdSaveSzulKeplet.DefaultExt := '*.szk';
            svdSaveSzulKeplet.Options := svdSaveSzulKeplet.Options + [ofNoChangeDir, ofOverwritePrompt, ofEnableSizing];

            if AMentesMaskent then
              svdSaveSzulKeplet.FileName := ASzulKeplet.FileName;

            if Trim(svdSaveSzulKeplet.FileName) = '' then
              svdSaveSzulKeplet.FileName := ASzulKeplet.Name;

            if svdSaveSzulKeplet.Execute then
              begin
                try
                  Result := GenerateSzulKepletFileAndSave(ASzulKeplet, svdSaveSzulKeplet.FileName);
                  if Result then
                    begin
                      ASzulKeplet.KepletInfoChanged := false; // elmentés után, minden oké!
                      ASzulKeplet.FileName := svdSaveSzulKeplet.FileName;
                    end;
                except
                  on E : Exception do
                    begin
                      MessageDlg('Hiba a Születési képlet mentésekor!' + #13#10#13#10 + E.Message, mtError, [mbOK], 0);
                      Result := false;
                    end;
                end;
              end
            else
              Result := false;
          finally
            FreeAndNil(svdSaveSzulKeplet);
          end;
        end;
    end
  else
    begin
      MessageDlg(Error_NincsSzulKeplet, mtError, [mbOK], 0);
    end;
end;

procedure TAstro4AllMain.SzulKeplet_NewFormCreate(ASzulKeplet: TSzuletesiKepletInfo);

  function GetMaxPageControlTabSheetNumber : integer;
  var i : integer;
  begin
    Result := 0;
    for i := 0 to FMainSzulKepletPageControl.PageCount - 1 do
      if OnlyNumeric(FMainSzulKepletPageControl.Pages[i].Name) > Result then
        Result := OnlyNumeric(FMainSzulKepletPageControl.Pages[i].Name);
  end;

var tsSheet: TTabSheet;
begin
  tsSheet := TTabSheet.Create(FMainSzulKepletPageControl);
  tsSheet.PageControl := FMainSzulKepletPageControl;

  tsSheet.Name := 'tsSheet' + IntToStr(GetMaxPageControlTabSheetNumber + 1);

  FSzulKepletFormsList.Add(TfrmBaseSzulKepletForm.Create(FMainSzulKepletPageControl));

  TfrmBaseSzulKepletForm(FSzulKepletFormsList.Items[FSzulKepletFormsList.Count - 1]).Caption := ASzulKeplet.Name;

  tsSheet.Caption := TfrmBaseSzulKepletForm(FSzulKepletFormsList.Items[FSzulKepletFormsList.Count - 1]).Caption;

  TfrmBaseSzulKepletForm(FSzulKepletFormsList.Items[FSzulKepletFormsList.Count - 1]).Height := tsSheet.Height;
  TfrmBaseSzulKepletForm(FSzulKepletFormsList.Items[FSzulKepletFormsList.Count - 1]).Width := tsSheet.Width;

  TfrmBaseSzulKepletForm(FSzulKepletFormsList.Items[FSzulKepletFormsList.Count - 1]).objDataSetInfoProvider := FobjDataSetInfoProvider;
  TfrmBaseSzulKepletForm(FSzulKepletFormsList.Items[FSzulKepletFormsList.Count - 1]).objSWECalculator := FobjSWECalculator;
  TfrmBaseSzulKepletForm(FSzulKepletFormsList.Items[FSzulKepletFormsList.Count - 1]).objAstro4AllMain := Self;

  TfrmBaseSzulKepletForm(FSzulKepletFormsList.Items[FSzulKepletFormsList.Count - 1]).TabSheetName := tsSheet.Name;

  TfrmBaseSzulKepletForm(FSzulKepletFormsList.Items[FSzulKepletFormsList.Count - 1]).Parent := tsSheet;
  TfrmBaseSzulKepletForm(FSzulKepletFormsList.Items[FSzulKepletFormsList.Count - 1]).Align := alClient;
  TfrmBaseSzulKepletForm(FSzulKepletFormsList.Items[FSzulKepletFormsList.Count - 1]).ManualDock(tsSheet);

  TfrmBaseSzulKepletForm(FSzulKepletFormsList.Items[FSzulKepletFormsList.Count - 1]).AddSzuletesiKeplet(ASzulKeplet);

  TfrmBaseSzulKepletForm(FSzulKepletFormsList.Items[FSzulKepletFormsList.Count - 1]).Show;

  TfrmBaseSzulKepletForm(FSzulKepletFormsList.Items[FSzulKepletFormsList.Count - 1]).RedrawSzulKeplet;

//  tsSheet.TabVisible := false;

  FMainSzulKepletPageControl.ActivePageIndex := tsSheet.TabIndex;

//  UpdateActiveSheetHint;

  {
  //tsSheet.ShowHint := true;
  tsSheet.ShowHint := false;
  {
  tsSheet.Hint := ASzulKeplet.Name + #13 +
                  DateTimeToStr(ASzulKeplet.DateOfBirth) + #13 +
                  ASzulKeplet.LocCity + ', ' + ASzulKeplet.LocCountry;
  {}

//  FMainSzulKepletPageControl.OnChange(Self);

  UpdateActiveSheetHint;
end;

procedure TAstro4AllMain.SzulKeplet_UjFelvitel;
begin
  Application.CreateForm(TfrmSzuletesiKepletAdatok, frmSzuletesiKepletAdatok);
  frmSzuletesiKepletAdatok.objDataSetInfoProvider := FobjDataSetInfoProvider;
  frmSzuletesiKepletAdatok.Result_SzulKeplet := TSzuletesiKepletInfo.Create;
  frmSzuletesiKepletAdatok.FobjAstro4AllMain := Self;

  if frmSzuletesiKepletAdatok.ShowModal = mrOK then
    begin
      SzulKeplet_NewFormCreate(frmSzuletesiKepletAdatok.Result_SzulKeplet);
      UpdateActiveSheetHint;
    end;

  FreeAndNil(frmSzuletesiKepletAdatok);
end;

procedure TAstro4AllMain.Tablazatok_Bolygok;
var ASzulKepletFormInfo: TSzulKepletFormInfo;
begin
  ASzulKepletFormInfo := GetAktSzulKepletFormKepletInfo;
  if Assigned(ASzulKepletFormInfo) then
    begin
      Application.CreateForm(TfrmPlanetPositions, frmPlanetPositions);
      frmPlanetPositions.FHouseNumArabic := FSettingsProvider.GetShowHouseNumbersByArabicNumbers;
      frmPlanetPositions.CalcResult := ASzulKepletFormInfo.FCalcResult;
      frmPlanetPositions.objAstro4AllMain := Self;

      frmPlanetPositions.ShowModal;

      FreeAndNil(frmPlanetPositions);
    end
  else
    begin
      MessageDlg(Error_NincsSzulKeplet, mtError, [mbOK], 0);
    end;
end;

procedure TAstro4AllMain.Tablazatok_FenyszogAdatok;
var ASzulKepletFormInfo: TSzulKepletFormInfo;
begin
  ASzulKepletFormInfo := GetAktSzulKepletFormKepletInfo;
  if Assigned(ASzulKepletFormInfo) then
    begin
      Application.CreateForm(TfrmAspectInformations, frmAspectInformations);
      frmAspectInformations.CalcResult := ASzulKepletFormInfo.FCalcResult;

      frmAspectInformations.ShowModal;

      FreeAndNil(frmAspectInformations);
    end
  else
    begin
      MessageDlg(Error_NincsSzulKeplet, mtError, [mbOK], 0);
    end;
end;

procedure TAstro4AllMain.Tablazatok_HazsarokPoz;
var ASzulKepletFormInfo: TSzulKepletFormInfo;
begin
  ASzulKepletFormInfo := GetAktSzulKepletFormKepletInfo;
  if Assigned(ASzulKepletFormInfo) then
    begin
      Application.CreateForm(TfrmHouseCuspsPositions, frmHouseCuspsPositions);
      frmHouseCuspsPositions.FHouseNumArabic := FSettingsProvider.GetShowHouseNumbersByArabicNumbers;
      frmHouseCuspsPositions.CalcResult := ASzulKepletFormInfo.FCalcResult;

      frmHouseCuspsPositions.ShowModal;

      FreeAndNil(frmHouseCuspsPositions);
    end
  else
    begin
      MessageDlg(Error_NincsSzulKeplet, mtError, [mbOK], 0);
    end;
end;

procedure TAstro4AllMain.CheckFonts;
var objFontCheck : TResourceFont;
begin
  objFontCheck := TResourceFont.Create;
  try
    objFontCheck.Execute('REGMON');
    objFontCheck.Execute('MOD20');
    //objFontCheck.Execute('MOON');
    //objFontCheck.Execute('PLACIDUS');
  finally
    FreeAndNil(objFontCheck);
  end;
end;

function TAstro4AllMain.DestroyPageByName(ATabSheetName: string;AChanged: boolean): Boolean;
var i : integer;
    bOK : boolean;
begin
  Result := false; bOK := true;

  if Assigned(FMainSzulKepletPageControl) and (FMainSzulKepletPageControl.PageCount > 0) then
    begin
      if Trim(ATabSheetName) <> '' then
        begin
          i := 0;
          while (i <= FSzulKepletFormsList.Count - 1) and (not Result) do
            begin
              if TfrmBaseSzulKepletForm(FSzulKepletFormsList.Items[i]).TabSheetName = ATabSheetName then
                begin
                  Result := AChanged; //TfrmBaseSzulKepletForm(FSzulKepletFormsList.Items[i]).GetAktKepletInfo.FSzuletesiKepletInfo.KepletInfoChanged;

                  if Result then // Changed!!!
                    begin
                      if MessageDlg('Jelenlegi formában mentsük a horoszkópot? ' + #13#10 + '"' + TfrmBaseSzulKepletForm(FSzulKepletFormsList.Items[i]).GetAktKepletInfo.FSzuletesiKepletInfo.Name + '"', mtConfirmation, [mbYes, mbNo],0) = mrYes then
                        bOK := SzulKeplet_Mentes()
                      else
                        bOK := true;
                    end;

                  if bOK then
                    begin
                      FObjLastOpenedFiles.AddOpenedFileName(TfrmBaseSzulKepletForm(FSzulKepletFormsList.Items[i]).GetAktKepletInfo.FSzuletesiKepletInfo.FileName);

                      FSzulKepletFormsList.Delete(i);
                      //FreeAndNil(TfrmBaseSzulKepletForm(FSzulKepletFormsList.Items[i]));
                      Result := true;
                    end
                  else
                    Result := false;
                end;
              inc(i);
            end;
        end;
    end;
end;

function TAstro4AllMain.Error_NincsSzulKeplet: string;
begin
  Result := 'Nincs kiválasztható Születési képlet!';
end;

procedure TAstro4AllMain.RedrawAllOpenedSzulKeplet(ARecalcValues: Boolean = False);
var i, j, actIDX : integer;
    sSheetName : string;
begin
  if Assigned(FMainSzulKepletPageControl) and (FMainSzulKepletPageControl.PageCount > 0) then
    begin
      actIDX := FMainSzulKepletPageControl.ActivePageIndex;

      LockWindowUpdate(Application.MainForm.Handle);

      for j := 0 to FMainSzulKepletPageControl.PageCount - 1 do
        begin
          FMainSzulKepletPageControl.ActivePageIndex := j;

          sSheetName := FMainSzulKepletPageControl.ActivePage.Name;
          if Trim(sSheetName) <> '' then
            begin
              i := 0;
              while (i <= FSzulKepletFormsList.Count - 1) do
                begin
                  if TfrmBaseSzulKepletForm(FSzulKepletFormsList.Items[i]).TabSheetName = sSheetName then
                    begin
                      if ARecalcValues then
                        begin
                          TfrmBaseSzulKepletForm(FSzulKepletFormsList.Items[i]).ClearDrawingItems;
                          TfrmBaseSzulKepletForm(FSzulKepletFormsList.Items[i]).SetAktKepletInfo(TfrmBaseSzulKepletForm(FSzulKepletFormsList.Items[i]).GetAktKepletInfo.FSzuletesiKepletInfo);
                        end;

                      TfrmBaseSzulKepletForm(FSzulKepletFormsList.Items[i]).RedrawSzulKeplet;
                      Break;
                    end;
                  inc(i);
                end;
            end;
        end;

      FMainSzulKepletPageControl.ActivePageIndex := actIDX;

      LockWindowUpdate(0);
    end;
end;

procedure TAstro4AllMain.Specialis_KepletLeptetoShow;
begin
  if not Assigned(frmKepletLepteto) then
    Application.CreateForm(TfrmKepletLepteto, frmKepletLepteto);

  frmKepletLepteto.objAstro4AllMain := Self;

  frmKepletLepteto.Show;
end;

procedure TAstro4AllMain.SzulKeplet_PrintPreview;
var ASzulKepletFormInfo: TSzulKepletFormInfo;
begin
  ASzulKepletFormInfo := GetAktSzulKepletFormKepletInfo;
  if Assigned(ASzulKepletFormInfo) then
    begin
      Application.CreateForm(TfrmPrintChartPreview, frmPrintChartPreview);
      frmPrintChartPreview.CalcResult := ASzulKepletFormInfo;
      frmPrintChartPreview.SettingsProvider := FSettingsProvider;

      frmPrintChartPreview.ShowModal;

      FreeAndNil(frmPrintChartPreview);
    end
  else
    begin
      MessageDlg(Error_NincsSzulKeplet, mtError, [mbOK], 0);
    end;
end;

procedure TAstro4AllMain.Tablazatok_EgyebAdatok;
var ASzulKepletFormInfo: TSzulKepletFormInfo;
begin
  ASzulKepletFormInfo := GetAktSzulKepletFormKepletInfo;
  if Assigned(ASzulKepletFormInfo) then
    begin
      Application.CreateForm(TfrmTablazat_EgyebInformaciok, frmTablazat_EgyebInformaciok);
      frmTablazat_EgyebInformaciok.FHouseNumArabic := FSettingsProvider.GetShowHouseNumbersByArabicNumbers;
      frmTablazat_EgyebInformaciok.CalcResult := ASzulKepletFormInfo;

      frmTablazat_EgyebInformaciok.ShowModal;

      FreeAndNil(frmTablazat_EgyebInformaciok);
    end
  else
    begin
      MessageDlg(Error_NincsSzulKeplet, mtError, [mbOK], 0);
    end;
end;

procedure TAstro4AllMain.Tablazatok_EletStrategiaJaratlanUt;
var ASzulKepletFormInfo: TSzulKepletFormInfo;
begin
  ASzulKepletFormInfo := GetAktSzulKepletFormKepletInfo;
  if Assigned(ASzulKepletFormInfo) then
    begin
      Application.CreateForm(TfrmEletstratJaratlanUt, frmEletstratJaratlanUt);
      frmEletstratJaratlanUt.CalcResult := ASzulKepletFormInfo.FCalcResult;

      frmEletstratJaratlanUt.ShowModal;

      FreeAndNil(frmEletstratJaratlanUt);
    end
  else
    begin
      MessageDlg(Error_NincsSzulKeplet, mtError, [mbOK], 0);
    end;
end;

procedure TAstro4AllMain.Tablazatok_Enjelolok;
var ASzulKepletFormInfo: TSzulKepletFormInfo;
begin
  ASzulKepletFormInfo := GetAktSzulKepletFormKepletInfo;

  if Assigned(ASzulKepletFormInfo) then
    begin
      Application.CreateForm(TfrmSelfMarkers, frmSelfMarkers);
      frmSelfMarkers.FHouseNumArabic := FSettingsProvider.GetShowHouseNumbersByArabicNumbers;
      frmSelfMarkers.CalcResult := ASzulKepletFormInfo.FCalcResult;

      frmSelfMarkers.ShowModal;

      FreeAndNil(frmSelfMarkers);
    end
  else
    begin
      MessageDlg(Error_NincsSzulKeplet, mtError, [mbOK], 0);
    end;
end;

procedure TAstro4AllMain.UpdateActiveSheetHint;
var objAktSzulKeplet : TSzuletesiKepletInfo;
begin
  //tsSheet.ShowHint := true;

  FMainSzulKepletPageControl.ActivePage.ShowHint := false;

  objAktSzulKeplet := GetAktSzulKepletInfo;

  FMainSzulKepletPageControl.ActivePage.Hint :=
    objAktSzulKeplet.Name + #13 +
    DateTimeToStr(objAktSzulKeplet.DateOfBirth) + #13 +
    objAktSzulKeplet.LocCity + ', ' + objAktSzulKeplet.LocCountry;

  FMainSzulKepletPageControl.ActivePage.Caption := objAktSzulKeplet.Name + '     ';

  {
  if objAktSzulKeplet.Changed then
    FMainSzulKepletPageControl.ActivePage.Caption :=
      FMainSzulKepletPageControl.ActivePage.Caption + ' *';
  {}
//  FMainSzulKepletPageControl.OnChange(Self);
(**)
end;

procedure TAstro4AllMain.Beallitasok_Szinek;
begin
  Application.CreateForm(TfrmBeallitasok_Szinek, frmBeallitasok_Szinek);
  frmBeallitasok_Szinek.objAstro4AllMain := Self;
  if frmBeallitasok_Szinek.ShowModal = mrOK then
    RedrawAllOpenedSzulKeplet;
  FreeAndNil(frmBeallitasok_Szinek);
end;

procedure TAstro4AllMain.Beallitasok_Hazrendszer(ANewHouseSystem: string);
var sHouseSysName : string;
begin
  sHouseSysName := ANewHouseSystem[Length(ANewHouseSystem) - 1];

  FobjSettingsINIFileLoader.SetStringValue(cGRP_chkbHazrendszer, cGRPITM_chkbHazrendszer, sHouseSysName);
  RedrawAllOpenedSzulKeplet(true);
end;

procedure TAstro4AllMain.Beallitasok_Zodiakus(AZodiacSystem: string);
var sZodiacSystem : string;
begin
  sZodiacSystem := AZodiacSystem[Length(AZodiacSystem) - 1];

  FobjSettingsINIFileLoader.SetStringValue(cGRP_chkbZodiakus, cGRPITM_chkbZodiakus, sZodiacSystem);
  RedrawAllOpenedSzulKeplet(true);
end;

procedure TAstro4AllMain.File_LastOpened(AFileNamePath: string);
begin
  SzulKeplet_NewFormCreate(objSzulKepletAdatokINIFileLoader.GetSzuletesiKepletFileInfo(AFileNamePath));
  FObjLastOpenedFiles.AddOpenedFileName(AFileNamePath);
  UpdateActiveSheetHint;
end;

procedure TAstro4AllMain.Beallitasok_EgyebBeallitasok;
begin
  Application.CreateForm(TfrmBeallitasok_Egyebek, frmBeallitasok_Egyebek);
  frmBeallitasok_Egyebek.objAstro4AllMain := Self;
  if frmBeallitasok_Egyebek.ShowModal = mrOK then
    FObjLastOpenedFiles.LastOpenedCount := FSettingsProvider.GetLastOpenedCount;
  FreeAndNil(frmBeallitasok_Egyebek);
end;

procedure TAstro4AllMain.File_Exportalas;
var ASzulKeplet : TSzulKepletFormInfo;
    objPrinter : TDrawPrinterController;
    pnlTempPanel : TPanel;
    imgIMage : TImage;
    bmpFile : TBitmap;
    jpgFile : TJPEGImage;
    bOK : boolean;
    sFileName, sExt, sExportDir: string;
    odSaveDialog : TSaveDialog;
begin
  ASzulKeplet := GetAktSzulKepletFormKepletInfo;

  if Assigned(ASzulKeplet) then
    begin
      bOK := true;
      sFileName := '';

      odSaveDialog := TSaveDialog.Create(Application);
      try
        odSaveDialog.Title := 'Születési képlet exportálása';
        odSaveDialog.Filter := 'JPEG file (*.jpg)|*.jpg|Windows bitmap file (*.bmp)|*.bmp';
        odSaveDialog.DefaultExt := 'jpg';
        sExportDir := FSettingsProvider.GetExportHelye;
        if Trim(sExportDir) = '' then
          sExportDir := ExtractFilePath(Application.ExeName);
        odSaveDialog.InitialDir := sExportDir;
        odSaveDialog.FileName := ASzulKeplet.FSzuletesiKepletInfo.Name;
        if odSaveDialog.Execute then
          sFileName := odSaveDialog.FileName;
      finally
        FreeAndNil(odSaveDialog);
      end;

      if Trim(sFileName) <> '' then
        begin
          sExt := UpperCase(ExtractFileExt(sFileName));

          FSettingsProvider.SetExportHelye(ExtractFileDir(sFileName));
          
          LockWindowUpdate(Application.MainForm.Handle);

          pnlTempPanel := TPanel.Create(Application.MainForm);
          pnlTempPanel.Width := 2977 div 2;
          pnlTempPanel.Height := 4210 div 2;
          pnlTempPanel.Parent := Application.MainForm;

          imgIMage := TImage.Create(pnlTempPanel);
          imgIMage.Width := pnlTempPanel.Width;
          imgIMage.Height := pnlTempPanel.Height;

          bmpFile := TBitmap.Create;
          bmpFile.Width := imgIMage.Width;
          bmpFile.Height := imgIMage.Height;

          objPrinter := TDrawPrinterController.Create(imgIMage.Canvas, pnlTempPanel, imgIMage, ASzulKeplet, ptSzulKeplet, FSettingsProvider, true, imgIMage.Width, imgIMage.Height);
          objPrinter.SzemelyisegRajz := false; // TODO
          try
            try
              objPrinter.FKellLockWindow := false;
              objPrinter.DrawCalculatedResult(ASzulKeplet.FCalcResult);

              bmpFile.Canvas.Draw(0, 0, imgIMage.Picture.Graphic);

              if sExt = '.JPG' then
                begin
                  jpgFile := TJPEGImage.Create;
                  jpgFile.Assign(bmpFile);
                  jpgFile.SaveToFile(sFileName);
                  jpgFile.Free;
                end
              else
                bmpFile.SaveToFile(sFileName);

            except
              bOK := false;
              raise;
            end;
          finally
            pnlTempPanel.Free;
            //objPrinter.Free;
            //imgIMage.Free;
            //bmpFile.Free;

            LockWindowUpdate(0);
          end;

          if bOK then
            MessageDlg('Exportálás kész a következõ helyre és néven: ' + #13#10#13#10 + sFileName, mtInformation, [mbOK], 0);
        end;
    end
  else
    begin
      MessageDlg(Error_NincsSzulKeplet, mtError, [mbOK], 0);
    end;
end;

procedure TAstro4AllMain.Specialis_DrakonikusAbra;
var objDrakonikus : TDrakonikusCalculator;
    infSzulKepletInfo, infAktKeplet : TSzuletesiKepletInfo;
    objCalcResult : TCalcResult;
begin
  objDrakonikus := TDrakonikusCalculator.Create(FobjDataSetInfoProvider, FSettingsProvider);
  objCalcResult := TCalcResult.Create;
  try
    infSzulKepletInfo := TSzuletesiKepletInfo.Create;

    infAktKeplet := GetAktSzulKepletInfo;

    infSzulKepletInfo.SetDateOfBirth(infAktKeplet.DateOfBirth);
    infSzulKepletInfo.Gender := infAktKeplet.Gender;
    infSzulKepletInfo.IsDayLightSavingTime := infAktKeplet.IsDayLightSavingTime;
    infSzulKepletInfo.LocAltitude := infAktKeplet.LocAltitude;
    infSzulKepletInfo.LocCity := infAktKeplet.LocCity;
    infSzulKepletInfo.LocCountry := infAktKeplet.LocCountry;
    infSzulKepletInfo.LocCountryID := infAktKeplet.LocCountryID;
    infSzulKepletInfo.LocLatDegree := infAktKeplet.LocLatDegree;
    infSzulKepletInfo.LocLatMinute := infAktKeplet.LocLatMinute;
    infSzulKepletInfo.LocLatSecond := infAktKeplet.LocLatSecond;
    infSzulKepletInfo.LocLongDegree := infAktKeplet.LocLongDegree;
    infSzulKepletInfo.LocLongMinute := infAktKeplet.LocLongMinute;
    infSzulKepletInfo.LocLongSecond := infAktKeplet.LocLongSecond;
    infSzulKepletInfo.Name := infAktKeplet.Name + ' - Drakonikus';
    infSzulKepletInfo.Note.AddStrings(infAktKeplet.Note);
    infSzulKepletInfo.TZoneCode := infAktKeplet.TZoneCode;
    infSzulKepletInfo.TZoneHour := infAktKeplet.TZoneHour;
    infSzulKepletInfo.TZoneMinute := infAktKeplet.TZoneMinute;
    infSzulKepletInfo.TZoneWest := infAktKeplet.TZoneWest;

    objDrakonikus.FCalcResult := objCalcResult;
    objDrakonikus.DoCalculateDraconicTimeAndDate(infSzulKepletInfo);
    objCalcResult := objDrakonikus.FCalcResult;

    SzulKeplet_NewFormCreate(infSzulKepletInfo);
  finally
    //infSzulKepletInfo.Free;
    objDrakonikus.Free;
  end;
end;

end.
