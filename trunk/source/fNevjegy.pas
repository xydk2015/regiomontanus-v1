unit fNevjegy;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, fBaseDialogFormOnlyOK, StdCtrls, Buttons, ExtCtrls, QzHtmlLabel2,
  jpeg;

type
  TfrmNevjegy = class(TfrmBaseDialogFormOnlyOK)
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Image1: TImage;
    Image2: TImage;
    QzHtmlLabel21: TQzHtmlLabel2;
    Label5: TLabel;
    Label6: TLabel;
    memLicence: TMemo;
    Image3: TImage;
    Image4: TImage;
    procedure Image2Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure QzHtmlLabel21Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmNevjegy: TfrmNevjegy;

implementation

uses uSegedUtils;

{$R *.dfm}

procedure TfrmNevjegy.Image2Click(Sender: TObject);
begin
  inherited;
  BrowseURL('http://www.astro.com');
end;

procedure TfrmNevjegy.Image3Click(Sender: TObject);
begin
  inherited;
  BrowseURL('http://esztergom.mcse.hu/files/old/regiomontanus.html');
end;

procedure TfrmNevjegy.Image4Click(Sender: TObject);
begin
  inherited;
  BrowseURL('http://www.humanisztikus.hu');
end;

procedure TfrmNevjegy.QzHtmlLabel21Click(Sender: TObject);
begin
  inherited;
  BrowseURL('http://astro4all.fw.hu');
end;

end.
