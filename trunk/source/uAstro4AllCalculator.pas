{
  Képlet adatok számítása és alapinfó szolgáltatás
}

unit uAstro4AllCalculator;

interface

uses SysUtils, uAstro4AllFileHandling, uAstro4AllTypes;

type
  //# A betöltött adatokból kérdezhetünk le vele információkat
  TDataSetInfoProvider = class(TObject)
  private
    FDataSetLoader: TDataSetLoader;
  public
    constructor Create;
    destructor Destroy; override;
    function GetCountryFromCountryID(ACountryID: string): string;
    function GetCountryIDFromCityName(ACityName: string): string;
    function GetTimeZoneIDFromCityName(ACityName: string): string;
    function GetTimeZoneIDFromCountry(ACountryID: string): string;
    function GetTimeZoneInfo(ATimeZoneID: string): TTimeZoneInfo;
    function IsDaylightSavingTimeOnDate(ADatum: TDateTime; ACountryID: string): Boolean;
    property DataSetLoader: TDataSetLoader read FDataSetLoader;
  end;

  TBaseCalculator = class(TObject)
  private
    FDataSetInfoProvider: TDataSetInfoProvider;
    FSettingsProvider: TSettingsProvider;
    procedure CalcAspects;
    procedure CalcHouseLords;
    procedure CalcPlanetsInHouses;
    procedure CalcSelfMarkers;
    procedure CalcWalkedUnWalkedPath;
    //function GetARMCTime: Double;
    function GetJulianDateET: Double;
    function GetJulianDateUT: Double;
    function GetSideralTime: Double;
  public
    FSzulKepletInfo: TSzuletesiKepletInfo;
    FCalcResult: TCalcResult;
    constructor Create(ADataSetInfoProvider: TDataSetInfoProvider; ASettingsProvider: TSettingsProvider);
    procedure CalcHouseCusps; virtual; abstract;
    procedure CalcPlanetsPosition; virtual; abstract;
    procedure CalculateOtherInformations;
    procedure DoCalculate(ASzulKepletInfo: TSzuletesiKepletInfo);
    function GetEclipticObliquity: Double;
    function GetGMTFromBirthDateTime: TDateTime;
  end;

  //# Swiss Ephemerides Calculator
  TSWECalculator = class(TBaseCalculator)
  public
    procedure CalcHouseCusps; override;
    procedure CalcPlanetsPosition; override;
  end;

  //# Napkelte, napnyugta
  TSunRiseSunSet = class(TObject)
  end;

  TDrakonikusCalculator = class(TSWECalculator)
  public
    procedure DoCalculateDraconicTimeAndDate(ASzulKepletInfo: TSzuletesiKepletInfo);
  end;

implementation

uses Math, Variants, DateUtils, DB, swe_de32, uAstro4AllConsts, uSegedUtils,
  Classes, Contnrs;

constructor TDataSetInfoProvider.Create;
begin
  inherited Create;
  FDataSetLoader := TDataSetLoader.Create();
end;

destructor TDataSetInfoProvider.Destroy;
begin
  FreeAndNil(FDataSetLoader);
  inherited Destroy;
end;

function TDataSetInfoProvider.GetCountryFromCountryID(ACountryID: string): string;
begin
  Result := '';

  if FDataSetLoader.CountryLoader.DataSet.Locate(cDS_COUNTRY_CountryCode, ACountryID, []) then
    Result := VarToStr(FDataSetLoader.CountryLoader.DataSet[cDS_COUNTRY_DisplayName]);
end;

function TDataSetInfoProvider.GetCountryIDFromCityName(ACityName: string): string;
var iCityID : integer;
begin
  Result := '';

  iCityID := FDataSetLoader.CityLoader.GetCityRecID(ACityName);
  if iCityID <> -1 then
    if FDataSetLoader.CityLoader.DataSetForSearch.Locate('RecID', iCityID, []) then
      Result := VarToStr(FDataSetLoader.CityLoader.DataSetForSearch[cDS_CITY_CountryCode]);
end;

function TDataSetInfoProvider.GetTimeZoneIDFromCityName(ACityName: string): string;
var iCityID : integer;
begin
  Result := '';

  if Trim(ACityName) <> '' then
    begin
      iCityID := FDataSetLoader.CityLoader.GetCityRecID(ACityName);
      if iCityID <> -1 then
        if FDataSetLoader.CityLoader.DataSetForSearch.Locate('RecID', iCityID, []) then
          Result := VarToStr(FDataSetLoader.CityLoader.DataSetForSearch[cDS_CITY_TimeZoneCode]);
    end;
end;

function TDataSetInfoProvider.GetTimeZoneIDFromCountry(ACountryID: string): string;
begin
  Result := '';

  if Trim(ACountryID) <> '' then
    if FDataSetLoader.CountryLoader.DataSet.Locate(cDS_COUNTRY_CountryCode, ACountryID, []) then
      Result := VarToStr(FDataSetLoader.CountryLoader.DataSet[cDS_COUNTRY_TimeZoneCode]);
end;

function TDataSetInfoProvider.GetTimeZoneInfo(ATimeZoneID: string): TTimeZoneInfo;
begin
  Result := nil;

  if Trim(ATimeZoneID) = '' then
    ATimeZoneID := 'GMT'; // GreenwichMeanTime 

  if DataSetLoader.TimeZoneLoader.DataSet.Locate(cDS_TZONE_TimeZoneCode, ATimeZoneID, [loCaseInsensitive]) then
    begin
      Result := TTimeZoneInfo.Create;

      Result.TimeZoneCode := DataSetLoader.TimeZoneLoader.DataSet[cDS_TZONE_TimeZoneCode];
      Result.DisplayName  := DataSetLoader.TimeZoneLoader.DataSet[cDS_TZONE_DisplayName];
      Result.Delta        := DataSetLoader.TimeZoneLoader.DataSet[cDS_TZONE_Delta];
      Result.Group        := DataSetLoader.TimeZoneLoader.DataSet[cDS_TZONE_Group];
      Result.TZType       := DataSetLoader.TimeZoneLoader.DataSet[cDS_TZONE_Type];
    end;
end;

function TDataSetInfoProvider.IsDaylightSavingTimeOnDate(ADatum: TDateTime; ACountryID: string): Boolean;
var dDatumTol, dDatumIg : TDateTime;
begin
  Result := false;

  // DoubleSummerTime... http://www.timeanddate.com/worldclock/timezone.html?n=136&syear=1925

  FDataSetLoader.CestLoader.DataSet.First;
  if FDataSetLoader.CestLoader.DataSet.Locate(cDS_CEST_CountryCode, ACountryID, [loCaseInsensitive]) then
    begin
      while (not FDataSetLoader.CestLoader.DataSet.Eof) and
            (FDataSetLoader.CestLoader.DataSet[cDS_CEST_CountryCode] = ACountryID) and
            (not Result) do
        begin
          // formátum pl.: ;H;1941;04;6;01:59:59;1942;11;2;02:59:59
          TryOwnEncodeDateTime
            (
              StrToInt(VarToStr(FDataSetLoader.CestLoader.DataSet[cDS_CEST_EVTOL])),
              StrToInt(VarToStr(FDataSetLoader.CestLoader.DataSet[cDS_CEST_HOTOL])),
              StrToInt(VarToStr(FDataSetLoader.CestLoader.DataSet[cDS_CEST_NAPTOL])),
              GetReszletFromCESTIdopont(tcOra, VarToStr(FDataSetLoader.CestLoader.DataSet[cDS_CEST_ORATOL])),
              GetReszletFromCESTIdopont(tcPerc, VarToStr(FDataSetLoader.CestLoader.DataSet[cDS_CEST_ORATOL])),
              GetReszletFromCESTIdopont(tcMP, VarToStr(FDataSetLoader.CestLoader.DataSet[cDS_CEST_ORATOL])),
              0,
              dDatumTol
            );

          TryOwnEncodeDateTime
            (
              StrToInt(VarToStr(FDataSetLoader.CestLoader.DataSet[cDS_CEST_EVIG])),
              StrToInt(VarToStr(FDataSetLoader.CestLoader.DataSet[cDS_CEST_HOIG])),
              StrToInt(VarToStr(FDataSetLoader.CestLoader.DataSet[cDS_CEST_NAPIG])),
              GetReszletFromCESTIdopont(tcOra, VarToStr(FDataSetLoader.CestLoader.DataSet[cDS_CEST_ORAIG])),
              GetReszletFromCESTIdopont(tcPerc, VarToStr(FDataSetLoader.CestLoader.DataSet[cDS_CEST_ORAIG])),
              GetReszletFromCESTIdopont(tcMP, VarToStr(FDataSetLoader.CestLoader.DataSet[cDS_CEST_ORAIG])),
              0,
              dDatumIg
            );

          if (ADatum >= dDatumTol) and (ADatum < dDatumIg) then
            Result := true;

          FDataSetLoader.CestLoader.DataSet.Next;
        end;
    end;
end;

constructor TBaseCalculator.Create(ADataSetInfoProvider: TDataSetInfoProvider; ASettingsProvider: TSettingsProvider);
begin
  inherited Create;
  FDataSetInfoProvider := ADataSetInfoProvider;
  FCalcResult := nil;
  FSzulKepletInfo := nil;
  FSettingsProvider := ASettingsProvider;
end;

procedure TBaseCalculator.CalcAspects;

  function GetPlanetOrAxisAspectQualityType(AObj01RA, AObj02RA: Double; ADeg, AOrb: double) : TAspectQualityType;
  var iSourceDeg, iDestDeg : double;
      iAspPlusDeg, iAspNegDeg: double;
      iDiffDeg : double;
  begin
    Result := taqu_None;

    iSourceDeg := AObj01RA;
    iDestDeg := AObj02RA;

    if iDestDeg < iSourceDeg then
      iDestDeg := iDestDeg + 360;

    // Plusz / Minusz irány az orbisszal
    iAspPlusDeg := ADeg + AOrb;
    iAspNegDeg := ADeg - AOrb;

    // Két pont közti különbség
    iDiffDeg := iDestDeg - iSourceDeg;

    if iDiffDeg = ADeg then
      begin
        Result := taqu_Exact;
      end
    else
      begin
        if (iDiffDeg >= iAspNegDeg) and (iDiffDeg <= iAspPlusDeg) then
          Result := taqu_Other;
      end;
  end;

var i, j, k : integer;
    oPlanet01, oPlanet02 : TPlanet;
    oAxis01 : TAxis;
    oHouseCusp : THouseCusp;
    aqType : TAspectQualityType;
    dOrb : Double;
begin
  // Fényszögek
  FCalcResult.AspectList.Clear;

  for i := SE_SUN to SE_VESTA{SE_TRUE_NODE{} do
    begin
      if i in [SE_SUN..SE_VESTA{SE_PLUTO{}{, SE_MEAN_NODE{}] then
        begin
          oPlanet01 := FCalcResult.PlanetList.GetPlanetInfo(i);
          if Assigned(oPlanet01) then
            begin
              for j := SE_SUN to SE_VESTA{SE_PLUTO{} {SE_TRUE_NODE{} do
                if (i <> j) and (j in [SE_SUN..SE_VESTA{SE_PLUTO{}{, SE_MEAN_NODE{}]) then // saját magát azé' csak máá ne
                  begin
                    for k := cFSZ_EGYUTTALLAS to cFSZ_2OTODFENY do
                      begin
                        oPlanet02 := FCalcResult.PlanetList.GetPlanetInfo(j);
                        if Assigned(oPlanet02) then
                          begin
                            dOrb := cFENYSZOGSETTINGS[k].iOrb;
                            
                            if k = cFSZ_EGYUTTALLAS then
                              if (oPlanet01.HouseNumber <> oPlanet02.HouseNumber) or (oPlanet01.InZodiacSign <> oPlanet02.InZodiacSign) then
                                dOrb := Round(dOrb) / 2;

                            aqType := GetPlanetOrAxisAspectQualityType(oPlanet01.RA, oPlanet02.RA, cFENYSZOGSETTINGS[k].iDeg, dOrb);
                            if aqType <> taqu_None then
                              FCalcResult.AspectList.AddNewAspectInfo(oPlanet01.PlanetID, tasc_Planet, oPlanet02.PlanetID, tasc_Planet, k, aqType);
                          end;
                      end;
                  end;

              // és itt a tengelyeken is mehetnénk... amikhez a fényszögeket megnézhetnénk...
              for j := 0 to FCalcResult.AxisList.Count - 1 do
                begin
                  if FCalcResult.AxisList.GetAxisInfo(j).AxisID in [SE_ASC..SE_NASCMC] then
                    for k := cFSZ_EGYUTTALLAS to cFSZ_2OTODFENY do
                      begin
                        oAxis01 := FCalcResult.AxisList.GetAxisInfo(j);
                        if Assigned(oAxis01) then
                          begin
                            aqType := GetPlanetOrAxisAspectQualityType(oPlanet01.RA, oAxis01.RA, cFENYSZOGSETTINGS[k].iDeg, cFENYSZOGSETTINGS[k].iOrb);
                            if aqType <> taqu_None then
                              FCalcResult.AspectList.AddNewAspectInfo(oPlanet01.PlanetID, tasc_Planet, oAxis01.AxisID, tasc_Axis, k, aqType);
                          end;
                      end;
                end;

              // és itt pedig a házak... 
              for j := 0 to FCalcResult.HouseCuspList.Count - 1 do
                begin
                  if FCalcResult.HouseCuspList.GetHouseCuspInfo(j).HouseNumber in ([cHSN_House01..cHSN_House12] - [cHSN_House01, cHSN_House10]) then
                    for k := cFSZ_EGYUTTALLAS to cFSZ_2OTODFENY do
                      begin
                        oHouseCusp := FCalcResult.HouseCuspList.GetHouseCuspInfo(j);
                        if Assigned(oHouseCusp) then
                          begin
                            aqType := GetPlanetOrAxisAspectQualityType(oPlanet01.RA, oHouseCusp.RA, cFENYSZOGSETTINGS[k].iDeg, cFENYSZOGSETTINGS[k].iOrb);
                            if aqType <> taqu_None then
                              FCalcResult.AspectList.AddNewAspectInfo(oPlanet01.PlanetID, tasc_Planet, oHouseCusp.HouseNumber, tasc_HouseCusp, k, aqType);
                          end;
                      end;
                end;
              (**)
            end;
        end;
    end;
end;

procedure TBaseCalculator.CalcHouseLords;
var i, j, k, l, iLastHouseNum, iCnt : integer;
    objPlanet : TPlanet;
    iInZodiacSet, iSetResult : set of byte;
begin
  // Házurak kiszámítása...

  for i := SE_SUN to SE_PLUTO do
    begin
      objPlanet := FCalcResult.PlanetList.GetPlanetInfo(i);
      objPlanet.FHouseLordsContainer.FClosedHouseNumbers := [];
      objPlanet.FHouseLordsContainer.FNormalHouseNumbers := [];

      for j := low(cZODIACANDPLANETLETTERS) to high(cZODIACANDPLANETLETTERS) do
        if cZODIACANDPLANETLETTERS[j].iPlanetID = objPlanet.PlanetID then
          begin
            iSetResult := [];
            iInZodiacSet := [];
            iInZodiacSet := iInZodiacSet + [cZODIACANDPLANETLETTERS[j].iZodiacID];

            for k := 0 to FCalcResult.HouseCuspList.Count - 1 do
              if THouseCusp(FCalcResult.HouseCuspList.Items[k]).HouseNumber in [cHSN_House01..cHSN_House12] then
                if THouseCusp(FCalcResult.HouseCuspList.Items[k]).InZodiacSign in iInZodiacSet then
                  begin
                    iSetResult := iSetResult + [THouseCusp(FCalcResult.HouseCuspList.Items[k]).HouseNumber];
                  end;

            if iSetResult <> [] then
              begin // Nem bezárt
                objPlanet.FHouseLordsContainer.FNormalHouseNumbers :=
                  objPlanet.FHouseLordsContainer.FNormalHouseNumbers + iSetResult;
              end
            else
              begin // Bezárt jegy... Melyik ház kezdõdik az "iInZodiacSet" elemben
                iLastHouseNum := -1;
                iCnt := 1;
                
                repeat
                  for l := 0 to FCalcResult.HouseCuspList.Count - 1 do
                    if THouseCusp(FCalcResult.HouseCuspList.Items[l]).HouseNumber in [cHSN_House01..cHSN_House12] then
                      if THouseCusp(FCalcResult.HouseCuspList.Items[l]).InZodiacSign = Round(IncPeriodValue(cZODIACANDPLANETLETTERS[j].iZodiacID, -iCnt, cZDS_Kos, cZDS_Halak)) then
                        if (THouseCusp(FCalcResult.HouseCuspList.Items[l]).HouseNumber > iLastHouseNum) and (iLastHouseNum <> 1) then
                          iLastHouseNum := THouseCusp(FCalcResult.HouseCuspList.Items[l]).HouseNumber;
                  inc(iCnt);
                until iLastHouseNum <> -1;

                if iLastHouseNum <> -1 then
                  objPlanet.FHouseLordsContainer.FClosedHouseNumbers :=
                    objPlanet.FHouseLordsContainer.FClosedHouseNumbers + [iLastHouseNum];
              end;
          end;
    end;

end;

procedure TBaseCalculator.CalcPlanetsInHouses;
var i, j, k : integer;
    iStartDeg, iEndDeg : Double;
    oPlanetInfo : TPlanet;
    oHouseInfo : THouseCusp;
    bOK : boolean;
begin
  for i := 0 to FCalcResult.PlanetList.Count - 1 do
    begin
      oPlanetInfo := TPlanet(FCalcResult.PlanetList.GetPlanet(i));

      bOK := false;
      j := 1;
      while (j <= FCalcResult.HouseCuspList.Count - 1) and (not bOK) do
        begin
          oHouseInfo := THouseCusp(FCalcResult.HouseCuspList.GetHouseCuspInfo(j));

          iStartDeg := THouseCusp(FCalcResult.HouseCuspList.GetHouseCuspInfo(j)).RA;
          if j = FCalcResult.HouseCuspList.Count - 1 then k := 1 else k := j + 1;
          iEndDeg := THouseCusp(FCalcResult.HouseCuspList.GetHouseCuspInfo(k)).RA;

          if IsBetweenDeg(oPlanetInfo.RA, iStartDeg, iEndDeg) then
            begin
              oPlanetInfo.HouseNumber := oHouseInfo.HouseNumber;
              bOK := true;
            end;

          inc(j);
        end;
    end;
end;

procedure TBaseCalculator.CalcSelfMarkers;
var i, iCnt, iEnd : integer;
    iStartHouse01, iStartHouse02 : integer;
    objZodSignSelfMarker : TZodiacSignForSelfMarkers;
begin
  // Énjelölõk
  {
    ASC, ASC analóg planétája = Szül.uralkodó, ASC és a vele 1,5°-on belül álló planéta
    1. házban található planéták
    az 1. házba bezárt zodiákus jegy(ek) és analóg planéta(i)
    Nap, Nap és a vele együtt álló 7,5°-on belüli planéta
    Hold
  }

  FCalcResult.SelfMarkerList.Clear;

  // Nap, és a vele együtt 7,5°-on belül álló planéta...
  FCalcResult.SelfMarkerList.AddNewSelfMarker(FCalcResult.PlanetList.GetPlanetInfo(SE_SUN));
  // Hold
  FCalcResult.SelfMarkerList.AddNewSelfMarker(FCalcResult.PlanetList.GetPlanetInfo(SE_MOON));

  // ASC
  FCalcResult.SelfMarkerList.AddNewSelfMarker(FCalcResult.HouseCuspList.GetHouseCuspInfo(1));
  // ASC analóg planéta, szül. uralkodó
  FCalcResult.SelfMarkerList.AddNewSelfMarker(FCalcResult.PlanetList.GetPlanetInfo(cZODIACANDPLANETLETTERS[FCalcResult.HouseCuspList.GetHouseCuspInfo(1).InZodiacSign].iPlanetID));

  // ASC és a vele 1,5°-on belül álló planéta
  // 1. házban található planéták ---- ebbe benne lesz az elõzõ is, ill a 12. ház nem!!! :(
  for i := 0 to FCalcResult.PlanetList.Count - 1 do
    begin
      if (FCalcResult.PlanetList.GetPlanet(i).HouseNumber = 1) and (FCalcResult.PlanetList.GetPlanet(i).PlanetID in [SE_SUN..SE_PLUTO]) then
        FCalcResult.SelfMarkerList.AddNewSelfMarker(FCalcResult.PlanetList.GetPlanet(i));
    end;

  // 1. házba bezárt zodiákus jegy(ek) és analóg planéta(i)
  iStartHouse01 := FCalcResult.HouseCuspList.GetHouseCuspInfo(1).InZodiacSign;
  iStartHouse02 := FCalcResult.HouseCuspList.GetHouseCuspInfo(2).InZodiacSign;

  iEnd := iStartHouse02 - iStartHouse01;

  if iStartHouse02 < iStartHouse01 then iEnd := (iStartHouse01 + (11 - iStartHouse01) + 1) - iStartHouse01;

  // a bezárt zodiákus jegyeket is énállapotként meg kellene jeleníteni!!! a zodiákus jegy közepén
  i := iStartHouse01;
  iCnt := 0;
  while iCnt < iEnd do
    begin
      i := Round(IncPeriodValue(i, 1, 0, 11));

      if (i <> iStartHouse01) and (i <> iStartHouse02) and (i in [0..11]) then
        begin
          objZodSignSelfMarker := TZodiacSignForSelfMarkers.Create;
          objZodSignSelfMarker.RA := i * 30 + 15; //bak = 9 - vízöntõ = 10 (!)
          objZodSignSelfMarker.SignID := i + 1;
          FCalcResult.SelfMarkerList.AddNewSelfMarker(objZodSignSelfMarker);
        end;

      inc(iCnt);
    end;

  // 9->0
  i := iStartHouse01;
  iCnt := 0;
  while iCnt < iEnd do
    begin
      //FCalcResult.
      i := Round(IncPeriodValue(i, 1, 0, 11));

      if (i in [0..11]) and (i <> iStartHouse02){} then
        FCalcResult.SelfMarkerList.AddNewSelfMarker(FCalcResult.PlanetList.GetPlanetInfo(cZODIACANDPLANETLETTERS[i].iPlanetID));
      inc(iCnt);
    end;
end;

procedure TBaseCalculator.CalculateOtherInformations;
begin
  CalcPlanetsInHouses;
  CalcAspects;
  CalcSelfMarkers;
  CalcWalkedUnWalkedPath;
  CalcHouseLords;
end;

procedure TBaseCalculator.CalcWalkedUnWalkedPath;

  function GetPointValue(AASCSign, AHelyzet: integer) : word;
  var k : integer;
      objPlanet : TPlanet;
  begin
    Result := 0;

    for k := 0 to FCalcResult.PlanetList.Count - 1 do
      begin
        objPlanet := TPlanet(FCalcResult.PlanetList.Items[k]);

        if objPlanet.PlanetID in [SE_SUN..SE_PLUTO] then
          begin
            if objPlanet.HouseNumber = AHelyzet then Result := Result + 1;
            if objPlanet.InZodiacSign = (AHelyzet - 1) then Result := Result + 1;

            if (objPlanet.HouseNumber = AHelyzet) or (objPlanet.InZodiacSign = (AHelyzet - 1)) then
              if objPlanet.PlanetID in [SE_SUN, SE_MOON, SE_MERCURY] then Result := Result + 1;
          end;
      end;
    if (AHelyzet - 1) = AASCSign then Result := Result + 2;
  end;

var iASCSign, i, j, iSumVizsz, iSumFugg : integer;
    lisMaxSor, lisMaxOszlop, lisMinSor, lisMinOszlop, lisJartUt, lisJaratlanUt : TSorOszlopList;
begin
  {
    -= Járt - járatlan út =-
    -= Életstartégia és "járatlan út" =-

    Nap, Hold, Merkur, ASCjegye 2x pont, többi 1-1
    Ha az egyes haz teljes egeszeben bennfoglal egy jegyet, akkor az ASC és a bezárt jegy is CSAK 1-1 pont

    Ell összeg: sor és oszlop SUM megegyezik

    Járt út    : a max sorok közül a legnagyobb értékû(ek)
    Járatlan út: a min sorok közül a legkisebb értékû(ek)

         | Kard.  |   Fix    | Labil. |
    -----------------------------------
    Tûz  | Kos/1  | Orosz/5  | Nyil/9 |
    -----------------------------------
    Föld | Bak/10 | Bika/2   | Szûz/6 |
    -----------------------------------
    Lev. | Mérl/7 | Vízõ/11  | Ikr/3  |
    -----------------------------------
    Vizes| Rák/4  | Skorp/8  | Hal/12 |
    -----------------------------------
  }

  FillChar(FCalcResult.matrJartJaratlanPontszam, sizeof(FCalcResult.matrJartJaratlanPontszam), #0);
  FCalcResult.matrJartJaratlanPontszam[1,1] :=  1; FCalcResult.matrJartJaratlanPontszam[2,1] :=  5; FCalcResult.matrJartJaratlanPontszam[3,1] :=  9;
  FCalcResult.matrJartJaratlanPontszam[1,2] := 10; FCalcResult.matrJartJaratlanPontszam[2,2] :=  2; FCalcResult.matrJartJaratlanPontszam[3,2] :=  6;
  FCalcResult.matrJartJaratlanPontszam[1,3] :=  7; FCalcResult.matrJartJaratlanPontszam[2,3] := 11; FCalcResult.matrJartJaratlanPontszam[3,3] :=  3;
  FCalcResult.matrJartJaratlanPontszam[1,4] :=  4; FCalcResult.matrJartJaratlanPontszam[2,4] :=  8; FCalcResult.matrJartJaratlanPontszam[3,4] := 12;

  iASCSign := FCalcResult.AxisList.GetAxisInfo(SE_ASC).InZodiacSign; // Kos = 0 .. Halak = 11
  iSumVizsz := 0;
  iSumFugg := 0;

  for i := 1 to 3 do
    for j := 1 to 4 do
      begin
        FCalcResult.matrJartJaratlanPontszam[i, j] := GetPointValue(iASCSign, FCalcResult.matrJartJaratlanPontszam[i, j]);

        FCalcResult.matrJartJaratlanPontszam[i, 5] := FCalcResult.matrJartJaratlanPontszam[i, 5] + FCalcResult.matrJartJaratlanPontszam[i, j];
        FCalcResult.matrJartJaratlanPontszam[4, j] := FCalcResult.matrJartJaratlanPontszam[4, j] + FCalcResult.matrJartJaratlanPontszam[i, j];
      end;

  lisMaxSor := TSorOszlopList.Create(true, true);
  lisMaxOszlop := TSorOszlopList.Create(true, true);
  lisMinSor := TSorOszlopList.Create(true, false);
  lisMinOszlop := TSorOszlopList.Create(true, false);

  for i := 1 to 3 do // oszlop
    begin
      iSumVizsz := iSumVizsz + FCalcResult.matrJartJaratlanPontszam[i, 5];
      lisMaxOszlop.AddNewItem(i, FCalcResult.matrJartJaratlanPontszam[i, 5]);
      lisMinOszlop.AddNewItem(i, FCalcResult.matrJartJaratlanPontszam[i, 5]);
    end;

  for i := 1 to 4 do // sor
    begin
      iSumFugg := iSumFugg + FCalcResult.matrJartJaratlanPontszam[4, i];
      lisMaxSor.AddNewItem(i, FCalcResult.matrJartJaratlanPontszam[4, i]);
      lisMinSor.AddNewItem(i, FCalcResult.matrJartJaratlanPontszam[4, i]);
    end;

  if iSumVizsz = iSumFugg then // Check! egyenlõnek kell lennie
    FCalcResult.matrJartJaratlanPontszam[4, 5] := iSumVizsz
  else
    FCalcResult.matrJartJaratlanPontszam[4, 5] := 999;

  lisJartUt := TSorOszlopList.Create(true, true);
  lisJaratlanUt := TSorOszlopList.Create(true, false);

  for i := 0 to lisMaxSor.Count - 1 do
    for j := 0 to lisMaxOszlop.Count - 1 do                           // oszlop, sor
      lisJartUt.AddNewItem
        (
          cJARTJARATLANZODIACs[lisMaxOszlop.GetItem(j).SO_ID, lisMaxSor.GetItem(i).SO_ID],
          FCalcResult.matrJartJaratlanPontszam[lisMaxOszlop.GetItem(j).SO_ID, lisMaxSor.GetItem(i).SO_ID]
        );

  for i := 0 to lisMinSor.Count - 1 do
    for j := 0 to lisMinOszlop.Count - 1 do                           // oszlop, sor
      lisJaratlanUt.AddNewItem
        (
          cJARTJARATLANZODIACs[lisMinOszlop.GetItem(j).SO_ID, lisMinSor.GetItem(i).SO_ID],
          FCalcResult.matrJartJaratlanPontszam[lisMinOszlop.GetItem(j).SO_ID, lisMinSor.GetItem(i).SO_ID]
        );

  SetLength(FCalcResult.utJartUt, 0);
  SetLength(FCalcResult.utJaratlanUt, 0);

  for i := 0 to lisJartUt.Count - 1 do
    begin
      SetLength(FCalcResult.utJartUt, Length(FCalcResult.utJartUt) + 1);
      FCalcResult.utJartUt[Length(FCalcResult.utJartUt) - 1] := lisJartUt.GetItem(i).SO_ID;
    end;

  for i := 0 to lisJaratlanUt.Count - 1 do
    begin
      SetLength(FCalcResult.utJaratlanUt, Length(FCalcResult.utJaratlanUt) + 1);
      FCalcResult.utJaratlanUt[Length(FCalcResult.utJaratlanUt) - 1] := lisJaratlanUt.GetItem(i).SO_ID;
    end;

  FreeAndNil(lisJartUt);
  FreeAndNil(lisJaratlanUt);
  FreeAndNil(lisMaxSor);
  FreeAndNil(lisMaxOszlop);
  FreeAndNil(lisMinSor);
  FreeAndNil(lisMinOszlop);
end;

procedure TBaseCalculator.DoCalculate(ASzulKepletInfo: TSzuletesiKepletInfo);
begin
  if Assigned(ASzulKepletInfo) then
    begin
      FSzulKepletInfo := ASzulKepletInfo;

      CalcHouseCusps;
      CalcPlanetsPosition;

      CalculateOtherInformations;
    end;
end;

function TBaseCalculator.GetEclipticObliquity: Double;
var dEclipticObliquity : TPlanetPositionInfo;
    sErr : TsErr;
begin
  Result := 23.4393; // 2000-es évben ez volt a mért érték!

  swe_calc(GetJulianDateET, SE_ECL_NUT, 0, dEclipticObliquity[0], sErr);

  if dEclipticObliquity[0] <> 0 then
    Result := dEclipticObliquity[0];
end;
{
function TBaseCalculator.GetARMCTime: Double;
begin
  Result := GetSideralTime * 15;
end;
{}
function TBaseCalculator.GetGMTFromBirthDateTime: TDateTime;
var iTimeZoneOraPerc : Double;
    objTimeZoneInfo : TTimeZoneInfo;
    iDayOfTheYear : integer;
    //iSzorzo : integer;
    //dDate, dTime : TDateTime;
begin
  {
    Visszaadja a Greenwich-i idõt = UT = GMT
     - Levonjuk a Téli/Nyári +1 órát
     - Levonjuk az idõzóna miatti idõt!
    Nyugati idõponttal mi is is van?! na az kicsit bonyolultabb, de mostmár alakul :D
  {}

  Result := FSzulKepletInfo.DateOfBirth; // DateTime of Birth - with TimeZone!!!
  iTimeZoneOraPerc := 0;

  if FSzulKepletInfo.TZoneCode <> 'LMT' then
    begin
      objTimeZoneInfo := FDataSetInfoProvider.GetTimeZoneInfo(FSzulKepletInfo.TZoneCode);
      if Assigned(objTimeZoneInfo) then // Beálíltott idõzóna
        iTimeZoneOraPerc := OraPercToDouble(Round(objTimeZoneInfo.DeltaHour), Round(objTimeZoneInfo.DeltaMinute))
      else
        if Trim(FSzulKepletInfo.TZoneCode) = '' then // kézi beállítás
          iTimeZoneOraPerc := OraPercToDouble(Round(FSzulKepletInfo.TZoneHour), Round(FSzulKepletInfo.TZoneMinute));
    end
  else
    begin
      iTimeZoneOraPerc :=
        (
          (4 * Abs(FSzulKepletInfo.LocLongDegree))
          +
          ((4 / 60) * FSzulKepletInfo.LocLongMinute)
        ); // ennyi perc összesen
      iTimeZoneOraPerc :=
        OraPercToDouble(
          Round(iTimeZoneOraPerc) div 60,
          Round(iTimeZoneOraPerc) - ((Round(iTimeZoneOraPerc) div 60) * 60)
                       );
    end;

  // megvan, hogy hány órával kell változtatni a normál idõpontot!
  // hozzá vesszük a nyári idõszámtást

  if (FSzulKepletInfo.IsDayLightSavingTime and ((pos('/S', FSzulKepletInfo.TZoneCode) = 0) and (pos('DT', FSzulKepletInfo.TZoneCode) = 0))) or
     ((FSzulKepletInfo.TZoneCode = 'LMT') and FSzulKepletInfo.IsDayLightSavingTime) or
     ((FSzulKepletInfo.TZoneCode = 'LMT') and FDataSetInfoProvider.IsDaylightSavingTimeOnDate(Result, FSzulKepletInfo.LocCountryID)) then
    begin
      if FSzulKepletInfo.TZoneWest then
        iTimeZoneOraPerc := iTimeZoneOraPerc - 1
      else
        iTimeZoneOraPerc := iTimeZoneOraPerc + 1;
    end;

  // mehet a változtatás
  if Result >= 0 then  // 1900.01.01-nél nagyobb = a dátum
    begin
      if FSzulKepletInfo.TZoneWest then // NY-i idõ => TZoneÓra az "-" értékû => hozzá kell adni az óraszámot
        begin
          if FSzulKepletInfo.TZoneCode <> 'LMT' then // NEM HelyiKözépidõ!
            begin 
              Result := IncHour(Result, - DoubleToOra(iTimeZoneOraPerc));
              Result := IncMinute(Result, - DoubleToPerc(iTimeZoneOraPerc));
            end
          else
            begin
              Result := IncHour(Result, DoubleToOra(iTimeZoneOraPerc));
              Result := IncMinute(Result, DoubleToPerc(iTimeZoneOraPerc));
            end;
        end
      else
        begin // K-i idõ => TZoneÓra az "+" értékû => le kell vonni az óraszámot
          //if FSzulKepletInfo.TZoneCode <> 'LMT' then // NEM HelyiKözépidõ!
            begin 
              Result := IncHour(Result, - DoubleToOra(iTimeZoneOraPerc));
              Result := IncMinute(Result, - DoubleToPerc(iTimeZoneOraPerc));
            end;
        end;
    end
  else
    begin
      if FSzulKepletInfo.TZoneWest then // NY-i idõ => TZoneÓra az "-" értékû => hozzá kell adni az óraszámot
        begin
          if FSzulKepletInfo.TZoneCode <> 'LMT' then // NEM HelyiKözépidõ!
            begin
              iDayOfTheYear := DayOfTheYear(Result);
              Result := IncHour(Result, DoubleToOra(iTimeZoneOraPerc));
              Result := IncMinute(Result, DoubleToPerc(iTimeZoneOraPerc));
              if iDayOfTheYear <> DayOfTheYear(Result) then
                Result := IncDay(Result, +2);
            end
          else
            begin
              iDayOfTheYear := DayOfTheYear(Result);
              Result := IncHour(Result, - DoubleToOra(iTimeZoneOraPerc));
              Result := IncMinute(Result, - DoubleToPerc(iTimeZoneOraPerc));
              if iDayOfTheYear <> DayOfTheYear(Result) then
                Result := IncDay(Result, +2);
            end;
        end
      else
        begin // K-i idõ => TZoneÓra az "+" értékû => le kell vonni az óraszámot
          //if FSzulKepletInfo.TZoneCode <> 'LMT' then // NEM HelyiKözépidõ!
            begin
              iDayOfTheYear := DayOfTheYear(Result);
              Result := IncHour(Result, DoubleToOra(iTimeZoneOraPerc));
              Result := IncMinute(Result, DoubleToPerc(iTimeZoneOraPerc));
              if iDayOfTheYear <> DayOfTheYear(Result) then
                Result := IncDay(Result, -2);
            end;
        end;
    end;
end;

function TBaseCalculator.GetJulianDateET: Double;
begin
  // Ephemeris Time!
  Result := GetJulianDateUT + swe_deltat(GetJulianDateUT);
end;

function TBaseCalculator.GetJulianDateUT: Double;
var dGMTSzulDatum : TDateTime;
begin
  dGMTSzulDatum := GetGMTFromBirthDateTime;

  Result := swe_julday
            (
              YearOf(dGMTSzulDatum),
              MonthOf(dGMTSzulDatum),
              DayOf(dGMTSzulDatum),
              OraPercToDouble(HourOf(dGMTSzulDatum), MinuteOf(dGMTSzulDatum)),
              SE_GREG_CAL
            );
end;

function TBaseCalculator.GetSideralTime: Double;
begin
  Result := swe_sidtime(GetJulianDateUT) + (FokFokPercToDouble(FSzulKepletInfo.LocLongDegree, FSzulKepletInfo.LocLongMinute) / 15);
end;

{ TSWECalculator }

procedure TSWECalculator.CalcHouseCusps;
var eps_true   : Double;
    HouseCusps : THouseCuspsType;
    AscMc      : TAscMcType;
    i, iFlagType : integer;
begin
  inherited;
  eps_true := GetEclipticObliquity;
{
  swe_houses_armc
    (
      GetARMCTime,
      FokFokPercToDouble(FSzulKepletInfo.LocLatDegree, FSzulKepletInfo.LocLatMinute),
      eps_true,
      SEHOUSE_SYSTEM[0],
      HouseCusps[0],
      AscMc[0]
    );
{}
{
  swe_houses
    (
      GetJulianDateUT,
      FokFokPercToDouble(FSzulKepletInfo.LocLatDegree, FSzulKepletInfo.LocLatMinute),
      FokFokPercToDouble(FSzulKepletInfo.LocLongDegree, FSzulKepletInfo.LocLongMinute),
      FSettingsProvider.GetHouseCuspSystem[1], //SEHOUSE_SYSTEM[0],
      HouseCusps[0],
      AscMc[0]
    );
{}
  iFlagType := 0;
  if FSettingsProvider.GetZodiacType = 'S' then
    iFlagType := iFlagType + SEFLG_SIDEREAL;

  swe_houses_ex
    (
      GetJulianDateUT,
      iFlagType,
      FokFokPercToDouble(FSzulKepletInfo.LocLatDegree, FSzulKepletInfo.LocLatMinute),
      FokFokPercToDouble(FSzulKepletInfo.LocLongDegree, FSzulKepletInfo.LocLongMinute),
      FSettingsProvider.GetHouseCuspSystem[1], //SEHOUSE_SYSTEM[0],
      HouseCusps[0],
      AscMc[0]
    );

  if Assigned(FCalcResult) then
    begin
      FCalcResult.EclipticObliquity := eps_true;
      
      for i := SE_ASC to SE_NASCMC do
        begin
          if i = SE_ASC then FCalcResult.ASC_PointValue := AscMc[i];
          
          FCalcResult.AxisList.AddNewAxisInfo(i, AscMc[i]);
        end;

      for i := Low(THouseCuspsType) to High(THouseCuspsType) do
        FCalcResult.HouseCuspList.AddNewHouseCuspInfo(i, HouseCusps[i]);
    end;
end;

procedure TSWECalculator.CalcPlanetsPosition;
var i, iFlagType : integer;
    dBolygoAdatok : TPlanetPositionInfo;
    sErr : TsErr;
    dSidTime : DOuble;
    wHour, wMin : word;
begin
  inherited;

  if Assigned(FCalcResult) then
    begin
      FCalcResult.UniversalTime := GetGMTFromBirthDateTime;

      dSidTime := GetSideralTime;

      // Nyugati idõ
      if dSidTime < 0 then dSidTime := 24 + dSidTime;

      // Már átmegy másik napra...
      if dSidTime >= 24 then dSidTime := dSidTime - (24 * (Round(dSidTime) div 24));

      wHour := DoubleToOra(dSidTime);
      wMin := DoubleToPerc(dSidTime);

      if wMin >= 60 then
        begin
          wHour := wHour + (wMin div 60);
          wMin := wMin - (60 * (wMin div 60));
        end;

      FCalcResult.SideralTime := EncodeDateTime(1900,01,01, wHour, wMin, 0, 0);

      FCalcResult.Ayanamsa := swe_get_ayanamsa_ut(GetJulianDateUT);
    end;

  iFlagType := SEFLG_SPEED;
  if FSettingsProvider.GetZodiacType = 'S' then
    iFlagType := iFlagType + SEFLG_SIDEREAL;

  for i := SE_SUN to SE_VESTA {SE_PLUTO{} do
    begin
      swe_calc(GetJulianDateET, i, iFlagType, dBolygoAdatok[0], sErr);
      //swe_calc(GetJulianDateUT, i, SEFLG_SPEED, dBolygoAdatok[0], sErr);

      if Assigned(FCalcResult) then // ha a dBolygoAdatok[3] < 0 akkor Retrográd a mozgás
        FCalcResult.PlanetList.AddNewPlanetInfo(i, dBolygoAdatok[0], 0, dBolygoAdatok[3]);
    end;
  // ERIS - SE_ERIS
  swe_calc(GetJulianDateET, SE_ERIS, iFlagType, dBolygoAdatok[0], sErr);
  if Assigned(FCalcResult) then // ha a dBolygoAdatok[3] < 0 akkor Retrográd a mozgás
    FCalcResult.PlanetList.AddNewPlanetInfo(SE_ERIS, dBolygoAdatok[0], 0, dBolygoAdatok[3]);
end;

procedure TDrakonikusCalculator.DoCalculateDraconicTimeAndDate(ASzulKepletInfo: TSzuletesiKepletInfo);
var dDegKulonbseg, dNodeUp, dAsc : double;
    iDecValue : integer;
begin
  FSzulKepletInfo := ASzulKepletInfo; // Mata Hari esetében ... hmm nem az igazi...

  DoCalculate(FSzulKepletInfo);

  iDecValue := 1;
  dDegKulonbseg := Abs(FCalcResult.PlanetList.GetPlanetInfo(SE_MEAN_NODE).RA - FCalcResult.HouseCuspList.GetHouseCuspInfo(SE_ASC).RA);
  while dDegKulonbseg > 0.1 do
    begin
      if dDegKulonbseg > 30 then iDecValue := 30 else
      if dDegKulonbseg > 15 then iDecValue := 15 else
      if dDegKulonbseg > 5 then iDecValue := 5 else
      if dDegKulonbseg > 1 then iDecValue := 1;{ else
      if dDegKulonbseg > 0.5 then iDecValue := 30 else
      if dDegKulonbseg > 0.01 then iDecValue := 5 else iDecValue := 2;{}

//      if dDegKulonbseg > 0.5 then
        FSzulKepletInfo.SetDateOfBirth(IncMinute(FSzulKepletInfo.DateOfBirth, - iDecValue));
//      else
//        FSzulKepletInfo.SetDateOfBirth(IncSecond(FSzulKepletInfo.DateOfBirth, - iDecValue));

      DoCalculate(FSzulKepletInfo);

      dNodeUp := FCalcResult.PlanetList.GetPlanetInfo(SE_MEAN_NODE).RA;
      dAsc := FCalcResult.HouseCuspList.GetHouseCuspInfo(1).RA;

      dDegKulonbseg := Abs(dNodeUp - dAsc);
    end;
end;

end.
