{
  DATA fájlok beolvasása
}
unit uAstro4AllFileHandling;

interface

uses Classes, Forms, SysUtils, DB, Graphics, dxMDaSet, INIFiles, uAstro4AllConsts, uAstro4AllTypes;

type
  //# Alap osztály az adatfájlok betöltésére
  TBaseDataLoader = class(TObject)
  private
    FDataSet: TdxMemData;
    procedure AddFieldDefsToDataSet; virtual; abstract;
    function LoadFromFile(AFileName: string): Boolean;
    procedure AddMemdataField(mt: TdxMemData; Name, DisplayName: string; fType:TFieldType);
    procedure AfterLoaded; virtual;
  public
    constructor Create;
    destructor Destroy; override;
    property DataSet: TdxMemData read FDataSet;
  end;

  //# Téli/Nyári idõszámítás betöltõ
  TCestLoader = class(TBaseDataLoader)
  private
    procedure AddFieldDefsToDataSet; override;
  public
    constructor Create;
  end;

  //# Település betöltõ
  TCityLoader = class(TBaseDataLoader)
  private
    FDataSetForSearch: TdxMemData;
    FslSortedCityes: TStringList;
    procedure AddCityInfoToStringList;
    procedure AddFieldDefsToDataSet; override;

    procedure OnFieldGetTextForLongLat(Sender: TField; var Text: String; DisplayText: Boolean);
  public
    constructor Create;
    destructor Destroy; override;
    function GetCityRecID(ACityName: string): Integer;
    property DataSetForSearch: TdxMemData read FDataSetForSearch;
    property slSortedCityes: TStringList read FslSortedCityes;
  end;

  //# Ország betöltõ
  TCountryLoader = class(TBaseDataLoader)
  private
    procedure AddFieldDefsToDataSet; override;
  public
    constructor Create;
  end;

  //# Idõzóna betöltõ
  TTimeZoneLoader = class(TBaseDataLoader)
  private
    procedure AddFieldDefsToDataSet; override;
    procedure AfterLoaded; override;
  public
    constructor Create;
  end;

  //# Alap INI fájl betöltõ a beállításokhoz és a szülképletekhez
  TBaseINIFileLoader = class(TObject)
  private
    FINIFile: TMemIniFile;
  public
    destructor Destroy; override;
    function LoadINIFile(AFileName: string): Boolean;
    property INIFile: TMemIniFile read FINIFile;
  end;

  //# Beállítások INI fájl betöltõ
  TSettingsINIFileLoader = class(TBaseINIFileLoader)
  private
  public
    destructor Destroy; override;
    function GetBoolValue(AGrpName, AItemName: string): Boolean;
    function GetDoubleValue(AGrpName, AItemName: string): Double;
    function GetStringValue(AGrpName, AItemName: string): String;
    function GetIntegerValue(AGrpName, AItemName: string): Integer;
    procedure SetBoolValue(AGrpName, AItemName: string; AValue: boolean);
    procedure SetDoubleValue(AGrpName, AItemName: string; AValue: Double);
    procedure SetStringValue(AGrpName, AItemName: string; AValue: string);
    procedure SetIntegerValue(AGrpName, AItemName: string; AValue: integer);
  end;

  //# Születési képlet információkat betöltõ
  TSzuletesiKepletAdatokINIFileLoader = class(TBaseINIFileLoader)
  public
    function GetSzuletesiKepletFileInfo(AFileName: string): TSzuletesiKepletInfo;
  end;

  TBulvarIniFileLoader = class(TBaseINIFileLoader)
  public
    function GetBulvarCaption(ABulvarType: TBulvarType): string;
    function GetBulvarDescription(ABulvarType: TBulvarType; AZodiacID: integer): string;
    function GetBulvarForras(ABulvarType: TBulvarType): string;
    function GetBulvarHosszuLeiras(ABulvarType: TBulvarType): string;
    function GetBulvarRovidLeiras(ABulvarType: TBulvarType): string;
  end;

  //# Betölti az összes DataSet-et
  TDataSetLoader = class(TObject)
  private
    FCestLoader: TCestLoader;
    FCityLoader: TCityLoader;
    FCountryLoader: TCountryLoader;
    FTimeZoneLoader: TTimeZoneLoader;
  public
    constructor Create;
    destructor Destroy; override;
    property CestLoader: TCestLoader read FCestLoader;
    property CityLoader: TCityLoader read FCityLoader;
    property CountryLoader: TCountryLoader read FCountryLoader;
    property TimeZoneLoader: TTimeZoneLoader read FTimeZoneLoader;
  end;

  TSettingsProvider = class(TObject)
  private
    FSettingsINIFileLoader: TSettingsINIFileLoader;
  protected
  public
    constructor Create(ASettingsINIFileLoader: TSettingsINIFileLoader);
    function GetHouseCuspSystem : string;
    function GetPrintAspectTable : boolean;
    function GetPrintEletstratTable : boolean;
    function GetPrintFejlecBirthDate : boolean;
    function GetPrintFejlecBirthDay : boolean;
    function GetPrintFejlecBirthPlace : boolean;
    function GetPrintFejlecBirthPlaceCoord : boolean;
    function GetPrintFejlecBirthTime : boolean;
    function GetPrintFejlecDaylightTime : boolean;
    function GetPrintFejlecHouseSystem : boolean;
    function GetPrintFejlecName : boolean;
    function GetPrintFejlecPrintType : boolean;
    function GetPrintFejlecST : boolean;
    function GetPrintFejlecTable : boolean;
    function GetPrintFejlecTimeZone : boolean;
    function GetPrintFejlecUT : boolean;
    function GetPrintHouseDegs : boolean;
    function GetPrintHouseTable : boolean;
    function GetPrintHouseZodiac : boolean;
    function GetPrintInColor : boolean;
    function GetPrintLablecPrgBaseInfo : boolean;
    function GetPrintLablecRegInfo : boolean;
    function GetPrintLablecTable : boolean;
    function GetPrintPlanetDegs : boolean;
    function GetPrintPlanetHouseLords : boolean;
    function GetPrintPlanetHousePos : boolean;
    function GetPrintPlanetTable : boolean;
    function GetPrintPlanetZodiac : boolean;
    function GetShowSelfMarkerAtorigPlace : boolean;
    function GetShowHouseDegValues : boolean;
    function GetShowHouseLords : boolean;
    function GetShowHouseNumbersByArabicNumbers : boolean;
    function GetShowHouseNumberSet: TByteSet;
    function GetShowInnerAspectDegLines : boolean;
    function GetShowInnerZodiacDegLines : boolean;
    function GetShownAnalogPlanets: Boolean;
    function GetShownAspectAxis : TByteSet;
    function GetShownAspectHouses : TByteSet;
    function GetShownAspectPlanets: string;
    function GetShownAspectTypes : TByteSet;
    function GetShownAspectSymbols : TByteSet;
    function GetShownHouseBorderSet: TByteSet;
    function GetShownPlanetSet(AAllPlanet: Boolean = false): String;
    function GetShownZodiacSigns: TByteSet;
    function GetShowOuterZodiacDegLines : boolean;
    function GetShowZodiacDegsOnOtherCircle : boolean;
    function GetShowPlanetDegs : boolean;
    function GetShowRetrogradeSign : boolean;
    function GetShowSelfMarkers : boolean;
    function GetZodiacType : string;
    function GetInditasTeljesMeretben : boolean;
    function GetColorOfFire : integer;
    function GetColorOfGround : integer;
    function GetColorOfAir : integer;
    function GetColorOfWater : integer;
    function GetColorOfAspectsBackground : integer;
    function GetColorOfAspect(AAspectID: integer) : integer;
    function GetLastOpenedCount: Integer;
    function GetStyleOfAspect(AAspectID: integer) : TPenStyle;
    function GetEnnalapotJelolesiMod : integer;
    function GetExportHelye: string;
    function GetBetumeretSzorzo : Double;
    procedure SetExportHelye(AHelye: string);
  end;

implementation

uses Variants, uSegedUtils, swe_de32;

procedure TBaseDataLoader.AddMemdataField(mt: TdxMemData; Name, DisplayName: string; fType:TFieldType);
var NewField: TFieldDef;
begin
  if mt.FieldDefList.Find(Name) = nil then
    begin
      NewField := mt.FieldDefs.AddFieldDef;
      NewField.Name := Name;
      NewField.DataType := fType;
      if fType = ftString then
        NewField.Size := 50;
      NewField.Required := false;
      NewField.DisplayName := DisplayName;
      NewField.CreateField(nil, nil, Name, true);
    end;
end;

constructor TBaseDataLoader.Create;
begin
  inherited Create;
  FDataSet := TdxMemData.Create(Application);
end;

destructor TBaseDataLoader.Destroy;
begin
//  FreeAndNil(FDataSet);
  inherited Destroy;
end;

procedure TBaseDataLoader.AfterLoaded;
begin
//
end;

function TBaseDataLoader.LoadFromFile(AFileName: string): Boolean;
var sFileNameWithPath : string;
begin
  Result := false;

  sFileNameWithPath := ExtractFilePath(Application.ExeName) + cPATH_DATA + AFileName;

  if (Trim(AFileName) <> '') and (FileExists(sFileNameWithPath)) and (FDataSet <> nil) then
    begin
      FDataSet.DelimiterChar := cFILE_SEP;
      FDataSet.LoadFromTextFile(sFileNameWithPath);

      FDataSet.Open;

      Result := FDataSet.RecordCount <> 0;
    end;
  AfterLoaded;
end;

{ TCestLoader }

constructor TCestLoader.Create;
begin
  inherited Create;

  FDataSet.Close;

  AddFieldDefsToDataSet;

  FDataSet.Open;

  LoadFromFile(cFILENAME_CEST);

  FDataSet.SortOptions := FDataSet.SortOptions + [soCaseInsensitive];
  FDataSet.SortedField := cDS_CEST_CountryCode;
end;

procedure TCestLoader.AddFieldDefsToDataSet;
begin
  AddMemdataField(FDataSet, cDS_CEST_CountryCode, cDS_CEST_CountryCode, ftString);
  AddMemdataField(FDataSet, cDS_CEST_EVTOL, cDS_CEST_EVTOL, ftInteger);
  AddMemdataField(FDataSet, cDS_CEST_HOTOL, cDS_CEST_HOTOL, ftInteger);
  AddMemdataField(FDataSet, cDS_CEST_NAPTOL, cDS_CEST_NAPTOL, ftInteger);
  AddMemdataField(FDataSet, cDS_CEST_ORATOL, cDS_CEST_ORATOL, ftString);
  AddMemdataField(FDataSet, cDS_CEST_EVIG, cDS_CEST_EVIG, ftInteger);
  AddMemdataField(FDataSet, cDS_CEST_HOIG, cDS_CEST_HOIG, ftInteger);
  AddMemdataField(FDataSet, cDS_CEST_NAPIG, cDS_CEST_NAPIG, ftInteger);
  AddMemdataField(FDataSet, cDS_CEST_ORAIG, cDS_CEST_ORAIG, ftString);
end;

{ TCityLoader }

constructor TCityLoader.Create;
begin
  inherited Create;

  FDataSet.Close;

  AddFieldDefsToDataSet;

  FDataSet.Open;

  LoadFromFile(cFILENAME_CITY);

  FDataSet.SortOptions := FDataSet.SortOptions + [soCaseInsensitive];

  FDataSetForSearch := TdxMemData.Create(Application);

  FDataSet.SortedField := cDS_CITY_CityName;
  FslSortedCityes := TStringList.Create();
  AddCityInfoToStringList;

  FDataSet.SortedField := cDS_CITY_CountryCode;

  FDataSetForSearch.FieldByName(cDS_CITY_Longitude).OnGetText := OnFieldGetTextForLongLat;
  FDataSetForSearch.FieldByName(cDS_CITY_Latitude).OnGetText := OnFieldGetTextForLongLat;
end;

destructor TCityLoader.Destroy;
begin
//  FreeAndNil(FDataSetForSearch);
  FreeAndNil(FslSortedCityes);
  inherited Destroy;
end;

procedure TCityLoader.AddCityInfoToStringList;
begin
  FDataSetForSearch.LoadFromDataSet(FDataSet);

  FDataSetForSearch.First;

  FslSortedCityes.Clear;

  while not FDataSetForSearch.Eof do
    begin
      FslSortedCityes.Add
        (
          VarToStr(FDataSetForSearch[cDS_CITY_CityName]) + '; ' +
          VarToStr(FDataSetForSearch[cDS_CITY_CountryCode]) +
          '@' + VarToStr(FDataSetForSearch['RecID'])
        );
      FDataSetForSearch.Next;
    end;

  FDataSetForSearch.First;
end;

procedure TCityLoader.AddFieldDefsToDataSet;
begin
  AddMemdataField(FDataSet, cDS_CITY_CountryCode, cDS_CITY_CountryCode, ftString);
  AddMemdataField(FDataSet, cDS_CITY_CityName, cDS_CITY_CityName, ftString);
  AddMemdataField(FDataSet, cDS_CITY_Longitude, cDS_CITY_Longitude, ftFloat);
  AddMemdataField(FDataSet, cDS_CITY_Latitude, cDS_CITY_Latitude, ftFloat);
  AddMemdataField(FDataSet, cDS_CITY_TimeZoneCode, cDS_CITY_TimeZoneCode, ftString);
end;

function TCityLoader.GetCityRecID(ACityName: string): Integer;
var i : integer;
begin
  Result := -1;

  i := 0;
  while (i <= FslSortedCityes.Count - 1) and (Result = -1) do
    begin
      if UpperCase(Copy(FslSortedCityes.Strings[i], 1, Length(ACityName))) = UpperCase(ACityName) then
        Result := StrToIntDef(copy(FslSortedCityes.Strings[i], pos('@', FslSortedCityes.Strings[i]) + 1, Length(FslSortedCityes.Strings[i]) - pos('@', FslSortedCityes.Strings[i])), -1);
      inc(i);
    end;
end;

procedure TCityLoader.OnFieldGetTextForLongLat(Sender: TField;
  var Text: String; DisplayText: Boolean);
var sText : string;
begin
  sText := '';

  sText := IntToStr(Round(GetFokFromListItem(IntToStr(Sender.Value)))) + '°' + PaddL(IntToStr(Round(GetFokPercFromListItem(IntToStr(Sender.Value)))), 2, '0') + '''';

  Text := sText;
end;

{ TCountryLoader }

constructor TCountryLoader.Create;
begin
  inherited Create;

  FDataSet.Close;

  AddFieldDefsToDataSet;

  FDataSet.Open;

  LoadFromFile(cFILENAME_COUNTRY);

  FDataSet.SortOptions := FDataSet.SortOptions + [soCaseInsensitive];
  FDataSet.SortedField := cDS_COUNTRY_CountryCode;
end;

procedure TCountryLoader.AddFieldDefsToDataSet;
begin
  AddMemdataField(FDataSet, cDS_COUNTRY_CountryCode, cDS_DISP_COUNTRY_CountryCode, ftString);
  AddMemdataField(FDataSet, cDS_COUNTRY_DisplayName, cDS_DISP_COUNTRY_DisplayName, ftString);
  AddMemdataField(FDataSet, cDS_COUNTRY_TimeZoneCode, cDS_DISP_COUNTRY_TimeZoneCode, ftString);
end;

{ TTimeZoneLoader }

constructor TTimeZoneLoader.Create;
begin
  inherited Create;

  FDataSet.Close;

  AddFieldDefsToDataSet;

  FDataSet.Open;

  LoadFromFile(cFILENAME_TIMEZONE);

  //FDataSet.SortOptions := FDataSet.SortOptions + [soCaseInsensitive];
  //FDataSet.SortedField := cDS_TZONE_TimeZoneCode;
end;

procedure TTimeZoneLoader.AddFieldDefsToDataSet;
begin
  AddMemdataField(FDataSet, cDS_TZONE_TimeZoneCode, cDS_TZONE_TimeZoneCode, ftString);
  AddMemdataField(FDataSet, cDS_TZONE_DisplayName, cDS_TZONE_DisplayName, ftString);
  AddMemdataField(FDataSet, cDS_TZONE_Delta, cDS_TZONE_Delta, ftFloat);
  AddMemdataField(FDataSet, cDS_TZONE_Group, cDS_TZONE_Group, ftString);
  AddMemdataField(FDataSet, cDS_TZONE_Type, cDS_TZONE_Type, ftString);
  AddMemdataField(FDataSet, cDS_TZONE_Order, cDS_TZONE_Order, ftString);
end;

destructor TBaseINIFileLoader.Destroy;
begin
  FreeAndNil(FINIFile);
  inherited Destroy;
end;

function TBaseINIFileLoader.LoadINIFile(AFileName: string): Boolean;
begin
  Result := true;

  try
    FINIFile := TMemIniFile.Create(AFileName);
  except
    Result := false;
  end;
end;

function TSzuletesiKepletAdatokINIFileLoader.GetSzuletesiKepletFileInfo(AFileName: string): TSzuletesiKepletInfo;
var slNotesSection : TStringList;
    i : integer;
begin
  Result := nil;
  if LoadINIFile(AFileName) then
    begin
      Result := TSzuletesiKepletInfo.Create;
      Result.FLoading := true;

      Result.FileName := AFileName;
      Result.Name  := INIFile.ReadString(cBIRTHINI_SECBIRTHINFO, cBIRTHINI_Name, 'NINCS NÉV');
      Result.Gender := INIFile.ReadInteger(cBIRTHINI_SECBIRTHINFO, cBIRTHINI_Gender, 3);
      Result.SetDateOfBirth
        (
          INIFile.ReadInteger(cBIRTHINI_SECBIRTHINFO, cBIRTHINI_Year,   1900),
          INIFile.ReadInteger(cBIRTHINI_SECBIRTHINFO, cBIRTHINI_Month,     1),
          INIFile.ReadInteger(cBIRTHINI_SECBIRTHINFO, cBIRTHINI_Day,       1),
          INIFile.ReadInteger(cBIRTHINI_SECBIRTHINFO, cBIRTHINI_Hour,      0),
          INIFile.ReadInteger(cBIRTHINI_SECBIRTHINFO, cBIRTHINI_Minute,    0),
          INIFile.ReadInteger(cBIRTHINI_SECBIRTHINFO, cBIRTHINI_Second,    0)
        );
      Result.TZoneCode     := INIFile.ReadString(cBIRTHINI_SECBIRTHINFO, cBIRTHINI_TZoneCode, '');
      Result.TZoneWest     := StrAstroToBool(INIFile.ReadString(cBIRTHINI_SECBIRTHINFO, cBIRTHINI_TZoneWest, ''));
      Result.TZoneHour     := INIFile.ReadInteger(cBIRTHINI_SECBIRTHINFO, cBIRTHINI_TZoneHour, 0);
      Result.TZoneMinute   := INIFile.ReadInteger(cBIRTHINI_SECBIRTHINFO, cBIRTHINI_TZoneMinute, 0);

      Result.LocCity       := INIFile.ReadString(cBIRTHINI_SECBIRTHINFO, cBIRTHINI_LocCity, '');
      Result.LocCountry    := INIFile.ReadString(cBIRTHINI_SECBIRTHINFO, cBIRTHINI_LocCountry, '');
      Result.LocCountryID  := INIFile.ReadString(cBIRTHINI_SECBIRTHINFO, cBIRTHINI_LocCountryID, '');

      Result.LocAltitude   := INIFile.ReadInteger(cBIRTHINI_SECBIRTHINFO, cBIRTHINI_LocAltitude, 0);

      Result.LocLongDegree := INIFile.ReadInteger(cBIRTHINI_SECBIRTHINFO, cBIRTHINI_LocLongDegree, 0);
      Result.LocLongMinute := INIFile.ReadInteger(cBIRTHINI_SECBIRTHINFO, cBIRTHINI_LocLongMinute, 0);
      Result.LocLongSecond := INIFile.ReadInteger(cBIRTHINI_SECBIRTHINFO, cBIRTHINI_LocLongSecond, 0);
      Result.LocLatDegree  := INIFile.ReadInteger(cBIRTHINI_SECBIRTHINFO, cBIRTHINI_LocLatDegree, 0);
      Result.LocLatMinute  := INIFile.ReadInteger(cBIRTHINI_SECBIRTHINFO, cBIRTHINI_LocLatMinute, 0);
      Result.LocLatSecond  := INIFile.ReadInteger(cBIRTHINI_SECBIRTHINFO, cBIRTHINI_LocLatSecond, 0);

      Result.IsDayLightSavingTime := StrAstroToBool(INIFile.ReadString(cBIRTHINI_SECBIRTHINFO, cBIRTHINI_IsDayLightSavingTime, ''));

      Result.Note := TStringList.Create();

      slNotesSection := TStringList.Create;
      try
        INIFile.ReadSection(cBIRTHINI_SECNOTES, slNotesSection);

        for i := 0 to slNotesSection.Count - 1 do
          Result.Note.Add(INIFile.ReadString(cBIRTHINI_SECNOTES, slNotesSection.Strings[i], ''));
      finally
        FreeAndNil(slNotesSection);
      end;

      Result.FLoading := false;

    end;
end;

constructor TDataSetLoader.Create;
begin
  inherited Create;
  FCestLoader := TCestLoader.Create();
  FCityLoader := TCityLoader.Create();
  FCountryLoader := TCountryLoader.Create();
  FTimeZoneLoader := TTimeZoneLoader.Create();
end;

destructor TDataSetLoader.Destroy;
begin
  FreeAndNil(FTimeZoneLoader);
  FreeAndNil(FCountryLoader);
  FreeAndNil(FCityLoader);
  FreeAndNil(FCestLoader);
  inherited Destroy;
end;


procedure TTimeZoneLoader.AfterLoaded;
var iValue: integer;
    sDelta : string;
begin
  inherited;
  FDataSet.First;
  while not FDataSet.Eof do
    begin
      FDataSet.Edit;

      iValue := OnlyNumeric(VarToStr(FDataSet[cDS_TZONE_Delta]));
      // TODO: ejj nem jóó -> +12 .. -12
      if iValue < 0 then
        sDelta := '-' + PaddL(IntToStr(Abs(iValue)), 4, '0')
      else
        sDelta := '+' + PaddL(IntToStr(Abs(iValue)), 4, '0');

      FDataSet[cDS_TZONE_Order] := VarToStr(FDataSet[cDS_TZONE_Group]) + sDelta ;
      FDataSet.Post;
      FDataSet.Next;
    end;
end;

function TBulvarIniFileLoader.GetBulvarCaption(ABulvarType: TBulvarType): string;
begin
  Result := FINIFile.ReadString(cBULVARTYPESECTIONS[ABulvarType], cBULVAR_Caption, 'Nincs Caption');
end;

function TBulvarIniFileLoader.GetBulvarDescription(ABulvarType: TBulvarType; AZodiacID: integer): string;
var sZodiacID : string;
    i : integer;
begin
  sZodiacID := cZODIACANDPLANETLETTERS[AZodiacID].sBulvarZodiacName;

  if ABulvarType in [tbulv_AjandekAJegySzulotteinek] then
    sZodiacID := cZODIACANDPLANETLETTERS[AZodiacID].sBulvarZodiacName + 'N;' + cZODIACANDPLANETLETTERS[AZodiacID].sBulvarZodiacName + 'F';

  for i := 1 to WordCount(sZodiacID, [';']) do
    Result := Result + FINIFile.ReadString(cBULVARTYPESECTIONS[ABulvarType], ExtractWord(i, sZodiacID, [';']), 'Nincs Részletezés') + '<BR>';
end;

function TBulvarIniFileLoader.GetBulvarForras(ABulvarType: TBulvarType): string;
begin
  Result := FINIFile.ReadString(cBULVARTYPESECTIONS[ABulvarType], cBULVAR_Forras, 'Nincs Forrás');
end;

function TBulvarIniFileLoader.GetBulvarHosszuLeiras(ABulvarType: TBulvarType): string;
begin
  Result := FINIFile.ReadString(cBULVARTYPESECTIONS[ABulvarType], cBULVAR_Leiras, 'Nincs Hosszú Leírás');
end;

function TBulvarIniFileLoader.GetBulvarRovidLeiras(ABulvarType: TBulvarType): string;
begin
  Result := FINIFile.ReadString(cBULVARTYPESECTIONS[ABulvarType], cBULVAR_RovidLeiras, 'Nincs Rövid Leírás');
end;

{ TSettingsINIFileLoader }

destructor TSettingsINIFileLoader.Destroy;
begin
  FINIFile.UpdateFile;  

  inherited Destroy;
end;

function TSettingsINIFileLoader.GetBoolValue(AGrpName, AItemName: string): Boolean;
begin
  Result := FINIFile.ReadInteger(AGrpName, AItemName, 0) = 1;
end;

function TSettingsINIFileLoader.GetDoubleValue(AGrpName,
  AItemName: string): Double;
begin
  Result := FINIFile.ReadFloat(AGrpName, AItemName, 1.0);
end;

function TSettingsINIFileLoader.GetIntegerValue(AGrpName,
  AItemName: string): Integer;
begin
  Result := FINIFile.ReadInteger(AGrpName, AItemName, 0);
end;

function TSettingsINIFileLoader.GetStringValue(AGrpName, AItemName: string): String;
begin
  Result := FINIFile.ReadString(AGrpName, AItemName, '');
end;

procedure TSettingsINIFileLoader.SetBoolValue(AGrpName, AItemName: string; AValue: boolean);
var iValue : integer;
begin
  if AValue then iValue := 1 else iValue := 0;
  FINIFile.WriteInteger(AGrpName, AItemName, iValue);
end;

constructor TSettingsProvider.Create(ASettingsINIFileLoader: TSettingsINIFileLoader);
begin
  inherited Create;
  FSettingsINIFileLoader := ASettingsINIFileLoader;
end;

function TSettingsProvider.GetBetumeretSzorzo: Double;
begin
  Result := FSettingsINIFileLoader.GetDoubleValue(cGRP_BetumeretSzorzo, cGRPITM_BetumeretSzorzo);
end;

function TSettingsProvider.GetColorOfAir: integer;
begin
  Result := FSettingsINIFileLoader.GetIntegerValue(cGRP_chkbZodiakusBackGroundColor, cGRPITM_chkbZodiakusBackGroundColor[2]);
end;

function TSettingsProvider.GetColorOfAspect(AAspectID: integer): integer;
begin
  case AAspectID of
  cFSZ_EGYUTTALLAS       : Result := FSettingsINIFileLoader.GetIntegerValue(cGRP_chkbFenyszogColor, cGRPITM_chkbFenyszogColor[1]);
  cFSZ_SZEMBENALLAS      : Result := FSettingsINIFileLoader.GetIntegerValue(cGRP_chkbFenyszogColor, cGRPITM_chkbFenyszogColor[2]);
  cFSZ_NEGYEDFENY        : Result := FSettingsINIFileLoader.GetIntegerValue(cGRP_chkbFenyszogColor, cGRPITM_chkbFenyszogColor[3]);
  cFSZ_NYOLCADFENY       : Result := FSettingsINIFileLoader.GetIntegerValue(cGRP_chkbFenyszogColor, cGRPITM_chkbFenyszogColor[4]);
  cFSZ_3NYOLCADFENY      : Result := FSettingsINIFileLoader.GetIntegerValue(cGRP_chkbFenyszogColor, cGRPITM_chkbFenyszogColor[5]);
  cFSZ_HARMADFENY        : Result := FSettingsINIFileLoader.GetIntegerValue(cGRP_chkbFenyszogColor, cGRPITM_chkbFenyszogColor[6]);
  cFSZ_HATODFENY         : Result := FSettingsINIFileLoader.GetIntegerValue(cGRP_chkbFenyszogColor, cGRPITM_chkbFenyszogColor[7]);
  cFSZ_TIZENKETTEDFENY   : Result := FSettingsINIFileLoader.GetIntegerValue(cGRP_chkbFenyszogColor, cGRPITM_chkbFenyszogColor[8]);
  cFSZ_5TIZENKETTEDFENY  : Result := FSettingsINIFileLoader.GetIntegerValue(cGRP_chkbFenyszogColor, cGRPITM_chkbFenyszogColor[9]);
  cFSZ_OTODFENY          : Result := FSettingsINIFileLoader.GetIntegerValue(cGRP_chkbFenyszogColor, cGRPITM_chkbFenyszogColor[10]);
  cFSZ_TIZEDFENY         : Result := FSettingsINIFileLoader.GetIntegerValue(cGRP_chkbFenyszogColor, cGRPITM_chkbFenyszogColor[11]);
  cFSZ_2OTODFENY         : Result := FSettingsINIFileLoader.GetIntegerValue(cGRP_chkbFenyszogColor, cGRPITM_chkbFenyszogColor[12]);
  end;
end;

function TSettingsProvider.GetColorOfAspectsBackground: integer;
begin
  Result := FSettingsINIFileLoader.GetIntegerValue(cGRP_chkbFenyszogHatterSzine, cGRPITM_chkbFenyszogHatterSzine);
end;

function TSettingsProvider.GetColorOfFire: integer;
begin
  Result := FSettingsINIFileLoader.GetIntegerValue(cGRP_chkbZodiakusBackGroundColor, cGRPITM_chkbZodiakusBackGroundColor[0]);
end;

function TSettingsProvider.GetColorOfGround: integer;
begin
  Result := FSettingsINIFileLoader.GetIntegerValue(cGRP_chkbZodiakusBackGroundColor, cGRPITM_chkbZodiakusBackGroundColor[1]);
end;

function TSettingsProvider.GetColorOfWater: integer;
begin
  Result := FSettingsINIFileLoader.GetIntegerValue(cGRP_chkbZodiakusBackGroundColor, cGRPITM_chkbZodiakusBackGroundColor[3]);
end;

function TSettingsProvider.GetEnnalapotJelolesiMod: integer;
begin
  Result := FSettingsINIFileLoader.GetIntegerValue(cGRP_rgrpEnallapotJelolMod, cGRPITM_rgrpEnallapotJelolMod);
end;

function TSettingsProvider.GetExportHelye: string;
begin
  Result := FSettingsINIFileLoader.GetStringValue(cGRP_dlgExportHelye, cGRPITM_dlgExportHelye);
end;

function TSettingsProvider.GetHouseCuspSystem: string;
begin
  Result := FSettingsINIFileLoader.GetStringValue(cGRP_chkbHazrendszer, cGRPITM_chkbHazrendszer);
  if Length(Trim(Result)) = 0 then
    Result := 'P'; // Placidus
end;

function TSettingsProvider.GetInditasTeljesMeretben: boolean;
begin
  Result := FSettingsINIFileLoader.GetBoolValue(cGRP_chkbInditasTeljesMeret, cGRPITM_chkbInditasTeljesMeret);
end;

function TSettingsProvider.GetLastOpenedCount: Integer;
begin
  Result := FSettingsINIFileLoader.GetIntegerValue(cGRP_chkbEgyebek, cGRPITM_chkbEgyebek[3]);
end;

function TSettingsProvider.GetPrintAspectTable: boolean;
begin
  Result := FSettingsINIFileLoader.GetBoolValue(cGRP_chkbFenyszogTablazat, cGRPITM_chkbFenyszogTablazat_KELL_E);
end;

function TSettingsProvider.GetPrintEletstratTable: boolean;
begin
  Result := FSettingsINIFileLoader.GetBoolValue(cGRP_chkbEletStratTablazat, cGRPITM_chkbEletStratTablazat_KELL_E);
end;

function TSettingsProvider.GetPrintFejlecBirthDate: boolean;
begin
  Result := FSettingsINIFileLoader.GetBoolValue(cGRP_chkbFejlecKijelzesek, cGRPITM_chkbFejlecKijelzesek[1]);
end;

function TSettingsProvider.GetPrintFejlecBirthDay: boolean;
begin
  Result := FSettingsINIFileLoader.GetBoolValue(cGRP_chkbFejlecKijelzesek, cGRPITM_chkbFejlecKijelzesek[3]);
end;

function TSettingsProvider.GetPrintFejlecBirthPlace: boolean;
begin
  Result := FSettingsINIFileLoader.GetBoolValue(cGRP_chkbFejlecKijelzesek, cGRPITM_chkbFejlecKijelzesek[9]);
end;

function TSettingsProvider.GetPrintFejlecBirthPlaceCoord: boolean;
begin
  Result := FSettingsINIFileLoader.GetBoolValue(cGRP_chkbFejlecKijelzesek, cGRPITM_chkbFejlecKijelzesek[10]);
end;

function TSettingsProvider.GetPrintFejlecBirthTime: boolean;
begin
  Result := FSettingsINIFileLoader.GetBoolValue(cGRP_chkbFejlecKijelzesek, cGRPITM_chkbFejlecKijelzesek[2]);
end;

function TSettingsProvider.GetPrintFejlecDaylightTime: boolean;
begin
  Result := FSettingsINIFileLoader.GetBoolValue(cGRP_chkbFejlecKijelzesek, cGRPITM_chkbFejlecKijelzesek[5]);
end;

function TSettingsProvider.GetPrintFejlecHouseSystem: boolean;
begin
  Result := FSettingsINIFileLoader.GetBoolValue(cGRP_chkbFejlecKijelzesek, cGRPITM_chkbFejlecKijelzesek[11]);
end;

function TSettingsProvider.GetPrintFejlecName: boolean;
begin
  Result := FSettingsINIFileLoader.GetBoolValue(cGRP_chkbFejlecKijelzesek, cGRPITM_chkbFejlecKijelzesek[0]);
end;

function TSettingsProvider.GetPrintFejlecPrintType: boolean;
begin
  Result := FSettingsINIFileLoader.GetBoolValue(cGRP_chkbFejlecKijelzesek, cGRPITM_chkbFejlecKijelzesek[8]);
end;

function TSettingsProvider.GetPrintFejlecST: boolean;
begin
  Result := FSettingsINIFileLoader.GetBoolValue(cGRP_chkbFejlecKijelzesek, cGRPITM_chkbFejlecKijelzesek[7]);
end;

function TSettingsProvider.GetPrintFejlecTable: boolean;
begin
  Result := FSettingsINIFileLoader.GetBoolValue(cGRP_chkbFejlecKijelzesek, cGRPITM_chkbFejlecKijelzesek_KELL_E);
end;

function TSettingsProvider.GetPrintFejlecTimeZone: boolean;
begin
  Result := FSettingsINIFileLoader.GetBoolValue(cGRP_chkbFejlecKijelzesek, cGRPITM_chkbFejlecKijelzesek[4]);
end;

function TSettingsProvider.GetPrintFejlecUT: boolean;
begin
  Result := FSettingsINIFileLoader.GetBoolValue(cGRP_chkbFejlecKijelzesek, cGRPITM_chkbFejlecKijelzesek[6]);
end;

function TSettingsProvider.GetPrintHouseDegs: boolean;
begin
  Result := FSettingsINIFileLoader.GetBoolValue(cGRP_chkbHazTablazat, cGRPITM_chkbHazTablazat[0]);
end;

function TSettingsProvider.GetPrintHouseTable: boolean;
begin
  Result := FSettingsINIFileLoader.GetBoolValue(cGRP_chkbHazTablazat, cGRPITM_chkbHazTablazat_KELL_E);
end;

function TSettingsProvider.GetPrintHouseZodiac: boolean;
begin
  Result := FSettingsINIFileLoader.GetBoolValue(cGRP_chkbHazTablazat, cGRPITM_chkbHazTablazat[1]);
end;

function TSettingsProvider.GetPrintInColor: boolean;
begin
  Result := FSettingsINIFileLoader.GetBoolValue(cGRP_chkbNyomtatas, cGRPITM_chkbNyomtatasSzinesben);
end;

function TSettingsProvider.GetPrintLablecPrgBaseInfo: boolean;
begin
  Result := FSettingsINIFileLoader.GetBoolValue(cGRP_chkbLablecKijelzesek, cGRPITM_chkbLablecKijelzesek[0]);
end;

function TSettingsProvider.GetPrintLablecRegInfo: boolean;
begin
  Result := FSettingsINIFileLoader.GetBoolValue(cGRP_chkbLablecKijelzesek, cGRPITM_chkbLablecKijelzesek[1]);
end;

function TSettingsProvider.GetPrintLablecTable: boolean;
begin
  Result := FSettingsINIFileLoader.GetBoolValue(cGRP_chkbLablecKijelzesek, cGRPITM_chkbLablecKijelzesek_KELL_E);
end;

function TSettingsProvider.GetPrintPlanetDegs: boolean;
begin
  Result := FSettingsINIFileLoader.GetBoolValue(cGRP_chkbBolygoTablazat, cGRPITM_chkbBolygoTablazat[0]);
end;

function TSettingsProvider.GetPrintPlanetHouseLords: boolean;
begin
  Result := FSettingsINIFileLoader.GetBoolValue(cGRP_chkbBolygoTablazat, cGRPITM_chkbBolygoTablazat[3]);
end;

function TSettingsProvider.GetPrintPlanetHousePos: boolean;
begin
  Result := FSettingsINIFileLoader.GetBoolValue(cGRP_chkbBolygoTablazat, cGRPITM_chkbBolygoTablazat[2]);
end;

function TSettingsProvider.GetPrintPlanetTable: boolean;
begin
  Result := FSettingsINIFileLoader.GetBoolValue(cGRP_chkbBolygoTablazat, cGRPITM_chkbBolygoTablazat_KELL_E);
end;

function TSettingsProvider.GetPrintPlanetZodiac: boolean;
begin
  Result := FSettingsINIFileLoader.GetBoolValue(cGRP_chkbBolygoTablazat, cGRPITM_chkbBolygoTablazat[1]);
end;

function TSettingsProvider.GetShowHouseDegValues: boolean;
begin
  Result := FSettingsINIFileLoader.GetBoolValue(cGRP_chkbFokjelolok, cGRPITM_chkbFokjelolok[3]);
end;

function TSettingsProvider.GetShowHouseLords: boolean;
begin
  Result := FSettingsINIFileLoader.GetBoolValue(cGRP_chkbEgyebMegjelenitesek, cGRPITM_chkbEgyebMegjelenitesek[3]);
end;

function TSettingsProvider.GetShowHouseNumbersByArabicNumbers: boolean;
begin
  Result := FSettingsINIFileLoader.GetBoolValue(cGRP_chkbEgyebMegjelenitesek, cGRPITM_chkbEgyebMegjelenitesek[4]);
end;

function TSettingsProvider.GetShowHouseNumberSet: TByteSet;
var i : integer;
begin
  Result := [];

  for i := low(cGRPITM_chkbHazSzamok) to high(cGRPITM_chkbHazSzamok) do
    if FSettingsINIFileLoader.GetBoolValue(cGRP_chkbHazSzamok, cGRPITM_chkbHazSzamok[i].sItemName) then
      Result := Result + [cGRPITM_chkbHazSzamok[i].iAssignedItem];
end;

function TSettingsProvider.GetShowInnerAspectDegLines: boolean;
begin
  Result := FSettingsINIFileLoader.GetBoolValue(cGRP_chkbFokjelolok, cGRPITM_chkbFokjelolok[2]);
end;

function TSettingsProvider.GetShowInnerZodiacDegLines: boolean;
begin
  Result := FSettingsINIFileLoader.GetBoolValue(cGRP_chkbFokjelolok, cGRPITM_chkbFokjelolok[1]);
end;

function TSettingsProvider.GetShownAnalogPlanets: Boolean;
begin
  Result := FSettingsINIFileLoader.GetBoolValue(cGRP_chkbZodiakusJelek, cGRPITM_chkbZodiakusJelek_AnalogPlanet_KELL_E);
end;

function TSettingsProvider.GetShownAspectAxis: TByteSet;
var i : integer;
begin
  Result := [];

  for i := low(cGRPITM_chkbFenyszogeltTengelyek) to high(cGRPITM_chkbFenyszogeltTengelyek) do
    if FSettingsINIFileLoader.GetBoolValue(cGRP_chkbFenyszogeltTengelyek, cGRPITM_chkbFenyszogeltTengelyek[i].sItemName) then
      Result := Result + [cGRPITM_chkbFenyszogeltTengelyek[i].iAssignedItem];
end;

function TSettingsProvider.GetShownAspectHouses: TByteSet;
var i : integer;
begin
  Result := [];

  for i := low(cGRPITM_chkbFenyszogeltHazak) to high(cGRPITM_chkbFenyszogeltHazak) do
    if FSettingsINIFileLoader.GetBoolValue(cGRP_chkbFenyszogeltHazak, cGRPITM_chkbFenyszogeltHazak[i].sItemName) then
      Result := Result + [cGRPITM_chkbFenyszogeltHazak[i].iAssignedItem];
end;

function TSettingsProvider.GetShownAspectPlanets: string;
var i : integer;
begin
  Result := '';           
  for i := low(cGRPITM_chkbFenyszogeltBolygok) to high(cGRPITM_chkbFenyszogeltBolygok) do
    if FSettingsINIFileLoader.GetBoolValue(cGRP_chkbFenyszogeltBolygok, cGRPITM_chkbFenyszogeltBolygok[i].sItemName) then
      Result := Result + IntToStr(cGRPITM_chkbFenyszogeltBolygok[i].iAssignedItem) + ';';

  for i := low(cGRPITM_chkbFenyszogeltKisBolygok) to high(cGRPITM_chkbFenyszogeltKisBolygok) do
    if FSettingsINIFileLoader.GetBoolValue(cGRP_chkbFenyszogeltKisBolygok, cGRPITM_chkbFenyszogeltKisBolygok[i].sItemName) then
      Result := Result + IntToStr(cGRPITM_chkbFenyszogeltKisBolygok[i].iAssignedItem) + ';';

  if FSettingsINIFileLoader.GetBoolValue(cGRP_chkbFenyszogeltCsompontok, cGRPITM_chkbFenyszogeltCsompontok[1]) then
    Result := Result + IntToStr(SE_TRUE_MEAN_NODE_DOWN) + ';'; // ha van leszálló holdcsomó, akkor mindegy, hogy mean vagy true, az jó lesz

  if FSettingsINIFileLoader.GetBoolValue(cGRP_chkbFenyszogeltCsompontok, cGRPITM_chkbFenyszogeltCsompontok[0]) then
    if FSettingsINIFileLoader.GetBoolValue(cGRP_chkbHoldocsomoTipus, cGRPITM_chkbHoldcsomoTipus[0]) then
      Result := Result + IntToStr(SE_MEAN_NODE) + ';'
    else
      if FSettingsINIFileLoader.GetBoolValue(cGRP_chkbHoldocsomoTipus, cGRPITM_chkbHoldcsomoTipus[1]) then
        Result := Result + IntToStr(SE_TRUE_NODE) + ';';
  if (length(Result) > 0) and (Result[Length(Result)] <> ';') then Result := Result + ';'
end;

function TSettingsProvider.GetShownAspectSymbols: TByteSet;
var i : integer;
begin
  Result := [];

  for i := low(cGRPITM_chkbFenyszogJelek) to high(cGRPITM_chkbFenyszogJelek) do
    if FSettingsINIFileLoader.GetBoolValue(cGRP_chkbFenyszogJelek, cGRPITM_chkbFenyszogJelek[i]) then
      Result := Result + [cGRPITM_chkbFenyszogek[i].iAssignedItem];
end;

function TSettingsProvider.GetShownAspectTypes: TByteSet;
var i : integer;
begin
  Result := [];

  for i := low(cGRPITM_chkbFenyszogek) to high(cGRPITM_chkbFenyszogek) do
    if FSettingsINIFileLoader.GetBoolValue(cGRP_chkbFenyszogek, cGRPITM_chkbFenyszogek[i].sItemName) then
      Result := Result + [cGRPITM_chkbFenyszogek[i].iAssignedItem];
end;

function TSettingsProvider.GetShownHouseBorderSet: TByteSet;
var i : integer;
begin
  Result := [];

  for i := low(cGRPITM_chkbHazHatarok) to high(cGRPITM_chkbHazHatarok) do
    if FSettingsINIFileLoader.GetBoolValue(cGRP_chkbHazHatarok, cGRPITM_chkbHazHatarok[i].sItemName) then
      Result := Result + [cGRPITM_chkbHazHatarok[i].iAssignedItem];
end;

function TSettingsProvider.GetShownPlanetSet(AAllPlanet: Boolean = false): String;
var i : integer;
begin
  Result := '';
  for i := low(cGRPITM_chkbBolygok) to high(cGRPITM_chkbBolygok) do
    if not AAllPlanet then
      begin
        if FSettingsINIFileLoader.GetBoolValue(cGRP_chkbBolygok, cGRPITM_chkbBolygok[i].sItemName) then
          Result := Result + IntToStr(cGRPITM_chkbBolygok[i].iAssignedItem) + ';';
      end
    else
      begin
        Result := Result + IntToStr(cGRPITM_chkbBolygok[i].iAssignedItem) + ';';
      end;

  for i := low(cGRPITM_chkbKisBolygok) to high(cGRPITM_chkbKisBolygok) do
    if not AAllPlanet then
      begin
        if FSettingsINIFileLoader.GetBoolValue(cGRP_chkbKisBolygok, cGRPITM_chkbKisBolygok[i].sItemName) then
          Result := Result + IntToStr(cGRPITM_chkbKisBolygok[i].iAssignedItem) + ';';
      end
    else
      begin
        Result := Result + IntToStr(cGRPITM_chkbKisBolygok[i].iAssignedItem) + ';';
      end;

  if FSettingsINIFileLoader.GetBoolValue(cGRP_chkbHoldcsomo, cGRPITM_chkbHoldcsomo[1]) then
    Result := Result + IntToStr(SE_TRUE_MEAN_NODE_DOWN) + ';'; // ha van leszálló holdcsomó, akkor mindegy, hogy mean vagy true, az jó lesz

  if FSettingsINIFileLoader.GetBoolValue(cGRP_chkbHoldcsomo, cGRPITM_chkbHoldcsomo[0]) then
    if FSettingsINIFileLoader.GetBoolValue(cGRP_chkbHoldocsomoTipus, cGRPITM_chkbHoldcsomoTipus[0]) then
      Result := Result + IntToStr(SE_MEAN_NODE) + ';'
    else
      if FSettingsINIFileLoader.GetBoolValue(cGRP_chkbHoldocsomoTipus, cGRPITM_chkbHoldcsomoTipus[1]) then
        Result := Result + IntToStr(SE_TRUE_NODE) + ';';
  if (length(Result) > 0) and (Result[Length(Result)] <> ';') then Result := Result + ';'
end;

function TSettingsProvider.GetShownZodiacSigns: TByteSet;
var i : integer;
begin
  Result := [];
  for i := low(cGRPITM_chkbZodiakusJelek) to high(cGRPITM_chkbZodiakusJelek) do
    if FSettingsINIFileLoader.GetBoolValue(cGRP_chkbZodiakusJelek, cGRPITM_chkbZodiakusJelek[i].sItemName) then
      Result := Result + [cGRPITM_chkbZodiakusJelek[i].iAssignedItem];
end;

function TSettingsProvider.GetShowOuterZodiacDegLines: boolean;
begin
  Result := FSettingsINIFileLoader.GetBoolValue(cGRP_chkbFokjelolok, cGRPITM_chkbFokjelolok[0]);
end;

function TSettingsProvider.GetShowPlanetDegs: boolean;
begin
  Result := FSettingsINIFileLoader.GetBoolValue(cGRP_chkbEgyebMegjelenitesek, cGRPITM_chkbEgyebMegjelenitesek[2]);
end;

function TSettingsProvider.GetShowRetrogradeSign: boolean;
begin
  Result := FSettingsINIFileLoader.GetBoolValue(cGRP_chkbEgyebMegjelenitesek, cGRPITM_chkbEgyebMegjelenitesek[1]);
end;

function TSettingsProvider.GetShowSelfMarkerAtorigPlace: boolean;
begin
  Result := FSettingsINIFileLoader.GetBoolValue(cGRP_chkbEgyebMegjelenitesek, cGRPITM_chkbEgyebMegjelenitesek[5]);
end;

function TSettingsProvider.GetShowSelfMarkers: boolean;
begin
  Result := FSettingsINIFileLoader.GetBoolValue(cGRP_chkbEgyebMegjelenitesek, cGRPITM_chkbEgyebMegjelenitesek[0]);
end;

function TSettingsProvider.GetShowZodiacDegsOnOtherCircle: boolean;
begin
  Result := FSettingsINIFileLoader.GetBoolValue(cGRP_chkbFokjelolok, cGRPITM_chkbFokjelolok[4]);
end;

function TSettingsProvider.GetStyleOfAspect(AAspectID: integer): TPenStyle;
var iStyleID : integer;
begin
  Result := psSolid;

  case AAspectID of
  cFSZ_EGYUTTALLAS       : iStyleID := FSettingsINIFileLoader.GetIntegerValue(cGRP_chkbFenyszogStyle, cGRPITM_chkbFenyszogStlye[1]);
  cFSZ_SZEMBENALLAS      : iStyleID := FSettingsINIFileLoader.GetIntegerValue(cGRP_chkbFenyszogStyle, cGRPITM_chkbFenyszogStlye[2]);
  cFSZ_NEGYEDFENY        : iStyleID := FSettingsINIFileLoader.GetIntegerValue(cGRP_chkbFenyszogStyle, cGRPITM_chkbFenyszogStlye[3]);
  cFSZ_NYOLCADFENY       : iStyleID := FSettingsINIFileLoader.GetIntegerValue(cGRP_chkbFenyszogStyle, cGRPITM_chkbFenyszogStlye[4]);
  cFSZ_3NYOLCADFENY      : iStyleID := FSettingsINIFileLoader.GetIntegerValue(cGRP_chkbFenyszogStyle, cGRPITM_chkbFenyszogStlye[5]);
  cFSZ_HARMADFENY        : iStyleID := FSettingsINIFileLoader.GetIntegerValue(cGRP_chkbFenyszogStyle, cGRPITM_chkbFenyszogStlye[6]);
  cFSZ_HATODFENY         : iStyleID := FSettingsINIFileLoader.GetIntegerValue(cGRP_chkbFenyszogStyle, cGRPITM_chkbFenyszogStlye[7]);
  cFSZ_TIZENKETTEDFENY   : iStyleID := FSettingsINIFileLoader.GetIntegerValue(cGRP_chkbFenyszogStyle, cGRPITM_chkbFenyszogStlye[8]);
  cFSZ_5TIZENKETTEDFENY  : iStyleID := FSettingsINIFileLoader.GetIntegerValue(cGRP_chkbFenyszogStyle, cGRPITM_chkbFenyszogStlye[9]);
  cFSZ_OTODFENY          : iStyleID := FSettingsINIFileLoader.GetIntegerValue(cGRP_chkbFenyszogStyle, cGRPITM_chkbFenyszogStlye[10]);
  cFSZ_TIZEDFENY         : iStyleID := FSettingsINIFileLoader.GetIntegerValue(cGRP_chkbFenyszogStyle, cGRPITM_chkbFenyszogStlye[11]);
  cFSZ_2OTODFENY         : iStyleID := FSettingsINIFileLoader.GetIntegerValue(cGRP_chkbFenyszogStyle, cGRPITM_chkbFenyszogStlye[12]);
  end;

  Result := cASPECTITEMSTYLE[iStyleID + 1].psPenStyle;
end;

function TSettingsProvider.GetZodiacType: string;
begin
  Result := FSettingsINIFileLoader.GetStringValue(cGRP_chkbZodiakus, cGRPITM_chkbZodiakus);
end;

procedure TSettingsINIFileLoader.SetDoubleValue(AGrpName,
  AItemName: string; AValue: Double);
begin
  FINIFile.WriteFloat(AGrpName, AItemName, AValue);
end;

procedure TSettingsINIFileLoader.SetIntegerValue(AGrpName,
  AItemName: string; AValue: integer);
begin
  FINIFile.WriteInteger(AGrpName, AItemName, AValue);
end;

procedure TSettingsINIFileLoader.SetStringValue(AGrpName, AItemName,
  AValue: string);
begin
  FINIFile.WriteString(AGrpName, AItemName, AValue);
end;

procedure TSettingsProvider.SetExportHelye(AHelye: string);
begin
  FSettingsINIFileLoader.SetStringValue(cGRP_dlgExportHelye, cGRPITM_dlgExportHelye, AHelye);
end;

end.
