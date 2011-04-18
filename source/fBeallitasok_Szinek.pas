unit fBeallitasok_Szinek;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, fBaseDialogForm, StdCtrls, Buttons, ExtCtrls, uAstro4AllMain,
  CheckLst, ComCtrls, ColorButton;

type
  TfrmBeallitasok_Szinek = class(TfrmBaseDialogForm)
    pcBeallitasok: TPageControl;
    tsSheet01: TTabSheet;
    GroupBox1: TGroupBox;
    dlgColor: TColorDialog;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    pnlTuzes: TPanel;
    pnlFoldes: TPanel;
    pnlVizes: TPanel;
    pnlLevegos: TPanel;
    GroupBox2: TGroupBox;
    Label5: TLabel;
    pnl01: TPanel;
    pnl02: TPanel;
    pnl03: TPanel;
    pnl04: TPanel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    pnl05: TPanel;
    pnl06: TPanel;
    pnl07: TPanel;
    pnl08: TPanel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    pnl09: TPanel;
    pnl10: TPanel;
    pnl11: TPanel;
    pnl12: TPanel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    GroupBox3: TGroupBox;
    Label17: TLabel;
    pnlAspectBackground: TPanel;
    cmb01: TComboBox;
    cmb02: TComboBox;
    cmb03: TComboBox;
    cmb04: TComboBox;
    cmb06: TComboBox;
    cmb08: TComboBox;
    cmb10: TComboBox;
    cmb12: TComboBox;
    cmb05: TComboBox;
    cmb07: TComboBox;
    cmb09: TComboBox;
    cmb11: TComboBox;
    procedure cmb01DrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
    procedure pnlTuzesClick(Sender: TObject);
  private
    FobjAstro4AllMain: TAstro4AllMain;

    procedure ReadSettings;
    procedure WriteSettings;
  public
    property objAstro4AllMain: TAstro4AllMain  read FobjAstro4AllMain write FobjAstro4AllMain;
  end;

var
  frmBeallitasok_Szinek: TfrmBeallitasok_Szinek;

implementation

uses uAstro4AllConsts, uAstro4AllFileHandling, uSegedUtils;

{$R *.dfm}

procedure TfrmBeallitasok_Szinek.cmb01DrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State:
    TOwnerDrawState);
begin
  inherited;
  with TComboBox(Control) do
    begin
      Canvas.Brush.Color := clWindow;    
      Canvas.FillRect(Rect);

      Canvas.Pen.Style := cASPECTITEMSTYLE[Index + 1].psPenStyle;

      Canvas.MoveTo(Rect.Left, Rect.Top + (Rect.Bottom - Rect.Top) div 2);
      Canvas.LineTo(Rect.Right, Rect.Top + (Rect.Bottom - Rect.Top) div 2);
      Canvas.MoveTo(Rect.Left, Rect.Top + (Rect.Bottom - Rect.Top) div 2 + 1);
      Canvas.LineTo(Rect.Right, Rect.Top + (Rect.Bottom - Rect.Top) div 2 + 1);

      //Canvas.TextOut(25, Rect.Top, cItems[Index + 1].sItemName);
    end;
end;

procedure TfrmBeallitasok_Szinek.FormCreate(Sender: TObject);
begin
  inherited;
  pcBeallitasok.ActivePage := tsSheet01;
end;

procedure TfrmBeallitasok_Szinek.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  if ModalResult = mrOK then
    begin
      WriteSettings;
    end;
end;

procedure TfrmBeallitasok_Szinek.FormShow(Sender: TObject);
begin
  inherited;
  ReadSettings;
end;

procedure TfrmBeallitasok_Szinek.pnlTuzesClick(Sender: TObject);
begin
  inherited;
  dlgColor.Color := TPanel(Sender).Color;

  if dlgColor.Execute then
    TPanel(Sender).Color := dlgColor.Color;
end;

procedure TfrmBeallitasok_Szinek.ReadSettings;
var i : integer;
begin
  pnlTuzes.Color := FobjAstro4AllMain.SettingsProvider.GetColorOfFire;
  pnlFoldes.Color := FobjAstro4AllMain.SettingsProvider.GetColorOfGround;
  pnlVizes.Color := FobjAstro4AllMain.SettingsProvider.GetColorOfWater;
  pnlLevegos.Color := FobjAstro4AllMain.SettingsProvider.GetColorOfAir;

  pnlAspectBackground.Color := FobjAstro4AllMain.SettingsProvider.GetColorOfAspectsBackground;

  for i := cFSZ_EGYUTTALLAS to cFSZ_2OTODFENY do
    TPanel(Self.FindComponent('pnl' + PaddL(IntToStr(i), 2, '0'))).Color :=
      FobjAstro4AllMain.objSettingsINIFileLoader.GetIntegerValue(cGRP_chkbFenyszogColor, cGRPITM_chkbFenyszogColor[i]);

  for i := cFSZ_EGYUTTALLAS to cFSZ_2OTODFENY do
    TComboBox(Self.FindComponent('cmb' + PaddL(IntToStr(i), 2, '0'))).ItemIndex :=
      FobjAstro4AllMain.objSettingsINIFileLoader.GetIntegerValue(cGRP_chkbFenyszogStyle, cGRPITM_chkbFenyszogStlye[i]);
end;

procedure TfrmBeallitasok_Szinek.WriteSettings;
var i : integer;
begin
  FobjAstro4AllMain.objSettingsINIFileLoader.SetIntegerValue(cGRP_chkbZodiakusBackGroundColor, cGRPITM_chkbZodiakusBackGroundColor[0], pnlTuzes.Color);
  FobjAstro4AllMain.objSettingsINIFileLoader.SetIntegerValue(cGRP_chkbZodiakusBackGroundColor, cGRPITM_chkbZodiakusBackGroundColor[1], pnlFoldes.Color);
  FobjAstro4AllMain.objSettingsINIFileLoader.SetIntegerValue(cGRP_chkbZodiakusBackGroundColor, cGRPITM_chkbZodiakusBackGroundColor[2], pnlLevegos.Color);
  FobjAstro4AllMain.objSettingsINIFileLoader.SetIntegerValue(cGRP_chkbZodiakusBackGroundColor, cGRPITM_chkbZodiakusBackGroundColor[3], pnlVizes.Color);

  FobjAstro4AllMain.objSettingsINIFileLoader.SetIntegerValue(cGRP_chkbFenyszogHatterSzine, cGRPITM_chkbFenyszogHatterSzine, pnlAspectBackground.Color);

  for i := cFSZ_EGYUTTALLAS to cFSZ_2OTODFENY do
    FobjAstro4AllMain.objSettingsINIFileLoader.SetIntegerValue(cGRP_chkbFenyszogColor, cGRPITM_chkbFenyszogColor[i], TPanel(Self.FindComponent('pnl' + PaddL(IntToStr(i), 2, '0'))).Color);

  for i := cFSZ_EGYUTTALLAS to cFSZ_2OTODFENY do
    FobjAstro4AllMain.objSettingsINIFileLoader.SetIntegerValue(cGRP_chkbFenyszogStyle, cGRPITM_chkbFenyszogStlye[i], TComboBox(Self.FindComponent('cmb' + PaddL(IntToStr(i), 2, '0'))).ItemIndex);
end;

end.
