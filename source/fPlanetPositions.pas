unit fPlanetPositions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, fBaseDialogFormOnlyOK, StdCtrls, Buttons, ExtCtrls, uAstro4AllTypes, uAstro4AllMain;

type
  TfrmPlanetPositions = class(TfrmBaseDialogFormOnlyOK)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    Bevel6: TBevel;
    Label13: TLabel;
    Bevel7: TBevel;
    procedure FormShow(Sender: TObject);
  private
    FCalcResult: TCalcResult;
    FobjAstro4AllMain: TAstro4AllMain;
    { Private declarations }
  public
    FHouseNumArabic : boolean;
    property CalcResult: TCalcResult read FCalcResult write FCalcResult;

    property objAstro4AllMain: TAstro4AllMain  read FobjAstro4AllMain write FobjAstro4AllMain;
  end;

var
  frmPlanetPositions: TfrmPlanetPositions;

implementation

uses Contnrs, Math, uAstro4AllConsts, swe_de32, uSegedUtils,
  uAstro4AllConstProvider;

{$R *.dfm}

procedure TfrmPlanetPositions.FormShow(Sender: TObject);

  function AddLabel(AID, AOszlopID: integer) : TLabel;
  begin
    Result := TLabel.Create(pnlClient);
    Result.Parent := pnlClient;
    Result.ParentFont := false;
    Result.Font.Style := Result.Font.Style - [fsBold];

    if AOszlopID in [2, 4] then
      begin
        Result.Top := 25 + (AID) * 18;
        Result.Font.Name := cSYMBOLSFONTNAME;
        Result.Font.Size := 14;
      end
    else
      begin
        Result.Top := 28 + (AID) * 18;
        Result.AutoSize := false;
        if AOszlopID in [3, 6] then
          Result.Alignment := taCenter
        else
          if AOszlopID in [5, 7] then
          Result.Alignment := taRightJustify;
        case AOszlopID of
        1 : Result.Width := 130;
        3 : Result.Width := 60;
        5 : Result.Width := 65;
        6 : Result.Width := 35;
        7 : Result.Width := 65;
        end;
      end;

    if AOszlopID in [1..4, 6] then
      Result.Cursor := crHandPoint;

    case AOszlopID of
    1 : Result.Left := 6;
    2 : Result.Left := 159;
    3 : Result.Left := 197;
    4 : Result.Left := 280;
    5 : Result.Left := 320;
    6 : Result.Left := 408;
    7 : Result.Left := 448;
    end;
  end;

var i, iCnt : integer;
    oPlanet : TPlanet;
    sSetOfPlanets : string;
    objPlanetName : TPlanetConstInfoProvider;
begin
  inherited;
  iCnt := 1;
  if Assigned(CalcResult) then
    begin
      sSetOfPlanets := FobjAstro4AllMain.SettingsProvider.GetShownPlanetSet(true);
      objPlanetName := TPlanetConstInfoProvider.Create;
      
      for i := 0 to CalcResult.PlanetList.Count - 1 do
        begin
          //oPlanet := TPlanet(CalcResult.PlanetList.Items[i]);

          oPlanet := CalcResult.PlanetList.GetPlanet(i);
          //if oPlanet.PlanetID in [SE_SUN..SE_PLUTO, SE_MEAN_NODE, {SE_TRUE_NODE, {}SE_MEAN_APOG, SE_CHIRON..SE_VESTA, SE_TRUE_MEAN_NODE_DOWN] then
          if Pos(IntToStr(oPlanet.PlanetID) + ';', sSetOfPlanets) > 0 then
            begin

              with AddLabel(iCnt, 1) do // Bolygó - Pont
                begin
                  Caption := oPlanet.PlanetName;
                  if oPlanet.Retrograd then
                    Caption := Caption + ' (' + BoolToRetrogradeAstro(oPlanet.Retrograd) + ')';
                end;
              with AddLabel(iCnt, 2) do // Jele
                begin
                  Caption := objPlanetName.cPlanetLetter(oPlanet.PlanetID); //cPLANETLIST[oPlanet.PlanetID].cPlanetLetter;
                  if Length(Caption) <> 1 then
                    begin
                      Font.Name := cBASEFONTNAME;
                      Font.Size := 8;
                      Top := Top + 3;
                    end;
                end;

              with AddLabel(iCnt, 3) do // Jegyben
                begin
                  Caption := cZODIACANDPLANETLETTERS[oPlanet.InZodiacSign].sZodiacName;
                end;
              with AddLabel(iCnt, 4) do // jele
                begin
                  Caption := cZODIACANDPLANETLETTERS[oPlanet.InZodiacSign].cZodiacLetter;
                end;
              with AddLabel(iCnt, 5) do // Pozíció
                begin
                  Caption := DoubleFokToStr(oPlanet.StartDegree); //FloatToStr(RoundTo(oPlanet.StartDegree, -2)) + '°';
                end;
              with AddLabel(iCnt, 6) do // Ház
                begin
                  if oPlanet.HouseNumber in [cHSN_House01..cHSN_House12] then
                    case FHouseNumArabic of
                    true : Caption := cHOUSECAPTIONS[oPlanet.HouseNumber].sHouseNumberArabic;
                    false: Caption := cHOUSECAPTIONS[oPlanet.HouseNumber].sHouseNumberOther;
                    end;
                end;
              with AddLabel(iCnt, 7) do // RA
                begin
                  Caption := DoubleFokToStr(oPlanet.RA); //FloatToStr(RoundTo(oPlanet.RA, -2)) + '°';
                end;
              inc(iCnt);
            end;
        end;

      Height := (iCnt + 1) * 18 + 90;

      FreeAndNil(objPlanetName);
    end;
end;

end.
