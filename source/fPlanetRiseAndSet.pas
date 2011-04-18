unit fPlanetRiseAndSet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, fBaseDialogFormOnlyOK, StdCtrls, Buttons, ExtCtrls;

type
  TfrmPlanetRiseAndSet = class(TfrmBaseDialogFormOnlyOK)
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPlanetRiseAndSet: TfrmPlanetRiseAndSet;

implementation

uses swe_de32, DateUtils;

{$R *.dfm}

procedure TfrmPlanetRiseAndSet.Button1Click(Sender: TObject);
{
var dDatum : Double;
    pName : PChar;
{}
begin
  inherited;
  //
{
  pName := ''
  swe_date_conversion(2009,12,01,0,'j',dDatum);
  swe_rise_trans(dDatum, SE_SUN, pName, SE_CALC_RISE, )
{}
end;

end.
