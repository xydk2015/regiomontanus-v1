unit fPrintChartPreview;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, fBaseDialogFormOnlyOK, NicePreview, StdCtrls, Buttons, ExtCtrls,
  uAstro4AllTypes, uAstro4AllDrawing, uAstro4AllPrinting, ComCtrls, ToolWin, ImgList,
  uAstro4AllFileHandling;

type
  TfrmPrintChartPreview = class(TfrmBaseDialogFormOnlyOK)
    prevPrintPreview: TNicePreview;
    pnlTop: TPanel;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    imgPreview: TImageList;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ToolButton11Click(Sender: TObject);
    procedure ToolButton13Click(Sender: TObject);
    procedure ToolButton14Click(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
    procedure ToolButton8Click(Sender: TObject);
    procedure ToolButton9Click(Sender: TObject);
  private
    { Private declarations }
    ACanvas : TCanvas;
    FCalcResult: TSzulKepletFormInfo;
    FDrawer : TDrawPrinterController;
    FSettingsProvider : TSettingsProvider; 
    { Private declarations }
  public
    property CalcResult: TSzulKepletFormInfo read FCalcResult write FCalcResult;
    property SettingsProvider: TSettingsProvider read FSettingsProvider write FSettingsProvider;
  end;

var
  frmPrintChartPreview: TfrmPrintChartPreview;

implementation

{$R *.dfm}

uses Math, Clipbrd, uAstro4AllConsts;

procedure TfrmPrintChartPreview.FormCreate(Sender: TObject);
var iMinValue : integer;
begin
  inherited;

  iMinValue := Round((Min(Application.MainForm.Height, Application.MainForm.Width) div 4) * 3.5);

  Height := Min(800, iMinValue);
  Width := Min(800, iMinValue);
end;

procedure TfrmPrintChartPreview.FormShow(Sender: TObject);
begin
  inherited;
  prevPrintPreview.ReadPrinterConfig;
  prevPrintPreview.Clear;
  ACanvas := prevPrintPreview.BeginPage;

  FDrawer := TDrawPrinterController.Create(ACanvas, prevPrintPreview, prevPrintPreview, FCalcResult, ptSzulKeplet, FSettingsProvider, true, prevPrintPreview.PageWidth, prevPrintPreview.PageHeight);
  FDrawer.SzemelyisegRajz := false; // TODO
  
//  FDrawer := TDrawPrinterController.Create(ACanvas, prevPrintPreview, prevPrintPreview, FCalcResult, ptSzulKeplet, FSettingsProvider, true, prevPrintPreview.PrinterPageWidth, prevPrintPreview.PrinterPageHeight);
  FDrawer.DrawCalculatedResult(FCalcResult.FCalcResult);

  prevPrintPreview.EndPage;

  prevPrintPreview.ViewWholePage;
  prevPrintPreview.PreviewMode := pmDrag;

  BitBtn1.Caption := 'Bezárás';
end;

procedure TfrmPrintChartPreview.ToolButton11Click(Sender: TObject);
var odSaveDialog : TSaveDialog;
begin
  inherited;
//  Clipboard.Assign(ncPrev01.Picture.Bitmap); // SaveToClipboard
  odSaveDialog := TSaveDialog.Create(Self);
  odSaveDialog.Title := 'Születési képlet mentése';
  odSaveDialog.Filter := 'Windows meta file (*.wmf)|*.wmf|Windows bitmap file (*.bmp)|*.bmp|JPEG file (*.jpg)|*.jpg';
  odSaveDialog.DefaultExt := 'wmf';
  odSaveDialog.InitialDir := ExtractFilePath(Application.ExeName);
  if odSaveDialog.Execute then
    prevPrintPreview.SaveToMetafile(odSaveDialog.FileName, 0);
  FreeAndNil(odSaveDialog);  
end;

procedure TfrmPrintChartPreview.ToolButton13Click(Sender: TObject);
begin
  inherited;
  prevPrintPreview.PreviewMode := pmZoomIn;
end;

procedure TfrmPrintChartPreview.ToolButton14Click(Sender: TObject);
begin
  inherited;
  prevPrintPreview.PreviewMode := pmZoomOut;
end;

procedure TfrmPrintChartPreview.ToolButton1Click(Sender: TObject);
begin
  inherited;
  prevPrintPreview.ViewWholePage;
end;

procedure TfrmPrintChartPreview.ToolButton2Click(Sender: TObject);
begin
  inherited;
  prevPrintPreview.ViewActualSize;
end;

procedure TfrmPrintChartPreview.ToolButton3Click(Sender: TObject);
begin
  inherited;
  prevPrintPreview.ViewFitToWidth;
end;

procedure TfrmPrintChartPreview.ToolButton4Click(Sender: TObject);
begin
  inherited;
  prevPrintPreview.PrintAll;
end;

procedure TfrmPrintChartPreview.ToolButton8Click(Sender: TObject);
begin
  inherited;
  prevPrintPreview.PreviewMode := pmNormal;
end;

procedure TfrmPrintChartPreview.ToolButton9Click(Sender: TObject);
begin
  inherited;
  prevPrintPreview.PreviewMode := pmDrag;
end;

end.
