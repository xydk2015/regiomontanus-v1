unit fCestSettings;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uAstro4AllCalculator, fBaseDialogForm, StdCtrls, Buttons,
  ExtCtrls, DB, Grids, DBGrids, DBCtrls;

type
  TfrmCestSettings = class(TfrmBaseDialogForm)
    dsCountry: TDataSource;
    GroupBox1: TGroupBox;
    dbgCountryAndTimeZone: TDBGrid;
    GroupBox2: TGroupBox;
    dsCest: TDataSource;
    dbgCestData: TDBGrid;
    dbNavCountry: TDBNavigator;
    DBNavigator1: TDBNavigator;
    Label4: TLabel;
    edtKereses: TEdit;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure TCountryDataSetNotifyEvent(DataSet: TDataSet);
    procedure TCestDataSetFilterRecordEvent(DataSet: TDataSet; var Accept: Boolean);
  public
    objDataSetInfoProvider: TDataSetInfoProvider;
    { Public declarations }
  end;

var
  frmCestSettings: TfrmCestSettings;

implementation

uses uAstro4AllConsts;

{$R *.dfm}

procedure TfrmCestSettings.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  dsCountry.DataSet.AfterScroll := nil;

  dsCest.DataSet.OnFilterRecord := nil;
  
  dsCest.DataSet.Filtered := false;
  dsCest.DataSet.Filter := '';
end;

procedure TfrmCestSettings.FormShow(Sender: TObject);
var i : integer;
    sDispName : string;
begin
  inherited;
  //
  dsCountry.DataSet := objDataSetInfoProvider.DataSetLoader.CountryLoader.DataSet;
  dsCest.DataSet := objDataSetInfoProvider.DataSetLoader.CestLoader.DataSet;

  for i := 1 to dsCountry.DataSet.FieldCount - 1 do
    begin
      dbgCountryAndTimeZone.Columns[i - 1].FieldName := dsCountry.DataSet.Fields[i].FieldName;

      sDispName := '';
      case i - 1 of
      0 : sDispName := cDS_DISP_COUNTRY_CountryCode;
      1 : sDispName := cDS_DISP_COUNTRY_DisplayName;
      2 : sDispName := cDS_DISP_COUNTRY_TimeZoneCode;
      end;

      dbgCountryAndTimeZone.Columns[i - 1].Title.Caption := sDispName;
    end;

  for i := 1 to dsCest.DataSet.FieldCount - 1 do
    begin
      dbgCestData.Columns[i - 1].FieldName := dsCest.DataSet.Fields[i].FieldName;

      sDispName := '';
      case i - 1 of
      0 : sDispName := cDS_DISP_CEST_CountryCode;
      1 : sDispName := cDS_DISP_CEST_EVTOL;
      2 : sDispName := cDS_DISP_CEST_HOTOL;
      3 : sDispName := cDS_DISP_CEST_NAPTOL;
      4 : sDispName := cDS_DISP_CEST_ORATOL;
      5 : sDispName := cDS_DISP_CEST_EVIG;
      6 : sDispName := cDS_DISP_CEST_HOIG;
      7 : sDispName := cDS_DISP_CEST_NAPIG;
      8 : sDispName := cDS_DISP_CEST_ORAIG;
      end;

      dbgCestData.Columns[i - 1].Title.Caption := sDispName;
    end;

  dsCest.DataSet.OnFilterRecord := TCestDataSetFilterRecordEvent;
  dsCountry.DataSet.AfterScroll := TCountryDataSetNotifyEvent;

  dsCountry.DataSet.Locate(cDS_COUNTRY_CountryCode, 'H', []);

  edtKereses.Text := '';
end;

procedure TfrmCestSettings.TCestDataSetFilterRecordEvent(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept := VarToStr(DataSet[cDS_CEST_CountryCode]) = VarToStr(dsCountry.DataSet[cDS_COUNTRY_CountryCode]);
end;

procedure TfrmCestSettings.TCountryDataSetNotifyEvent(DataSet: TDataSet);
begin
  dsCest.DataSet.Filtered := false;
  dsCest.DataSet.Filter := cDS_CEST_CountryCode + '=' + QuotedStr(DataSet[cDS_COUNTRY_CountryCode]);
  dsCest.DataSet.Filtered := true;
end;

end.
