program Regiomontanus;

{$R 'astrofonts.res' 'astrofonts.RC'}

uses
  Forms,
  SysUtils,
  fMain in 'fMain.pas' {frmMain},
  swe_de32 in 'swe_de32.pas',
  uAstro4AllConsts in 'uAstro4AllConsts.pas',
  uAstro4AllFileHandling in 'uAstro4AllFileHandling.pas',
  uAstro4AllMain in 'uAstro4AllMain.pas',
  uAstro4AllCalculator in 'uAstro4AllCalculator.pas',
  uAstro4AllTypes in 'uAstro4AllTypes.pas',
  uAstro4AllDrawing in 'uAstro4AllDrawing.pas',
  fBaseDialogForm in 'fBaseDialogForm.pas' {frmBaseDialogForm},
  fSzuletesiKepletAdatok in 'fSzuletesiKepletAdatok.pas' {frmSzuletesiKepletAdatok},
  fCountryAndTimeZone in 'fCountryAndTimeZone.pas' {frmCountryAndTimeZone},
  uSegedUtils in 'uSegedUtils.pas',
  fBaseSzulKepletForm in 'fBaseSzulKepletForm.pas' {frmBaseSzulKepletForm},
  dAstro4All in 'dAstro4All.pas' {dmAstro4All: TDataModule},
  fCestSettings in 'fCestSettings.pas' {frmCestSettings},
  fLoadScreen in 'fLoadScreen.pas' {frmLoadScreen},
  fBaseDialogFormOnlyOK in 'fBaseDialogFormOnlyOK.pas' {frmBaseDialogFormOnlyOK},
  fPlanetPositions in 'fPlanetPositions.pas' {frmPlanetPositions},
  fHouseCuspsPositions in 'fHouseCuspsPositions.pas' {frmHouseCuspsPositions},
  fPlanetRiseAndSet in 'fPlanetRiseAndSet.pas' {frmPlanetRiseAndSet},
  fTimeZoneSelect in 'fTimeZoneSelect.pas' {frmTimeZoneSelect},
  fBulvarItemShow in 'fBulvarItemShow.pas' {frmBulvarItemShow},
  fNevjegy in 'fNevjegy.pas' {frmNevjegy},
  fAspectInformations in 'fAspectInformations.pas' {frmAspectInformations},
  uOtherTypes in 'uOtherTypes.pas',
  fTablazat_EgyebInformaciok in 'fTablazat_EgyebInformaciok.pas' {frmTablazat_EgyebInformaciok},
  fPrintChartPreview in 'fPrintChartPreview.pas' {frmPrintChartPreview},
  fKepletLepteto in 'fKepletLepteto.pas' {frmKepletLepteto},
  uAstro4AllPrinting in 'uAstro4AllPrinting.pas',
  fSelfMarkers in 'fSelfMarkers.pas' {frmSelfMarkers},
  fBeallitasok_Megjelenites in 'fBeallitasok_Megjelenites.pas' {frmBeallitasok_Megjelenites},
  fEletstratJaratlanUt in 'fEletstratJaratlanUt.pas' {frmEletstratJaratlanUt},
  uAstro4AllPrintTest in 'uAstro4AllPrintTest.pas',
  fBeallitasok_Szinek in 'fBeallitasok_Szinek.pas' {frmBeallitasok_Szinek},
  NBPageControl in 'InfoSource\Components\NBPageControl\NBPageControl.pas',
  fBeallitasok_Egyebek in 'fBeallitasok_Egyebek.pas' {frmBeallitasok_Egyebek},
  uAstro4AllConstProvider in 'uAstro4AllConstProvider.pas',
  uAstro4AllGraphicsUtils in 'uAstro4AllGraphicsUtils.pas';

{$R *.res}

begin
  Application.Initialize;

  frmLoadScreen := TfrmLoadScreen.Create(Application);
  frmLoadScreen.Show;
  frmLoadScreen.Update;

  Application.Title := 'Regiomontanus';
  Application.CreateForm(TdmAstro4All, dmAstro4All);
  Application.CreateForm(TfrmMain, frmMain);
  frmLoadScreen.Close;
  FreeAndNil(frmLoadScreen);

  Application.Run;
end.
