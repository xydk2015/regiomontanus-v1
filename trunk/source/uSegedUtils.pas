unit uSegedUtils;

interface

uses Classes, SysUtils, Types,
     uAstro4AllConsts, uAstro4AllTypes;

type TCharSet = TSysCharSet;

function WordCount(const S: string; const WordDelims: TCharSet): Integer;
function WordPosition(const N: Integer; const S: string; const WordDelims: TCharSet): Integer;
function ExtractWord(N: Integer; const S: string; const WordDelims: TCharSet): string;
function PaddL(const S: string; N: Integer; C: Char): string;
function PaddLT(const S: string; N: Integer; C: Char): string;
function PaddR(const S: string; N: Integer; C: Char): string;
function PaddRT(const S: string; N: Integer; C: Char): string;
function OnlyNumeric(AStrValue: string) : integer;

function OraPercToDouble(AOra, APerc : integer) : Double;
function FokFokPercToDouble(AFok, AFokPerc : integer) : Double;
function DoubleToOra(AIdopont: Double) : integer;
function DoubleToPerc(AIdopont: Double) : integer;
function DoubleFokToStr(AFok: double; AAll: Boolean = true): string;
function DoubleToFokStrOnlyFokPerc(AFok: double): string;

function GetFokFromListItem(AFokFokPerc: string) : Double;
function GetFokPercFromListItem(AFokFokPerc: string) : Double;

function GetDayNumberSinceJ2000(AIdoPont: TDateTime): Double;

function TryOwnEncodeDateTime(const AYear, AMonth, ADay, AHour, AMinute, ASecond, AMilliSecond: Word; out AValue: TDateTime): Boolean;

function GetReszletFromCESTIdopont(ACestReszlet: TCestReszlet; ACestIdopont: string) : integer;

function Degs: Double;
function Rads: Double;

function AddFokSzam(AOrigFok, AAddFok: Double) : Double;

function AddInteger(AMaxValue, AAktValue, AIncValue : integer) : integer;

function BoolToStrAstro(AValue: boolean; ALongFormat: boolean) : string;
function StrAstroToBool(AValue: string) : boolean;
function BoolToRetrogradeAstro(AValue: boolean) : string;

function IsBetweenDeg(AValue, AStart, AEnd: Double) : boolean;
function IncPeriodValue(AValue, ACount, AMinPeriod, AMaxPeriod: Double): Double;

function PointInTriangle(const Px, Py, x1, y1, x2, y2, x3, y3 : Double) : boolean;
function Orientation(const x1, y1, x2, y2, Px, Py : Double) : integer;
function GetMetszespont(AX1, AY1, AX2, AY2, AU1, AV1, AU2, AV2: integer; AXValue: boolean): integer;
function GetHarmadoloPont(AValue1, AValue2 : integer) : integer;
function GetFelezoPont(AValue1, AValue2 : integer) : integer;
// B,C,D,E a négyszög csúcspontjai, A a négyszög "közepe", Z a keresett pont, ami benne van-e
function MelyTernegyedben(B, C, D, E, A, Z: TPoint; var ADebugStr: String): TTerNegyed;

function BrowseURL(const URL: string) : boolean;

{ Visszaadja , hogy egy string benne van-e a CommandLine paraméterekben }
function IsCmdLineArg(const s: string): boolean;

implementation

uses Math, DateUtils, Registry, ShellAPI, Windows;

function WordCount(const S: string; const WordDelims: TCharSet): Integer;
var
  SLen, I: Cardinal;
begin
  Result := 0;
  I := 1;
  SLen := Length(S);
  while I <= SLen do begin
    while (I <= SLen) and (S[I] in WordDelims) do Inc(I);
    if I <= SLen then Inc(Result);
    while (I <= SLen) and not(S[I] in WordDelims) do Inc(I);
  end;
end;

function WordPosition(const N: Integer; const S: string;
  const WordDelims: TCharSet): Integer;
var
  Count, I: Integer;
begin
  Count := 0;
  I := 1;
  Result := 0;
  while (I <= Length(S)) and (Count <> N) do begin
    { skip over delimiters }
    while (I <= Length(S)) and (S[I] in WordDelims) do Inc(I);
    { if we're not beyond end of S, we're at the start of a word }
    if I <= Length(S) then Inc(Count);
    { if not finished, find the end of the current word }
    if Count <> N then
      while (I <= Length(S)) and not (S[I] in WordDelims) do Inc(I)
    else Result := I;
  end;
end;

function ExtractWord(N: Integer; const S: string;
  const WordDelims: TCharSet): string;
var
  I: Integer;
  Len: Integer;
begin
  Len := 0;
  I := WordPosition(N, S, WordDelims);
  if I <> 0 then
    { find the end of the current word }
    while (I <= Length(S)) and not(S[I] in WordDelims) do begin
      { add the I'th character to result }
      Inc(Len);
      SetLength(Result, Len);
      Result[Len] := S[I];
      Inc(I);
    end;
  SetLength(Result, Len);
end;

function MakeStr(C: Char; N: Integer): string;
begin
  if N < 1 then Result := ''
  else begin
{$IFNDEF WIN32}
    if N > 255 then N := 255;
{$ENDIF WIN32}
    SetLength(Result, N);
    FillChar(Result[1], Length(Result), C);
  end;
end;

function AddCharL(C: Char; const S: string; N: Integer): string;
begin
  if Length(S) < N then
    Result := MakeStr(C, N - Length(S)) + S
  else Result := S;
end;

function AddCharR(C: Char; const S: string; N: Integer): string;
begin
  if Length(S) < N then
    Result := S + MakeStr(C, N - Length(S))
  else Result := S;
end;

function PaddL(const S: string; N: Integer; C: Char): string;
begin
  Result := AddCharL(C,S,N);
end;

function PaddR(const S: string; N: Integer; C: Char): string;
begin
  Result := AddCharR(C,S,N);
end;

function PaddLT(const S: string; N: Integer; C: Char): string;
begin
  if Length(S) < N then
    Result := MakeStr(C, N - Length(S)) + S
  else Result := copy(S,1,N);
end;

function PaddRT(const S: string; N: Integer; C: Char): string;
begin
  if Length(S) < N then
    Result := S + MakeStr(C, N - Length(S))
  else Result := copy(S,1,N);
end;

function OnlyNumeric(AStrValue: string) : integer;
var i : integer;
    sTemp : string;
begin
  sTemp := '';
  for i := 1 to Length(AStrValue) do
    if AStrValue[i] in ['0'..'9', '-', '+'] then
      sTemp := sTemp + AStrValue[i];
  Result := StrToIntDef(sTemp, 0);
end;

function OraPercToDouble(AOra, APerc : integer) : Double;
begin
  Result := AOra + (APerc / 60);
end;

function FokFokPercToDouble(AFok, AFokPerc : integer) : Double;
begin
  if AFok >= 0 then
    Result := AFok + (AFokPerc / 60)
  else
    Result := AFok - (AFokPerc / 60);
end;

function DoubleToOra(AIdopont: Double) : integer;
begin
  Result := Round(Int(AIdopont));
end;

function DoubleToPerc(AIdopont: Double) : integer;
begin
  Result := Abs(Round(Frac(AIdopont) * 60));
end;

function DoubleFokToStr(AFok: double; AAll: Boolean = true): string;
begin
  Result := IntToStr(Trunc(AFok)) + '°';
  AFok := AFok - Int(AFok);
  if AFok <> 0 then
    begin
      Result := Result + PaddL(IntToStr(Trunc(AFok * 60)), 2, '0') + '''';
      AFok := AFok - (Trunc(AFok * 60) / 60);
      if AAll then
        if AFok <> 0 then
          Result := Result + PaddL(IntToStr(Trunc(AFok * 60 * 60)), 2, '0') + '"';
    end;
end;

function DoubleToFokStrOnlyFokPerc(AFok: double): string;
begin
  Result := IntToStr(Trunc(AFok));
  AFok := AFok - Int(AFok);
  if AFok <> 0 then
    Result := Result + '.' + PaddL(IntToStr(Trunc(AFok * 60)), 2, '0');
end;

function GetFokFromListItem(AFokFokPerc: string) : Double;
begin
  Result := StrToIntDef(AFokFokPerc, 0) div 100;
end;

function GetFokPercFromListItem(AFokFokPerc: string) : Double;
begin
  Result := Abs(StrToIntDef(AFokFokPerc, 0) - ((StrToIntDef(AFokFokPerc, 0) div 100) * 100));
end;

function GetDayNumberSinceJ2000(AIdoPont: TDateTime): Double;
begin
  Result :=   367 * YearOf(AIdoPont) - 7 * (YearOf(AIdoPont) + (MonthOf(AIdoPont) + 9) div 12) div 4
            + 275 * MonthOf(AIdoPont) div 9 + DayOf(AIdoPont) - cY2000 + (HourOf(AIdoPont) + MinuteOf(AIdoPont) / 60) / 24;
end;

function TryOwnEncodeDateTime(const AYear, AMonth, ADay, AHour, AMinute, ASecond, AMilliSecond: Word; out AValue: TDateTime): Boolean;
var
  LTime: TDateTime;
begin
  {
    TryEncodeDateTime not correct for dates before Dec. 30, 1899
    http://qc.embarcadero.com/wc/qcmain.aspx?d=3792
    Mar. 10, 1803 11:07:59 will be encoded as Mar. 11, 1803 12:52:01
  }

  Result := TryEncodeDate(AYear, AMonth, ADay, AValue);
  if Result then
  begin
    Result := TryEncodeTime(AHour, AMinute, ASecond, AMilliSecond, LTime);
    if Result then
      if AValue > 0 then
        AValue := AValue + LTime
      else
        AValue := AValue - LTime;
  end;
end;

function GetReszletFromCESTIdopont(ACestReszlet: TCestReszlet; ACestIdopont: string) : integer;
begin
  Result := 0;
  case ACestReszlet of
  tcOra  : StrToIntDef(ExtractWord(1, ACestIdopont, [':']), 0);
  tcPerc : StrToIntDef(ExtractWord(2, ACestIdopont, [':']), 0);
  tcMP   : StrToIntDef(ExtractWord(3, ACestIdopont, [':']), 0);
  end;
end;

function Degs: Double;
begin
  Result := 180 / PI;
end;

function Rads: Double;
begin
  Result := PI / 180;
end;

function AddFokSzam(AOrigFok, AAddFok: Double) : Double;
begin
  Result := AOrigFok + AAddFok;
  if Result < 0 then
    Result := 360 - (Abs(AAddFok) - AOrigFok)
  else
    if Result >= 360 then
      Result := Result - 360;
end;

function AddInteger(AMaxValue, AAktValue, AIncValue : integer) : integer;
begin
  AAktValue := AAktValue + AIncValue;

  if AAktValue < 0 then
    AAktValue := AMaxValue - (Abs(AIncValue) - AAktValue)
  else
    if AAktValue > AMaxValue then
      AAktValue := AAktValue - AMaxValue;

  Result := AAktValue;
end;

function BoolToStrAstro(AValue: boolean; ALongFormat: boolean) : string;
begin
  Result := '';
  case AValue of
  true : if ALongFormat then Result := 'True' else Result := 'T';
  false: if ALongFormat then Result := 'False' else Result := 'F';
  end;
end;

function StrAstroToBool(AValue: string) : boolean;
begin
  Result := false;
  if pos('T', AValue) > 0 then Result := true else
  if pos('F', AValue) > 0 then Result := false;
end;

function BoolToRetrogradeAstro(AValue: boolean) : string;
begin
  Result := '';
  case AValue of
  true : Result := 'R';
  false: Result := ' ';
  end;
end;

function IsBetweenDeg(AValue, AStart, AEnd: Double) : boolean;
begin
  Result := false;

  if AStart <= AEnd then
    Result := (AValue >= AStart) and (AValue <= AEnd)
  else
    if AStart > AEnd then
      begin
        Result := ((AValue >= AStart) and (AValue <= 360)) or
                  ((AValue >= 0) and (AValue <= AEnd))
      end;
end;

function IncPeriodValue(AValue, ACount, AMinPeriod, AMaxPeriod: Double): Double;
begin
  AValue := AValue + ACount;
  if AValue > AMaxPeriod then
    begin
      AValue := AValue - AMaxPeriod - 1;
    end
  else
    if AValue < AMinPeriod then
      begin
        AValue := AValue + AMaxPeriod + 1;
      end;

  Result := AValue;
end;

function PointInTriangle(const Px, Py, x1, y1, x2, y2, x3, y3 : Double) : boolean;
var or1, or2, or3 : integer;
begin
  or1 := Orientation(x1, y1, x2, y2, Px, Py);
  or2 := Orientation(x2, y2, x3, y3, Px, Py);
  or3 := Orientation(x3, y3, x1, y1, Px, Py);

  if (or1 = or2) and (or2 = or3) then Result := true else
  if (or1 = 0) then Result := (or2 = 0) or (or3 = 0) else
  if (or2 = 0) then Result := (or1 = 0) or (or3 = 0) else
  if (or3 = 0) then Result := (or2 = 0) or (or1 = 0) else
  Result := false;
end;

function Orientation(const x1, y1, x2, y2, Px, Py : Double) : integer;
var orin : Double;
begin
  orin := (x2 - x1) * (Py - y1) - (Px - x1) * (y2 - y1);

  if orin > 0.0 then
    Result := +1
  else
    if orin < 0.0 then
      Result := -1
    else
      Result := 0; 
end;

function GetMetszespont(AX1, AY1, AX2, AY2, AU1, AV1, AU2, AV2: integer; AXValue: boolean): integer;
var a1, a2, b1, b2, xi, yi, x1, x2, y1, y2, u1, u2, v1, v2 : integer;
begin
  Result := 0;

  {
    input x1,y1
    input x2,y2
    input u1,v1
    input u2,v2

    b1 = (y2-y1)/(x2-x1) (A)
    b2 = (v2-v1)/(u2-u1) (B)
    a1 = y1-b1*x1
    a2 = v1-b2*u1

    xi =-(a1-a2)/(b1-b2) (C)
    yi = a1+b1*xi

    if (x1-xi)*(xi-x2)>=0 AND (u1-xi)*(xi-u2)>=0 AND (y1-yi)*(yi-y2)>=0 AND (v1-yi)*(yi-v2)>=0 then print "az egyenesek metszéspontja",xi,yi
    else print "az egyenesek nem metszõdnek"
    end if
  }

  x1 := AX1; y1 := AY1;
  x2 := AX2; y2 := AY2;

  u1 := AU1; v1 := AV1;
  u2 := AU2; v2:= AV2;

  b1 := 0; b2 := 0;

  if ((x2 - x1) <> 0) and ((u2 - u1) <> 0) and ((b1 - b2) <> 0) then
    begin
      b1 := Round((y2-y1)/Max(1, (x2-x1)));
      b2 := Round((v2-v1)/Max(1, (u2-u1)));
      a1 := y1-b1*x1;
      a2 := v1-b2*u1;

      xi :=-Round((a1-a2)/Max(1, (b1-b2)));
      yi := a1+b1*xi;

      if AXValue then
        Result := xi
      else
        Result := yi;
    end;
end;

(*
  Szakasz felezõpontjának koordinátái: az A -B szakasz F felezõpontjának koordinátái:
  x ={x1 +x2 /2}, y ={y1 +y2 /2}.

  A végpontok koordinátáival megadott szakasz felezõpontjának koordinátái a végpontok megfelelõ koordinátáinak számtani közepei.

  A végpontok koordinátáival megadott szakasz harmadolópontjának koordinátái:
  x =x1 +2*x2 /3 y =y1 +2*y2 /3.

  A H harmadolópont koordinátáit megkapjuk, ha a hozzá közelebbi végpont megfelelõ koordinátája kétszereséhez hozzáadjuk a távolabbi végpont megfelelõ koordinátáját, s ezt az összeget osztjuk 3mal.
*)

function GetHarmadoloPont(AValue1, AValue2 : integer) : integer;
begin
// (2 * iKozepX + (xc + xk1)) div 3
  Result := (AValue1 + 2 * AValue2) div 3;
end;

function GetFelezoPont(AValue1, AValue2 : integer) : integer;
begin
  Result := (AValue1 + AValue2) div 2;
end;

function MelyTernegyedben(B, C, D, E, A, Z: TPoint; var ADebugStr: String): TTerNegyed;
var iDEFTAV : integer;
    P, Q, R, S : TPoint;
begin
  Result := negyNONE; ADebugStr := '';

  iDEFTAV := 500 ; //Abs(A.X - Z.X) * 5;

  // P kiszámítása...

  P.X := A.X + iDEFTAV;
  Q.X := P.X;

  // irányvektoros egyenletek
  P.Y :=
    ( (B.Y - A.Y) * P.X - (B.Y - A.Y) * A.X + (B.X - A.X) * A.Y )
    div
    (B.X - A.X);

  Q.Y :=
    ( (C.Y - A.Y) * P.X - (C.Y - A.Y) * A.X + (C.X - A.X) * A.Y )
    div
    (C.X - A.X);

  // többi pont értéke...
  R.X := A.X - iDEFTAV;
  R.Y := Q.Y;

  S.X := R.X;
  S.Y := P.Y;

  if PointInTriangle(Z.X, Z.Y, A.X, A.Y, P.X, P.Y, Q.X, Q.Y) then Result := negyJobb else
  if PointInTriangle(Z.X, Z.Y, A.X, A.Y, Q.X, Q.Y, R.X, R.Y) then Result := negyAlso else
  if PointInTriangle(Z.X, Z.Y, A.X, A.Y, R.X, R.Y, S.X, S.Y) then Result := negyBal else
  if PointInTriangle(Z.X, Z.Y, A.X, A.Y, S.X, S.Y, P.X, P.Y) then Result := negyFelso;

  ADebugStr :=
    'A.X : ' + IntToStr(A.X) + ' ; A.Y : ' + IntToStr(A.Y) + #13 + #13 +
    'B.X : ' + IntToStr(B.X) + ' ; B.Y : ' + IntToStr(B.Y) + #13 +
    'C.X : ' + IntToStr(C.X) + ' ; C.Y : ' + IntToStr(C.Y) + #13 +
    'D.X : ' + IntToStr(D.X) + ' ; D.Y : ' + IntToStr(D.Y) + #13 +
    'E.X : ' + IntToStr(E.X) + ' ; E.Y : ' + IntToStr(E.Y) + #13 + #13 +
    'P.X : ' + IntToStr(P.X) + ' ; P.Y : ' + IntToStr(P.Y) + #13 +
    'Q.X : ' + IntToStr(Q.X) + ' ; Q.Y : ' + IntToStr(Q.Y) + #13 +
    'R.X : ' + IntToStr(R.X) + ' ; R.Y : ' + IntToStr(R.Y) + #13 +
    'S.X : ' + IntToStr(S.X) + ' ; S.Y : ' + IntToStr(S.Y) + #13 + #13 +
    'Z.X : ' + IntToStr(Z.X) + ' ; Z.Y : ' + IntToStr(Z.Y) + #13 + #13;

  case Result of
  negyNONE : ADebugStr := ADebugStr + 'Nincs negyed!';
  negyJobb : ADebugStr := ADebugStr + 'Jobb negyed!';
  negyAlso : ADebugStr := ADebugStr + 'Alsó negyed!';
  negyBal  : ADebugStr := ADebugStr + 'Bal negyed!';
  negyFelso: ADebugStr := ADebugStr + 'Felsõ negyed!';
  end;
end;

{
A vonal egyenlete:
y = a + bx

A kör egyenlete:
(x-a)2+(y-b)2=r2

itt a 2-es a négyzet akar lenni

Két egyenes metszéspontjai:
xi = -(a1-a2) / (b1-b2)
yi = a1 + b1xi
}

{
A metszéspontot hogy kapom meg?

Ax + t1 * (Bx-Ax) == Cx + t2 * (Dx-Cx)
Ay + t1 * (By-Ay) == Cy + t2 * (Dy-Cy)
Az + t1 * (Bz-Az) == Cz + t2 * (Dz-Cz)

t1,t2 -re megoldod. Ha nincs megoldás, akkor a két egyenes kitérõ, ha egy megoldás van, akkor metszõ, ha végtelen sok megoldás van, akkor a két egyenes egybeesik.

A metszéspont pedig a megoldás visszahelyettesítésébõl adódik:

Px = Ax + t1 * (Bx-Ax)
Py = Ay + t1 * (By-Ay)
Pz = Az + t1 * (Bz-Az)
}

function BrowseURL(const URL: string) : boolean;
var Browser: string;
begin
  Result := True;
  Browser := '';
  with TRegistry.Create do
    try
      RootKey := HKEY_CLASSES_ROOT;
      Access := KEY_QUERY_VALUE;
      if OpenKey('\htmlfile\shell\open\command', False) then
        Browser := ReadString('') ;
      CloseKey;
    finally
      Free;
    end;

  if Browser = '' then
    begin
      Result := False;
      Exit;
    end;
  Browser := Copy(Browser, Pos('"', Browser) + 1, Length(Browser)) ;
  Browser := Copy(Browser, 1, Pos('"', Browser) - 1) ;

  ShellExecute(0, 'open', PChar(Browser), PChar(URL), nil, SW_SHOW) ;end;

{ Visszaadja , hogy egy string benne van-e a CommandLine paraméterekben }
function IsCmdLineArg(const s: string): boolean;
var
  I: Integer;
begin
  Result := false;
  for I := 1 to ParamCount do
  begin
    if LowerCase(trim(ParamStr(I))) = LowerCase(trim(s)) then
    begin
     Result := true;
     break;
    end;
  end;

end;

end.
