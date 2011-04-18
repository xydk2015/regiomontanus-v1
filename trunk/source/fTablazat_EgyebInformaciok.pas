unit fTablazat_EgyebInformaciok;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, fBaseDialogFormOnlyOK, StdCtrls, Buttons, ExtCtrls, uAstro4AllTypes;

type
  TfrmTablazat_EgyebInformaciok = class(TfrmBaseDialogFormOnlyOK)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    lblNev: TLabel;
    lblSzulIdo: TLabel;
    lblSzulHelye: TLabel;
    lblIdozona: TLabel;
    lblSzulNapja: TLabel;
    lblEkliptika: TLabel;
    lblUT: TLabel;
    lblSidTime: TLabel;
    lblAyanamsa: TLabel;
    lblSUNSign: TLabel;
    lblMoonSign: TLabel;
    lblASCSign: TLabel;
    lblSUNSignKepler: TLabel;
    lblMoonSignKepler: TLabel;
    lblASCSignKepler: TLabel;
    procedure FormShow(Sender: TObject);
  private
    FCalcResult: TSzulKepletFormInfo;
    { Private declarations }
  public
    FHouseNumArabic : boolean;
    property CalcResult: TSzulKepletFormInfo read FCalcResult write FCalcResult;
  end;

var
  frmTablazat_EgyebInformaciok: TfrmTablazat_EgyebInformaciok;

implementation

{$R *.dfm}

uses Math, StrUtils, DateUtils, uAstro4AllConsts, uSegedUtils, swe_de32;

procedure TfrmTablazat_EgyebInformaciok.FormShow(Sender: TObject);
var sHouseNum : string;
begin
  inherited;
  lblNev.Caption       := FCalcResult.FSzuletesiKepletInfo.Name;
  lblSzulIdo.Caption   := DateTimeToStr(FCalcResult.FSzuletesiKepletInfo.DateOfBirth);
  lblSzulHelye.Caption := FCalcResult.FSzuletesiKepletInfo.LocCity + ', ' + FCalcResult.FSzuletesiKepletInfo.LocCountry;
  lblIdozona.Caption   := FCalcResult.FSzuletesiKepletInfo.TZoneCode;
  lblSzulNapja.Caption := cDAYNAMES[DayOfTheWeek(FCalcResult.FSzuletesiKepletInfo.DateOfBirth)];

  lblEkliptika.Caption := DoubleFokToStr(FCalcResult.FCalcResult.EclipticObliquity);


  IfThen(FHouseNumArabic, cHOUSECAPTIONS[FCalcResult.FCalcResult.PlanetList.GetPlanetInfo(SE_SUN).HouseNumber].sHouseNumberArabic, cHOUSECAPTIONS[FCalcResult.FCalcResult.PlanetList.GetPlanetInfo(SE_SUN).HouseNumber].sHouseNumberOther);
  lblSUNSign.Caption := cZODIACANDPLANETLETTERS[FCalcResult.FCalcResult.PlanetList.GetPlanetInfo(SE_SUN).InZodiacSign].sZodiacName + ' [ ' +
                        DoubleFokToStr(FCalcResult.FCalcResult.PlanetList.GetPlanetInfo(SE_SUN).StartDegree) + ' ] - ' +
                        sHouseNum + '. házban';
  lblSUNSignKepler.Caption := cZODIACANDPLANETLETTERS[FCalcResult.FCalcResult.PlanetList.GetPlanetInfo(SE_SUN).InZodiacSign].cZodiacLetter;



  IfThen(FHouseNumArabic, cHOUSECAPTIONS[FCalcResult.FCalcResult.PlanetList.GetPlanetInfo(SE_MOON).HouseNumber].sHouseNumberArabic, cHOUSECAPTIONS[FCalcResult.FCalcResult.PlanetList.GetPlanetInfo(SE_MOON).HouseNumber].sHouseNumberOther);
  lblMoonSign.Caption := cZODIACANDPLANETLETTERS[FCalcResult.FCalcResult.PlanetList.GetPlanetInfo(SE_MOON).InZodiacSign].sZodiacName + ' [ ' +
                        DoubleFokToStr(FCalcResult.FCalcResult.PlanetList.GetPlanetInfo(SE_MOON).StartDegree) + ' ] - ' +
                        sHouseNum + '. házban';
  lblMoonSignKepler.Caption := cZODIACANDPLANETLETTERS[FCalcResult.FCalcResult.PlanetList.GetPlanetInfo(SE_MOON).InZodiacSign].cZodiacLetter;



  lblASCSign.Caption := cZODIACANDPLANETLETTERS[FCalcResult.FCalcResult.AxisList.GetAxisInfo(SE_ASC).InZodiacSign].sZodiacName + ' [ ' +
                        DoubleFokToStr(FCalcResult.FCalcResult.AxisList.GetAxisInfo(SE_ASC).StartDegree) + ' ]';
  lblASCSignKepler.Caption := cZODIACANDPLANETLETTERS[FCalcResult.FCalcResult.AxisList.GetAxisInfo(SE_ASC).InZodiacSign].cZodiacLetter;



  lblUT.Caption := DateTimeToStr(FCalcResult.FCalcResult.UniversalTime);

  lblSidTime.Caption := FormatDateTime('hh:nn:ss', FCalcResult.FCalcResult.SideralTime);

  lblAyanamsa.Caption := DoubleFokToStr(FCalcResult.FCalcResult.Ayanamsa);
end;

end.
