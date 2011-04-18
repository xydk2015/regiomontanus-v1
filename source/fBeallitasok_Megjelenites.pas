unit fBeallitasok_Megjelenites;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, fBaseDialogForm, StdCtrls, Buttons, ExtCtrls, ComCtrls, CheckLst,
  uAstro4AllMain, Mask;

type
  TfrmBeallitasok_Megjelenites = class(TfrmBaseDialogForm)
    pcBeallitasok: TPageControl;
    tsSheet01: TTabSheet;
    GroupBox1: TGroupBox;
    chkbZodiakusJelek: TCheckListBox;
    GroupBox2: TGroupBox;
    chkbTengelyek: TCheckListBox;
    GroupBox3: TGroupBox;
    chkbHazHatarok: TCheckListBox;
    GroupBox4: TGroupBox;
    chkbBolygok: TCheckListBox;
    GroupBox5: TGroupBox;
    chkbKisBolygok: TCheckListBox;
    Label1: TLabel;
    chkbHazSzamok: TCheckListBox;
    GroupBox7: TGroupBox;
    chkbHoldcsomo: TCheckListBox;
    chkbHoldocsomoTipus: TCheckListBox;
    tsSheet02: TTabSheet;
    GroupBox6: TGroupBox;
    chkbFenyszogek: TCheckListBox;
    Label2: TLabel;
    chkbFenyszogJelek: TCheckListBox;
    GroupBox8: TGroupBox;
    chkbFenyszogeltTengelyek: TCheckListBox;
    chkbFenyszogeltHazak: TCheckListBox;
    Label3: TLabel;
    Label4: TLabel;
    chkbFenyszogeltBolygok: TCheckListBox;
    Label5: TLabel;
    chkbFenyszogeltKisBolygok: TCheckListBox;
    chkbFenyszogeltCsompontok: TCheckListBox;
    Label6: TLabel;
    Label7: TLabel;
    tsSheet03: TTabSheet;
    GroupBox10: TGroupBox;
    Label9: TLabel;
    GroupBox11: TGroupBox;
    chkbBolygoTablazat: TCheckListBox;
    GroupBox12: TGroupBox;
    chkbHazTablazat: TCheckListBox;
    chkKellBolygoTablazat: TCheckListBox;
    chkKellHazTablazat: TCheckListBox;
    GroupBox13: TGroupBox;
    chkKellFenyszogTablazat: TCheckListBox;
    GroupBox14: TGroupBox;
    chkKellFejlec: TCheckListBox;
    chkbFejlecKijelzesek: TCheckListBox;
    GroupBox15: TGroupBox;
    chkKellLablec: TCheckListBox;
    chkbLablecKijelzesek: TCheckListBox;
    chkbKellAnalogPlaneta: TCheckListBox;
    GroupBox16: TGroupBox;
    chkKellEletstratTablazat: TCheckListBox;
    GroupBox17: TGroupBox;
    chkNyomtatasSzinesben: TCheckListBox;
    tsSheet04: TTabSheet;
    GroupBox9: TGroupBox;
    chkbEgyebMegjelenitesek: TCheckListBox;
    GroupBox18: TGroupBox;
    chkbFokjelolok: TCheckListBox;
    GroupBox19: TGroupBox;
    chkInditasTeljesMeret: TCheckListBox;
    rgrpEnallapotJelolesMod: TRadioGroup;
    GroupBox20: TGroupBox;
    Label8: TLabel;
    edtBetumeretSzorzo: TMaskEdit;
    Label10: TLabel;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FobjAstro4AllMain: TAstro4AllMain;

    procedure ReadSettings;
    procedure WriteSettings;
  public
    property objAstro4AllMain: TAstro4AllMain  read FobjAstro4AllMain write FobjAstro4AllMain;
  end;

var
  frmBeallitasok_Megjelenites: TfrmBeallitasok_Megjelenites;

implementation

uses uAstro4AllConsts, uAstro4AllFileHandling;

{$R *.dfm}

procedure TfrmBeallitasok_Megjelenites.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  if ModalResult = mrOK then
    begin
      WriteSettings;
    end;
end;

procedure TfrmBeallitasok_Megjelenites.FormCreate(Sender: TObject);
var i : integer;
begin
  inherited;
  edtBetumeretSzorzo.EditMask := '0' + DecimalSeparator + '0';
  //edtBetumeretSzorzo.Text := '0' + DecimalSeparator + '0';
  pcBeallitasok.ActivePage := tsSheet01;

  chkbFenyszogek.Items.Clear;
  for i := Low(cFENYSZOGSETTINGS) to High(cFENYSZOGSETTINGS) do
    begin
      chkbFenyszogek.Items.Add(cFENYSZOGSETTINGS[i].sAspectName + ' (' + IntToStr(cFENYSZOGSETTINGS[i].iDeg) + '°)');
    end;
end;

procedure TfrmBeallitasok_Megjelenites.FormShow(Sender: TObject);
begin
  inherited;
  ReadSettings;
end;

procedure TfrmBeallitasok_Megjelenites.ReadSettings;
var i : integer;
begin
  // Sheet01
  for i := 0 to chkbZodiakusJelek.Items.Count - 1 do
    chkbZodiakusJelek.Checked[i] := FobjAstro4AllMain.objSettingsINIFileLoader.GetBoolValue(cGRP_chkbZodiakusJelek, cGRPITM_chkbZodiakusJelek[i].sItemName);

  chkbKellAnalogPlaneta.Checked[0] := FobjAstro4AllMain.objSettingsINIFileLoader.GetBoolValue(cGRP_chkbZodiakusJelek, cGRPITM_chkbZodiakusJelek_AnalogPlanet_KELL_E);

  for i := 0 to chkbHazHatarok.Items.Count - 1 do
    chkbHazHatarok.Checked[i] := FobjAstro4AllMain.objSettingsINIFileLoader.GetBoolValue(cGRP_chkbHazHatarok, cGRPITM_chkbHazHatarok[i].sItemName);

  for i := 0 to chkbHazSzamok.Items.Count - 1 do
    chkbHazSzamok.Checked[i] := FobjAstro4AllMain.objSettingsINIFileLoader.GetBoolValue(cGRP_chkbHazSzamok, cGRPITM_chkbHazSzamok[i].sItemName);
    
  for i := 0 to chkbTengelyek.Items.Count - 1 do
    chkbTengelyek.Checked[i] := FobjAstro4AllMain.objSettingsINIFileLoader.GetBoolValue(cGRP_chkbTengelyek, cGRPITM_chkbTengelyek[i]);

  for i := 0 to chkbBolygok.Items.Count - 1 do
    chkbBolygok.Checked[i] := FobjAstro4AllMain.objSettingsINIFileLoader.GetBoolValue(cGRP_chkbBolygok, cGRPITM_chkbBolygok[i].sItemName);

  for i := 0 to chkbKisBolygok.Items.Count - 1 do
    chkbKisBolygok.Checked[i] := FobjAstro4AllMain.objSettingsINIFileLoader.GetBoolValue(cGRP_chkbKisBolygok, cGRPITM_chkbKisBolygok[i].sItemName);

  for i := 0 to chkbHoldcsomo.Items.Count - 1 do
    chkbHoldcsomo.Checked[i] := FobjAstro4AllMain.objSettingsINIFileLoader.GetBoolValue(cGRP_chkbHoldcsomo, cGRPITM_chkbHoldcsomo[i]);

  for i := 0 to chkbHoldocsomoTipus.Items.Count - 1 do
    chkbHoldocsomoTipus.Checked[i] := FobjAstro4AllMain.objSettingsINIFileLoader.GetBoolValue(cGRP_chkbHoldocsomoTipus, cGRPITM_chkbHoldcsomoTipus[i]);

  // Sheet02
  for i := 0 to chkbFenyszogek.Items.Count - 1 do
    chkbFenyszogek.Checked[i] := FobjAstro4AllMain.objSettingsINIFileLoader.GetBoolValue(cGRP_chkbFenyszogek, cGRPITM_chkbFenyszogek[i].sItemName);

  for i := 0 to chkbFenyszogJelek.Items.Count - 1 do
    chkbFenyszogJelek.Checked[i] := FobjAstro4AllMain.objSettingsINIFileLoader.GetBoolValue(cGRP_chkbFenyszogJelek, cGRPITM_chkbFenyszogJelek[i]);

  for i := 0 to chkbFenyszogeltTengelyek.Items.Count - 1 do
    chkbFenyszogeltTengelyek.Checked[i] := FobjAstro4AllMain.objSettingsINIFileLoader.GetBoolValue(cGRP_chkbFenyszogeltTengelyek, cGRPITM_chkbFenyszogeltTengelyek[i].sItemName);

  for i := 0 to chkbFenyszogeltCsompontok.Items.Count - 1 do
    chkbFenyszogeltCsompontok.Checked[i] := FobjAstro4AllMain.objSettingsINIFileLoader.GetBoolValue(cGRP_chkbFenyszogeltCsompontok, cGRPITM_chkbFenyszogeltCsompontok[i]);

  for i := 0 to chkbFenyszogeltHazak.Items.Count - 1 do
    chkbFenyszogeltHazak.Checked[i] := FobjAstro4AllMain.objSettingsINIFileLoader.GetBoolValue(cGRP_chkbFenyszogeltHazak, cGRPITM_chkbFenyszogeltHazak[i].sItemName);

  for i := 0 to chkbFenyszogeltBolygok.Items.Count - 1 do
    chkbFenyszogeltBolygok.Checked[i] := FobjAstro4AllMain.objSettingsINIFileLoader.GetBoolValue(cGRP_chkbFenyszogeltBolygok, cGRPITM_chkbFenyszogeltBolygok[i].sItemName);

  for i := 0 to chkbFenyszogeltKisBolygok.Items.Count - 1 do
    chkbFenyszogeltKisBolygok.Checked[i] := FobjAstro4AllMain.objSettingsINIFileLoader.GetBoolValue(cGRP_chkbFenyszogeltKisBolygok, cGRPITM_chkbFenyszogeltKisBolygok[i].sItemName);

  for i := 0 to chkbEgyebMegjelenitesek.Items.Count - 1 do
    chkbEgyebMegjelenitesek.Checked[i] := FobjAstro4AllMain.objSettingsINIFileLoader.GetBoolValue(cGRP_chkbEgyebMegjelenitesek, cGRPITM_chkbEgyebMegjelenitesek[i]);

  for i := 0 to chkbFokjelolok.Items.Count - 1 do
    chkbFokjelolok.Checked[i] := FobjAstro4AllMain.objSettingsINIFileLoader.GetBoolValue(cGRP_chkbFokjelolok, cGRPITM_chkbFokjelolok[i]);

  rgrpEnallapotJelolesMod.ItemIndex := FobjAstro4AllMain.objSettingsINIFileLoader.GetIntegerValue(cGRP_rgrpEnallapotJelolMod, cGRPITM_rgrpEnallapotJelolMod);
  edtBetumeretSzorzo.Text := FloatToStr(FobjAstro4AllMain.objSettingsINIFileLoader.GetDoubleValue(cGRP_BetumeretSzorzo, cGRPITM_BetumeretSzorzo));

  // Sheet03
  chkKellBolygoTablazat.Checked[0] := FobjAstro4AllMain.objSettingsINIFileLoader.GetBoolValue(cGRP_chkbBolygoTablazat, cGRPITM_chkbBolygoTablazat_KELL_E);
  for i := 0 to chkbBolygoTablazat.Items.Count - 1 do
    chkbBolygoTablazat.Checked[i] := FobjAstro4AllMain.objSettingsINIFileLoader.GetBoolValue(cGRP_chkbBolygoTablazat, cGRPITM_chkbBolygoTablazat[i]);

  chkKellHazTablazat.Checked[0] := FobjAstro4AllMain.objSettingsINIFileLoader.GetBoolValue(cGRP_chkbHazTablazat, cGRPITM_chkbHazTablazat_KELL_E);
  for i := 0 to chkbHazTablazat.Items.Count - 1 do
    chkbHazTablazat.Checked[i] := FobjAstro4AllMain.objSettingsINIFileLoader.GetBoolValue(cGRP_chkbHazTablazat, cGRPITM_chkbHazTablazat[i]);

  chkKellFenyszogTablazat.Checked[0] := FobjAstro4AllMain.objSettingsINIFileLoader.GetBoolValue(cGRP_chkbFenyszogTablazat, cGRPITM_chkbFenyszogTablazat_KELL_E);

  chkKellEletstratTablazat.Checked[0] := FobjAstro4AllMain.objSettingsINIFileLoader.GetBoolValue(cGRP_chkbEletStratTablazat, cGRPITM_chkbEletStratTablazat_KELL_E);

  chkNyomtatasSzinesben.Checked[0] := FobjAstro4AllMain.objSettingsINIFileLoader.GetBoolValue(cGRP_chkbNyomtatas, cGRPITM_chkbNyomtatasSzinesben);

  chkKellFejlec.Checked[0] := FobjAstro4AllMain.objSettingsINIFileLoader.GetBoolValue(cGRP_chkbFejlecKijelzesek, cGRPITM_chkbFejlecKijelzesek_KELL_E);
  for i := 0 to chkbFejlecKijelzesek.Items.Count - 1 do
    chkbFejlecKijelzesek.Checked[i] := FobjAstro4AllMain.objSettingsINIFileLoader.GetBoolValue(cGRP_chkbFejlecKijelzesek, cGRPITM_chkbFejlecKijelzesek[i]);

  chkKellLablec.Checked[0] := FobjAstro4AllMain.objSettingsINIFileLoader.GetBoolValue(cGRP_chkbLablecKijelzesek, cGRPITM_chkbLablecKijelzesek_KELL_E);
  for i := 0 to chkbLablecKijelzesek.Items.Count - 1 do
    chkbLablecKijelzesek.Checked[i] := FobjAstro4AllMain.objSettingsINIFileLoader.GetBoolValue(cGRP_chkbLablecKijelzesek, cGRPITM_chkbLablecKijelzesek[i]);

  // tsSheet04
  chkInditasTeljesMeret.Checked[0] := FobjAstro4AllMain.objSettingsINIFileLoader.GetBoolValue(cGRP_chkbInditasTeljesMeret, cGRPITM_chkbInditasTeljesMeret);
end;

procedure TfrmBeallitasok_Megjelenites.WriteSettings;
var i : integer;
begin
  // Sheet01
  for i := 0 to chkbZodiakusJelek.Items.Count - 1 do
    FobjAstro4AllMain.objSettingsINIFileLoader.SetBoolValue(cGRP_chkbZodiakusJelek, cGRPITM_chkbZodiakusJelek[i].sItemName, chkbZodiakusJelek.Checked[i]);

  FobjAstro4AllMain.objSettingsINIFileLoader.SetBoolValue(cGRP_chkbZodiakusJelek, cGRPITM_chkbZodiakusJelek_AnalogPlanet_KELL_E, chkbKellAnalogPlaneta.Checked[0]);

  for i := 0 to chkbHazHatarok.Items.Count - 1 do
    FobjAstro4AllMain.objSettingsINIFileLoader.SetBoolValue(cGRP_chkbHazHatarok, cGRPITM_chkbHazHatarok[i].sItemName, chkbHazHatarok.Checked[i]);

  for i := 0 to chkbHazSzamok.Items.Count - 1 do
    FobjAstro4AllMain.objSettingsINIFileLoader.SetBoolValue(cGRP_chkbHazSzamok, cGRPITM_chkbHazSzamok[i].sItemName, chkbHazSzamok.Checked[i]);
    
  for i := 0 to chkbTengelyek.Items.Count - 1 do
    FobjAstro4AllMain.objSettingsINIFileLoader.SetBoolValue(cGRP_chkbTengelyek, cGRPITM_chkbTengelyek[i], chkbTengelyek.Checked[i]);

  for i := 0 to chkbBolygok.Items.Count - 1 do
    FobjAstro4AllMain.objSettingsINIFileLoader.SetBoolValue(cGRP_chkbBolygok, cGRPITM_chkbBolygok[i].sItemName, chkbBolygok.Checked[i]);

  for i := 0 to chkbKisBolygok.Items.Count - 1 do
    FobjAstro4AllMain.objSettingsINIFileLoader.SetBoolValue(cGRP_chkbKisBolygok, cGRPITM_chkbKisBolygok[i].sItemName, chkbKisBolygok.Checked[i]);

  for i := 0 to chkbHoldcsomo.Items.Count - 1 do
    FobjAstro4AllMain.objSettingsINIFileLoader.SetBoolValue(cGRP_chkbHoldcsomo, cGRPITM_chkbHoldcsomo[i], chkbHoldcsomo.Checked[i]);

  for i := 0 to chkbHoldocsomoTipus.Items.Count - 1 do
    FobjAstro4AllMain.objSettingsINIFileLoader.SetBoolValue(cGRP_chkbHoldocsomoTipus, cGRPITM_chkbHoldcsomoTipus[i], chkbHoldocsomoTipus.Checked[i]);

  // Sheet02
  for i := 0 to chkbFenyszogek.Items.Count - 1 do
    FobjAstro4AllMain.objSettingsINIFileLoader.SetBoolValue(cGRP_chkbFenyszogek, cGRPITM_chkbFenyszogek[i].sItemName, chkbFenyszogek.Checked[i]);

  for i := 0 to chkbFenyszogJelek.Items.Count - 1 do
    FobjAstro4AllMain.objSettingsINIFileLoader.SetBoolValue(cGRP_chkbFenyszogJelek, cGRPITM_chkbFenyszogJelek[i], chkbFenyszogJelek.Checked[i]);

  for i := 0 to chkbFenyszogeltTengelyek.Items.Count - 1 do
    FobjAstro4AllMain.objSettingsINIFileLoader.SetBoolValue(cGRP_chkbFenyszogeltTengelyek, cGRPITM_chkbFenyszogeltTengelyek[i].sItemName, chkbFenyszogeltTengelyek.Checked[i]);

  for i := 0 to chkbFenyszogeltCsompontok.Items.Count - 1 do
    FobjAstro4AllMain.objSettingsINIFileLoader.SetBoolValue(cGRP_chkbFenyszogeltCsompontok, cGRPITM_chkbFenyszogeltCsompontok[i], chkbFenyszogeltCsompontok.Checked[i]);

  for i := 0 to chkbFenyszogeltHazak.Items.Count - 1 do
    FobjAstro4AllMain.objSettingsINIFileLoader.SetBoolValue(cGRP_chkbFenyszogeltHazak, cGRPITM_chkbFenyszogeltHazak[i].sItemName, chkbFenyszogeltHazak.Checked[i]);

  for i := 0 to chkbFenyszogeltBolygok.Items.Count - 1 do
    FobjAstro4AllMain.objSettingsINIFileLoader.SetBoolValue(cGRP_chkbFenyszogeltBolygok, cGRPITM_chkbFenyszogeltBolygok[i].sItemName, chkbFenyszogeltBolygok.Checked[i]);

  for i := 0 to chkbFenyszogeltKisBolygok.Items.Count - 1 do
    FobjAstro4AllMain.objSettingsINIFileLoader.SetBoolValue(cGRP_chkbFenyszogeltKisBolygok, cGRPITM_chkbFenyszogeltKisBolygok[i].sItemName, chkbFenyszogeltKisBolygok.Checked[i]);

  for i := 0 to chkbEgyebMegjelenitesek.Items.Count - 1 do
    FobjAstro4AllMain.objSettingsINIFileLoader.SetBoolValue(cGRP_chkbEgyebMegjelenitesek, cGRPITM_chkbEgyebMegjelenitesek[i], chkbEgyebMegjelenitesek.Checked[i]);

  for i := 0 to chkbFokjelolok.Items.Count - 1 do
    FobjAstro4AllMain.objSettingsINIFileLoader.SetBoolValue(cGRP_chkbFokjelolok, cGRPITM_chkbFokjelolok[i], chkbFokjelolok.Checked[i]);

  FobjAstro4AllMain.objSettingsINIFileLoader.SetIntegerValue(cGRP_rgrpEnallapotJelolMod, cGRPITM_rgrpEnallapotJelolMod, rgrpEnallapotJelolesMod.ItemIndex);
  FobjAstro4AllMain.objSettingsINIFileLoader.SetDoubleValue(cGRP_BetumeretSzorzo, cGRPITM_BetumeretSzorzo, StrToFloatDef(edtBetumeretSzorzo.Text, 1.0));

  // Sheet03
  FobjAstro4AllMain.objSettingsINIFileLoader.SetBoolValue(cGRP_chkbBolygoTablazat, cGRPITM_chkbBolygoTablazat_KELL_E, chkKellBolygoTablazat.Checked[0]);
  for i := 0 to chkbBolygoTablazat.Items.Count - 1 do
    FobjAstro4AllMain.objSettingsINIFileLoader.SetBoolValue(cGRP_chkbBolygoTablazat, cGRPITM_chkbBolygoTablazat[i], chkbBolygoTablazat.Checked[i]);

  FobjAstro4AllMain.objSettingsINIFileLoader.SetBoolValue(cGRP_chkbHazTablazat, cGRPITM_chkbHazTablazat_KELL_E, chkKellHazTablazat.Checked[0]);
  for i := 0 to chkbHazTablazat.Items.Count - 1 do
    FobjAstro4AllMain.objSettingsINIFileLoader.SetBoolValue(cGRP_chkbHazTablazat, cGRPITM_chkbHazTablazat[i], chkbHazTablazat.Checked[i]);

  FobjAstro4AllMain.objSettingsINIFileLoader.SetBoolValue(cGRP_chkbFenyszogTablazat, cGRPITM_chkbFenyszogTablazat_KELL_E, chkKellFenyszogTablazat.Checked[0]);

  FobjAstro4AllMain.objSettingsINIFileLoader.SetBoolValue(cGRP_chkbEletStratTablazat, cGRPITM_chkbEletStratTablazat_KELL_E, chkKellEletstratTablazat.Checked[0]);

  FobjAstro4AllMain.objSettingsINIFileLoader.SetBoolValue(cGRP_chkbNyomtatas, cGRPITM_chkbNyomtatasSzinesben, chkNyomtatasSzinesben.Checked[0]);

  FobjAstro4AllMain.objSettingsINIFileLoader.SetBoolValue(cGRP_chkbFejlecKijelzesek, cGRPITM_chkbFejlecKijelzesek_KELL_E, chkKellFejlec.Checked[0]);
  for i := 0 to chkbFejlecKijelzesek.Items.Count - 1 do
    FobjAstro4AllMain.objSettingsINIFileLoader.SetBoolValue(cGRP_chkbFejlecKijelzesek, cGRPITM_chkbFejlecKijelzesek[i], chkbFejlecKijelzesek.Checked[i]);

  FobjAstro4AllMain.objSettingsINIFileLoader.SetBoolValue(cGRP_chkbLablecKijelzesek, cGRPITM_chkbLablecKijelzesek_KELL_E, chkKellLablec.Checked[0]);
  for i := 0 to chkbLablecKijelzesek.Items.Count - 1 do
    FobjAstro4AllMain.objSettingsINIFileLoader.SetBoolValue(cGRP_chkbLablecKijelzesek, cGRPITM_chkbLablecKijelzesek[i], chkbLablecKijelzesek.Checked[i]);

  // tsSheet04
  FobjAstro4AllMain.objSettingsINIFileLoader.SetBoolValue(cGRP_chkbInditasTeljesMeret, cGRPITM_chkbInditasTeljesMeret, chkInditasTeljesMeret.Checked[0]);
end;

end.
