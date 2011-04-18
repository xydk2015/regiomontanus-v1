unit fBaseDialogFormOnlyOK;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons;

type
  TfrmBaseDialogFormOnlyOK = class(TForm)
    pnlBottom: TPanel;
    pnlClient: TPanel;
    BitBtn1: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBaseDialogFormOnlyOK: TfrmBaseDialogFormOnlyOK;

implementation

{$R *.dfm}

procedure TfrmBaseDialogFormOnlyOK.FormCreate(Sender: TObject);
begin
  pnlBottom.Caption := '';
  pnlClient.Caption := '';
end;

procedure TfrmBaseDialogFormOnlyOK.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
  VK_ESCAPE : Close;
  end;
end;

end.
