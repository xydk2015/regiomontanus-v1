{
  Nyomtatás próba
}
unit uAstro4AllPrintTest;

interface

uses Windows, Messages, Classes, Graphics, ExtCtrls, Forms, Controls, Contnrs,
     Printers, Math, SysUtils;

procedure DrawImage(Canvas: TCanvas; DestRect: TRect; ABitmap: TBitmap);
procedure PrintImage(AImage: TBitmap; ZoomPercent: Integer);

implementation

procedure DrawImage(Canvas: TCanvas; DestRect: TRect; ABitmap: TBitmap);
var
  Header, Bits: Pointer;
  HeaderSize: DWORD;
  BitsSize: DWORD;
begin
  GetDIBSizes(ABitmap.Handle, HeaderSize, BitsSize);
  Header := AllocMem(HeaderSize);
  Bits := AllocMem(BitsSize);
  try
    GetDIB(ABitmap.Handle, ABitmap.Palette, Header^, Bits^);
    StretchDIBits(Canvas.Handle, DestRect.Left, DestRect.Top,
      DestRect.Right, DestRect.Bottom,
      0, 0, ABitmap.Width, ABitmap.Height, Bits, TBitmapInfo(Header^),
      DIB_RGB_COLORS, SRCCOPY);
  finally
    FreeMem(Header, HeaderSize);
    FreeMem(Bits, BitsSize);
  end;
end;

procedure PrintImage(AImage: TBitmap; ZoomPercent: Integer);
// if ZoomPercent=100, AImage will be printed across the whole page
var
  relHeight, relWidth: integer;
begin
  Screen.Cursor := crHourglass;
  Printer.BeginDoc;
  with AImage do 
  begin
    if ((Width / Height) > (Printer.PageWidth / Printer.PageHeight)) then
    begin
      // Stretch Bitmap to width of PrinterPage
      relWidth := Printer.PageWidth;
      relHeight := MulDiv(Height, Printer.PageWidth, Width);
    end 
    else
    begin
      // Stretch Bitmap to height of PrinterPage
      relWidth  := MulDiv(Width, Printer.PageHeight, Height);
      relHeight := Printer.PageHeight;
    end;
    relWidth := Round(relWidth * ZoomPercent / 100);
    relHeight := Round(relHeight * ZoomPercent / 100);
    DrawImage(Printer.Canvas, Rect(0, 0, relWidth, relHeight), AImage);
  end;
  Printer.EndDoc;
  Screen.cursor := crDefault;
end;

end.

(*
uses
  printers;

procedure DrawImage(Canvas: TCanvas; DestRect: TRect; ABitmap: TBitmap);
var
  Header, Bits: Pointer;
  HeaderSize: DWORD;
  BitsSize: DWORD;
begin
  GetDIBSizes(ABitmap.Handle, HeaderSize, BitsSize);
  Header := AllocMem(HeaderSize);
  Bits := AllocMem(BitsSize);
  try
    GetDIB(ABitmap.Handle, ABitmap.Palette, Header^, Bits^);
    StretchDIBits(Canvas.Handle, DestRect.Left, DestRect.Top,
      DestRect.Right, DestRect.Bottom,
      0, 0, ABitmap.Width, ABitmap.Height, Bits, TBitmapInfo(Header^),
      DIB_RGB_COLORS, SRCCOPY);
  finally
    FreeMem(Header, HeaderSize);
    FreeMem(Bits, BitsSize);
  end;
end;

procedure PrintImage(Image: TImage; ZoomPercent: Integer);
  // if ZoomPercent=100, Image will be printed across the whole page
var 
  relHeight, relWidth: integer;
begin
  Screen.Cursor := crHourglass;
  Printer.BeginDoc;
  with Image.Picture.Bitmap do 
  begin
    if ((Width / Height) > (Printer.PageWidth / Printer.PageHeight)) then
    begin
      // Stretch Bitmap to width of PrinterPage
      relWidth := Printer.PageWidth;
      relHeight := MulDiv(Height, Printer.PageWidth, Width);
    end 
    else
    begin
      // Stretch Bitmap to height of PrinterPage
      relWidth  := MulDiv(Width, Printer.PageHeight, Height);
      relHeight := Printer.PageHeight;
    end;
    relWidth := Round(relWidth * ZoomPercent / 100);
    relHeight := Round(relHeight * ZoomPercent / 100);
    DrawImage(Printer.Canvas, Rect(0, 0, relWidth, relHeight), Image.Picture.Bitmap);
  end;
  Printer.EndDoc;
  Screen.cursor := crDefault;
end;

// Example Call:

procedure TForm1.Button1Click(Sender: TObject);
begin
  // Print image at 40% zoom:
  PrintImage(Image1, 40);
end;
*) 