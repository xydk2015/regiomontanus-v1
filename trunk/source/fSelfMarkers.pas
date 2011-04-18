unit fSelfMarkers;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, fBaseDialogFormOnlyOK, StdCtrls, Buttons, ExtCtrls, uAstro4AllTypes;

type
  TfrmSelfMarkers = class(TfrmBaseDialogFormOnlyOK)
    Label2: TLabel;
    Bevel3: TBevel;
    Label3: TLabel;
    Bevel4: TBevel;
    Bevel2: TBevel;
    Label4: TLabel;
    procedure FormShow(Sender: TObject);
  private
    FCalcResult: TCalcResult ;
    { Private declarations }
  public
    FHouseNumArabic : boolean;
    property CalcResult: TCalcResult  read FCalcResult write FCalcResult;
    { Public declarations }
  end;

var
  frmSelfMarkers: TfrmSelfMarkers;

implementation

uses Contnrs, uAstro4AllConsts, uSegedUtils, swe_de32;

{$R *.dfm}

procedure TfrmSelfMarkers.FormShow(Sender: TObject);

  function AddLabel(AID, AOszlopID: integer) : TLabel;
  begin
    Result := TLabel.Create(pnlClient);
    Result.Parent := pnlClient;
    Result.ParentFont := false;
    Result.Font.Style := Result.Font.Style - [fsBold];

    Result.Top := 40 + (AID + 1 - 1) * 18;
    if AOszlopID in [2, 4] then
      Result.Top := Result.Top + 3;

    if AOszlopID in [1, 3] then
      begin
        Result.Font.Name := cSYMBOLSFONTNAME;
        Result.Font.Size := 14;
      end;

    if AOszlopID = 2 then
      begin
        Result.Alignment := taCenter;
        Result.AutoSize := false;
        Result.Width := 60;
      end;

    if AOszlopID in [1..3] then
      Result.Cursor := crHandPoint;

    case AOszlopID of
    1 : Result.Left := 15;
    2 : Result.Left := 55;
    3 : Result.Left := 140;
    4 : Result.Left := 168;
    end;
  end;

var i : integer;
    objItem : TObject;
    sHouseNum : string;
begin
  inherited;

  for i := 0 to FCalcResult.SelfMarkerList.Count - 1 do
    begin
      objItem := FCalcResult.SelfMarkerList.Items[i];
      if objItem is TPlanet then
        begin
          case FHouseNumArabic of
          true : sHouseNum := cHOUSECAPTIONS[TPlanet(objItem).HouseNumber].sHouseNumberArabic;
          false: sHouseNum := cHOUSECAPTIONS[TPlanet(objItem).HouseNumber].sHouseNumberOther;
          end;
          AddLabel(i, 1).Caption := cPLANETLIST[TPlanet(objItem).PlanetID].cPlanetLetter;
          AddLabel(i, 2).Caption := cPLANETLIST[TPlanet(objItem).PlanetID].sPlanetName;
          AddLabel(i, 3).Caption := cZODIACANDPLANETLETTERS[TPlanet(objItem).InZodiacSign].cZodiacLetter;
          AddLabel(i, 4).Caption :=
            ' ' +
            cZODIACANDPLANETLETTERS[TPlanet(objItem).InZodiacSign].sZodiacName +
            ' jegyében ' +
            DoubleFokToStr(TPlanet(objItem).StartDegree) +
            ' fokon a(z) ' +
            sHouseNum +
            '. házban';
        end
      else
        if objItem is THouseCusp then
          begin
            AddLabel(i, 1).Caption := cASC_KEPLERLETTER;
            AddLabel(i, 2).Caption := cAXISNAMES[SE_ASC].sLongAxisName;
            AddLabel(i, 3).Caption := cZODIACANDPLANETLETTERS[THouseCusp(objItem).InZodiacSign].cZodiacLetter;
            AddLabel(i, 4).Caption :=
              ' ' +
              cZODIACANDPLANETLETTERS[THouseCusp(objItem).InZodiacSign].sZodiacName +
              ' jegyében ' +
              DoubleFokToStr(THouseCusp(objItem).StartDegree) +
              ' fokon ';
          end
        else
          if objItem is TZodiacSignForSelfMarkers then
            begin
              AddLabel(i, 1).Caption := cZODIACANDPLANETLETTERS[TZodiacSignForSelfMarkers(objItem).SignID - 1].cZodiacLetter;
              AddLabel(i, 2).Caption := cZODIACANDPLANETLETTERS[TZodiacSignForSelfMarkers(objItem).SignID - 1].sZodiacName;
              AddLabel(i, 3).Caption := cZODIACANDPLANETLETTERS[TZodiacSignForSelfMarkers(objItem).SignID - 1].cZodiacLetter;
              AddLabel(i, 4).Caption :=
                ' ' +
                cZODIACANDPLANETLETTERS[TZodiacSignForSelfMarkers(objItem).SignID - 1].sZodiacName +
                ', mint az 1. házba bezárt jegy';
            end;
    end;

    ClientHeight := FCalcResult.SelfMarkerList.Count * 20 + 85;
end;

end.
