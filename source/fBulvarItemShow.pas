unit fBulvarItemShow;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, fBaseDialogFormOnlyOK, StdCtrls, Buttons, ExtCtrls, QzHtmlLabel2,
  uAstro4AllTypes, uAstro4AllCalculator, ComCtrls,
  uAstro4AllFileHandling, uAstro4AllConsts, uAstro4AllMain;

type
  TfrmBulvarItemShow = class(TfrmBaseDialogFormOnlyOK)
    imgZodiacSign: TImage;
    lblTitle: TQzHtmlLabel2;
    lblDescription: TQzHtmlLabel2;
    edtSzulDatum: TDateTimePicker;
    lblLongTitle: TQzHtmlLabel2;
    lblForras: TQzHtmlLabel2;
    cmbZodiacSign: TComboBox;
    procedure cmbZodiacSignCloseUp(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    function GetImageName : string;
  public
    objCalculator: TSWECalculator;
    objBulvarIniFileLoader: TBulvarIniFileLoader;
    FBulvarType: TBulvarType;
    objSzulKepletFormInfo: TSzulKepletFormInfo;
    objAstroForAllMain : TAstro4AllMain;
  end;

procedure ShowBulvarType(ABulvarType: TBulvarType; ACalculator: TSWECalculator; ASzulKepletFormInfo:
    TSzulKepletFormInfo; ABulvarIniFileLoader: TBulvarIniFileLoader; AAstroForAllMain : TAstro4AllMain);

implementation

uses dAstro4All, swe_de32, uSegedUtils;

{$R *.dfm}

var frmBulvarItemShow: TfrmBulvarItemShow;

procedure ShowBulvarType(ABulvarType: TBulvarType; ACalculator: TSWECalculator; ASzulKepletFormInfo:
    TSzulKepletFormInfo; ABulvarIniFileLoader: TBulvarIniFileLoader; AAstroForAllMain : TAstro4AllMain);
begin
  Application.CreateForm(TfrmBulvarItemShow, frmBulvarItemShow);

  frmBulvarItemShow.objCalculator := ACalculator;
  frmBulvarItemShow.objBulvarIniFileLoader := ABulvarIniFileLoader;
  frmBulvarItemShow.FBulvarType := ABulvarType;
  frmBulvarItemShow.objSzulKepletFormInfo := ASzulKepletFormInfo;
  frmBulvarItemShow.objAstroForAllMain := AAstroForAllMain; 
  
  frmBulvarItemShow.ShowModal;
  FreeAndNil(frmBulvarItemShow);
end;

procedure TfrmBulvarItemShow.cmbZodiacSignCloseUp(Sender: TObject);
begin
  inherited;
  lblDescription.Html := objBulvarIniFileLoader.GetBulvarDescription(FBulvarType, cmbZodiacSign.ItemIndex);

  //dmAstro4All.imgBulvarZodiacSigns.GetBitmap(cmbZodiacSign.ItemIndex, imgZodiacSign.Picture.Bitmap);

  imgZodiacSign.Picture.Bitmap.Handle := LoadImage(objAstroForAllMain.ImageDLLHandle, PChar(GetImageName), IMAGE_BITMAP, 0, 0, LR_DEFAULTCOLOR);

  imgZodiacSign.Hint := cZODIACANDPLANETLETTERS[cmbZodiacSign.ItemIndex].sZodiacName;
  imgZodiacSign.Refresh;
end;

procedure TfrmBulvarItemShow.FormCreate(Sender: TObject);
var i : integer;
begin
  inherited;
  lblTitle.Html := '';
  lblTitle.Caption := '';
  lblDescription.Html := '';
  lblDescription.Caption := '';
  lblLongTitle.Html := '';
  lblLongTitle.Caption := '';
  lblForras.Html := '';
  lblForras.Caption := '';

  cmbZodiacSign.Items.Clear;
  for i := low(cZODIACANDPLANETLETTERS) to high(cZODIACANDPLANETLETTERS) do
    cmbZodiacSign.Items.Add(cZODIACANDPLANETLETTERS[i].sBulvarZodiacItemName);
end;

procedure TfrmBulvarItemShow.FormShow(Sender: TObject);
var iZodiacSign : integer;
begin
  inherited;
  if Assigned(objSzulKepletFormInfo) then
    begin
      iZodiacSign := objSzulKepletFormInfo.FCalcResult.PlanetList.GetPlanetInfo(SE_SUN).InZodiacSign;
      edtSzulDatum.Date := objSzulKepletFormInfo.FSzuletesiKepletInfo.DateOfBirth;
    end
  else
    begin
      iZodiacSign := 0; // KOS
      edtSzulDatum.Date := Date; // Most
    end;

  cmbZodiacSign.ItemIndex := iZodiacSign;

  //dmAstro4All.imgBulvarZodiacSigns.GetBitmap(iZodiacSign, imgZodiacSign.Picture.Bitmap);
  imgZodiacSign.Picture.Bitmap.Handle := LoadImage(objAstroForAllMain.ImageDLLHandle, PChar(GetImageName), IMAGE_BITMAP, 0, 0, LR_DEFAULTCOLOR);
  imgZodiacSign.Hint := cZODIACANDPLANETLETTERS[iZodiacSign].sZodiacName;

  lblTitle.Html := objBulvarIniFileLoader.GetBulvarRovidLeiras(FBulvarType);
  lblLongTitle.Html := objBulvarIniFileLoader.GetBulvarHosszuLeiras(FBulvarType);
  lblDescription.Html := objBulvarIniFileLoader.GetBulvarDescription(FBulvarType, iZodiacSign);
  lblForras.Html := objBulvarIniFileLoader.GetBulvarForras(FBulvarType);

  Caption := objBulvarIniFileLoader.GetBulvarCaption(FBulvarType);
end;

function TfrmBulvarItemShow.GetImageName: string;
begin
  //Result := LowerCase('bulvar_' + PaddL(IntToStr(cmbZodiacSign.ItemIndex + 1), 2, '0') + '_' + cZODIACANDPLANETLETTERS[cmbZodiacSign.ItemIndex].sBulvarZodiacName);
  Result := LowerCase('bulvar' + PaddL(IntToStr(cmbZodiacSign.ItemIndex + 1), 2, '0'));
end;

end.
