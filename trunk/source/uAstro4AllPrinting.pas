{
  Születési képlet nyomtatása
}
unit uAstro4AllPrinting;

interface

uses SysUtils, Controls, Graphics, uAstro4AllDrawing, uAstro4AllTypes, uAstro4AllConsts, uAstro4AllFileHandling;

type
  TDrawPrinterController = class(TDrawControllerBase)
  private
    FPrintType: TPrintType;
    FSzulKepletFormInfo: TSzulKepletFormInfo;
  protected
    function GetAspectPenColor(AColor: TColor): TColor; override;
    function GetBaseBackgroundBrushColor: TColor; override;
    procedure PaintInfoToPrintImage(ACanvas: TCanvas; AWidth, AHeight: integer); override;
  public
    constructor Create(ACanvas: TCanvas; AParentWinControl: TWinControl; ACanvasControl: TControl; ASzulKepletFormInfo:
        TSzulKepletFormInfo; APrintType: TPrintType; ASettingsProvider: TSettingsProvider; AIsPrinting: Boolean = false; AWidth: integer = -1; AHeight: integer =
        -1);
  end;

implementation

uses Math, DateUtils, uSegedUtils, swe_de32, Classes,
  uAstro4AllGraphicsUtils;

constructor TDrawPrinterController.Create(ACanvas: TCanvas; AParentWinControl: TWinControl; ACanvasControl: TControl;
    ASzulKepletFormInfo: TSzulKepletFormInfo; APrintType: TPrintType; ASettingsProvider: TSettingsProvider; AIsPrinting: Boolean = false; AWidth: integer =
    -1; AHeight: integer = -1);
begin
  inherited Create(ACanvas, AParentWinControl, ACanvasControl, ASettingsProvider, AIsPrinting, AWidth, AHeight);
  FSzulKepletFormInfo := ASzulKepletFormInfo;
  FPrintType := APrintType;
end;

{ TDrawPrinterController }

function TDrawPrinterController.GetAspectPenColor(AColor: TColor): TColor;
begin
  Result := clBlack;
end;

function TDrawPrinterController.GetBaseBackgroundBrushColor: TColor;
begin
  Result := clWhite;
end;

procedure TDrawPrinterController.PaintInfoToPrintImage(ACanvas: TCanvas; AWidth, AHeight: integer);
var iTop, iLeft, iPlusGap : integer;
    sPrintable : string;

  procedure DrawNewItem(AGraphicControl: TBaseGraphicControl; AFontName: string; AFontSize: integer; ABrushStyle: TBrushStyle =
    bsClear);
  begin
    if Assigned(AGraphicControl) then
      begin
        ACanvas.Font.Name := AFontName;
        ACanvas.Font.Size := AFontSize;
        ACanvas.Brush.Style := ABrushStyle;

        if AGraphicControl is TPlanetSignGraphicControl then
          ACanvas.TextOut
            (
              AGraphicControl.Left + (AGraphicControl.Width - ACanvas.TextWidth(AGraphicControl.SignLetter)) div 2,
              AGraphicControl.Top + Abs(AGraphicControl.FDecHeightValue),
              AGraphicControl.SignLetter
            )
        else
          if AGraphicControl is TSelfMarkerGraphicControl then
            begin
              //AGraphicControl.Canvas.CopyRect(Rect(AGraphicControl.ClientRect.TopLeft, AGraphicControl.ClientRect.BottomRight), ACanvas, AGraphicControl.Canvas.ClipRect);
              if not TSelfMarkerGraphicControl(AGraphicControl).FTriangle then
                begin // kör
                  DrawCircleToCanvas
                    (
                      ACanvas,
                      Rect(AGraphicControl.Left, AGraphicControl.Top, AGraphicControl.Left + AGraphicControl.Width, AGraphicControl.Top + AGraphicControl.Height), //Canvas.ClipRect,
                      TSelfMarkerGraphicControl(AGraphicControl).BackGroundColor,
                      TSelfMarkerGraphicControl(AGraphicControl).Canvas.Font.Color,
                      clBlack,
                      2,
                      AGraphicControl.Height,
                      AGraphicControl.Width,
                      true
                    );
                end
              else
                begin // 3szeg
                  DrawTriangleToCanvas
                    (
                      ACanvas,
                      Rect(AGraphicControl.Left, AGraphicControl.Top, AGraphicControl.Left + AGraphicControl.Width, AGraphicControl.Top + AGraphicControl.Height), //Canvas.ClipRect,
                      TSelfMarkerGraphicControl(AGraphicControl).BackGroundColor,
                      TSelfMarkerGraphicControl(AGraphicControl).Canvas.Font.Color,
                      clBlack,
                      2,
                      AGraphicControl.Height,
                      AGraphicControl.Width,
                      AGraphicControl.Left,
                      AGraphicControl.Top,
                      TSelfMarkerGraphicControl(AGraphicControl).SelfMarkerPlanetX,
                      TSelfMarkerGraphicControl(AGraphicControl).SelfMarkerPlanetY,
                      true
                    );
                end;
            end
          else
            ACanvas.TextOut
              (
                AGraphicControl.Left + (AGraphicControl.Width - ACanvas.TextWidth(AGraphicControl.SignLetter)) div 2,
                AGraphicControl.Top + (AGraphicControl.Height - ACanvas.TextHeight(AGraphicControl.SignLetter)) div 2,
                AGraphicControl.SignLetter
              );
      end;
  end;

  procedure PrintFejlec;
  var sTemp : string;
  begin
    iTop := iLeft;
    ACanvas.Font.Name := cBASEFONTNAME2;
    ACanvas.Font.Size := Round(GetFontSize * 1.25); //16;

    /////////////////////////////////////////////////////////////////////////
    // Személy neve
    sPrintable := FSzulKepletFormInfo.FSzuletesiKepletInfo.Name;
    ACanvas.TextOut(iLeft, iTop, sPrintable);

    ACanvas.Font.Size := Round(GetFontSize * 0.9);// 12;
    case FPrintType of
    ptSzulKeplet : sPrintable := 'Születési képlet';
    ptDrakonikus : sPrintable := 'Drakonikus ábra';
    prOsszevetes : sPrintable := 'Összevetés';
    end;

    if FSettingsProvider.GetPrintFejlecName then
      ACanvas.TextOut(AWidth - iLeft - ACanvas.TextWidth(sPrintable), iTop + 3, sPrintable);

    ACanvas.Font.Name := cBASEFONTNAME2;
    ACanvas.Font.Size := Round(GetFontSize * 1.25); //16;
    iTop := iTop + ACanvas.TextHeight(sPrintable) + 5;
    /////////////////////////////////////////////////////////////////////////

    /////////////////////////////////////////////////////////////////////////
    // csíkkkkk...
    ACanvas.MoveTo(iLeft, iTop);
    ACanvas.LineTo(AWidth - iLeft, iTop);

    ACanvas.Font.Size := GetFontSize;// 12;
    iTop := iTop + iPlusGap;
    /////////////////////////////////////////////////////////////////////////

    /////////////////////////////////////////////////////////////////////////
    // Születési idõpont
    sPrintable := FormatDateTime('YYYY.MM.DD - hh:nn:ss', FSzulKepletFormInfo.FSzuletesiKepletInfo.DateOfBirth) + '  ' +
                  '(' + cDAYNAMES[DayOfTheWeek(FSzulKepletFormInfo.FSzuletesiKepletInfo.DateOfBirth)] + ')';

    if FSettingsProvider.GetPrintFejlecBirthDate or FSettingsProvider.GetPrintFejlecBirthTime then
      ACanvas.TextOut(iLeft, iTop, sPrintable);

    // Születés helye (ország, város)
    sPrintable := FSzulKepletFormInfo.FSzuletesiKepletInfo.LocCity + ', ' + FSzulKepletFormInfo.FSzuletesiKepletInfo.LocCountry;

    if FSettingsProvider.GetPrintFejlecBirthPlace then
      ACanvas.TextOut(AWidth - iLeft - ACanvas.TextWidth(sPrintable), iTop, sPrintable);

    iTop := iTop + ACanvas.TextHeight(sPrintable) + iPlusGap;
    /////////////////////////////////////////////////////////////////////////

    ACanvas.Font.Size := (GetFontSize div 4) * 3; //10;
    /////////////////////////////////////////////////////////////////////////
    // idõzóna adatok
    sPrintable := 'Idõzóna: ' + FSzulKepletFormInfo.FSzuletesiKepletInfo.TZoneCode;

    sTemp := '';
    if FSzulKepletFormInfo.FSzuletesiKepletInfo.TZoneHour >= 0 then
      sTemp := '+';

    if (Trim(FSzulKepletFormInfo.FSzuletesiKepletInfo.TZoneCode) <> 'LMT') and
       (Trim(FSzulKepletFormInfo.FSzuletesiKepletInfo.TZoneCode) <> '') then
      sPrintable := sPrintable + ' [' + sTemp + IntToStr(FSzulKepletFormInfo.FSzuletesiKepletInfo.TZoneHour) + ':' + PaddL(IntToStr(FSzulKepletFormInfo.FSzuletesiKepletInfo.TZoneMinute), 2, '0') + ']';

    if (Trim(FSzulKepletFormInfo.FSzuletesiKepletInfo.TZoneCode) = 'LMT') then sPrintable := sPrintable + ' [Helyi középidõ]' else
    if (Trim(FSzulKepletFormInfo.FSzuletesiKepletInfo.TZoneCode) = '') then
      sPrintable := sPrintable + ' [Kézi zónaidõ = ' + sTemp +
                    IntToStr(FSzulKepletFormInfo.FSzuletesiKepletInfo.TZoneHour) + ':' + PaddL(IntToStr(FSzulKepletFormInfo.FSzuletesiKepletInfo.TZoneMinute), 2, '0') + ']';

    if FSettingsProvider.GetPrintFejlecTimeZone then
      ACanvas.TextOut(iLeft, iTop, sPrintable);

    // Születési koord adatok...
    sPrintable := IntToStr(Abs(FSzulKepletFormInfo.FSzuletesiKepletInfo.LocLatDegree)) + '°' +
                  PaddL(IntToStr(FSzulKepletFormInfo.FSzuletesiKepletInfo.LocLatMinute), 2, '0') + '''';
    if FSzulKepletFormInfo.FSzuletesiKepletInfo.LocLatDegree >= 0 then
      sPrintable := sPrintable + ' É'
    else
      sPrintable := sPrintable + ' D';

    sPrintable := sPrintable + '  ' +
                  IntToStr(Abs(FSzulKepletFormInfo.FSzuletesiKepletInfo.LocLongDegree)) + '°' +
                  PaddL(IntToStr(FSzulKepletFormInfo.FSzuletesiKepletInfo.LocLongMinute), 2, '0') + '''';

    if FSzulKepletFormInfo.FSzuletesiKepletInfo.LocLongDegree >= 0 then
      sPrintable := sPrintable + ' K'
    else
      sPrintable := sPrintable + ' Ny';

    if FSettingsProvider.GetPrintFejlecBirthPlaceCoord then
      ACanvas.TextOut(AWidth - iLeft - ACanvas.TextWidth(sPrintable), iTop, sPrintable);

    iTop := iTop + ACanvas.TextHeight(sPrintable) + iPlusGap;
    /////////////////////////////////////////////////////////////////////////

    /////////////////////////////////////////////////////////////////////////
    sPrintable := 'Nyári idõszámítás';
    if FSettingsProvider.GetPrintFejlecDaylightTime then
      if FSzulKepletFormInfo.FSzuletesiKepletInfo.IsDayLightSavingTime then
        ACanvas.TextOut(iLeft, iTop, sPrintable);

    iTop := iTop + ACanvas.TextHeight(sPrintable) + iPlusGap;
    /////////////////////////////////////////////////////////////////////////

    /////////////////////////////////////////////////////////////////////////
    sPrintable := 'UT: ' + FormatDateTime('YYYY.MM.DD - hh:nn:ss', FSzulKepletFormInfo.FCalcResult.UniversalTime);
    if FSettingsProvider.GetPrintFejlecUT then
      ACanvas.TextOut(iLeft, iTop, sPrintable);

    sPrintable := 'Házrendszer: ' + GetHouseSystemName(FSettingsProvider.GetHouseCuspSystem);
    if FSettingsProvider.GetPrintFejlecHouseSystem then
      ACanvas.TextOut(AWidth - iLeft - ACanvas.TextWidth(sPrintable), iTop, sPrintable);

    iTop := iTop + ACanvas.TextHeight(sPrintable) + iPlusGap;
    /////////////////////////////////////////////////////////////////////////

    /////////////////////////////////////////////////////////////////////////
    sPrintable := 'ST: ' + FormatDateTime('hh:nn:ss', FSzulKepletFormInfo.FCalcResult.SideralTime);
    if FSettingsProvider.GetPrintFejlecST then
      ACanvas.TextOut(iLeft, iTop, sPrintable);

    sPrintable := 'Tropikus';
    if FSettingsProvider.GetZodiacType = 'S' then
      sPrintable := 'Sziderikus';

    ACanvas.TextOut(AWidth - iLeft - ACanvas.TextWidth(sPrintable), iTop, sPrintable);
    iTop := iTop + ACanvas.TextHeight(sPrintable) + iPlusGap;
    /////////////////////////////////////////////////////////////////////////
  end;

  procedure PrintLablec;
  begin
    ACanvas.Font.Name := cBASEFONTNAME2;
    ACanvas.Font.Size := (GetFontSize div 4) * 3; //10;

    // csíkkkkk...
    //iTop := AHeight - 100;
    iTop := AHeight - Round(iLeft * 1.5);
    ACanvas.MoveTo(iLeft, iTop);
    ACanvas.LineTo(AWidth - iLeft, iTop);

    iTop := iTop + iPlusGap;
    sPrintable := 'Regiomontanus by Nemes Balázs 2009 - 2010     E-mail: info@regiomontanus.hu     http://www.regiomontanus.hu';
    if FSettingsProvider.GetPrintLablecPrgBaseInfo then
      ACanvas.TextOut(iLeft, iTop, sPrintable);

    sPrintable := 'Powered by Swiss Ephemeris';
    ACanvas.TextOut(AWidth - iLeft - ACanvas.TextWidth(sPrintable), iTop, sPrintable);

    iTop := iTop + ACanvas.TextHeight(sPrintable) + iPlusGap;
    //sPrintable := 'Registered to: Nemes Balázs - 2017 Pócsmegyer, Arany János utca 17. Tel.: +36203711729';
    sPrintable := 'Registered to: Humanisztikus Asztrológia Iskola';
    if FSettingsProvider.GetPrintLablecRegInfo then
      ACanvas.TextOut(iLeft, iTop, sPrintable);
  end;

  procedure PrintBolygok;
  // egy lehetséges sor:  O R  18°47'  K  12
  const cWIDTH = 'O R   18°47,  K  12 12,(11),10,9';
  var i, iBaseWidth : integer;
      oPlanet : TPlanet;
      oAxis : TAxis;
      iOrigBrushStyle : TBrushStyle;
  begin
    iOrigBrushStyle := ACanvas.Brush.Style;
    ACanvas.Brush.Style := bsClear;
    
    ACanvas.Font.Name := cBASEFONTNAME2;
    //ACanvas.Font.Size := 12;
    ACanvas.Font.Size := GetFontSize;

    iTop := AHeight - iLeft - 13 * (ACanvas.TextHeight('A') + iPlusGap);
    sPrintable := 'Bolygók';
    ACanvas.TextOut(AWidth - iLeft - ACanvas.TextWidth(cWIDTH), iTop, sPrintable);

    iBaseWidth := ACanvas.TextWidth('W');

    iTop := iTop + iPlusGap + ACanvas.TextHeight(sPrintable);
    ACanvas.MoveTo(AWidth - iLeft - ACanvas.TextWidth(cWIDTH), iTop);
    ACanvas.LineTo(AWidth - iLeft, iTop);

    iTop := iTop + iPlusGap;
    iLeft := AWidth - iLeft - ACanvas.TextWidth(cWIDTH);

    for i := 0 to FSzulKepletFormInfo.FCalcResult.PlanetList.Count - 1 do
      begin
        oPlanet := FSzulKepletFormInfo.FCalcResult.PlanetList.GetPlanet(i);
        if oPlanet.PlanetID in [SE_SUN..SE_PLUTO, SE_MEAN_NODE {SE_TRUE_NODE{}] then
          begin
            ACanvas.Font.Name := cSYMBOLSFONTNAME;
            ACanvas.Font.Size := GetFontSize; //12
            ACanvas.TextOut(iLeft, iTop - 2, cPLANETLIST[oPlanet.PlanetID].cPlanetLetter);

            ACanvas.Font.Name := cBASEFONTNAME2;
            ACanvas.Font.Size := GetFontSize div 2; //6

            if oPlanet.Retrograd then
              ACanvas.TextOut(iLeft + iBaseWidth, iTop + GetFontSize - GetFontSize div 2, 'R');

            if FSettingsProvider.GetPrintPlanetDegs then
              begin
                ACanvas.Font.Name := cBASEFONTNAME2;
                ACanvas.Font.Size := (GetFontSize div 4) * 3; //10;

                sPrintable := DoubleFokToStr(oPlanet.StartDegree);
                ACanvas.TextOut(iLeft + iBaseWidth * 6 - ACanvas.TextWidth(sPrintable), iTop, sPrintable);
              end;

            if FSettingsProvider.GetPrintPlanetZodiac then
              begin
                ACanvas.Font.Name := cSYMBOLSFONTNAME;
                ACanvas.Font.Size := GetFontSize; // 12;
                ACanvas.TextOut(iLeft + iBaseWidth * 7, iTop - 2, cZODIACANDPLANETLETTERS[oPlanet.InZodiacSign].cZodiacLetter);
              end;

            if FSettingsProvider.GetPrintPlanetHousePos then
              begin
                ACanvas.Font.Name := cBASEFONTNAME2;
                ACanvas.Font.Size := (GetFontSize div 4) * 3; //10;
                case FSettingsProvider.GetShowHouseNumbersByArabicNumbers of
                true : ACanvas.TextOut(iLeft + iBaseWidth * 9, iTop, cHOUSECAPTIONS[oPlanet.HouseNumber].sHouseNumberArabic);
                false: ACanvas.TextOut(iLeft + iBaseWidth * 9, iTop, cHOUSECAPTIONS[oPlanet.HouseNumber].sHouseNumberOther);
                end;
              end;

            if FSettingsProvider.GetPrintPlanetHouseLords then
              begin
                ACanvas.Font.Size := (GetFontSize div 4) * 3; //10; //GetFontSize div 2; //7
                ACanvas.TextOut(iLeft + iBaseWidth * 11, iTop{ + 4{}, oPlanet.FHouseLordsContainer.GetHouseNumberTexts);
              end;

            ACanvas.Font.Size := (GetFontSize div 4) * 3; //10;
            iTop := iTop + ACanvas.TextHeight('K') + iPlusGap;
          end;
      end;

    for i := 0 to FSzulKepletFormInfo.FCalcResult.AxisList.Count - 1 do
      begin
        oAxis := FSzulKepletFormInfo.FCalcResult.AxisList.GetAxisInfo(i);
        if oAxis.AxisID in [SE_ASC..SE_MC] then
          begin
            ACanvas.Font.Name := cBASEFONTNAME2;
            ACanvas.Font.Size := (GetFontSize div 4) * 3; //10;

            ACanvas.TextOut(iLeft, iTop, cAXISNAMES[oAxis.AxisID].sShortAxisName);

            sPrintable := DoubleFokToStr(oAxis.StartDegree);
            ACanvas.TextOut(iLeft + iBaseWidth * 6 - ACanvas.TextWidth(sPrintable), iTop, sPrintable);

            ACanvas.Font.Name := cSYMBOLSFONTNAME;
            ACanvas.Font.Size := GetFontSize;// 12;
            ACanvas.TextOut(iLeft + iBaseWidth * 7, iTop - 2, cZODIACANDPLANETLETTERS[oAxis.InZodiacSign].cZodiacLetter);

            ACanvas.Font.Size := (GetFontSize div 4) * 3; //10;
            iTop := iTop + ACanvas.TextHeight('K') + iPlusGap;
          end;
      end;

    ACanvas.Brush.Style := iOrigBrushStyle;
  end;

  procedure PrintHazak;
  // egy lehetséges sor:  O R  18°47'  K  12
  const cWIDTH = 'OO   18°47,   K';
  var i, iBaseWidth : integer;
      oHouseCusp : THouseCusp;
  begin
    ACanvas.Font.Name := cBASEFONTNAME2;
    ACanvas.Font.Size := GetFontSize;// 12;
    ACanvas.Brush.Style := bsClear;

    iLeft := Round(50 * (GetFontSize / 12));

    iTop := AHeight - Round(iLeft * 5.1) - 12 * (ACanvas.TextHeight('A') + iPlusGap) - 4;
    sPrintable := 'Házak';

    //iLeft := 385;
    //iLeft := AWidth - Round(250 * (GetFontSize / 12));
    iLeft := AWidth - iLeft - Round((ACanvas.TextWidth(sPrintable) * 2.5));
    ACanvas.TextOut(iLeft, iTop, sPrintable);

    iBaseWidth := ACanvas.TextWidth('W');

    iTop := iTop + iPlusGap + ACanvas.TextHeight(sPrintable);
    ACanvas.MoveTo(iLeft, iTop);
    ACanvas.LineTo(iLeft + ACanvas.TextWidth(cWIDTH), iTop);

    iTop := iTop + iPlusGap;

    for i := 1 to FSzulKepletFormInfo.FCalcResult.HouseCuspList.Count - 1 do
      begin
        oHouseCusp := FSzulKepletFormInfo.FCalcResult.HouseCuspList.GetHouseCuspInfo(i);

        if oHouseCusp.HouseNumber in [1..12] then
          begin
            ACanvas.Font.Name := cBASEFONTNAME2;
            ACanvas.Font.Size := (GetFontSize div 4) * 3; //10;
            case FSettingsProvider.GetShowHouseNumbersByArabicNumbers of
            true : ACanvas.TextOut(iLeft, iTop, cHOUSECAPTIONS[oHouseCusp.HouseNumber].sHouseNumberArabic);
            false: ACanvas.TextOut(iLeft, iTop, cHOUSECAPTIONS[oHouseCusp.HouseNumber].sHouseNumberOther);
            end;

            sPrintable := DoubleFokToStr(oHouseCusp.StartDegree);
            ACanvas.TextOut(iLeft + iBaseWidth * 5 - ACanvas.TextWidth(sPrintable), iTop, sPrintable);

            ACanvas.Font.Name := cSYMBOLSFONTNAME;
            ACanvas.Font.Size := GetFontSize;// 12;
            ACanvas.TextOut(iLeft + iBaseWidth * 6, iTop - 2, cZODIACANDPLANETLETTERS[oHouseCusp.InZodiacSign].cZodiacLetter);

            //
            ACanvas.Font.Size := (GetFontSize div 4) * 3; //10;
            iTop := iTop + ACanvas.TextHeight('K') + iPlusGap;
          end;
      end;
  end;

  procedure PrintFenyszogek;
  //const cWIDTH = 'OOOOOOOOOOOOOOOOOOOOOO';
  var i, iBaseWidth, iHeight, iPlus: integer;
      iTopx, iTopy, iBottomX, iBottomY : integer;
      oAspectInfo : TAspectInfo;
      bOK : boolean;
  begin
    ACanvas.Font.Name := cBASEFONTNAME2;
    ACanvas.Font.Size := GetFontSize;// 12;
    ACanvas.Brush.Style := bsClear;

    //iBaseWidth := ACanvas.TextWidth('W');

    //iLeft := 55;
    iLeft := Round(50 * (GetFontSize / 12));

    iTop := AHeight - Round(iLeft * 1.5) {64{} - 14 * (ACanvas.TextHeight('A') + iPlusGap);
    //sPrintable := 'Fényszögek';

    //ACanvas.TextOut(iLeft, iTop, sPrintable);

    ACanvas.Font.Size := (GetFontSize div 4) * 3; //10;
    iBaseWidth := ACanvas.TextWidth('AC');

    //iTop := iTop + iPlusGap + ACanvas.TextHeight(sPrintable);
    //ACanvas.MoveTo(iLeft, iTop);
    //ACanvas.LineTo(iLeft + ACanvas.TextWidth(cWIDTH), iTop);

    //iTop := iTop + iPlusGap;

    ACanvas.Font.Name := cSYMBOLSFONTNAME; // bolygó típus
    ACanvas.Font.Size := GetFontSize;// 12;
    iPlus := 0; iHeight := 0;

    // SE_SUN..SE_PLUTO, SE_TRUE_NODE
    for i := 1 to 13 do
      begin
        if i - 1 in [SE_SUN..SE_PLUTO] then
          begin
            ACanvas.Font.Name := cSYMBOLSFONTNAME; // bolygó típus
            ACanvas.Font.Size := GetFontSize;// 12;
            sPrintable := cPLANETLIST[i - 1].cPlanetLetter;
            iHeight := ACanvas.TextHeight('S');
            iPlus := 0;
          end
        else
          case i of
          11 : begin
                 ACanvas.Font.Name := cSYMBOLSFONTNAME; // bolygó típus
                 ACanvas.Font.Size := GetFontSize;// 12;
                 sPrintable := cPLANETLIST[SE_MEAN_NODE{SE_TRUE_NODE{}].cPlanetLetter;
                 iHeight := ACanvas.TextHeight('S');
                 iPlus := 0;
               end;
          12, 13 :
               begin
                 ACanvas.Font.Name := cBASEFONTNAME2;
                 ACanvas.Font.Size := (GetFontSize div 5) * 4; //9;
                 sPrintable := cAXISNAMES[i - 12].sShortAxisName;
                 iPlus := 3;
               end;
          end;

        ACanvas.TextOut
          (
            iLeft + ((i - 1) * iBaseWidth),
            iTop + ((iHeight + iPlusGap) * (i - 1)) + iPlus,
            sPrintable
          );
        // rácsozás megrajzolása...
        if i = 1 then
          begin
            // függõleges vonal
            iTopx := iLeft - 1 - 2;
            iTopy := iTop + ((iHeight + iPlusGap) * (i));

            iBottomX := iTopx;
            iBottomY := iTop + ((iHeight + iPlusGap) * (13));

            ACanvas.MoveTo(iTopx, iTopy);
            ACanvas.LineTo(iBottomX, iBottomY);

            // víszintes vonal
            iTopx := iLeft - 1 - 2;
            iTopy := iTop + ((iHeight + iPlusGap) * (i ));

            iBottomX := iLeft + ((i) * iBaseWidth) - 1 - 2;
            iBottomY := iTop + ((iHeight + iPlusGap) * (i ));

            ACanvas.MoveTo(iTopx, iTopy);
            ACanvas.LineTo(iBottomX, iBottomY);
          end;

        if i in [1..12] then
          begin
            // függõleges vonal
            iTopx := iLeft + ((i {-1}) * iBaseWidth) - 1 - 2;
            iTopy := iTop + ((iHeight + iPlusGap) * (i));

            iBottomX := iTopx;
            iBottomY := iTop + ((iHeight + iPlusGap) * (13));

            ACanvas.MoveTo(iTopx, iTopy);
            ACanvas.LineTo(iBottomX, iBottomY);

            // víszintes vonal
            iTopx := iLeft + ((Min(12, i + 1)) * iBaseWidth) - 1 - 2;
            iTopy := iTop + ((iHeight + iPlusGap) * (i + 1));

            iBottomX := iLeft + ((0) * iBaseWidth) - 1 - 2;
            iBottomY := iTop + ((iHeight + iPlusGap) * (i + 1));

            ACanvas.MoveTo(iTopx, iTopy);
            ACanvas.LineTo(iBottomX, iBottomY);
          end;

      end; // For vége
    iTopx := 0; iTopy := 0; 
    ACanvas.Font.Name := cSYMBOLSFONTNAME; // bolygó típus
    ACanvas.Font.Size := GetFontSize; //(GetFontSize div 5) * 2; //8;
    for i := 0 to FSzulKepletFormInfo.FCalcResult.AspectList.Count - 1 do
      begin
        oAspectInfo := FSzulKepletFormInfo.FCalcResult.AspectList.GetAspectInfo(i);
        // oAspectInfo.Aspect01Type - tasc_None, tasc_Planet, tasc_Axis, tasc_HouseCusp

        bOK := false;
        if (
             (oAspectInfo.Aspect01Type = tasc_Planet) and
             (oAspectInfo.Aspect01ID in [SE_SUN..SE_PLUTO, SE_TRUE_NODE])
           )
           and
           (
             (
               (oAspectInfo.Aspect02Type = tasc_Planet) and
               (oAspectInfo.Aspect02ID in [SE_SUN..SE_PLUTO, SE_TRUE_NODE])
             )
             or
             (
               (oAspectInfo.Aspect02Type = tasc_Axis) and
               (oAspectInfo.Aspect02ID in [SE_ASC..SE_MC])
             )
           )
          then bOK := true;

        if bOK then
          begin
            if (oAspectInfo.Aspect01Type = tasc_Planet) and (oAspectInfo.Aspect02Type = tasc_Planet) then
              begin
                iTopx := oAspectInfo.Aspect01ID; //Min(11, oAspectInfo.Aspect01ID);
                iTopy := oAspectInfo.Aspect02ID; //Min(11, oAspectInfo.Aspect02ID);

                if oAspectInfo.Aspect01ID > 10 then iTopx := iTopx - 1;
                if oAspectInfo.Aspect02ID > 10 then iTopy := iTopy - 1;
              end
            else{}
              if (oAspectInfo.Aspect01Type = tasc_Planet) and (oAspectInfo.Aspect02Type = tasc_Axis) then
                begin
                  iTopx := oAspectInfo.Aspect01ID ;//Min(12, oAspectInfo.Aspect01ID);
                  iTopy := oAspectInfo.Aspect02ID + 11;

                  if oAspectInfo.Aspect01ID > 10 then iTopx := iTopx - 1;
                end;

            sPrintable := cFENYSZOGSETTINGS[oAspectInfo.AspectID].cAspectLetter;

            // az iID = 0..9 bolygók ; 10 - felsz ; 11 - AS ; 12 - MC
            ACanvas.TextOut
              (
                iLeft + ((Min(iTopx, iTopy)) * iBaseWidth),
                iTop + ((iHeight + iPlusGap) * (Max(iTopx, iTopy))) + iPlus,
                sPrintable
              );
          end;
      end;
  end;

  procedure PrintEletstrategiaTablazat;
  //const cWIDTH = 'OO   18°47,   K';
  const cCELLWIDTH : integer = 90; //50
  var i, j, {iBaseWidth, {}iSavediTop : integer;
  begin
    ACanvas.Font.Name := cBASEFONTNAME2;
    ACanvas.Font.Size := GetFontSize; //12;

    iLeft := Round(50 * (GetFontSize / 12));

    iTop := AHeight - iLeft - 13 * (ACanvas.TextHeight('A') + iPlusGap);
    //iTop := AHeight - Round(iLeft * 1.8) {64{} - 14 * (ACanvas.TextHeight('A') + iPlusGap);

    //iTop := AHeight - 80 - 12 * (ACanvas.TextHeight('A') + iPlusGap) - 4;
    sPrintable := 'Életstratégia, "járatlan út" ';

    //iLeft := 260;
    iLeft := Round(280 * (GetFontSize / 12));
    ACanvas.TextOut(iLeft, iTop, sPrintable);

    //iBaseWidth := ACanvas.TextWidth('W');

    iTop := iTop + iPlusGap + ACanvas.TextHeight(sPrintable);
    ACanvas.MoveTo(iLeft, iTop);
    ACanvas.LineTo(iLeft + ACanvas.TextWidth(sPrintable), iTop);

    iTop := iTop + iPlusGap * 7;
    iSavediTop := iTop;

    ACanvas.Font.Size := (GetFontSize div 4) * 3; //10;
    
    cCELLWIDTH := ACanvas.TextWidth('Levegõs__');

    sPrintable := 'O'; // Kard.     Fix     Vált.      Össz.
    //ACanvas.TextOut(iLeft + 55, iTop, sPrintable);
    ACanvas.TextOut(iLeft + (1 * cCELLWIDTH) + ((cCELLWIDTH - ACanvas.TextWidth('Kard.')) div 2), iTop, 'Kard.');
    ACanvas.TextOut(iLeft + (2 * cCELLWIDTH) + ((cCELLWIDTH - ACanvas.TextWidth('Fix')) div 2), iTop, 'Fix');
    ACanvas.TextOut(iLeft + (3 * cCELLWIDTH) + ((cCELLWIDTH - ACanvas.TextWidth('Vált.')) div 2), iTop, 'Vált.');
    ACanvas.TextOut(iLeft + (4 * cCELLWIDTH) + ((cCELLWIDTH - ACanvas.TextWidth('Össz.')) div 2), iTop, 'Össz.');

    iTop := iTop + iPlusGap + ACanvas.TextHeight(sPrintable);

    sPrintable := 'Tüzes';
    ACanvas.TextOut(iLeft, iTop, sPrintable);
    iTop := iTop + iPlusGap + ACanvas.TextHeight(sPrintable);

    sPrintable := 'Földes';
    ACanvas.TextOut(iLeft, iTop, sPrintable);
    iTop := iTop + iPlusGap + ACanvas.TextHeight(sPrintable);

    sPrintable := 'Levegõs';
    ACanvas.TextOut(iLeft, iTop, sPrintable);
    iTop := iTop + iPlusGap + ACanvas.TextHeight(sPrintable);

    sPrintable := 'Vizes';
    ACanvas.TextOut(iLeft, iTop, sPrintable);
    iTop := iTop + iPlusGap + ACanvas.TextHeight(sPrintable);

    sPrintable := 'Össz.';
    ACanvas.TextOut(iLeft, iTop, sPrintable);
    iTop := iTop + iPlusGap + ACanvas.TextHeight(sPrintable);

    sPrintable := 'O';
    iTop := iSavediTop + iPlusGap + ACanvas.TextHeight(sPrintable);
    // vízszintes vonalak
    for i := 1 to 6 do
      begin
        ACanvas.MoveTo(iLeft, iTop - 2);
        ACanvas.LineTo(iLeft + cCELLWIDTH * 5, iTop - 2);

        iTop := iTop + iPlusGap + ACanvas.TextHeight(sPrintable);
      end;
    // függõleges vonalak
    for i := 1 to 5 do
      begin
        ACanvas.MoveTo(iLeft + i * cCELLWIDTH, iSavediTop );
        ACanvas.LineTo(iLeft + i * cCELLWIDTH, iTop - iPlusGap * 2 - ACanvas.TextHeight(sPrintable));
      end;

    for i := 1 to 4 do
      for j := 1 to 5 do
        begin
          sPrintable := IntToStr(TCalcResult(CalcResultList.Items[0]).matrJartJaratlanPontszam[i,j]);
          ACanvas.TextOut
            (
              iLeft + (i * cCELLWIDTH) + ((cCELLWIDTH - ACanvas.TextWidth(sPrintable)) div 2),
              iSavediTop + j * (iPlusGap + ACanvas.TextHeight(sPrintable)),
              sPrintable
            );
        end;

    iTop := iTop - iPlusGap * 2;

    sPrintable := 'Életstratégia: ';

    for i := 0 to Length(TCalcResult(CalcResultList.Items[0]).utJartUt) - 1 do
      sPrintable := sPrintable + cZODIACANDPLANETLETTERS[TCalcResult(CalcResultList.Items[0]).utJartUt[i]].sZodiacName + ',';
    delete(sPrintable, Length(sPrintable), 1);

    ACanvas.TextOut(iLeft + 60, iTop, sPrintable);
    iTop := iTop + iPlusGap + ACanvas.TextHeight(sPrintable);

    sPrintable := 'Járatlan út: ';
    for i := 0 to Length(TCalcResult(CalcResultList.Items[0]).utJaratlanUt) - 1 do
      sPrintable := sPrintable + cZODIACANDPLANETLETTERS[TCalcResult(CalcResultList.Items[0]).utJaratlanUt[i]].sZodiacName + ',';
    delete(sPrintable, Length(sPrintable), 1);

    ACanvas.TextOut(iLeft + 60, iTop, sPrintable);
    iTop := iTop + iPlusGap + ACanvas.TextHeight(sPrintable);
  end;

var i : integer;
begin
  // Fejléc szöveg kíírás
  ACanvas.Font.Name := cBASEFONTNAME2;
  ACanvas.Font.Size := 16;

  iLeft := Round(50 * (GetFontSize / 12));
  iPlusGap := 3;

  if FSettingsProvider.GetPrintFejlecTable then PrintFejlec;
    
  if FSettingsProvider.GetPrintLablecTable then PrintLablec;

  if FSettingsProvider.GetPrintPlanetTable then PrintBolygok;

  // majd egyéb printbeállítás segítségével
  if FSettingsProvider.GetPrintHouseTable then PrintHazak;

  if FSettingsProvider.GetPrintAspectTable then PrintFenyszogek;

  if FSettingsProvider.GetPrintEletstratTable then PrintEletstrategiaTablazat;

  /////////////////////////////////////////////////////////////////////////
  for i := 0 to ZodiacSignGraphicControlList.Count - 1 do
    begin
      // zodiákus jegy
      if ZodiacSignGraphicControlList.Count > 0 then
        DrawNewItem(TZodiacSignGraphicControl(ZodiacSignGraphicControlList.Items[i]), cSYMBOLSFONTNAME, Round(GetFontSize * 1.3));
      // analóg planéta
      if ZodiacPlanetSignGraphicControlList.Count > 0 then
        DrawNewItem(TPlanetZodiacSignGraphicControl(ZodiacPlanetSignGraphicControlList.Items[i]), cSYMBOLSFONTNAME, GetFontSize - 2);
    end;

  // házszámok...
  for i := 0 to HouseSignGraphicControlList.Count - 1 do // 11 do // 1->12
    DrawNewItem(THouseNumberGraphicControl(HouseSignGraphicControlList.Items[i]), cBASEFONTNAME2, GetFontSize - 5);

  // bolygók
  for i := 0 to PlanetGraphicControlList.Count - 1 do
    begin
      if TPlanetSignGraphicControl(PlanetGraphicControlList.Items[i]).FIsShortNamePlanet then
        DrawNewItem(TPlanetSignGraphicControl(PlanetGraphicControlList.Items[i]), cSYMBOLSFONTNAME, Round(GetFontSize * 1.3), bsSolid)
      else
        DrawNewItem(TPlanetSignGraphicControl(PlanetGraphicControlList.Items[i]), cBASEFONTNAME, (Round(GetFontSize * 1.3) div 3) * 2, bsSolid)
    end;

  // énjelölõk
  for i := 0 to SelfMarkerGraphicControlList.Count - 1 do
    DrawNewItem(TSelfMarkerGraphicControl(SelfMarkerGraphicControlList.Items[i]), cSYMBOLSFONTNAME, Round(GetFontSize * 0.8));

  DrawPlanetsInfo(TCalcResult(CalcResultList.Items[0]).AxisList.GetAxisInfo(SE_ASC).RA, TCalcResult(CalcResultList.Items[0]).PlanetList);
end;

end.
