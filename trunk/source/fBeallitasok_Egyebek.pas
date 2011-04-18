unit fBeallitasok_Egyebek;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, fBaseDialogForm, StdCtrls, Buttons, ExtCtrls, uAstro4AllMain,
  ComCtrls, Grids, DBGrids, DB;

type
  TfrmBeallitasok_Egyebek = class(TfrmBaseDialogForm)
    chkgrpTelepulesDB: TRadioGroup;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    edtFileokSzama: TEdit;
    UpDown1: TUpDown;
    Label2: TLabel;
    Label3: TLabel;
    edtTelepules: TEdit;
    dsCity: TDataSource;
    dbgCityes: TDBGrid;
    btnKivalasztas: TButton;
    Label4: TLabel;
    procedure btnKivalasztasClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtTelepulesChange(Sender: TObject);
    procedure edtTelepulesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    FobjAstro4AllMain: TAstro4AllMain;

    procedure ReadSettings;
    procedure WriteSettings;
  public
    property objAstro4AllMain: TAstro4AllMain  read FobjAstro4AllMain write FobjAstro4AllMain;
  end;

var
  frmBeallitasok_Egyebek: TfrmBeallitasok_Egyebek;

implementation

{$R *.dfm}

uses uAstro4AllConsts, uAstro4AllFileHandling, dxMDaSet;

procedure TfrmBeallitasok_Egyebek.btnKivalasztasClick(Sender: TObject);
begin
  inherited;
  if Assigned(dsCity.DataSet) then
    begin //edtTelepules.Text := ASzulKeplet.LocCity + '; ' + ASzulKeplet.LocCountryID;
      edtTelepules.Text := VarToStr(FobjAstro4AllMain.objDataSetInfoProvider.DataSetLoader.CityLoader.DataSetForSearch[cDS_CITY_CityName]) +
                           '; ' +
                           VarToStr(FobjAstro4AllMain.objDataSetInfoProvider.DataSetLoader.CityLoader.DataSetForSearch[cDS_CITY_CountryCode]);
    end;
end;

procedure TfrmBeallitasok_Egyebek.FormCreate(Sender: TObject);
begin
  inherited;
  edtTelepules.Text := '';
end;

procedure TfrmBeallitasok_Egyebek.edtTelepulesChange(Sender: TObject);
var iRecID : integer;
begin
  inherited;
  // Keresés a települések listájában
  if Assigned(dsCity.DataSet) then
    begin
      iRecID := FobjAstro4AllMain.objDataSetInfoProvider.DataSetLoader.CityLoader.GetCityRecID(edtTelepules.Text);
      if iRecID <> -1 then
        TdxMemData(dsCity.DataSet).Locate('RecID', iRecID, []);
    end;
end;

procedure TfrmBeallitasok_Egyebek.edtTelepulesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
  VK_UP : begin
            Key := 0;
            dbgCityes.DataSource.DataSet.Prior;
          end;
  VK_DOWN : begin
            Key := 0;
            dbgCityes.DataSource.DataSet.Next;
          end;
  end;

  inherited;
end;

procedure TfrmBeallitasok_Egyebek.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  if ModalResult = mrOK then
    begin
      WriteSettings;
    end;
end;

procedure TfrmBeallitasok_Egyebek.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
  VK_RETURN : begin
                if edtTelepules.Focused then
                  begin
                    Key := 0;
                    btnKivalasztas.OnClick(Self);
                  end;
              end;
  end;
  inherited;
end;

procedure TfrmBeallitasok_Egyebek.FormShow(Sender: TObject);
begin
  inherited;
//  bKeyDownKezelesKell_e := false;
  dsCity.DataSet := FobjAstro4AllMain.objDataSetInfoProvider.DataSetLoader.CityLoader.DataSetForSearch;

  ReadSettings;
end;

{ TfrmBeallitasok_Egyebek }

procedure TfrmBeallitasok_Egyebek.ReadSettings;
begin
  edtFileokSzama.Text := IntToStr(FobjAstro4AllMain.objSettingsINIFileLoader.GetIntegerValue(cGRP_chkbEgyebek, cGRPITM_chkbEgyebek[3]));
  chkgrpTelepulesDB.ItemIndex := FobjAstro4AllMain.objSettingsINIFileLoader.GetIntegerValue(cGRP_chkbEgyebek, cGRPITM_chkbEgyebek[1]);
  edtTelepules.Text := FobjAstro4AllMain.objSettingsINIFileLoader.GetStringValue(cGRP_chkbEgyebek, cGRPITM_chkbEgyebek[2]);
end;

procedure TfrmBeallitasok_Egyebek.WriteSettings;
begin
  FobjAstro4AllMain.objSettingsINIFileLoader.SetIntegerValue(cGRP_chkbEgyebek, cGRPITM_chkbEgyebek[3], StrToIntDef(edtFileokSzama.Text, 0));
  FobjAstro4AllMain.objSettingsINIFileLoader.SetIntegerValue(cGRP_chkbEgyebek, cGRPITM_chkbEgyebek[1], chkgrpTelepulesDB.ItemIndex);

  // ez kicsit kevés!!!!
  FobjAstro4AllMain.objSettingsINIFileLoader.SetStringValue(cGRP_chkbEgyebek, cGRPITM_chkbEgyebek[2], edtTelepules.Text);
end;

end.
 