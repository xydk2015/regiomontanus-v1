unit fCountryAndTimeZone;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, fBaseDialogForm, StdCtrls, Buttons, ExtCtrls, Grids, DBGrids, DB,
  uAstro4AllTypes, uAstro4AllCalculator, DBCtrls;

type
  TfrmCountryAndTimeZone = class(TfrmBaseDialogForm)
    dsCountry: TDataSource;
    GroupBox1: TGroupBox;
    dbgCountryAndTimeZone: TDBGrid;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    lblTimeZoneCodeAndName: TLabel;
    Label3: TLabel;
    lblDelta: TLabel;
    Label2: TLabel;
    lblType: TLabel;
    dbNavCountry: TDBNavigator;
    Label4: TLabel;
    edtKereses: TEdit;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure ReadTimeZoneInfo;

    procedure TCountryDataSetNotifyEvent(DataSet: TDataSet);
  public
    objDataSetInfoProvider: TDataSetInfoProvider;
  end;

var
  frmCountryAndTimeZone: TfrmCountryAndTimeZone;

implementation

uses uAstro4AllConsts, uAstro4AllFileHandling;

{$R *.dfm}

procedure TfrmCountryAndTimeZone.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;

  dsCountry.DataSet.AfterScroll := nil;
end;

procedure TfrmCountryAndTimeZone.FormShow(Sender: TObject);
var i : integer;
    sDispName : string;
begin
  inherited;
  
  dsCountry.DataSet := objDataSetInfoProvider.DataSetLoader.CountryLoader.DataSet;

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

  lblTimeZoneCodeAndName.Caption := '';
  lblDelta.Caption := '';
  lblType.Caption := '';

  dsCountry.DataSet.AfterScroll := TCountryDataSetNotifyEvent;

  dsCountry.DataSet.Locate(cDS_COUNTRY_CountryCode, 'H', []);

  edtKereses.Text := '';

//  ReadTimeZoneInfo;
end;

procedure TfrmCountryAndTimeZone.ReadTimeZoneInfo;
var objTimeZoneInfo : TTimeZoneInfo;
begin
  objTimeZoneInfo := objDataSetInfoProvider.GetTimeZoneInfo(dsCountry.DataSet[cDS_COUNTRY_TimeZoneCode]);

  if Assigned(objTimeZoneInfo) then
    begin
      lblTimeZoneCodeAndName.Caption := objTimeZoneInfo.TimeZoneCode + ' - ' + objTimeZoneInfo.DisplayName;
      lblDelta.Caption := objTimeZoneInfo.GetDeltaAsString;
      lblType.Caption := objTimeZoneInfo.TZType;
      
      FreeAndNil(objTimeZoneInfo);
    end;
end;

procedure TfrmCountryAndTimeZone.TCountryDataSetNotifyEvent(
  DataSet: TDataSet);
begin
  ReadTimeZoneInfo;
end;

end.
