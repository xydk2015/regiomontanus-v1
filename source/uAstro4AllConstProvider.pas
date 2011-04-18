{
  Konstansok helyett osztályok szolgáltatják az infókat...
}

unit uAstro4AllConstProvider;

interface

uses uAstro4AllConsts;

type
  TPlanetConstInfoProvider = class(TObject)
  public
    function cPlanetLetter(APlanetID: integer): string;
    function sPlanetName(APlanetID: integer): string;
  end;

implementation

uses swe_de32, uAstro4AllTypes;

function TPlanetConstInfoProvider.cPlanetLetter(APlanetID: integer): string;
begin
  Result := '';
  if APlanetID in [SE_SUN..SE_TRUE_MEAN_NODE_DOWN] then
    begin
      Result := cPLANETLIST[APlanetID].cPlanetLetter;
    end
  else
    begin
      if APlanetID = SE_ERIS then
        Result := 'Eri';
    end;
end;

function TPlanetConstInfoProvider.sPlanetName(APlanetID: integer): string;
var //sName : PChar;
    sName : TsErr;
begin
  Result := '';
  if APlanetID in [SE_SUN..SE_TRUE_MEAN_NODE_DOWN] then
    begin
      Result := cPLANETLIST[APlanetID].sPlanetName;
    end
  else
    begin
      swe_get_planet_name(APlanetID, sName);
      
      Result := string(sName);
    end;
end;

end.
