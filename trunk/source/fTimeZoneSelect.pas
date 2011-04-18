unit fTimeZoneSelect;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, fBaseDialogForm, ComCtrls, StdCtrls, Buttons, ExtCtrls, uAstro4AllCalculator;

type
  TfrmTimeZoneSelect = class(TfrmBaseDialogForm)
    grpIdozonak: TGroupBox;
    trvTimeZone: TTreeView;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FobjDataSetInfoProvider: TDataSetInfoProvider;
    procedure SetobjDataSetInfoProvider(const Value: TDataSetInfoProvider);
  public
    FAktSelectedTimeZonedCode : string;
    property objDataSetInfoProvider: TDataSetInfoProvider read FobjDataSetInfoProvider write SetobjDataSetInfoProvider;
  end;

var
  frmTimeZoneSelect: TfrmTimeZoneSelect;

implementation

uses uAstro4AllConsts, uSegedUtils, uAstro4AllFileHandling, DB;

{$R *.dfm}

procedure TfrmTimeZoneSelect.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var sTzSelected : string;
begin
  inherited;
  if ModalResult = mrOK then
    begin
      sTzSelected := trvTimeZone.Selected.Text;
      delete(sTzSelected, 1, pos('[', sTzSelected));
      delete(sTzSelected, Length(sTzSelected), 1);

      FAktSelectedTimeZonedCode := sTzSelected;
    end;
end;

procedure TfrmTimeZoneSelect.FormCreate(Sender: TObject);
begin
  inherited;
  FAktSelectedTimeZonedCode := '';
end;

procedure TfrmTimeZoneSelect.FormShow(Sender: TObject);
var i : integer;
    bOK : boolean;
begin
  inherited;
  if Trim(FAktSelectedTimeZonedCode) <> '' then
    begin
      i := 0; bOK := false;
      while (i <= trvTimeZone.Items.Count - 1) and (not bOK) do
        begin
          if pos('[' + FAktSelectedTimeZonedCode, trvTimeZone.Items[i].Text) > 0 then
            begin
              bOK := true;
              trvTimeZone.Items[i].Selected := true;
            end;
          inc(i);
        end;
    end;
end;

procedure TfrmTimeZoneSelect.SetobjDataSetInfoProvider(const Value: TDataSetInfoProvider);
var dDelta : integer;
    trTreeNode : TTreeNode;
    sStr, sNeg : string;
begin
  FobjDataSetInfoProvider := Value;

  trvTimeZone.Items.Clear;
  trTreeNode := nil;

  //FobjDataSetInfoProvider.DataSetLoader.TimeZoneLoader.DataSet.SortedField := cDS_TZONE_Order;
  FobjDataSetInfoProvider.DataSetLoader.TimeZoneLoader.DataSet.First;
  while not FobjDataSetInfoProvider.DataSetLoader.TimeZoneLoader.DataSet.Eof do
    begin
      sStr := VarToStr(FobjDataSetInfoProvider.DataSetLoader.TimeZoneLoader.DataSet[cDS_TZONE_Group]);
      delete(sStr, 1, pos(',', sStr));

      if OnlyNumeric(sStr) = 1 then
        trTreeNode := nil;

      dDelta := FobjDataSetInfoProvider.DataSetLoader.TimeZoneLoader.DataSet.FieldByName(cDS_TZONE_Delta).AsInteger;

      sNeg := '+';
      if dDelta < 0 then sNeg := '-' else
      if dDelta = 0 then sNeg := '';

      sStr := PaddR(sNeg + PaddL(IntToStr(Abs(dDelta div 100)), 2, '0') + ':' + PaddL(IntToStr(Abs(dDelta mod 100)), 2, '0'), 8, ' ') +
              PaddR(VarToStr(FobjDataSetInfoProvider.DataSetLoader.TimeZoneLoader.DataSet[cDS_TZONE_DisplayName]), 35, ' ') + '   ' +
              '[' + VarToStr(FobjDataSetInfoProvider.DataSetLoader.TimeZoneLoader.DataSet[cDS_TZONE_TimeZoneCode]) + ']';

      if Assigned(trTreeNode) then
        trvTimeZone.Items.AddChild(trTreeNode, sStr)
      else
        trTreeNode := trvTimeZone.Items.Add(trTreeNode, sStr);

      FobjDataSetInfoProvider.DataSetLoader.TimeZoneLoader.DataSet.Next;
    end;
  FobjDataSetInfoProvider.DataSetLoader.TimeZoneLoader.DataSet.First;

//  FobjDataSetInfoProvider.DataSetLoader.TimeZoneLoader.DataSet.SaveToTextFile('TimeZone.txt');

//  FobjDataSetInfoProvider.DataSetLoader.TimeZoneLoader.DataSet.SortedField := '';

  trvTimeZone.FullExpand;
end;

end.
