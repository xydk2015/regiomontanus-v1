unit fEletstratJaratlanUt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, fBaseDialogFormOnlyOK, StdCtrls, Buttons, ExtCtrls, Grids, uAstro4AllTypes;

type
  TfrmEletstratJaratlanUt = class(TfrmBaseDialogFormOnlyOK)
    GroupBox1: TGroupBox;
    gridStrat: TStringGrid;
    Label1: TLabel;
    Label2: TLabel;
    lblEletstrat: TLabel;
    lblJaratlanUt: TLabel;
    procedure FormShow(Sender: TObject);
  private
    FCalcResult: TCalcResult;
    { Private declarations }
  public
    property CalcResult: TCalcResult read FCalcResult write FCalcResult;
  end;

var
  frmEletstratJaratlanUt: TfrmEletstratJaratlanUt;

implementation

uses uAstro4AllConsts;

{$R *.dfm}

procedure TfrmEletstratJaratlanUt.FormShow(Sender: TObject);
var i, j : integer;
    sPrintable : string;
begin
  inherited;
  gridStrat.Cells[1, 0] := 'Kardinális';
  gridStrat.Cells[2, 0] := 'Fix';
  gridStrat.Cells[3, 0] := 'Labilis';
  gridStrat.Cells[4, 0] := 'Összesen';

  gridStrat.Cells[0, 1] := 'Tûz';
  gridStrat.Cells[0, 2] := 'Föld';
  gridStrat.Cells[0, 3] := 'Levegõ';
  gridStrat.Cells[0, 4] := 'Viz';
  gridStrat.Cells[0, 5] := 'Összesen';

  for i := 1 to 4 do
    for j := 1 to 5 do
      gridStrat.Cells[i,j] := IntToStr(CalcResult.matrJartJaratlanPontszam[i, j]);

  lblEletstrat.Caption := ''; lblJaratlanUt.Caption := '';

  sPrintable := '';
  for i := 0 to Length(CalcResult.utJartUt) - 1 do
    sPrintable := sPrintable + cZODIACANDPLANETLETTERS[CalcResult.utJartUt[i]].sZodiacName + ',';
  delete(sPrintable, Length(sPrintable), 1);

  lblEletstrat.Caption := sPrintable;

  sPrintable := '';
  for i := 0 to Length(CalcResult.utJaratlanUt) - 1 do
    sPrintable := sPrintable + cZODIACANDPLANETLETTERS[CalcResult.utJaratlanUt[i]].sZodiacName + ',';
  delete(sPrintable, Length(sPrintable), 1);

  lblJaratlanUt.Caption := sPrintable;

  gridStrat.SetFocus;
end;

end.
