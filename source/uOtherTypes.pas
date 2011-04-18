{
  Leírás: egyéb oosztályok, melyek szükségesek a program mûködéséhez...
  Forrás: DSO, stb

  Készült: 2010.03.20
}
unit uOtherTypes;

interface

uses Windows, Classes, SysUtils, Messages;

type
  TResourceFont = class(TObject)
  public
    procedure Execute(AFontName: string);
  end;

implementation

const cMAX_PATH = 200;

procedure TResourceFont.Execute(AFontName: string);
var WinDir  : array[0..cMAX_PATH] of char;
    FontDir : string;
    rs: TResourceStream;
begin
  GetWindowsDirectory(@WinDir, cMAX_PATH);
  FontDir := WinDir+'\Fonts\';
  if not FileExists(FontDir + AFontName + '.ttf') then
    begin
      rs := TResourceStream.Create(hInstance, AFontName, RT_RCDATA);
      rs.SavetoFile(FontDir + AFontName + '.ttf');
      rs.Free;
    end;
  AddFontResource(PChar(FontDir + AFontName + '.ttf'));
  SendMessage(HWND_BROADCAST, WM_FONTCHANGE, 0, 0);
end;

end.
