unit fBaseDialogForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons;

type
  TfrmBaseDialogForm = class(TForm)
    pnlClient: TPanel;
    pnlBottom: TPanel;
    btnRendben: TBitBtn;
    btnMegsem: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    bKeyDownKezelesKell_e : boolean;
  end;

var
  frmBaseDialogForm: TfrmBaseDialogForm;

implementation

{$R *.dfm}

procedure TfrmBaseDialogForm.FormCreate(Sender: TObject);
begin
  pnlClient.Caption := '';
  pnlBottom.Caption := '';
  bKeyDownKezelesKell_e  := true;
end;

procedure TfrmBaseDialogForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var Direction : integer;
begin
  Direction := -1;
  case Key of
  VK_DOWN, VK_RETURN : Direction := 0; {Next}
  VK_UP              : Direction := 1; {Previous}
  VK_ESCAPE          : Close;
  end;
  if (Direction <> -1) and (bKeyDownKezelesKell_e) then
    begin
      Perform(WM_NEXTDLGCTL, Direction, 0);
      Key := 0;
    end;
end;

end.
