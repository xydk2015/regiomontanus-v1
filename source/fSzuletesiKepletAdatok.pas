unit fSzuletesiKepletAdatok;

interface                       

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, fBaseDialogForm, StdCtrls, Buttons, ExtCtrls, ComCtrls, uAstro4AllTypes, uAstro4AllCalculator,
  DB, Grids, DBGrids, uAstro4AllMain;

type
  TfrmSzuletesiKepletAdatok = class(TfrmBaseDialogForm)
    grpSzemAdatok: TGroupBox;
    Label1: TLabel;
    edtNev: TEdit;
    rgpEset: TRadioGroup;
    rgpSzulIdo: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    rgpSzulHely: TGroupBox;
    lblTelepulesCimke: TLabel;
    edtTelepules: TEdit;
    rgpFoldRajzHelyzet: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    edtHosszFok: TEdit;
    edtSzelFok: TEdit;
    edtHosszPerc: TEdit;
    edtSzelPerc: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    rgpIdozona: TGroupBox;
    Label11: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    chkNyariIdoszamitas: TCheckBox;
    lblIdozonaTipusa: TLabel;
    btnMost: TBitBtn;
    rgpMegjegyz: TGroupBox;
    memNotes: TMemo;
    pnlHosszusag: TPanel;
    rgbKeleti: TRadioButton;
    rgbNyugati: TRadioButton;
    pnlSzelesseg: TPanel;
    rgbEszaki: TRadioButton;
    rgbDeli: TRadioButton;
    dsCity: TDataSource;
    dbgCityes: TDBGrid;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    edtSzhEv: TEdit;
    edtSzhHo: TEdit;
    edtSzhNap: TEdit;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    edtSzhOra: TEdit;
    edtSzhPerc: TEdit;
    edtSzhMp: TEdit;
    Label13: TLabel;
    lblOrszag: TLabel;
    edtZonaOra: TEdit;
    edtZonaPerc: TEdit;
    cmbTimeZoneSettings: TComboBox;
    btnTimeZoneSelector: TBitBtn;
    procedure btnTimeZoneSelectorClick(Sender: TObject);
    procedure chkNyariIdoszamitasClick(Sender: TObject);
    procedure cmbTimeZoneSettingsChange(Sender: TObject);
    procedure dbgCityesCellClick(Column: TColumn);
    procedure dbgCityesDblClick(Sender: TObject);
    procedure dbgCityesExit(Sender: TObject);
    procedure dbgCityesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtSzhEvExit(Sender: TObject);
    procedure edtTelepulesChange(Sender: TObject);
    procedure edtTelepulesEnter(Sender: TObject);
    procedure edtTelepulesExit(Sender: TObject);
    procedure edtTelepulesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    FFobjAstro4AllMain: TAstro4AllMain;
    FLetezoSzulKepletBetoltes: Boolean;
    FobjDataSetInfoProvider: TDataSetInfoProvider;
    FResult_SzulKeplet: TSzuletesiKepletInfo;
    FOldCityName : string;

    procedure EditBeallitasok;
    procedure SelectAktRekord;
    procedure InitMost;
    procedure UpdateFoldrajziKoordCheckBoxes;
    procedure SetNyariIdoszamitas_e;
    procedure InitTimeZoneInfo(ABaseTZCode: string);
    function CheckDateTime : boolean;
  public
    procedure LetezoSzulKepletMegjelenit(ASzulKeplet: TSzuletesiKepletInfo);
    property FobjAstro4AllMain: TAstro4AllMain read FFobjAstro4AllMain write FFobjAstro4AllMain;
    property objDataSetInfoProvider: TDataSetInfoProvider read FobjDataSetInfoProvider write FobjDataSetInfoProvider;
    property Result_SzulKeplet: TSzuletesiKepletInfo read FResult_SzulKeplet write FResult_SzulKeplet;
  end;

var
  frmSzuletesiKepletAdatok: TfrmSzuletesiKepletAdatok;

implementation

uses DateUtils, dxMDaSet, uAstro4AllConsts, uAstro4AllFileHandling, uSegedUtils;

{$R *.dfm}

procedure TfrmSzuletesiKepletAdatok.btnTimeZoneSelectorClick(Sender: TObject);
var sResult : string;
begin
  inherited;
  // Idõzóna választó...
  sResult := FFobjAstro4AllMain.GetTimeZoneIDFromSelector(Trim(copy(lblIdozonaTipusa.Caption, 1, pos('-', lblIdozonaTipusa.Caption) - 1)));
  if Trim(sResult) <> '' then
    InitTimeZoneInfo(sResult);
end;

procedure TfrmSzuletesiKepletAdatok.chkNyariIdoszamitasClick(Sender: TObject);
begin
  inherited;
  EditBeallitasok;
end;

procedure TfrmSzuletesiKepletAdatok.cmbTimeZoneSettingsChange(Sender: TObject);
begin
  inherited;
  edtZonaOra.Enabled := cmbTimeZoneSettings.ItemIndex = 0;
  edtZonaPerc.Enabled := edtZonaOra.Enabled;
  EditBeallitasok;
end;

procedure TfrmSzuletesiKepletAdatok.dbgCityesCellClick(Column: TColumn);
begin
  inherited;
  dbgCityes.Visible := true;
  dbgCityes.SetFocus;
end;

procedure TfrmSzuletesiKepletAdatok.dbgCityesDblClick(Sender: TObject);
begin
  inherited;
  SelectAktRekord;
end;

procedure TfrmSzuletesiKepletAdatok.dbgCityesExit(Sender: TObject);
begin
  inherited;
  dbgCityes.Visible := false;
end;

procedure TfrmSzuletesiKepletAdatok.dbgCityesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = VK_RETURN then SelectAktRekord;
end;

procedure TfrmSzuletesiKepletAdatok.edtTelepulesChange(Sender: TObject);
var iRecID : integer;
begin
  inherited;
  // Le is kéne nyitni, ha épp benne állunk
  if edtTelepules.Focused and not dbgCityes.Visible then
    dbgCityes.Visible := true;

  // Keresés a települések listájában 
  if Assigned(dsCity.DataSet) then
    begin
      iRecID := objDataSetInfoProvider.DataSetLoader.CityLoader.GetCityRecID(edtTelepules.Text);
      if iRecID <> -1 then
        TdxMemData(dsCity.DataSet).Locate('RecID', iRecID, []);
    end;
end;

procedure TfrmSzuletesiKepletAdatok.edtTelepulesEnter(Sender: TObject);
begin
  inherited;
  dbgCityes.Visible := true;
  FOldCityName := edtTelepules.Text;
  CheckDateTime;
end;

procedure TfrmSzuletesiKepletAdatok.edtTelepulesExit(Sender: TObject);
begin
  inherited;
  dbgCityes.Visible := false;
  EditBeallitasok;
  SetNyariIdoszamitas_e;
  FOldCityName := '';
end;

procedure TfrmSzuletesiKepletAdatok.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var objTimeZoneInfo : TTimeZoneInfo;
    {sCityTZ, {}sBeallTZ : string;
begin
  inherited;
  if ModalResult = mrOK then
    if CheckDateTime then
      begin
        if Assigned(FResult_SzulKeplet) then
          begin
            //FResult_SzulKeplet.Changed := true;
            FResult_SzulKeplet.Name := edtNev.Text;
            FResult_SzulKeplet.SetDateOfBirth
              (
                StrToIntDef(edtSzhEv.Text, 1900),
                StrToIntDef(edtSzhHo.Text, 01),
                StrToIntDef(edtSzhNap.Text, 01),
                StrToIntDef(edtSzhOra.Text, 00),
                StrToIntDef(edtSzhPerc.Text, 00),
                StrToIntDef(edtSzhMp.Text, 00)
              );
            FResult_SzulKeplet.Gender := rgpEset.ItemIndex;
            FResult_SzulKeplet.LocCity := edtTelepules.Text;
            FResult_SzulKeplet.LocCountryID := objDataSetInfoProvider.GetCountryIDFromCityName(edtTelepules.Text);
            FResult_SzulKeplet.LocCountry := objDataSetInfoProvider.GetCountryFromCountryID(FResult_SzulKeplet.LocCountryID);
            FResult_SzulKeplet.LocAltitude := 0;

            FResult_SzulKeplet.LocLatDegree := StrToIntDef(edtSzelFok.Text, 0);
            FResult_SzulKeplet.LocLatMinute := StrToIntDef(edtSzelPerc.Text, 0);
            if rgbDeli.Checked and (FResult_SzulKeplet.LocLatDegree > 0) then
              FResult_SzulKeplet.LocLatDegree := - FResult_SzulKeplet.LocLatDegree;

            FResult_SzulKeplet.LocLongDegree := StrToIntDef(edtHosszFok.Text, 0);
            FResult_SzulKeplet.LocLongMinute := StrToIntDef(edtHosszPerc.Text, 0);
            if rgbNyugati.Checked and (FResult_SzulKeplet.LocLongDegree > 0) then
              FResult_SzulKeplet.LocLongDegree := - FResult_SzulKeplet.LocLongDegree;

            FResult_SzulKeplet.IsDayLightSavingTime := chkNyariIdoszamitas.Checked;

            //objTimeZoneInfo := objDataSetInfoProvider.GetTimeZoneInfo(FobjDataSetInfoProvider.GetTimeZoneIDFromCountry(FobjDataSetInfoProvider.GetCountryIDFromCityName(edtTelepules.Text)));

            // Település alapján kérjük le az idõzónát...
            //sCityTZ := FobjDataSetInfoProvider.GetTimeZoneIDFromCityName(edtTelepules.Text);
            sBeallTZ := Trim(copy(lblIdozonaTipusa.Caption, 1, pos('-', lblIdozonaTipusa.Caption) - 1));

            //if (FResult_SzulKeplet.IsDayLightSavingTime) and (pos('/S', sBeallTZ) = 0) then
            //  sBeallTZ := sBeallTZ + '/S';

            objTimeZoneInfo := objDataSetInfoProvider.GetTimeZoneInfo(sBeallTZ);

            if Assigned(objTimeZoneInfo) and (cmbTimeZoneSettings.ItemIndex = 1) then
              begin
                FResult_SzulKeplet.TZoneCode := objTimeZoneInfo.TimeZoneCode;
                FResult_SzulKeplet.TZoneHour := Round(objTimeZoneInfo.DeltaHour);
                FResult_SzulKeplet.TZoneMinute := Round(objTimeZoneInfo.DeltaMinute);
                FResult_SzulKeplet.TZoneWest := objTimeZoneInfo.DeltaHour < 0;
              end
            else
              begin
                case cmbTimeZoneSettings.ItemIndex of
                0 : FResult_SzulKeplet.TZoneCode := '';
                2 : FResult_SzulKeplet.TZoneCode := 'LMT';
                end;
                FResult_SzulKeplet.TZoneHour := StrToIntDef(edtZonaOra.Text, 0);
                FResult_SzulKeplet.TZoneMinute := StrToIntDef(edtZonaPerc.Text, 0);
                FResult_SzulKeplet.TZoneWest := FResult_SzulKeplet.LocLongDegree < 0;//FResult_SzulKeplet.TZoneHour < 0;
              end;

            FResult_SzulKeplet.Note.Clear;
            FResult_SzulKeplet.Note.AddStrings(memNotes.Lines);
          end;
      end
    else
      begin
        CanClose := false;
      end;
end;

procedure TfrmSzuletesiKepletAdatok.FormCreate(Sender: TObject);
begin
  inherited;
  Caption := 'Új születési képlet felvitele...';

  FOldCityName := '';

  pnlHosszusag.Caption := '';
  pnlSzelesseg.Caption := '';

  edtNev.Text := '';
  rgpEset.ItemIndex := -1;
  edtTelepules.Text := '';

  edtHosszFok.Text := '';
  edtHosszPerc.Text := '';
  edtSzelFok.Text := '';
  edtSzelPerc.Text := '';

  edtZonaOra.Text := '';
  edtZonaPerc.Text := '';

  rgbKeleti.Checked := false; rgbNyugati.Checked := false;
  rgbEszaki.Checked := false; rgbDeli.Checked := false;

  lblIdozonaTipusa.Caption := '';
  lblOrszag.Caption := '';
  cmbTimeZoneSettings.ItemIndex := 1;

  chkNyariIdoszamitas.Checked := false;

  memNotes.Lines.Clear;

  InitMost;

  FLetezoSzulKepletBetoltes := False;
end;

procedure TfrmSzuletesiKepletAdatok.FormShow(Sender: TObject);
begin
  inherited;
  dsCity.DataSet := objDataSetInfoProvider.DataSetLoader.CityLoader.DataSetForSearch;

  if not FLetezoSzulKepletBetoltes then
    begin
      if Trim(FobjAstro4AllMain.objSettingsINIFileLoader.GetStringValue(cGRP_chkbEgyebek, cGRPITM_chkbEgyebek[2])) <> '' then
        begin
          edtTelepules.Text := FobjAstro4AllMain.objSettingsINIFileLoader.GetStringValue(cGRP_chkbEgyebek, cGRPITM_chkbEgyebek[2]);
          SelectAktRekord;
        end;
      if edtNev.CanFocus then
        edtNev.SetFocus;
    end;

  edtTelepules.OnChange(Self);

  dbgCityes.Visible := false;
  //dbgCityes.Left := 74;
  dbgCityes.Left := 0;
  dbgCityes.Top := 46;
  dbgCityes.Height := 75;  
  dbgCityes.Width := rgpSzulHely.Width - 2;

  rgpEset.ItemIndex := FResult_SzulKeplet.Gender;
end;

procedure TfrmSzuletesiKepletAdatok.EditBeallitasok;
var sTZCode : string;
begin
  UpdateFoldrajziKoordCheckBoxes;

  // Idõzóna...
  // ha létezõ képletet nyitok meg akkor is a TZCode a városból jön....
  // TODO: ha megváltoztattuk a TimeZone-t, akkor nem a település alapján kell kikeresni!!! - OK
  //objTimeZoneInfo := objDataSetInfoProvider.GetTimeZoneInfo(FobjDataSetInfoProvider.GetTimeZoneIDFromCountry(FobjDataSetInfoProvider.GetCountryIDFromCityName(edtTelepules.Text)));
  if (not FLetezoSzulKepletBetoltes and (FOldCityName <> edtTelepules.Text)) or
     (FLetezoSzulKepletBetoltes and (FOldCityName <> edtTelepules.Text)) then
    begin
      if FLetezoSzulKepletBetoltes and (Trim(FResult_SzulKeplet.TZoneCode) <> '') then
        sTZCode := FResult_SzulKeplet.TZoneCode
      else
        sTZCode := FobjDataSetInfoProvider.GetTimeZoneIDFromCityName(edtTelepules.Text);
      if chkNyariIdoszamitas.Checked then
        sTZCode := sTZCode + '/S';

      InitTimeZoneInfo(sTZCode);
    end;
  if Trim(edtTelepules.Text) <> '' then
    lblOrszag.Caption := FobjDataSetInfoProvider.GetCountryFromCountryID(FobjDataSetInfoProvider.GetCountryIDFromCityName(edtTelepules.Text));
end;

procedure TfrmSzuletesiKepletAdatok.edtSzhEvExit(Sender: TObject);
begin
  inherited;
  SetNyariIdoszamitas_e;
end;

procedure TfrmSzuletesiKepletAdatok.edtTelepulesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
  VK_UP : begin
            Key := 0;
            dbgCityes.DataSource.DataSet.Prior;
          end;
  VK_DOWN : begin
            Key := 0;
            dbgCityes.DataSource.DataSet.Next;
          end;
  end;

  inherited;

  case Key of
  VK_ESCAPE : begin
                dbgCityes.Visible := not dbgCityes.Visible;
                edtTelepules.Text := FOldCityName;
                Key := 0;
              end;
  VK_RETURN : begin
                dbgCityes.OnDblClick(Self);
                SetNyariIdoszamitas_e;
                Key := 0;
              end;
  end;
end;

procedure TfrmSzuletesiKepletAdatok.LetezoSzulKepletMegjelenit(ASzulKeplet: TSzuletesiKepletInfo);
begin
  Caption := 'Születési képlet szerkesztése...';

  FResult_SzulKeplet := ASzulKeplet;
  FLetezoSzulKepletBetoltes := true;

  edtNev.Text := ASzulKeplet.Name;

  rgpEset.ItemIndex := ASzulKeplet.Gender;

  //edtSzulDatum.Date := DateOf(ASzulKeplet.DateOfBirth);
  edtSzhEv.Text := IntToStr(YearOf(ASzulKeplet.DateOfBirth));
  edtSzhHo.Text := IntToStr(MonthOf(ASzulKeplet.DateOfBirth));
  edtSzhNap.Text := IntToStr(DayOf(ASzulKeplet.DateOfBirth));

  edtSzhOra.Text := IntToStr(HourOf(ASzulKeplet.DateOfBirth));
  edtSzhPerc.Text := IntToStr(MinuteOf(ASzulKeplet.DateOfBirth));
  edtSzhMp.Text := IntToStr(SecondOf(ASzulKeplet.DateOfBirth));
  //edtSzulIdopont.Time := TimeOf(ASzulKeplet.DateOfBirth);

  edtTelepules.Text := ASzulKeplet.LocCity;
  if pos(';', edtTelepules.Text) = 0 then
    edtTelepules.Text := ASzulKeplet.LocCity + '; ' + ASzulKeplet.LocCountryID;

  edtHosszFok.Text := IntToStr(ASzulKeplet.LocLongDegree);
  edtHosszPerc.Text := IntToStr(ASzulKeplet.LocLongMinute);

  edtSzelFok.Text := IntToStr(ASzulKeplet.LocLatDegree);
  edtSzelPerc.Text := IntToStr(ASzulKeplet.LocLatMinute);

  if Trim(ASzulKeplet.TZoneCode) = '' then
    cmbTimeZoneSettings.ItemIndex := 0
  else
    if Trim(ASzulKeplet.TZoneCode) = 'LMT' then
      cmbTimeZoneSettings.ItemIndex := 2
    else
      cmbTimeZoneSettings.ItemIndex := 1;

  memNotes.Lines.AddStrings(ASzulKeplet.Note);

  SetNyariIdoszamitas_e;

  EditBeallitasok;
end;

procedure TfrmSzuletesiKepletAdatok.SelectAktRekord;
begin
  edtTelepules.Text := VarToStr(objDataSetInfoProvider.DataSetLoader.CityLoader.DataSetForSearch[cDS_CITY_CityName]) +
                       '; ' +
                       VarToStr(objDataSetInfoProvider.DataSetLoader.CityLoader.DataSetForSearch[cDS_CITY_CountryCode]);

  edtHosszFok.Text := FloatToStr(GetFokFromListItem(VarToStr(objDataSetInfoProvider.DataSetLoader.CityLoader.DataSetForSearch[cDS_CITY_Longitude])));
  edtHosszPerc.Text := FloatToStr(GetFokPercFromListItem(VarToStr(objDataSetInfoProvider.DataSetLoader.CityLoader.DataSetForSearch[cDS_CITY_Longitude])));

  edtSzelFok.Text := FloatToStr(GetFokFromListItem(VarToStr(objDataSetInfoProvider.DataSetLoader.CityLoader.DataSetForSearch[cDS_CITY_Latitude])));
  edtSzelPerc.Text := FloatToStr(GetFokPercFromListItem(VarToStr(objDataSetInfoProvider.DataSetLoader.CityLoader.DataSetForSearch[cDS_CITY_Latitude])));

  edtTelepules.SetFocus;
  dbgCityes.Visible := false;

  SetNyariIdoszamitas_e;

  FOldCityName := '';

  EditBeallitasok;
end;

procedure TfrmSzuletesiKepletAdatok.InitMost;
begin
  edtSzhEv.Text := IntToStr(YearOf(Now));
  edtSzhHo.Text := IntToStr(MonthOf(Now));
  edtSzhNap.Text := IntToStr(DayOf(Now));

  edtSzhOra.Text := IntToStr(HourOf(Now));
  edtSzhPerc.Text := IntToStr(MinuteOf(Now));
  edtSzhMp.Text := IntToStr(SecondOf(Now));
end;

procedure TfrmSzuletesiKepletAdatok.SetNyariIdoszamitas_e;
var dDatum : TDateTime;
begin
  try
    dDatum := EncodeDate
              (
                StrToIntDef(edtSzhEv.Text, 1900),
                StrToIntDef(edtSzhHo.Text, 01),
                StrToIntDef(edtSzhNap.Text, 01)
              );
    dDatum := IncHour(dDatum, StrToIntDef(edtSzhOra.Text, 0));
    dDatum := IncMinute(dDatum, StrToIntDef(edtSzhPerc.Text, 0));

    if Trim(edtTelepules.Text) <> '' then
      begin
        if not FLetezoSzulKepletBetoltes then
          chkNyariIdoszamitas.Checked :=
            objDataSetInfoProvider.IsDaylightSavingTimeOnDate
              (
                dDatum,
                FobjDataSetInfoProvider.GetCountryIDFromCityName(edtTelepules.Text)
              )
        else
          chkNyariIdoszamitas.Checked := FResult_SzulKeplet.IsDayLightSavingTime;
      end;
  except
    on E : EConvertError do
      begin
        {
        dDatum := EncodeDate
                  (
                    Abs(StrToIntDef(edtSzhEv.Text, 1900)),
                    Abs(Min(StrToIntDef(edtSzhHo.Text, 01), 12)),
                    Abs(Min(EndOfTheMonth(), StrToIntDef(edtSzhNap.Text, 01)))
                  );
        {}
      end;
  end;
end;

procedure TfrmSzuletesiKepletAdatok.InitTimeZoneInfo(ABaseTZCode: string);
var objTimeZoneInfo : TTimeZoneInfo;
    sOrig : string;
begin
  sOrig := ABaseTZCode;
  objTimeZoneInfo := objDataSetInfoProvider.GetTimeZoneInfo(ABaseTZCode);

  // Nincs olyan timezone, ami "/S"-re vlgzõdik, pl.: PST => PDT a párja
  // Kivétel a GMT aminek a párja a WET/S - WET/DS
  if not Assigned(objTimeZoneInfo) then
    begin
      delete(ABaseTZCode, Length(ABaseTZCode) - 3, 4);

      if pos('GMT/', sOrig) > 0 then
        ABaseTZCode := 'WET/S'
      else
        ABaseTZCode := ABaseTZCode + 'DT';
      objTimeZoneInfo := objDataSetInfoProvider.GetTimeZoneInfo(ABaseTZCode);
    end;

  // Ha ez sincs, akkor, eredeti "/S" nélkül
  if not Assigned(objTimeZoneInfo) then
    begin
      delete(sOrig, Length(sOrig) - 1, 2);
      ABaseTZCode := sOrig ;
      objTimeZoneInfo := objDataSetInfoProvider.GetTimeZoneInfo(ABaseTZCode);
    end;

  if Assigned(objTimeZoneInfo) then
    begin
      lblIdozonaTipusa.Caption := objTimeZoneInfo.TimeZoneCode + ' - ' + objTimeZoneInfo.DisplayName;
      //lblZonaido.Caption := objTimeZoneInfo.GetDeltaAsString;
      edtZonaOra.Text := IntToStr(Round(objTimeZoneInfo.DeltaHour));
      edtZonaPerc.Text := IntToStr(Round(objTimeZoneInfo.DeltaMinute));

      if cmbTimeZoneSettings.ItemIndex in [0, 2] then
        begin
          lblIdozonaTipusa.Caption := '';

          case cmbTimeZoneSettings.ItemIndex of
          0 : begin
                lblIdozonaTipusa.Caption := 'Kézi beállítás';
              end;
          2 : begin
                lblIdozonaTipusa.Caption := 'Helyi középidõ';
                edtZonaOra.Text := '';
                edtZonaPerc.Text := '';
              end;
          end;
        end;
    end;
end;

procedure TfrmSzuletesiKepletAdatok.UpdateFoldrajziKoordCheckBoxes;
begin
  if StrToIntDef(edtHosszFok.Text, 0) >= 0 then
    rgbKeleti.Checked := true
  else
    rgbNyugati.Checked := true;

  if StrToIntDef(edtSzelFok.Text, 0) >= 0 then
    rgbEszaki.Checked := true
  else
    rgbDeli.Checked := true;
end;

function TfrmSzuletesiKepletAdatok.CheckDateTime: boolean;
var dTempDate : TDateTime;
begin
  Result := true;
  if not TryEncodeDateTime
    (
       StrToIntDef(edtSzhEv.Text, 1900),
       StrToIntDef(edtSzhHo.Text, 01),
       StrToIntDef(edtSzhNap.Text, 01),
       StrToIntDef(edtSzhOra.Text, 00),
       StrToIntDef(edtSzhPerc.Text, 00),
       StrToIntDef(edtSzhMp.Text, 00), 0, dTempDate
    ) then
    begin
      ShowMessage('Hibás dátumot adott meg, kérem ellenõrizze!');
      edtSzhEv.SetFocus;
      Result := false;
    end;
end;

procedure TfrmSzuletesiKepletAdatok.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var bMehetInherited : boolean;
begin
  bMehetInherited := true;
  case Key of
  VK_UP,
  VK_DOWN,
  VK_RETURN,
  VK_ESCAPE : if (edtTelepules.Focused and dbgCityes.Visible) or dbgCityes.Focused then
                bMehetInherited := false;
  end;

  if bMehetInherited then
    inherited;
end;

end.
