unit fBaseSzulKepletForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Contnrs, uAstro4AllTypes, uAstro4AllCalculator,
  uAstro4AllDrawing, ComCtrls, ToolWin, ActnList, uAstro4AllMain;

type
  TfrmBaseSzulKepletForm = class(TForm)
    tbrRight: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    tbrLeft: TToolBar;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    pnlDrawRegion: TPanel;
    actSzulKeplet: TActionList;
    actHozzaad: TAction;
    actElvesz: TAction;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    actBolygok: TAction;
    actHazak: TAction;
    actFenyszogek: TAction;
    actJartJaratlanUt: TAction;
    actEnjelolok: TAction;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    actKepletLepteto: TAction;
    actProgrLepteto: TAction;
    imgSzulKeplet: TImage;
    actSzemelyisegRajz: TAction;
    ToolButton10: TToolButton;
    procedure actHozzaadExecute(Sender: TObject);
    procedure actBolygokExecute(Sender: TObject);
    procedure actHazakExecute(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure actFenyszogekExecute(Sender: TObject);
    procedure actKepletLeptetoExecute(Sender: TObject);
    procedure actEnjelolokExecute(Sender: TObject);
    procedure actJartJaratlanUtExecute(Sender: TObject);
  private
    FobjAstro4AllMain: TAstro4AllMain;
    FobjDataSetInfoProvider: TDataSetInfoProvider;
    FobjSWECalculator: TSWECalculator;
    FTabSheetName: string;
    FLoaded : boolean;
    objSzulKepletList: TObjectList;
    objDrawController: TDrawControllerBase;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure AddSzuletesiKeplet(ASzulKeplet: TSzuletesiKepletInfo);
    function GetAktKepletInfo: TSzulKepletFormInfo;
    procedure SetAktKepletInfo(ASzulKeplet: TSzuletesiKepletInfo);
    procedure RedrawSzulKeplet;
    procedure ClearDrawingItems;
    property objAstro4AllMain: TAstro4AllMain read FobjAstro4AllMain write FobjAstro4AllMain;
    property objDataSetInfoProvider: TDataSetInfoProvider read FobjDataSetInfoProvider write FobjDataSetInfoProvider;
    property objSWECalculator: TSWECalculator read FobjSWECalculator write FobjSWECalculator;
    property TabSheetName: string read FTabSheetName write FTabSheetName;
  end;

var
  frmBaseSzulKepletForm: TfrmBaseSzulKepletForm;

implementation

uses dAstro4All, ClipBrd, DateUtils, uAstro4AllConsts;

{$R *.dfm}

constructor TfrmBaseSzulKepletForm.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  objSzulKepletList := TObjectList.Create();
  FTabSheetName := '';
  pnlDrawRegion.Caption := '';
  //objDrawController := TDrawControllerBase.Create(pbxSzulKeplet.Canvas, pnlDrawRegion);
  objDrawController := nil;

  imgSzulKeplet.Width := 2000;
  imgSzulKeplet.Height := 2000;
//  imgSzulKeplet.Picture.Bitmap.PixelFormat := pf32bit;

  // Init!
  Self.OnResize(Self);

  FLoaded := false;
end;

destructor TfrmBaseSzulKepletForm.Destroy;
begin
  FreeAndNil(objDrawController);
  FreeAndNil(objSzulKepletList);
  inherited Destroy;
end;

procedure TfrmBaseSzulKepletForm.AddSzuletesiKeplet(ASzulKeplet: TSzuletesiKepletInfo);
var objCalcResult : TCalcResult;
    objSzuletesiKepletInfo : TSzulKepletFormInfo;
begin

  if not Assigned(objDrawController) then
    objDrawController := TDrawControllerBase.Create(imgSzulKeplet.Canvas, pnlDrawRegion, imgSzulKeplet, objAstro4AllMain.SettingsProvider);

  objSzuletesiKepletInfo := TSzulKepletFormInfo.Create;
  objSzuletesiKepletInfo.FSzuletesiKepletInfo := ASzulKeplet;

  objCalcResult := TCalcResult.Create;
  objSWECalculator.FCalcResult := objCalcResult;
  objSWECalculator.DoCalculate(ASzulKeplet);
  objCalcResult := objSWECalculator.FCalcResult;

  objSzuletesiKepletInfo.FCalcResult := objSWECalculator.FCalcResult;
  objSzulKepletList.Add(objSzuletesiKepletInfo);

  objDrawController.DrawCalculatedResult(objCalcResult);

  FLoaded := true;
end;

function TfrmBaseSzulKepletForm.GetAktKepletInfo: TSzulKepletFormInfo;
begin
  Result := nil;
  if Assigned(objSzulKepletList) and (objSzulKepletList.Count > 0) then
    Result := TSzulKepletFormInfo(objSzulKepletList.Items[0]);
end;

procedure TfrmBaseSzulKepletForm.actHozzaadExecute(Sender: TObject);
var opdOpenSzuleKeplet : TOpenDialog;
begin
  //ShowMessage('Under construction... - Only 4 Test');
  // SzulKeplet_NewFormCreate(FobjSzulKepletAdatokINIFileLoader.GetSzuletesiKepletFileInfo(opdOpenSzuleKeplet.FileName));

  opdOpenSzuleKeplet := TOpenDialog.Create(Application.MainForm);
  try
    opdOpenSzuleKeplet.Title := '+1 Születési képlet megnyitása';
    opdOpenSzuleKeplet.Filter := cSZULKEPLETFILEFILETER;
    opdOpenSzuleKeplet.InitialDir := ExtractFilePath(Application.ExeName) + cPATH_SZULKEPLET;
    opdOpenSzuleKeplet.DefaultExt := '*.szk';
    opdOpenSzuleKeplet.Options := opdOpenSzuleKeplet.Options + [ofNoChangeDir, ofEnableSizing];

    if opdOpenSzuleKeplet.Execute then
      AddSzuletesiKeplet(FobjAstro4AllMain.objSzulKepletAdatokINIFileLoader.GetSzuletesiKepletFileInfo(opdOpenSzuleKeplet.FileName));
  finally
    FreeAndNil(opdOpenSzuleKeplet);
  end;
end;

procedure TfrmBaseSzulKepletForm.actBolygokExecute(Sender: TObject);
begin
  objAstro4AllMain.Tablazatok_Bolygok;
end;

procedure TfrmBaseSzulKepletForm.actHazakExecute(Sender: TObject);
begin
  objAstro4AllMain.Tablazatok_HazsarokPoz;
end;

procedure TfrmBaseSzulKepletForm.FormResize(Sender: TObject);
begin
  if FLoaded {and (Self.Parent.Visible){} then
    begin
      imgSzulKeplet.Width := pnlDrawRegion.ClientWidth;
      imgSzulKeplet.Height := pnlDrawRegion.ClientHeight;

      imgSzulKeplet.Picture.Bitmap.Width := pnlDrawRegion.ClientWidth;
      imgSzulKeplet.Picture.Bitmap.Height := pnlDrawRegion.ClientHeight;
      
      objDrawController.ReDrawCalculatedResults;
    end;
end;

procedure TfrmBaseSzulKepletForm.RedrawSzulKeplet;
begin
  objDrawController.ReDrawCalculatedResults;
end;

procedure TfrmBaseSzulKepletForm.actFenyszogekExecute(Sender: TObject);
begin
  objAstro4AllMain.Tablazatok_FenyszogAdatok;
end;

procedure TfrmBaseSzulKepletForm.SetAktKepletInfo(ASzulKeplet: TSzuletesiKepletInfo);
//var i : integer;
begin
  if Assigned(objSzulKepletList) and (objSzulKepletList.Count > 0) then
    begin
      objSWECalculator.FCalcResult := TSzulKepletFormInfo(objSzulKepletList.Items[0]).FCalcResult;
      objSWECalculator.DoCalculate(TSzulKepletFormInfo(objSzulKepletList.Items[0]).FSzuletesiKepletInfo);
      ASzulKeplet.KepletInfoChanged := true;
    end;
end;

procedure TfrmBaseSzulKepletForm.ClearDrawingItems;
begin
  objDrawController.ClearDrawingItems;
end;

procedure TfrmBaseSzulKepletForm.actKepletLeptetoExecute(Sender: TObject);
begin
  objAstro4AllMain.Specialis_KepletLeptetoShow;
end;

procedure TfrmBaseSzulKepletForm.actEnjelolokExecute(Sender: TObject);
begin
  objDrawController.SzemelyisegRajz := ToolButton7.Down;
  objDrawController.ReDrawCalculatedResults;

  if ToolButton7.Down then
    objAstro4AllMain.Tablazatok_Enjelolok;
end;

procedure TfrmBaseSzulKepletForm.actJartJaratlanUtExecute(Sender: TObject);
begin
  objAstro4AllMain.Tablazatok_EletStrategiaJaratlanUt;
end;

end.
