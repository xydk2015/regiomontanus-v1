unit uAstro4AllTypes;

interface

uses Windows, Classes, Contnrs, uAstro4AllConsts, Registry;

type
  // Házsarok pozíciók
  THouseCuspsType = array[0..12] of Double;

  // Long, Lat, Distance, Speed in Long, Speed in Lat, Speed in dist
  TPlanetPositionInfo  = array[0..5] of Double;

  TAscMcType           = array[0..9] of Double;

  TsErr = array[0..255] of Char;

  TCestReszlet = (tcOra, tcPerc, tcMP);
  
  TSzuletesiKepletInfo = class(TObject)
  private
    FKepletInfoChanged: Boolean;
    FDay: word;
    FFileName: string;
    FGender: Integer;
    FHour: word;
    FIsDayLightSavingTime: Boolean;
    FLocAltitude: Integer;
    FLocCity: string;
    FLocCountry: string;
    FLocCountryID: string;
    FLocLatDegree: Integer;
    FLocLatMinute: word;
    FLocLatSecond: word;
    FLocLongDegree: Integer;
    FLocLongMinute: word;
    FLocLongSecond: word;
    FMinute: word;
    FMonth: word;
    FName: string;
    FNote: TStringList;
    FSecond: word;
    FTZoneCode: string;
    FTZoneHour: Integer;
    FTZoneMinute: word;
    FTZoneWest: Boolean;
    FYear: word;
    function GetDateOfBirth: TDateTime;
    function GetDateOfBirthJulian: Double;
    procedure SetFileName(const Value: string);
    procedure SetGender(const Value: Integer);
    procedure SetIsDayLightSavingTime(const Value: Boolean);
    procedure SetLocAltitude(const Value: Integer);
    procedure SetLocCity(Value: string);
    procedure SetLocCountry(const Value: string);
    procedure SetLocCountryID(const Value: string);
    procedure SetLocLatDegree(const Value: Integer);
    procedure SetLocLatMinute(const Value: word);
    procedure SetLocLatSecond(const Value: word);
    procedure SetLocLongDegree(const Value: Integer);
    procedure SetLocLongMinute(const Value: word);
    procedure SetLocLongSecond(const Value: word);
    procedure SetName(const Value: string);
    procedure SetNote(const Value: TStringList);
    procedure SetTZoneCode(const Value: string);
    procedure SetTZoneHour(const Value: Integer);
    procedure SetTZoneMinute(const Value: word);
  public
    FLoading: Boolean;
    constructor Create;
    destructor Destroy; override;
    procedure SetDateOfBirth(AYearMonthDay: TDateTime); overload;
    procedure SetDateOfBirth(AHour, AMinute, ASecond: word); overload;
    procedure SetDateOfBirth(AYear, AMonth, ADay, AHour, AMinute, ASecond: word); overload;
    property KepletInfoChanged: Boolean read FKepletInfoChanged write FKepletInfoChanged;
    property DateOfBirth: TDateTime read GetDateOfBirth;
    property DateOfBirthJulian: Double read GetDateOfBirthJulian;
    property Day: word read FDay;
    property FileName: string read FFileName write SetFileName;
    property Gender: Integer read FGender write SetGender;
    property Hour: word read FHour;
    property IsDayLightSavingTime: Boolean read FIsDayLightSavingTime write SetIsDayLightSavingTime;
    property LocAltitude: Integer read FLocAltitude write SetLocAltitude;
    property LocCity: string read FLocCity write SetLocCity;
    property LocCountry: string read FLocCountry write SetLocCountry;
    property LocCountryID: string read FLocCountryID write SetLocCountryID;
    property LocLatDegree: Integer read FLocLatDegree write SetLocLatDegree;
    property LocLatMinute: word read FLocLatMinute write SetLocLatMinute;
    property LocLatSecond: word read FLocLatSecond write SetLocLatSecond;
    property LocLongDegree: Integer read FLocLongDegree write SetLocLongDegree;
    property LocLongMinute: word read FLocLongMinute write SetLocLongMinute;
    property LocLongSecond: word read FLocLongSecond write SetLocLongSecond;
    property Minute: word read FMinute;
    property Month: word read FMonth;
    property Name: string read FName write SetName;
    property Note: TStringList read FNote write SetNote;
    property Second: word read FSecond;
    property TZoneCode: string read FTZoneCode write SetTZoneCode;
    property TZoneHour: Integer read FTZoneHour write SetTZoneHour;
    property TZoneMinute: word read FTZoneMinute write SetTZoneMinute;
    property TZoneWest: Boolean read FTZoneWest write FTZoneWest;
    property Year: word read FYear;
  end;

  TTimeZoneInfo = class(TObject)
  private
    FDelta: Double;
    FDisplayName: string;
    FGroup: string;
    FTimeZoneCode: string;
    FTZType: string;
    function GetDeltaHour: Double;
    function GetDeltaMinute: Double;
  public
    constructor Create;
    function GetDeltaAsString: string;
    property Delta: Double read FDelta write FDelta;
    property DeltaHour: Double read GetDeltaHour;
    property DeltaMinute: Double read GetDeltaMinute;
    property DisplayName: string read FDisplayName write FDisplayName;
    property Group: string read FGroup write FGroup;
    property TimeZoneCode: string read FTimeZoneCode write FTimeZoneCode;
    property TZType: string read FTZType write FTZType;
  end;

  THouseSet = set of cHSN_House01..cHSN_House12;

  THouseLordsContainer = class(TObject)
  public
    FClosedHouseNumbers : THouseSet;
    FNormalHouseNumbers : THouseSet;

    function GetHouseNumberTexts : string;
  end;
                                   
  //# Bolygó osztály
  TPlanet = class(TObject)
  private
    FDec: Double;
    FHouseNumber: Integer;
    FPlanetID: Integer;
    FRA: Double;
    FSpeed: Double;
    function GetInZodiacSign: Integer;
    function GetPlanetName: string;
    function GetRetrograd: Boolean;
    function GetStartDegree: Double;
  public
    FHouseLordsContainer: THouseLordsContainer;
    constructor Create;
    destructor Destroy; override;
    property Dec: Double read FDec write FDec;
    property HouseNumber: Integer read FHouseNumber write FHouseNumber;
    property InZodiacSign: Integer read GetInZodiacSign;
    property PlanetID: Integer read FPlanetID write FPlanetID;
    property PlanetName: string read GetPlanetName;
    property RA: Double read FRA write FRA;
    property Retrograd: Boolean read GetRetrograd;
    property Speed: Double read FSpeed write FSpeed;
    property StartDegree: Double read GetStartDegree;
  end;

  //# A képletben lévõ bolygók osztálya
  TPlanetList = class(TObjectList)
  public
    procedure AddNewPlanetInfo(APlanetID: integer; ARA, ADec, ASpeed: Double);
    function GetPlanet(AItemIDX: integer): TPlanet;
    function GetPlanetInfo(APlanetID: integer): TPlanet;
    function IsPlanetInList(APlanetID: integer): Boolean;
  end;

  //# Házsarok osztály
  THouseCusp = class(TObject)
  private
    FHouseNumber: Integer;
    FRA: Double;
    function GetInZodiacSign: Integer;
    function GetStartDegree: Double;
  public
    property HouseNumber: Integer read FHouseNumber write FHouseNumber;
    property InZodiacSign: Integer read GetInZodiacSign;
    property RA: Double read FRA write FRA;
    property StartDegree: Double read GetStartDegree;
  end;

  //# A képletben lévõ házak pozícióinak osztálya
  THouseList = class(TObjectList)
  public
    procedure AddNewHouseCuspInfo(AHouseNum: integer; ARA: Double);
    function GetHouseCuspInfo(AHouseNum: integer): THouseCusp;
    function IsHouseInList(AHouseNum: integer): Boolean;
  end;

  //# Tengely osztály
  TAxis = class(TObject)
  private
    FAxisID: Integer;
    FRA: Double;
    function GetInZodiacSign: Integer;
    function GetStartDegree: Double;
  public
    property AxisID: Integer read FAxisID write FAxisID;
    property InZodiacSign: Integer read GetInZodiacSign;
    property RA: Double read FRA write FRA;
    property StartDegree: Double read GetStartDegree;
  end;

  //# Tengelyek listája
  TAxisList = class(TObjectList)
  public
    procedure AddNewAxisInfo(AAxisID: integer; ARA: Double);
    function GetAxisInfo(AAxisID: integer): TAxis;
    function IsAxisInList(AAxisID: integer): Boolean;
  end;

  TAspectInfo = class(TObject)
  private
    FAspect01ID: Integer;
    FAspect01Type: TAspectType;
    FAspect02ID: Integer;
    FAspect02Type: TAspectType;
    FAspectID: Integer;
    FAspectQuality: TAspectQualityType;
  public
    constructor Create;
    property Aspect01ID: Integer read FAspect01ID write FAspect01ID;
    property Aspect01Type: TAspectType read FAspect01Type write FAspect01Type;
    property Aspect02ID: Integer read FAspect02ID write FAspect02ID;
    property Aspect02Type: TAspectType read FAspect02Type write FAspect02Type;
    property AspectID: Integer read FAspectID write FAspectID;
    property AspectQuality: TAspectQualityType read FAspectQuality write FAspectQuality;
  end;

  //# Fényszög lista
  TAspectInfoList = class(TObjectList)
  public
    procedure AddNewAspectInfo(AAspect01ID: integer; AAspect01Type: TAspectType; AAspect02ID: integer; AAspect02Type:
        TAspectType; AAspectID: integer; AAspectQualityType: TAspectQualityType);
    function GetAspectInfo(AIdx: integer): TAspectInfo;
    function IsAspectInList(AAspect01ID: integer; AAspect01Type: TAspectType; AAspect02ID: integer; AAspect02Type:
        TAspectType; AAspectID: integer; AAspectQualityType: TAspectQualityType): Boolean;
  end;

  //# Én jelölõk listája
  TSelfMarkerList = class(TObjectList)
  public
    procedure AddNewSelfMarker(ASelfMarker: TObject);
    function GetSelfMarker(AIdx: integer): TObject;
    function IsSelfMarkerInList(ASelfMarker: TObject): Boolean;
  end;

  //# Számítási eredmények osztálya
  TCalcResult = class(TObject)
  private
    FAspectList: TAspectInfoList;
    FAxisList: TAxisList;
    FHouseCuspList: THouseList;
    FPlanetList: TPlanetList;
    FSelfMarkerList: TSelfMarkerList;
  public
    Ayanamsa: Double;
    EclipticObliquity: Double;
    SideralTime: TDateTime;
    UniversalTime: TDateTime;
    ASC_PointValue : Double;
    matrJartJaratlanPontszam : array[1..4, 1..5] of word;
    utJartUt, utJaratlanUt : array of byte;
    constructor Create;
    destructor Destroy; override;
    property AspectList: TAspectInfoList read FAspectList;
    property AxisList: TAxisList read FAxisList;
    property HouseCuspList: THouseList read FHouseCuspList;
    property PlanetList: TPlanetList read FPlanetList;
    property SelfMarkerList: TSelfMarkerList read FSelfMarkerList;
  end;

  TSzulKepletFormInfo = class(TObject)
  public
    FCalcResult: TCalcResult;
    FSzuletesiKepletInfo: TSzuletesiKepletInfo;
    constructor Create;
  end;

  TRegistrationSettings = class(TObject)
  private
    FRegEmail: string;
    FRegistered: Boolean;
    FRegName: string;
    FRegState: TRegState;
    function GetRegistered: Boolean;
    procedure ReadRegistrationInfo;
  public
    constructor Create;
    property RegEmail: string read FRegEmail;
    property Registered: Boolean read GetRegistered;
    property RegName: string read FRegName;
    property RegState: TRegState read FRegState;
  end;

  TSorOszlopType = class(TObject)
  private
  public
    SO_ID: Integer;
    SO_Value: Integer;
    constructor Create;
  end;

  TSorOszlopList = class(TObjectList)
  private
    FMaxKereses: Boolean;
  public
    constructor Create(AOwnsObjects, AMaxKereses: Boolean); overload;
    procedure AddNewItem(AID, AValue: Integer);
    function GetItem(AIdx: Integer): TSorOszlopType;
  end;

  TLastOpenedFiles = class(TObject)
  private
    FLastOpenedCount: Integer;
    FOpenedFilesContainer: TStringList;
    FRegistry: TRegistry;
    procedure ReadLastOpenedFilesFromRegistry;
    procedure SetLastOpenedCount(const Value: Integer);
    procedure WriteLastOpenedFilesToRegistry;
  public
    FMaxOpenedCount: Integer;
    constructor Create;
    destructor Destroy; override;
    procedure AddOpenedFileName(AFileNamePath: string);
    procedure RemoveOpenedFileName(AFileNamePath: string);
    function GetLastOpenedFiles: string;
    property LastOpenedCount: Integer read FLastOpenedCount write SetLastOpenedCount;
  end;

  TZodiacSignForSelfMarkers = class(TObject)
  private
    FRA: Double;
    FSignID: Integer;
  public
    constructor Create;
    property RA: Double read FRA write FRA;
    property SignID: Integer read FSignID write FSignID;
  end;

implementation

uses Math, SysUtils, DateUtils, uSegedUtils, swe_de32,
  uAstro4AllConstProvider;

constructor TSzuletesiKepletInfo.Create;
begin
  inherited Create;
  FDay := 0;
  FHour := 0;
  FMinute := 0;
  FMonth := 0;
  FName := '';
  FSecond := 0;
  FYear := 0;
  FTZoneCode := '';
  FTZoneWest := false;
  FTZoneHour := cINITNUMBER;
  FTZoneMinute := cINITNUMBER;
  FLocCity := '';
  FLocAltitude := 0;
  FLocLongDegree := cINITNUMBER;
  FLocLongMinute := cINITNUMBER;
  FLocLongSecond := cINITNUMBER;
  FLocLatDegree := cINITNUMBER;
  FLocLatMinute := cINITNUMBER;
  FLocLatSecond := cINITNUMBER;
  FNote := TStringList.Create();
  FFileName := '';
  FKepletInfoChanged := False;
  FLocCountry := '';
  FLocCountryID := '';
  FGender := 2;
  FIsDayLightSavingTime := false;
  FLoading := False;
end;

destructor TSzuletesiKepletInfo.Destroy;
begin
  FreeAndNil(FNote);
  inherited Destroy;
end;

function TSzuletesiKepletInfo.GetDateOfBirth: TDateTime;
begin
  if FYear + FMonth + FDay = 0 then
    raise ExceptionClass.Create
  else
    TryOwnEncodeDateTime(FYear, FMonth, FDay, FHour, FMinute, FSecond, 0, Result);
end;

function TSzuletesiKepletInfo.GetDateOfBirthJulian: Double;
var dDate : Double;
begin
  dDate := 0;
  swe_date_conversion(FYear, FMonth, FDay, OraPercToDouble(FHour, FMinute), 'g', dDate);
  Result := dDate;
end;

procedure TSzuletesiKepletInfo.SetDateOfBirth(AYearMonthDay: TDateTime);
var dTemp : word;
begin
  DecodeDateTime(AYearMonthDay, FYear, FMonth, FDay, FHour, FMinute, FSecond, dTemp);
end;

procedure TSzuletesiKepletInfo.SetDateOfBirth(AHour, AMinute, ASecond: word);
begin
  FHour := AHour;
  FMinute := AMinute;
  FSecond := ASecond;
end;

procedure TSzuletesiKepletInfo.SetDateOfBirth(AYear, AMonth, ADay, AHour, AMinute, ASecond: word);
begin
  FYear := AYear;
  FMonth := AMonth;
  FDay := ADay;
  FHour := AHour;
  FMinute := AMinute;
  FSecond := ASecond;
end;

procedure TSzuletesiKepletInfo.SetFileName(const Value: string);
begin
  if (Trim(FFileName) <> '') and (Value <> FFileName) and (not FLoading) then FKepletInfoChanged := true;
  FFileName := Value;
end;

procedure TSzuletesiKepletInfo.SetGender(const Value: Integer);
begin
  if (FGender <> 0) and (Value <> FGender) and (not FLoading) then FKepletInfoChanged := true;
  FGender := Value;
end;

procedure TSzuletesiKepletInfo.SetIsDayLightSavingTime(const Value: Boolean);
begin
  if (Value <> FIsDayLightSavingTime) and (not FLoading) then FKepletInfoChanged := true;
  FIsDayLightSavingTime := Value;
end;

procedure TSzuletesiKepletInfo.SetLocAltitude(const Value: Integer);
begin
  if (FLocAltitude <> 0) and (Value <> FLocAltitude) and (not FLoading) then FKepletInfoChanged := true;
  FLocAltitude := Value;
end;

procedure TSzuletesiKepletInfo.SetLocCity(Value: string);
begin
  if pos('; ', Value) > 0 then
    Value := copy(Value, 1, pos('; ', Value) - 1);

  if (Trim(FLocCity) <> '') and (Value <> FLocCity) and (not FLoading) then FKepletInfoChanged := true;

  FLocCity := Value;
end;

procedure TSzuletesiKepletInfo.SetLocCountry(const Value: string);
begin
  if (Trim(FLocCountryID) <> '') and (Value <> FLocCountryID) and (not FLoading) then FKepletInfoChanged := true;
  FLocCountry := Value;
end;

procedure TSzuletesiKepletInfo.SetLocCountryID(const Value: string);
begin
  if (Trim(FLocCountryID) <> '') and (Value <> FLocCountryID) and (not FLoading) then FKepletInfoChanged := true;
  FLocCountryID := Value;
end;

procedure TSzuletesiKepletInfo.SetLocLatDegree(const Value: Integer);
begin
  if (FLocLatDegree <> cINITNUMBER) and (Value <> FLocLatDegree) and (not FLoading) then FKepletInfoChanged := true;
  FLocLatDegree := Value;
end;

procedure TSzuletesiKepletInfo.SetLocLatMinute(const Value: word);
begin
  if (FLocLatMinute <> cINITNUMBER) and (Value <> FLocLatMinute) and (not FLoading) then FKepletInfoChanged := true;
  FLocLatMinute := Value;
end;

procedure TSzuletesiKepletInfo.SetLocLatSecond(const Value: word);
begin
  if (FLocLatSecond <> cINITNUMBER) and (Value <> FLocLatSecond) and (not FLoading) then FKepletInfoChanged := true;
  FLocLatSecond := Value;
end;

procedure TSzuletesiKepletInfo.SetLocLongDegree(const Value: Integer);
begin
  if (FLocLongDegree <> cINITNUMBER) and (Value <> FLocLongDegree) and (not FLoading) then FKepletInfoChanged := true;
  FLocLongDegree := Value;
end;

procedure TSzuletesiKepletInfo.SetLocLongMinute(const Value: word);
begin
  if (FLocLongMinute <> cINITNUMBER) and (Value <> FLocLongMinute) and (not FLoading) then FKepletInfoChanged := true;
  FLocLongMinute := Value;
end;

procedure TSzuletesiKepletInfo.SetLocLongSecond(const Value: word);
begin
  if (FLocLongSecond <> cINITNUMBER) and (Value <> FLocLongSecond) and (not FLoading) then FKepletInfoChanged := true;
  FLocLongSecond := Value;
end;

procedure TSzuletesiKepletInfo.SetName(const Value: string);
begin
  if (Trim(FName) <> '') and (Value <> FName) and (not FLoading) then FKepletInfoChanged := true;
  FName := Value;
end;

procedure TSzuletesiKepletInfo.SetNote(const Value: TStringList);
begin
  if (Trim(FNote.Text) <> '') and (FNote.Text <> Value.Text) and (not FLoading) then FKepletInfoChanged := true;
  FNote := Value;
end;

procedure TSzuletesiKepletInfo.SetTZoneCode(const Value: string);
begin
  if (Trim(FTZoneCode) <> '') and (FTZoneCode <> Value) and (not FLoading) then FKepletInfoChanged := true;
  FTZoneCode := Value;
end;

procedure TSzuletesiKepletInfo.SetTZoneHour(const Value: Integer);
begin
  if (FTZoneHour <> cINITNUMBER) and (Value <> FTZoneHour) and (not FLoading) then FKepletInfoChanged := true;
  FTZoneHour := Value;
end;

procedure TSzuletesiKepletInfo.SetTZoneMinute(const Value: word);
begin
  if (FTZoneMinute <> cINITNUMBER) and (Value <> FTZoneMinute) and (not FLoading) then FKepletInfoChanged := true;
  FTZoneMinute := Value;
end;

constructor TTimeZoneInfo.Create;
begin
  inherited Create;
  FTimeZoneCode := '';
  FDisplayName := '';
  FDelta := 0;
  FGroup := '';
  FTZType := '';
end;

function TTimeZoneInfo.GetDeltaAsString: string;
begin
  Result := FloatToStr(DeltaHour) + ':' + PaddL(FloatToStr(DeltaMinute), 2, '0');
end;

function TTimeZoneInfo.GetDeltaHour: Double;
begin
  Result := Round(FDelta) div 100;
end;

function TTimeZoneInfo.GetDeltaMinute: Double;
begin
  Result := Abs(Round(FDelta) mod 100);
end;

constructor TCalcResult.Create;
begin
  inherited Create;
  EclipticObliquity := 0;

  FPlanetList := TPlanetList.Create();
  FHouseCuspList := THouseList.Create();
  FAxisList := TAxisList.Create();
  FAspectList := TAspectInfoList.Create();
  FSelfMarkerList := TSelfMarkerList.Create();
  UniversalTime := 0;
  SideralTime := 0;
  Ayanamsa := 0;
  ASC_PointValue := 0;

  FillChar(matrJartJaratlanPontszam, sizeof(matrJartJaratlanPontszam), #0);
  SetLength(utJartUt, 0);
  SetLength(utJaratlanUt, 0);
end;

destructor TCalcResult.Destroy;
begin
//  FreeAndNil(FSelfMarkerList);
  FreeAndNil(FAspectList);
  FreeAndNil(FAxisList);
  FreeAndNil(FHouseCuspList);
  FreeAndNil(FPlanetList);
  inherited Destroy;
end;

constructor TPlanet.Create;
begin
  inherited Create;
  FPlanetID := -1;
  FDec := 0;
  FRA := 0;
  FSpeed := 0;
  FHouseNumber := 0;
  FHouseLordsContainer := THouseLordsContainer.Create();
end;

destructor TPlanet.Destroy;
begin
  FreeAndNil(FHouseLordsContainer);
  inherited Destroy;
end;

function TPlanet.GetInZodiacSign: Integer;
begin
  Result := (Round(Int(FRA)) div 30){ + 1{};
end;

function TPlanet.GetPlanetName: string;
//var pPlanetName : TsErr;
var objPlanetNameProvider : TPlanetConstInfoProvider;
begin
  Result := '';

  try
    objPlanetNameProvider := TPlanetConstInfoProvider.Create;
    Result := objPlanetNameProvider.sPlanetName(FPlanetID);
  finally
    FreeAndNil(objPlanetNameProvider);
  end;
{
  //swe_get_planet_name(FPlanetID, pPlanetName);

  if FPlanetID <> -1 then // azaz van ID megadva
    Result := cPLANETLIST[FPlanetID].sPlanetName;
{}
end;

function TPlanet.GetRetrograd: Boolean;
begin
  Result := FSpeed < 0; // ekkor retrograd a mozgás
end;

function TPlanet.GetStartDegree: Double;
begin
  Result := FRA - ((Round(Int(FRA)) div 30) * 30);
end;

procedure TPlanetList.AddNewPlanetInfo(APlanetID: integer; ARA, ADec, ASpeed: Double);
var oPlanet : TPlanet;
    bAdd : boolean;
begin
  bAdd := true;

  if not IsPlanetInList(APlanetID) then
    oPlanet := TPlanet.Create
  else
    begin
      oPlanet := GetPlanetInfo(APlanetID);
      bAdd := false;
    end;
    
  oPlanet.PlanetID := APlanetID;
  oPlanet.RA  := ARA;
  oPlanet.Dec := ADec;
  oPlanet.Speed := ASpeed;

  if bAdd then
    Add(oPlanet);

  if APlanetID = SE_MEAN_NODE{SE_TRUE_NODE{} then
    begin // Felszálló holdcsomó párját megadjuk...
      if bAdd then
        oPlanet := TPlanet.Create
      else
        oPlanet := GetPlanetInfo(SE_TRUE_MEAN_NODE_DOWN);
        
      oPlanet.PlanetID := SE_TRUE_MEAN_NODE_DOWN;
      oPlanet.RA := AddFokSzam(ARA, 180);
      oPlanet.Dec := ADec;
      oPlanet.Speed := ASpeed;

      if bAdd then
        Add(oPlanet); 
    end;
end;

function TPlanetList.GetPlanet(AItemIDX: integer): TPlanet;
begin
  Result := nil;

  if AItemIDX <= Count - 1 then
    Result := TPlanet(Items[AItemIDX]);
end;

function TPlanetList.GetPlanetInfo(APlanetID: integer): TPlanet;
var i : integer;
begin
  Result := nil;

  i := 0;
  while (i <= Count - 1) and (Result = nil) do
    begin
      if TPlanet(Items[i]).PlanetID = APlanetID then
        Result := TPlanet(Items[i]);
      inc(i);
    end;
end;

function TPlanetList.IsPlanetInList(APlanetID: integer): Boolean;
begin
  Result := Assigned(GetPlanetInfo(APlanetID));
end;

function THouseCusp.GetInZodiacSign: Integer;
begin
  Result := (Round(Int(FRA)) div 30){ + 1{};
end;

function THouseCusp.GetStartDegree: Double;
begin
  Result := FRA - ((Round(Int(FRA)) div 30) * 30);
end;

procedure THouseList.AddNewHouseCuspInfo(AHouseNum: integer; ARA: Double);
var oHouseCusp : THouseCusp;
    bAdd : boolean;
begin
  bAdd := true;

  if not IsHouseInList(AHouseNum) then
    oHouseCusp := THouseCusp.Create
  else
    begin
      oHouseCusp := GetHouseCuspInfo(AHouseNum);
      bAdd := false;
    end;
    
  oHouseCusp.RA := ARA;
  oHouseCusp.HouseNumber := AHouseNum;

  if bAdd then
    Add(oHouseCusp);
end;

function THouseList.GetHouseCuspInfo(AHouseNum: integer): THouseCusp;
var i : integer;
begin
  Result := nil;

  i := 0;
  while (i <= Count - 1) and (Result = nil) do
    begin
      if THouseCusp(Items[i]).HouseNumber = AHouseNum then
        Result := THouseCusp(Items[i]);
      inc(i);
    end;
end;

function THouseList.IsHouseInList(AHouseNum: integer): Boolean;
begin
  Result := Assigned(GetHouseCuspInfo(AHouseNum));
end;

procedure TAxisList.AddNewAxisInfo(AAxisID: integer; ARA: Double);
var oAxis : TAxis;
    bAdd : boolean;
begin
  bAdd := true;
  if not IsAxisInList(AAxisID) then
    oAxis := TAxis.Create
  else
    begin
      oAxis := GetAxisInfo(AAxisID);
      bAdd := false;
    end;
    
  oAxis.RA := ARA;
  oAxis.AxisID := AAxisID;

  if bAdd then
    Add(oAxis);
end;

function TAxisList.GetAxisInfo(AAxisID: integer): TAxis;
var i : integer;
begin
  Result := nil;

  i := 0;
  while (i <= Count - 1) and (Result = nil) do
    begin
      if TAxis(Items[i]).AxisID = AAxisID then
        Result := TAxis(Items[i]);
      inc(i);
    end;
end;

function TAxisList.IsAxisInList(AAxisID: integer): Boolean;
begin
  Result := Assigned(GetAxisInfo(AAxisID));
end;

function TAxis.GetInZodiacSign: Integer;
begin
  Result := (Round(Int(FRA)) div 30){ + 1{};
end;

function TAxis.GetStartDegree: Double;
begin
  Result := FRA - ((Round(Int(FRA)) div 30) * 30);
end;

constructor TSzulKepletFormInfo.Create;
begin
  inherited Create;
  FCalcResult := nil;
  FSzuletesiKepletInfo := nil;
end;

procedure TAspectInfoList.AddNewAspectInfo(AAspect01ID: integer; AAspect01Type: TAspectType; AAspect02ID: integer;
    AAspect02Type: TAspectType; AAspectID: integer; AAspectQualityType: TAspectQualityType);
var objAspectInfo : TAspectInfo;
begin
  if not IsAspectInList(AAspect01ID, AAspect01Type, AAspect02ID, AAspect02Type, AAspectID, AAspectQualityType) then
    begin
      objAspectInfo := TAspectInfo.Create;
      objAspectInfo.Aspect01ID   := AAspect01ID;
      objAspectInfo.Aspect01Type := AAspect01Type;
      objAspectInfo.Aspect02ID   := AAspect02ID;
      objAspectInfo.Aspect02Type := AAspect02Type;
      objAspectInfo.AspectID     := AAspectID;
      objAspectInfo.AspectQuality:= AAspectQualityType;

      Add(objAspectInfo);
    end;
end;

function TAspectInfoList.GetAspectInfo(AIdx: integer): TAspectInfo;
begin
  Result := nil;
  if AIdx <= Count - 1 then
    Result := TAspectInfo(Items[AIdx]);
end;

function TAspectInfoList.IsAspectInList(AAspect01ID: integer; AAspect01Type: TAspectType; AAspect02ID: integer;
    AAspect02Type: TAspectType; AAspectID: integer; AAspectQualityType: TAspectQualityType): Boolean;
var i : integer;
    objAspectInfo : TAspectInfo;
begin
  Result := false;
  i := 0;

  while (i <= Count - 1) and (not Result) do
    begin
      objAspectInfo := GetAspectInfo(i);
      if Assigned(objAspectInfo) then
        begin
          if (AAspectID = objAspectInfo.AspectID)
             and
             (
               ((AAspect01ID = objAspectInfo.Aspect01ID) and (AAspect01Type = objAspectInfo.Aspect01Type))
               or
               ((AAspect01ID = objAspectInfo.Aspect02ID) and (AAspect01Type = objAspectInfo.Aspect02Type))
             )
             and
             (
               ((AAspect02ID = objAspectInfo.Aspect01ID) and (AAspect02Type = objAspectInfo.Aspect01Type))
               or
               ((AAspect02ID = objAspectInfo.Aspect02ID) and (AAspect02Type = objAspectInfo.Aspect02Type))
             ) then
            Result := true;
        end;
      inc(i);
    end;
end;

constructor TAspectInfo.Create;
begin
  inherited Create;
  FAspect01ID   := -1;
  FAspect01Type := tasc_None;
  FAspect02ID   := -1;
  FAspect02Type := tasc_None;
  FAspectID     := -1;
  FAspectQuality := taqu_None;
end;

procedure TSelfMarkerList.AddNewSelfMarker(ASelfMarker: TObject);
var objMarker : TObject;
begin
  objMarker := nil;
  
  if ASelfMarker is THouseCusp then
    begin
      objMarker := THouseCusp.Create;

      THouseCusp(objMarker).HouseNumber := THouseCusp(ASelfMarker).HouseNumber;
      THouseCusp(objMarker).RA := THouseCusp(ASelfMarker).RA;
    end
  else
    if ASelfMarker is TPlanet then
      begin
        objMarker := TPlanet.Create;

        TPlanet(objMarker).Dec := TPlanet(ASelfMarker).Dec;
        TPlanet(objMarker).HouseNumber := TPlanet(ASelfMarker).HouseNumber;
        TPlanet(objMarker).PlanetID := TPlanet(ASelfMarker).PlanetID;
        TPlanet(objMarker).RA := TPlanet(ASelfMarker).RA;
        TPlanet(objMarker).Speed := TPlanet(ASelfMarker).Speed;
      end
    else
      if ASelfMarker is TZodiacSignForSelfMarkers then
        begin
          objMarker := TZodiacSignForSelfMarkers.Create;

          TZodiacSignForSelfMarkers(objMarker).RA := TZodiacSignForSelfMarkers(ASelfMarker).RA;
          TZodiacSignForSelfMarkers(objMarker).SignID := TZodiacSignForSelfMarkers(ASelfMarker).SignID;
        end;
    
  //if not IsSelfMarkerInList(ASelfMarker) then
  //  Add(ASelfMarker);
  if not IsSelfMarkerInList(objMarker) then
    Add(objMarker);
end;

function TSelfMarkerList.GetSelfMarker(AIdx: integer): TObject;
begin
  Result := nil;
  if AIdx <= Count - 1 then
    Result := Items[AIdx];
end;

function TSelfMarkerList.IsSelfMarkerInList(ASelfMarker: TObject): Boolean;
var i, sPlanetID, tPlanetID : integer;
    objSelfMarker: TObject;
begin
  Result := false;
  i := 0;

  if ASelfMarker is TPlanet then
    begin
      while (i <= Count - 1) and (not Result) do
        begin
          objSelfMarker := GetSelfMarker(i);

          if Assigned(objSelfMarker) then
            begin
              sPlanetID := TPlanet(objSelfMarker).PlanetID;
              tPlanetID := TPlanet(ASelfMarker).PlanetID;

              //if objSelfMarker = ASelfMarker then
              if sPlanetID = tPlanetID then
                Result := true;
            end;
          inc(i);
        end;
    end;
end;

function THouseLordsContainer.GetHouseNumberTexts: string;
const cSEP = ',';
var i : integer;
begin
  Result := '';

  for i := cHSN_House01 to cHSN_House12 do
    begin
      if i in FClosedHouseNumbers then
        Result := Result + '(' + IntToStr(i) + ')' + cSEP
      else
        if i in FNormalHouseNumbers then
          Result := Result + IntToStr(i) + cSEP;
    end;

  delete(Result, Length(Result), 1);
end;

constructor TRegistrationSettings.Create;
begin
  inherited Create;
  FRegistered := False;
  FRegName := 'Nincs regisztrálva';
  FRegEmail := '';
  FRegState := regAll;

  ReadRegistrationInfo;
end;

function TRegistrationSettings.GetRegistered: Boolean;
begin
  Result := FRegistered;
end;

procedure TRegistrationSettings.ReadRegistrationInfo;
begin
  FRegistered := TRUE; //
end;

constructor TSorOszlopType.Create;
begin
  inherited Create;
  SO_ID := 0;
  SO_Value := 0;
end;

constructor TSorOszlopList.Create(AOwnsObjects, AMaxKereses: Boolean);
begin
  inherited Create(AOwnsObjects);
  FMaxKereses := AMaxKereses;
end;

procedure TSorOszlopList.AddNewItem(AID, AValue: Integer);
var i : integer;
    objItem : TSorOszlopType;
    bBerakhato, bClear : boolean;
begin
  bBerakhato := false; bClear := false;

  for i := 0 to Count - 1 do
    begin
      objItem := GetItem(i);
      case FMaxKereses of
      true : begin
               bBerakhato := AValue >= objItem.SO_Value;
               bClear := AValue > objItem.SO_Value;
             end;  
      false: begin
               bBerakhato := AValue <= objItem.SO_Value;
               bClear := AValue < objItem.SO_Value;
             end;
      end;
    end;

  if Count = 0 then bBerakhato := true;

  if bBerakhato then
    begin
      if bClear then Self.Clear;

      objItem := TSorOszlopType.Create;
      objItem.SO_ID := AID;
      objItem.SO_Value := AValue;

      Add(objItem);
    end;
end;

function TSorOszlopList.GetItem(AIdx: Integer): TSorOszlopType;
begin
  Result := TSorOszlopType(Items[AIdx]);
end;

constructor TLastOpenedFiles.Create;
begin
  inherited Create;
  FOpenedFilesContainer := TStringList.Create();
  FRegistry := TRegistry.Create();
  FOpenedFilesContainer.Sorted := false;
  ReadLastOpenedFilesFromRegistry;
  FMaxOpenedCount := 10;
end;

destructor TLastOpenedFiles.Destroy;
begin
  WriteLastOpenedFilesToRegistry;
  FRegistry.Free;
  FreeAndNil(FOpenedFilesContainer);
  inherited Destroy;
end;

procedure TLastOpenedFiles.AddOpenedFileName(AFileNamePath: string);
begin
  if (Trim(AFileNamePath) <> '') and (FOpenedFilesContainer.IndexOf(Trim(AFileNamePath)) = -1) then
    begin
      if (FOpenedFilesContainer.Count >= FLastOpenedCount) and (FOpenedFilesContainer.Count <> 0) then
        FOpenedFilesContainer.Delete(FOpenedFilesContainer.Count - 1); // egy sort szimulálunk...
      if FLastOpenedCount <> 0 then
        FOpenedFilesContainer.Insert(0, AFileNamePath);
    end;
end;

function TLastOpenedFiles.GetLastOpenedFiles: string;
var i : integer;
begin
  Result := '';
  ReadLastOpenedFilesFromRegistry;

  for i := 0 to FOpenedFilesContainer.Count - 1 do
    Result := Result + FOpenedFilesContainer.Strings[i] + ';';

  if Length(Result) > 0 then
    delete(Result, Length(Result), 1);
end;

procedure TLastOpenedFiles.ReadLastOpenedFilesFromRegistry;
var i : integer;
    sValue : string;
begin
  if FOpenedFilesContainer.Count > 0 then
    WriteLastOpenedFilesToRegistry;

  FOpenedFilesContainer.Clear;

  FRegistry.RootKey := HKEY_CURRENT_USER;
  if FRegistry.OpenKey(cREG_KEYLASTOPENEDFILES, true) then
    begin
      for i := Min(FLastOpenedCount, FMaxOpenedCount) downto 1 do
        begin
          try
            sValue := FRegistry.ReadString(cREG_PREFIX_LASTOPENED + PaddL(IntToStr(i), 2, '0'));
            if Trim(sValue) <> '' then
              AddOpenedFileName(sValue);
          except
          end;
        end;
      FRegistry.CloseKey;
    end;
end;

procedure TLastOpenedFiles.SetLastOpenedCount(const Value: Integer);
begin
  FLastOpenedCount := Min(Value, FMaxOpenedCount);
end;

procedure TLastOpenedFiles.WriteLastOpenedFilesToRegistry;
var i : integer;
    sValue : string;
begin
  FRegistry.RootKey := HKEY_CURRENT_USER;
  FRegistry.DeleteKey(cREG_KEYLASTOPENEDFILES);
  if FRegistry.OpenKey(cREG_KEYLASTOPENEDFILES, true) then
    begin
      for i := 0 to Min(Min(FOpenedFilesContainer.Count, FLastOpenedCount), FMaxOpenedCount) - 1 do
        begin
          try
            sValue := FOpenedFilesContainer.Strings[i];
            if Trim(sValue) <> '' then
              FRegistry.WriteString(cREG_PREFIX_LASTOPENED + PaddL(IntToStr(i + 1), 2, '0'), sValue);
          except
          end;
        end;
      FRegistry.CloseKey;
    end;
end;

procedure TLastOpenedFiles.RemoveOpenedFileName(AFileNamePath: string);
begin
  if (Trim(AFileNamePath) <> '') and (FOpenedFilesContainer.IndexOf(Trim(AFileNamePath)) <> -1) then
    begin
      FOpenedFilesContainer.Delete(FOpenedFilesContainer.IndexOf(Trim(AFileNamePath)));
    end;
end;

constructor TZodiacSignForSelfMarkers.Create;
begin
  inherited Create;
  FRA := 0;
  FSignID := 0;
end;

end.
