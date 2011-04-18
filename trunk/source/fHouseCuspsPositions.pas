unit fHouseCuspsPositions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, fBaseDialogFormOnlyOK, StdCtrls, Buttons, ExtCtrls, uAstro4AllTypes;

type
  TfrmHouseCuspsPositions = class(TfrmBaseDialogFormOnlyOK)
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    Bevel1: TBevel;
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
  private
    FCalcResult: TCalcResult;
    { Private declarations }
  public
    FHouseNumArabic : boolean;
    property CalcResult: TCalcResult read FCalcResult write FCalcResult;
    { Public declarations }
  end;

var
  frmHouseCuspsPositions: TfrmHouseCuspsPositions;

implementation

uses Math, uAstro4AllConsts, uSegedUtils;

{$R *.dfm}

procedure TfrmHouseCuspsPositions.FormShow(Sender: TObject);

  function AddLabel(AID, AOszlopID: integer) : TLabel;
  begin
    Result := TLabel.Create(pnlClient);
    Result.Parent := pnlClient;
    Result.ParentFont := false;
    Result.Font.Style := Result.Font.Style - [fsBold];

    if AOszlopID in [3] then
      begin
        Result.Top := 25 + (AID + 1 - 1) * 18;
        Result.Font.Name := cSYMBOLSFONTNAME;
        Result.Font.Size := 14;
      end
    else
      begin
        Result.Top := 28 + (AID + 1 - 1) * 18;
        Result.AutoSize := false;
        if AOszlopID in [1, 2, 4, 5] then
          Result.Alignment := taCenter;
        case AOszlopID of
        1 : Result.Width := 35;
        2 : Result.Width := 60;
        4 : Result.Width := 65;
        5 : Result.Width := 65;
        end;
      end;

    if AOszlopID in [1..3] then
      Result.Cursor := crHandPoint;

    case AOszlopID of
    1 : Result.Left := 6;
    2 : Result.Left := 55;
    3 : Result.Left := 140;
    4 : Result.Left := 188;
    5 : Result.Left := 282;
    end;
  end;

var i, iCnt : integer;
    oHouse : THouseCusp;
begin
  inherited;
  iCnt := 1;
  if Assigned(CalcResult) then
    begin
      for i := 1 to CalcResult.HouseCuspList.Count - 1 do
        begin
          oHouse := THouseCusp(CalcResult.HouseCuspList.Items[i]);

          with AddLabel(i, 1) do // Ház
            begin
              case FHouseNumArabic of
              true : Caption := cHOUSECAPTIONS[Max(1, oHouse.HouseNumber)].sHouseNumberArabic;
              false: Caption := cHOUSECAPTIONS[Max(1, oHouse.HouseNumber)].sHouseNumberOther;
              end;
            end;
          with AddLabel(i, 2) do // Jegyben
            begin
              Caption := cZODIACANDPLANETLETTERS[oHouse.InZodiacSign].sZodiacName;
            end;

          with AddLabel(i, 3) do // Jele
            begin
              Caption := cZODIACANDPLANETLETTERS[oHouse.InZodiacSign].cZodiacLetter;
            end;
          with AddLabel(i, 4) do // Poz
            begin
              Caption := DoubleFokToStr(oHouse.StartDegree);
            end;

          with AddLabel(i, 5) do // RA
            begin
              Caption := DoubleFokToStr(oHouse.RA);
            end;

          inc(iCnt);
        end;

      Height := (iCnt + 1) * 18 + 90;
    end;
end;

end.
