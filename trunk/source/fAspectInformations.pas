unit fAspectInformations;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uAstro4AllTypes, fBaseDialogFormOnlyOK, StdCtrls, Buttons,
  ExtCtrls;

type
  TfrmAspectInformations = class(TfrmBaseDialogFormOnlyOK)
    grpAspects: TGroupBox;
    lblAspectInfo: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FCalcResult: TCalcResult;
    function AddLabel(AID: integer; ALetter: string; AAspect: boolean = false; AAspectID01: integer = 0; AAspectID02:
        integer = 0; ADefWidth: integer = 30; ADefHeight : integer = 20): TLabel;
    procedure CreateAspectTable;

    procedure AspectClick(Sender: TObject);
    procedure CreateBevels;
  public
    property CalcResult: TCalcResult read FCalcResult write FCalcResult;
  end;

var
  frmAspectInformations: TfrmAspectInformations;

implementation

uses uAstro4AllConsts, uSegedUtils, swe_de32, Math;

{$R *.dfm}

procedure TfrmAspectInformations.FormCreate(Sender: TObject);
begin
  inherited;
  lblAspectInfo.Caption := 'Fényszög információ' + #13 + 'Kérem kattintson egy tetszõleges fényszögre a táblázatban';
end;

function TfrmAspectInformations.AddLabel(AID: integer; ALetter: string; AAspect: boolean = false; AAspectID01: integer
    = 0; AAspectID02: integer = 0; ADefWidth: integer = 30; ADefHeight : integer = 20): TLabel;
var lblResult : TLabel;
begin
  lblResult := TLabel.Create(grpAspects);
  lblResult.Parent := grpAspects;
  lblResult.ParentFont := false;
  lblResult.ShowHint   := true;
  //lblResult.AutoSize := false;

  //Result.AutoSize := false;
  lblResult.Cursor := crHandPoint;

  if not AAspect then
    begin
      lblResult.Font.Size  := 16;
      lblResult.Font.Name  := cSYMBOLSFONTNAME;
      lblResult.Font.Style := lblResult.Font.Style - [fsBold];

      if AID in [SE_SUN..SE_PLUTO, SE_MEAN_NODE {SE_TRUE_NODE{}] then
        lblResult.Hint := cPLANETLIST[AID].sPlanetName
      else
        lblResult.Hint := cAXISNAMES[AID - 12].sLongAxisName;

      if AID > 10 then AID := AID - 1;

      lblResult.Top  := 27 + (AID * {ADefHeight{}27) + 2;
      lblResult.Left := (AID * ADefWidth) + ADefWidth div 2;
    end
  else
    begin
      lblResult.Font.Size := 14;
      lblResult.Font.Name := cSYMBOLSFONTNAME;

      if AAspectID01 > 10 then AAspectID01 := AAspectID01 - 1;
      if AAspectID02 > 10 then AAspectID02 := AAspectID02 - 1;

      lblResult.Top  := 27 + (Max(AAspectID01, AAspectID02) * 27{ADefHeight{}) + 2;

      lblResult.Left := (Min(AAspectID01, AAspectID02) * ADefWidth) + ADefWidth div 2;

      lblResult.OnClick := AspectClick;
    end;

  lblResult.Caption    := ALetter;

  Result := lblResult;
end;

procedure TfrmAspectInformations.CreateAspectTable;
var i : integer;
begin
  // Létrehozzuk a fényszög táblázatot

  CreateBevels;

  for i := SE_SUN to SE_TRUE_NODE do
    if i in [SE_SUN..SE_PLUTO, SE_MEAN_NODE{SE_TRUE_NODE{}] then
      AddLabel(i, cPLANETLIST[i].cPlanetLetter);

  AddLabel(12, cASC_KEPLERLETTER);
  AddLabel(13, cMC_KEPLERLETTER);
end;

procedure TfrmAspectInformations.FormShow(Sender: TObject);
var i, kID : integer;
    oAspectInfo : TAspectInfo;
    bOK : boolean;
begin
  inherited;
  CreateAspectTable;

  if Assigned(FCalcResult) then
    begin
      for i := 0 to FCalcResult.AspectList.Count - 1 do
        begin
          oAspectInfo := FCalcResult.AspectList.GetAspectInfo(i);

          bOK := false;

          if (
               (oAspectInfo.Aspect01Type = tasc_Planet) and
               (oAspectInfo.Aspect01ID in [SE_SUN..SE_PLUTO, SE_TRUE_NODE])
             )
             and
             (
               (
                 (oAspectInfo.Aspect02Type = tasc_Planet) and
                 (oAspectInfo.Aspect02ID in [SE_SUN..SE_PLUTO, SE_TRUE_NODE])
               )
               or
               (
                 (oAspectInfo.Aspect02Type = tasc_Axis) and
                 (oAspectInfo.Aspect02ID in [SE_ASC..SE_MC])
               )
             )
            then bOK := true;

          if bOK then
            begin
              if (oAspectInfo.Aspect01Type = tasc_Planet) and (oAspectInfo.Aspect02Type = tasc_Planet) then
                begin

                  AddLabel
                    (
                      0,
                      cFENYSZOGSETTINGS[oAspectInfo.AspectID].cAspectLetter,
                      true,
                      FCalcResult.PlanetList.GetPlanetInfo(oAspectInfo.Aspect01ID).PlanetID,
                      FCalcResult.PlanetList.GetPlanetInfo(oAspectInfo.Aspect02ID).PlanetID
                    ).Hint :=
                      FCalcResult.PlanetList.GetPlanetInfo(oAspectInfo.Aspect01ID).PlanetName + ' -+- ' +
                      FCalcResult.PlanetList.GetPlanetInfo(oAspectInfo.Aspect02ID).PlanetName + ' --> ' +
                      cFENYSZOGSETTINGS[oAspectInfo.AspectID].sAspectName +
                      ' (' + cFENYSZOGSETTINGS[oAspectInfo.AspectID].sOtherAspectName + ')';

                end
              else
                if (oAspectInfo.Aspect01Type = tasc_Planet) and (oAspectInfo.Aspect02Type = tasc_Axis) then
                  begin

                    if FCalcResult.AxisList.GetAxisInfo(oAspectInfo.Aspect02ID).AxisID = SE_ASC then
                      kID := 12
                    else
                      kID := 13;

                    AddLabel
                      (
                        0,
                        cFENYSZOGSETTINGS[oAspectInfo.AspectID].cAspectLetter,
                        true,
                        FCalcResult.PlanetList.GetPlanetInfo(oAspectInfo.Aspect01ID).PlanetID,
                        kID
                      ).Hint :=
                        FCalcResult.PlanetList.GetPlanetInfo(oAspectInfo.Aspect01ID).PlanetName + ' -+- ' +
                        cAXISNAMES[FCalcResult.AxisList.GetAxisInfo(oAspectInfo.Aspect02ID).AxisID].sLongAxisName + ' --> ' +
                        cFENYSZOGSETTINGS[oAspectInfo.AspectID].sAspectName +
                        ' (' + cFENYSZOGSETTINGS[oAspectInfo.AspectID].sOtherAspectName + ')';
                  end;
            end;
        end;
    end;
end;

procedure TfrmAspectInformations.AspectClick(Sender: TObject);
begin
  lblAspectInfo.Caption := TLabel(Sender).Hint;
end;

procedure TfrmAspectInformations.CreateBevels;
var bevBevel : TBevel;
    i, j : integer;
begin
  // 30 széles 20 magas
  
  for i := 1 to 13 do
    for j := 1 to i do
      begin
        bevBevel := TBevel.Create(grpAspects);
        bevBevel.Parent := grpAspects;
        bevBevel.Shape  := bsFrame;
        bevBevel.Style  := bsLowered;

        bevBevel.Top    := i * 27;
        bevBevel.Left   := j * 30 - 8 - 15;

        bevBevel.Width  := 30;
        bevBevel.Height := 27;
      end;
end;

end.
 