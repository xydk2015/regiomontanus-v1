//////////////////////////////////////////////////////////////////////////////
//                                                                          //
//  Unit NLDCollision                                                       //
//                                                                          //
//  Determination of intersection point of two 2-dimensional lines          //
//                                                                          //
//                                                                          //
//  Original idea by: PsychoMark@NLDelphi.com                               //
//  See also:         http://www.nldelphi.com/Forum/showthread.php?t=13154  //
//                                                                          //
//                                                                          //
//  By NLDelphi.com members ©2006                                           //
//                                                                          //
//////////////////////////////////////////////////////////////////////////////

unit NLDCollision;

interface

uses
  Windows;

type
  TLine = record
    X1: Integer;
    Y1: Integer;
    X2: Integer;
    Y2: Integer;
  end;

  TIntersectResult = (irParallel, irNoLength, irIntersection,
    irApparentIntersection, irBeyondIntegerLimits);

function Line(const AX1, AY1, AX2, AY2: Integer): TLine;

function LinesIntersect(const ALine1, ALine2: TLine): TIntersectResult;
  overload;
function LinesIntersect(const ALine1, ALine2: TLine;
  var AHit: TPoint): TIntersectResult; overload;

implementation

uses
  Math;

function Line(const AX1, AY1, AX2, AY2: Integer): TLine;
begin
  Result.X1 := AX1;
  Result.Y1 := AY1;
  Result.X2 := AX2;
  Result.Y2 := AY2;
end;

function LinesIntersect(const ALine1, ALine2: TLine): TIntersectResult;
var
  pDummy: TPoint;
begin
  Result := LinesIntersect(ALine1, ALine2, pDummy);
end;

//////////////////////////////////////////////////////////////////////////////
//                                                                          //
// EXAMPLE DEFINITION OF USED MATHEMATICAL FORMULAS                         //
//                                                                          //
// General 2D-line (1):        y = (Slope * x) + Offset                     //
// Offset (2):            Offset = y - (Slope * x)                          //
//                                                                          //
// Line1:                      y = 6x + 2  (= Slope1 * x + Offset1)         //
// Line2:                      y = 3x + 5  (= Slope2 * x + Offset2)         //
// Intersection point:         y = y                                        //
// Substitution:          6x + 2 = 3x + 5                                   //
//                       6x - 3x = 5 - 2                                    //
//                      x(6 - 3) = 5 - 2                                    //
// Intersection result:        x = (5 - 2) / (6 - 3)                        //
// Translation (3):            x = (Offset2 - Offset1) / (Slope1 - Slope2)  //
//                                                                          //
//////////////////////////////////////////////////////////////////////////////

function LinesIntersect(const ALine1,
  ALine2: TLine; var AHit: TPoint): TIntersectResult; overload;

  function Slope(const ALine: TLine): Double;
  const
    SlopeVertical = 9999999999;
    //SlopeHorizontal = 0;
  begin
    with ALine do
      if X1 = X2 then
        Result := SlopeVertical
      else
        Result := (Y2 - Y1) / (X2 - X1);
    if Abs(Result) >= SlopeVertical then
      Result := SlopeVertical;
  end;

  function HasLength(const ALine: TLine): Boolean;
  begin
    with ALine do
      Result := (X1 <> X2) or (Y1 <> Y2);
  end;

  function PointWithinLine(const APoint: TPoint; const ALine: TLine): Boolean;
  begin
    with APoint, ALine do
      Result := (X >= Min(X1, X2)) and (X <= Max(X1, X2)) and
                (Y >= Min(Y1, Y2)) and (Y <= Max(Y1, Y2));
  end;

var
  Slope1: Double;
  Slope2: Double;
  Offset1: Double;
  Offset2: Double;
  IntersectX: Double;
  IntersectY: Double;
begin
  if not (HasLength(ALine1) and HasLength(ALine2)) then
  begin
    Result := irNoLength;
    Exit;
  end;
  Slope1 := Slope(ALine1);
  Slope2 := Slope(ALine2);
  if Slope1 = Slope2 then
  begin
    Result := irParallel;
    Exit;
  end;
  Offset1 := ALine1.Y1 - (Slope1 * ALine1.X1); //see formula 2 above
  Offset2 := ALine2.Y1 - (Slope2 * ALine2.X1);
  IntersectX := (Offset2 - Offset1) / (Slope1 - Slope2); //see formula 3 above
  IntersectY := (Slope1 * IntersectX) + Offset1; //see formula 1 above
  AHit.X := Round(IntersectX);
  AHit.Y := Round(IntersectY);
  if PointWithinLine(AHit, ALine1) and PointWithinLine(AHit, ALine2) then
    Result := irIntersection
  else
    Result := irApparentIntersection;
  if ((Round(IntersectX) > MaxInt) or (Round(IntersectY) > MaxInt)) then
    Result := irBeyondIntegerLimits;
end;

end.


