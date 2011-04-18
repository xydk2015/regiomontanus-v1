unit uAstro4AllGraphicsUtils;

interface

uses Windows, Types, Graphics, Math;

procedure DrawCircleToCanvas(ACanvas: TCanvas; ARect: TRect; ABgColor, ABrushColor, APenColor: TColor; APenWidth, AHeight,
  AWidth: integer; APrint: Boolean = false);

procedure DrawTriangleToCanvas(ACanvas: TCanvas; ARect: TRect; ABgColor, ABrushColor, APenColor: TColor; APenWidth, AHeight,
  AWidth, ALeft, ATop, ASelfMarkerPlanetX, ASelfMarkerPlanetY: integer; APrint: Boolean = false);

procedure GetArrowPoint(width, height: integer; p1, p2: TPoint; var p3, p4: TPoint; endpoint: boolean);

implementation

uses uAstro4AllConsts, uSegedUtils, NLDCollision;

procedure DrawCircleToCanvas(ACanvas: TCanvas; ARect: TRect; ABgColor, ABrushColor, APenColor: TColor; APenWidth, AHeight,
  AWidth: integer; APrint: Boolean = false);
begin
  if not APrint then
    ACanvas.FillRect(ARect);
    
  ACanvas.Brush.Color := ABgColor;
  ACanvas.Pen.Color := APenColor;
  ACanvas.Pen.Width := APenWidth; //2
  if not APrint then
    ACanvas.Ellipse(ARect.Left, ARect.Top, Min(AHeight, AWidth), Min(AHeight, AWidth))
  else
    ACanvas.Ellipse(ARect.Left, ARect.Top, ARect.Left + Min(AHeight, AWidth), ARect.Top + Min(AHeight, AWidth));

  ACanvas.Brush.Color := ABrushColor;
  if not APrint then
    ExtFloodFill(ACanvas.Handle, Min(AHeight, AWidth) div 2, Min(AHeight, AWidth) div 2, APenColor, FLOODFILLBORDER)
  else
    ExtFloodFill
      (
        ACanvas.Handle,
        ARect.Left + Min(AHeight, AWidth) - Min(AHeight, AWidth) div 2,
        ARect.Top + Min(AHeight, AWidth) - Min(AHeight, AWidth) div 2,
        APenColor,
        FLOODFILLBORDER
      );
end;

procedure GetArrowPoint(width, height: integer; p1, p2: TPoint; var p3, p4: TPoint; endpoint: boolean);
var
  p, xy1: TPoint;
  h2, c1, f, ang: extended;
  sa, ca: integer;
begin
  xy1 := Point(p1.x-p2.x, p1.y-p2.y);
  c1  := sqrt(xy1.y * xy1.y + xy1.x * xy1.x);
  f   := width / c1;
  if endpoint then
    begin
      p := Point(Round(p2.x+f*xy1.x), Round(p2.y+f*xy1.y));
    end
  else
    begin
      p := Point(Round(p1.x-f*xy1.x), Round(p1.y-f*xy1.y));
    end;
  if p1.x <> p2.x then
    begin
      ang := arctan(xy1.y/xy1.x);
      h2 := height/2;
      sa := Round(sin(ang)*h2);
      ca := Round(cos(ang)*h2);
    end
  else
    begin
      ang := arctan(xy1.x/xy1.y);
      h2 := height/2;
      ca := Round(sin(ang)*h2);
      sa := Round(cos(ang)*h2);
  end;
  if endpoint then
    begin
      p3 := Point(p.x+sa, p.y-ca);
      p4 := Point(p.x-sa, p.y+ca);
    end
  else
    begin
      p3 := Point(p.x-sa, p.y+ca);
      p4 := Point(p.x+sa, p.y-ca);
    end;
end;

procedure DrawTriangleToCanvas(ACanvas: TCanvas; ARect: TRect; ABgColor, ABrushColor, APenColor: TColor; APenWidth, AHeight,
  AWidth, ALeft, ATop, ASelfMarkerPlanetX, ASelfMarkerPlanetY: integer; APrint: Boolean = false);
var melyTernegyed : TTerNegyed;
    B,C,D,E,A,Z,P,APntMetszet : TPoint;
    sDeb : string;
    arr: array[0..3] of TPoint;
begin
  if not APrint then
    ACanvas.FillRect(ARect);

  ACanvas.Brush.Color := ABgColor;
  ACanvas.Pen.Color := APenColor;
  ACanvas.Pen.Width := APenWidth;

  // a 4 csúcs - jobb felsõ saroktól indulva
  B := Point(ALeft + AWidth, ATop);
  C := Point(ALeft + AWidth, ATop + AHeight);
  D := Point(ALeft, ATop + AHeight);
  E := Point(ALeft, ATop);

  // középpont
  A := Point(ALeft + AWidth div 2, ATop + AHeight div 2);

  // a távoli pont
  Z := Point(ASelfMarkerPlanetX, ASelfMarkerPlanetY);

  // keressük P-t
  melyTernegyed := MelyTernegyedben(B,C,D,E,A,Z,sDeb);

  case melyTernegyed of
  negyNONE : begin
               if (Z.X < B.X) and (Z.Y < B.Y) then // bal felsõ sarok
                 P := E
               else
                 if (Z.X > C.X) and (Z.Y < C.Y) then // jobb felsõ
                   P := B
                 else
                   if (Z.X > D.X) and (Z.Y > D.Y) then // jobb alsó
                     P := C
                   else
                     if (Z.X < E.X) and (Z.Y > E.Y) then // bal alsó
                       P := D;
             end;
  negyJobb : begin
               LinesIntersect(Line(B.X, B.Y, C.X, C.Y), Line(A.X, A.Y, Z.X, Z.Y), APntMetszet);
               if not APrint then
                 P.X := AWidth
               else
                 P.X := ALeft + AWidth;

               if not APrint then
                 P.Y := APntMetszet.Y - B.Y
               else
                 P.Y := ATop + APntMetszet.Y - B.Y;
             end;
  negyAlso : begin
               LinesIntersect(Line(D.X, D.Y, C.X, C.Y), Line(A.X, A.Y, Z.X, Z.Y), APntMetszet);
               if not APrint then
                 P.X := APntMetszet.X - D.X
               else
                 P.X := ALeft + APntMetszet.X - D.X;

               if not APrint then
                 P.Y := AHeight
               else
                 P.Y := ATop + AHeight;
             end;
  negyBal : begin
               LinesIntersect(Line(E.X, E.Y, D.X, D.Y), Line(A.X, A.Y, Z.X, Z.Y), APntMetszet);
               if not APrint then
                 P.X := 0
               else
                 P.X := ALeft;

               if not APrint then
                 P.Y := APntMetszet.Y - E.Y
               else
                 P.Y := ATop + APntMetszet.Y - E.Y;
             end;
  negyFelso : begin
               LinesIntersect(Line(E.X, E.Y, B.X, B.Y), Line(A.X, A.Y, Z.X, Z.Y), APntMetszet);

               if not APrint then
                 P.X := APntMetszet.X - E.X
               else
                 P.X := ALeft + APntMetszet.X - E.X;

               if not APrint then
                 P.Y := 0
               else
                 P.Y := ATop;
             end;
  end;

  // ez már a Control közepe!!!
  if not APrint then
    A.X := AWidth div 2
  else
    A.X := ALeft + AWidth div 2;
  if not APrint then
    A.Y := AHeight div 2
  else
    A.Y := ATop + AHeight div 2;

  if not APrint then
    GetArrowPoint(AWidth div 5 * 3, AHeight div 5 * 3, P, A, B, C, false)
  else
    GetArrowPoint(AWidth div 4 * 3, AHeight div 4 * 3, P, A, B, C, false);

  arr[0] := P;
  arr[1] := B;
  arr[2] := C;
  arr[3] := P;
  ACanvas.Brush.Color := ABrushColor;
  ACanvas.Polygon(Slice(arr, 4));
end;

end.
