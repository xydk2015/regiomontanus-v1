unit PointAndPolygon;

interface

uses Windows;

function PointInPolygon(TestPolygon: array of TPoint; TestPoint : TPoint) : Boolean;
function InSide (const x,y : integer; Polygon: array of TPoint): boolean;

{The function has been developed by Philippe De Boe and Thérèse Hanquet,
 Brussels, Belgium, for a custom cartography application.}

{It applies to polygons considered by Microsoft as ALTERNATE
 http://msdn.microsoft.com/library/psdk/gdi/regions_2z8l.htm}

{The algorithm is based on a simple assumption:
 if you draw the horizontal line on which the point is located,
 and if you travel along this line,
 if the point is inside the polygon,
 you will cross the perimeter of the polygon an odd number of times
 before reaching the point - and an odd number of times after.
 If it is not inside the polygone,
 you will not cross the perimeter of the polygon,
 or you will cross it an even number of times before reaching the point
 and an even number of times after}

{Of course this can also work with a vertical line but it can be less intuitive
 to read because in some cases y coordinates may be oriented toward the top
 and in other cases toward the bottom}

{Comments are welcome at therese.hanquet@skynet.be}

implementation

function PointInPolygon(TestPolygon: array of TPoint; TestPoint : TPoint) : Boolean;

var ToTheLeftofPoint, ToTheRightofPoint : Byte;
    np : Integer;
    OpenPolygon : Boolean;
    XIntersection : Real;

 begin
  ToTheLeftofPoint := 0;
  ToTheRightofPoint := 0;
  OpenPolygon := False;

{tests if the polygon is closed}

 if not ((TestPolygon[0].X=TestPolygon[High(TestPolygon)].X) and
         (TestPolygon[0].Y=TestPolygon[High(TestPolygon)].Y)) then
         OpenPolygon := True;

{tests for each couple of points to see if the side between them
 crosses the horizontal line going through TestPoint}

  for np := 1 to High(TestPolygon) do
    if ((TestPolygon[np-1].Y <= TestPoint.Y) and
        (TestPolygon[np].Y > TestPoint.Y)) or
         ((TestPolygon[np-1].Y > TestPoint.Y) and
        (TestPolygon[np].Y <= TestPoint.Y))

    {if it does}

         then begin
         {computes the x coordinate of the intersection}

         XIntersection := TestPolygon[np-1].X +
             ((TestPolygon[np].X-TestPolygon[np-1].X)/
              (TestPolygon[np].Y-TestPolygon[np-1].Y))
              *(TestPoint.Y-TestPolygon[np-1].Y);

         {increments appropriate counter}
         if XIntersection < TestPoint.X then Inc(ToTheLeftofPoint);
         if XIntersection > TestPoint.X then Inc(ToTheRightofPoint);

         end;

  {if the polygon is open, test for the last side}

  if OpenPolygon then
   begin
    np := High(TestPolygon);  {Thanks to William Boyd - 03/06/2001}
    if ((TestPolygon[np].Y <= TestPoint.Y) and
        (TestPolygon[0].Y > TestPoint.Y)) or
         ((TestPolygon[np].Y > TestPoint.Y) and
        (TestPolygon[0].Y <= TestPoint.Y))
        then begin
         XIntersection := TestPolygon[np].X +
             ((TestPolygon[0].X-TestPolygon[np].X)/
              (TestPolygon[0].Y-TestPolygon[np].Y))
              *(TestPoint.Y-TestPolygon[np].Y);

         if XIntersection < TestPoint.X then Inc(ToTheLeftofPoint);
         if XIntersection > TestPoint.X then Inc(ToTheRightofPoint);
        end;
   end;

  if (ToTheLeftofPoint mod 2 = 1) and (ToTheRightofPoint mod 2 = 1)
      then Result := True else Result := False;

  end;

// InSide function by Andreas Filsinger
function InSide (const x,y : integer; Polygon: array of TPoint): boolean;
  var
     PolyHandle: HRGN;
begin
   PolyHandle := CreatePolygonRgn(Polygon[0],length(Polygon),Winding);
   result     := PtInRegion(PolyHandle,X,Y);
   DeleteObject(PolyHandle);
end;

end.
