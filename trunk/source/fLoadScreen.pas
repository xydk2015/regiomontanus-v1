unit fLoadScreen;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, StdCtrls;

type
  TfrmLoadScreen = class(TForm)
    Label1: TLabel;
    Image1: TImage;
    Image2: TImage;
    Label2: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLoadScreen: TfrmLoadScreen;

implementation

{$R *.dfm}

end.
