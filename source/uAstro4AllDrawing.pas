{
  Rajzolást végzõ osztályok
}
unit uAstro4AllDrawing;

interface

uses Forms, Windows, Classes, Graphics, uAstro4AllTypes, Contnrs, Controls, ExtCtrls,
     uAstro4AllConsts, uAstro4AllFileHandling;

type
  TRectInformations = class(TObject)
  private
    FWinControl: TWinControl;
    FHeight, FWidth : integer;
    FMargin: integer;
    FPrintFromTop: Integer;
    FPrinting : boolean;
  public
    constructor Create(AWinControl: TWinControl; AWidth: integer = -1; AHeight: integer = -1);
    function GetBottomRightX: Integer;
    function GetBottomRightY: Integer;
    function GetMaxHeightWidth: Integer;
    function GetMidPointX: Integer;
    function GetMidPointY: Integer;
    function GetTopLeftX: Integer;
    function GetTopLeftY: Integer;
    procedure RecalcMargin(APrint: Boolean = false);
    property Margin: integer read FMargin;
  end;

  TBaseGraphicControl = class(TImage)
  private
    FBackGroundColor: TColor;
    FDecTextValue: Integer;
    FFokPerc: string;
    FFontSize: Integer;
    FHazursag: string;
    FKepletIdx: Integer;
    FOwnerDraw: Boolean;
    FRetrograde: string;
    FSignID: Integer;
    FSignLetter: string;
    procedure SetFontSize(const Value: Integer);
    procedure SetHintString(AID : integer); virtual; abstract;
    procedure SetSignID(const Value: Integer);
    procedure SetSignLetter(AID: integer); virtual; abstract;

    procedure OnBaseImageClick(Sender: TObject);
  protected
  public
    FDecHeightValue: Integer;
    FIsShortNamePlanet: Boolean;
    constructor Create(AOwner: TComponent); override;
    procedure RecalcHeight(AKellDecrease: boolean = true);
    property BackGroundColor: TColor read FBackGroundColor write FBackGroundColor;
    property FontSize: Integer read FFontSize write SetFontSize;
    property KepletIdx: Integer read FKepletIdx write FKepletIdx;
    property SignID: Integer read FSignID write SetSignID;
    property SignLetter: string read FSignLetter;
  end;

  TZodiacSignGraphicControl = class(TBaseGraphicControl)
  private
    procedure SetHintString(AID : integer); override;
    procedure SetSignLetter(AID: integer); override;
  public
  end;

  TPlanetZodiacSignGraphicControl = class(TBaseGraphicControl)
  private
    procedure SetHintString(AID : integer); override;
    procedure SetSignLetter(AID: integer); override;
  end;

  TPlanetSignGraphicControl = class(TBaseGraphicControl)
  private
    FNewLeft: Integer;
    FNewRA: Double;
    FNewTop: Integer;
    FOrigLeft: Integer;
    FOrigRA: Double;
    FOrigTop: Integer;
    FPainted : boolean;
    FPlanet: TPlanet;
    FPlanetName: string;
    procedure SetHintString(AID : integer); override;
    procedure SetNewLeft(const Value: Integer);
    procedure SetNewRA(const Value: Double);
    procedure SetNewTop(const Value: Integer);
    procedure SetOrigLeft(const Value: Integer);
    procedure SetOrigRA(const Value: Double);
    procedure SetOrigTop(const Value: Integer);
    procedure SetSignLetter(AID: integer); override;
    procedure OnImageClick(Sender: TObject);
    procedure SetPlanet(const Value: TPlanet);
  protected
    procedure Paint; override;
  public
    FHouseNumArabic: Boolean;
    constructor Create(AOwner: TComponent); override;
    property NewLeft: Integer read FNewLeft write SetNewLeft;
    property NewRA: Double read FNewRA write SetNewRA;
    property NewTop: Integer read FNewTop write SetNewTop;
    property OrigLeft: Integer read FOrigLeft write SetOrigLeft;
    property OrigRA: Double read FOrigRA write SetOrigRA;
    property OrigTop: Integer read FOrigTop write SetOrigTop;
    property Planet: TPlanet read FPlanet write SetPlanet;
    property PlanetName: string read FPlanetName write FPlanetName;
  end;

  TSelfMarkerGraphicControl = class(TBaseGraphicControl)
  private
    FPainted: Boolean;
    FSelfMarkerPlanetX: Integer;
    FSelfMarkerPlanetY: Integer;
    procedure DoOwnerPaint;
    procedure PaintCircle;
    procedure PaintTriangle;
    procedure SetHintString(AID : integer); override;
    procedure SetSignLetter(AID: integer); override;
  protected
    procedure SelfOnResize(Sender: TObject);
    procedure Paint; override;
  public
    FTriangle: Boolean;
    constructor Create(AOwner: TComponent); override;
    procedure SetSelfMarkerPlanetXY(X, Y: Integer);
    property SelfMarkerPlanetX: Integer read FSelfMarkerPlanetX;
    property SelfMarkerPlanetY: Integer read FSelfMarkerPlanetY;
  end;

  THouseNumberGraphicControl = class(TBaseGraphicControl)
  private
    FHouseCusp: THouseCusp;
    procedure SetHintString(AID : integer); override;
    procedure SetHouseCusp(const Value: THouseCusp);
    procedure SetSignLetter(AID: integer); override;
  public
    FHouseNumArabic: Boolean;
    constructor Create(AOwner: TComponent); override;
    property HouseCusp: THouseCusp read FHouseCusp write SetHouseCusp;
  end;

  TGraphicControlList = class(TObjectList)
  private
    function GetItemIndexOfGraphicControl(AKepletIdx: integer; ASignID: integer): Integer;
  public
    procedure AddGraphicItem(AGraphicItem: TBaseGraphicControl);
    function GetGraphicItem(AKepletIdx: integer; ASignID: integer): TBaseGraphicControl;
  end;

  TDrawControllerBase = class(TObject)
  private
    FCalcResultList: TObjectList;
    FCanvas: TCanvas;
    FobjCanvasInfo: TRectInformations;
    FParentWinControl: TWinControl;
    FCanvasControl: TControl;

    FIsPrinting: Boolean; // Nyomtatáshoz...

    FHouseSignGraphicControlList: TGraphicControlList;
    FPlanetGraphicControlList: TGraphicControlList;
    FSelfMarkerGraphicControlList: TGraphicControlList;
    FSzemelyisegRajz: Boolean;
    FZodiacPlanetSignGraphicControlList: TGraphicControlList;
    FZodiacSignGraphicControlList: TGraphicControlList;

    r,                // sugár mérete
    xc, yc : integer; // középpont

    procedure DrawAspects(AListIndexValue: Integer; ARA: double; AAspectList: TAspectInfoList; APlanetList: TPlanetList; AAxisList:
      TAxisList; AHouseCuspList: THouseList);
    procedure DrawBaseCircles(AListIndexValue: Integer; ARA: double);
    procedure DrawHouseCusps(AListIndexValue: Integer; ARA: double; AHouseCuspList: THouseList);
    procedure DrawHouseNumbers(AListIndexValue: Integer; ARA: double; AHouseCuspList: THouseList);
    procedure DrawPlanets(AListIndexValue: Integer; ARA: double; APlanetList: TPlanetList; ASelfMarkerList: TSelfMarkerList);
    procedure DrawSelfMarkers(AListIndexValue: Integer; ARA: double; ASelfMarkerList: TSelfMarkerList);
    procedure HideSelfMarkers(AHide: boolean = true);
    procedure DrawZodiacSigns(AListIndexValue: Integer; ARA: double);
    function GetColorOfType(AColorType: TColorType): TColor;
    function GetInnerHouseBorderGap: Integer;
    function GetInnerZodiacBorderGap: Integer;
    function GetInnerZodiacBorderGap_IfOtherDeg : integer;
    function GetOuterHouseBorderGap: Integer;
    function GetOuterZodiacBorderGap: Integer;
    function GetPlanetBorderLineGap: Integer;
    function GetPlanetExtBorderLineGap : integer;
    function GetSzorzoErtekFor_iGaps: Double;
    function GetZodiacBorderLineGap: Integer;
    function GetZodiacBorderLineGap_IfOtherDeg : integer;
    procedure ReArrangePlanets(ARA : double);
    function GetZodiacSignColor(AZodiacSignID: integer) : TColor;
    function Get_iGap_ForPlanets(AListIndexValue: Integer): Integer;
    function IsPlanetVisible(APlanetID: Integer): Boolean;
  protected
    FSettingsProvider: TSettingsProvider;
    procedure DrawPlanetsInfo(ARA: double; APlanetList: TPlanetList);
    function GetAspectPenColor(AColor: TColor): TColor; virtual;
    function GetBaseBackgroundBrushColor: TColor; virtual;
    function GetCalcResultCount: Integer;
    function GetFontSize: Integer;
    procedure PaintInfoToPrintImage(ACanvas: TCanvas; AWidth, AHeight: integer); virtual;

    property CalcResultList: TObjectList read FCalcResultList;
    property HouseSignGraphicControlList: TGraphicControlList read FHouseSignGraphicControlList;
    property PlanetGraphicControlList: TGraphicControlList read FPlanetGraphicControlList;
    property SelfMarkerGraphicControlList: TGraphicControlList read FSelfMarkerGraphicControlList;
    property ZodiacPlanetSignGraphicControlList: TGraphicControlList read FZodiacPlanetSignGraphicControlList;
    property ZodiacSignGraphicControlList: TGraphicControlList read FZodiacSignGraphicControlList;
  public
    FKellLockWindow : boolean;
    constructor Create(ACanvas: TCanvas; AParentWinControl: TWinControl; ACanvasControl: TControl; ASettingsProvider:
      TSettingsProvider; AIsPrinting: Boolean = false; AWidth: integer = -1; AHeight: integer = -1);
    destructor Destroy; override;
    procedure DrawCalculatedResult(ACalcResult: TCalcResult);
    procedure ReDrawCalculatedResults;
    procedure ClearDrawingItems;
    property SzemelyisegRajz: Boolean read FSzemelyisegRajz write FSzemelyisegRajz;
  end;

implementation

uses Dialogs, SysUtils, Math, Types, uSegedUtils, swe_de32, NLDCollision,
  uAstro4AllConstProvider, uAstro4AllGraphicsUtils;

procedure TDrawControllerBase.ClearDrawingItems;
begin
  FSelfMarkerGraphicControlList.Clear;
end;

constructor TDrawControllerBase.Create(ACanvas: TCanvas; AParentWinControl: TWinControl; ACanvasControl: TControl;
  ASettingsProvider: TSettingsProvider; AIsPrinting: Boolean = false; AWidth: integer = -1; AHeight: integer = -1);
begin
  inherited Create;
  FCanvas := ACanvas;
  FCalcResultList := TObjectList.Create();
  FobjCanvasInfo := TRectInformations.Create(AParentWinControl, AWidth, AHeight);
  FParentWinControl := AParentWinControl;
  FCanvasControl := ACanvasControl;

  FIsPrinting := AIsPrinting;

  FZodiacSignGraphicControlList := TGraphicControlList.Create();
  FZodiacPlanetSignGraphicControlList := TGraphicControlList.Create();
  FPlanetGraphicControlList := TGraphicControlList.Create();
  FHouseSignGraphicControlList := TGraphicControlList.Create();
  FSelfMarkerGraphicControlList := TGraphicControlList.Create();
  FSettingsProvider := ASettingsProvider;

  FKellLockWindow := true;
  FSzemelyisegRajz := False;
end;

destructor TDrawControllerBase.Destroy;
begin
  FreeAndNil(FSelfMarkerGraphicControlList);
  FreeAndNil(FHouseSignGraphicControlList);
  FreeAndNil(FPlanetGraphicControlList);
  FreeAndNil(FZodiacPlanetSignGraphicControlList);
  FreeAndNil(FZodiacSignGraphicControlList);

  FreeAndNil(FobjCanvasInfo);
  FreeAndNil(FCalcResultList);

  inherited Destroy;
end;

procedure TDrawControllerBase.DrawAspects(AListIndexValue: Integer; ARA: double; AAspectList: TAspectInfoList; APlanetList:
  TPlanetList; AAxisList: TAxisList; AHouseCuspList: THouseList);

  procedure SetAImagePenProp(AColor: TColor; APenStyle: TPenStyle; AWidth: integer = 1);
  begin
    FCanvas.Pen.Color := GetAspectPenColor(AColor);
      
    FCanvas.Pen.Style := APenStyle;
    FCanvas.Pen.Width := AWidth;
  end;

var i, xk1, xk2, yk1, yk2, iOrigColor, iOrigFontSize : integer;
    oAspectInfo : TAspectInfo;
    iItem01, iItem02 : double;
    bsAspectTypes, bsAspectAxis, bsHouseCusp : TByteSet;
    bsPlanets, bsAspectPlanets : string;
    bOK : boolean;
begin
  iOrigColor := FCanvas.Pen.Color;
  FCanvas.Pen.Color := clGray;
  iItem01 := 0; iItem02 := 0;

  bsAspectTypes := FSettingsProvider.GetShownAspectTypes;
  bsAspectPlanets := FSettingsProvider.GetShownAspectPlanets;
  bsPlanets := FSettingsProvider.GetShownPlanetSet;
  bsAspectAxis := FSettingsProvider.GetShownAspectAxis;
  bsHouseCusp := FSettingsProvider.GetShownAspectHouses;

  iOrigFontSize := GetFontSize;
  FCanvas.Font.Name := cSYMBOLSFONTNAME;
  FCanvas.Font.Size := iOrigFontSize - 3;

  for i := 0 to AAspectList.Count - 1 do
    begin
      oAspectInfo := AAspectList.GetAspectInfo(i);
      if oAspectInfo.AspectQuality <> taqu_None then
        begin
          if oAspectInfo.Aspect01Type = tasc_Planet then
            begin
              iItem01 := APlanetList.GetPlanetInfo(oAspectInfo.Aspect01ID).RA;
            end;

          if oAspectInfo.Aspect02Type = tasc_Planet then
            iItem02 := APlanetList.GetPlanetInfo(oAspectInfo.Aspect02ID).RA
          else
            if oAspectInfo.Aspect02Type = tasc_Axis then
              iItem02 := AAxisList.GetAxisInfo(oAspectInfo.Aspect02ID).RA
            else
              if oAspectInfo.Aspect02Type = tasc_HouseCusp then
                iItem02 := AHouseCuspList.GetHouseCuspInfo(oAspectInfo.Aspect02ID).RA;

          (*
          case oAspectInfo.AspectID of
          cFSZ_EGYUTTALLAS                       : SetAImagePenProp(GetColorOfType(tcol_Water), psSolid);
          cFSZ_SZEMBENALLAS..cFSZ_3NYOLCADFENY   : SetAImagePenProp(GetColorOfType(tcol_Ground), psSolid);
          cFSZ_HARMADFENY..cFSZ_5TIZENKETTEDFENY : SetAImagePenProp(GetColorOfType(tcol_Air), psDash{psDot{});
          cFSZ_OTODFENY..cFSZ_2OTODFENY          : SetAImagePenProp(GetColorOfType(tcol_Fire), psDash);
          end;
          *)

          FCanvas.Pen.Color := FSettingsProvider.GetColorOfAspect(oAspectInfo.AspectID);
          FCanvas.Pen.Color := GetAspectPenColor(FCanvas.Pen.Color);

          FCanvas.Pen.Style := FSettingsProvider.GetStyleOfAspect(oAspectInfo.AspectID);
          FCanvas.Pen.Width := 1;

          bOK := false;
          case oAspectInfo.Aspect02Type of
          tasc_Planet    : bOK := (Pos(IntToStr(oAspectInfo.Aspect02ID) + ';', bsPlanets) > 0) and (Pos(IntToStr(oAspectInfo.Aspect02ID) + ';', bsAspectPlanets) > 0);
          tasc_Axis      : bOK := {(oAspectInfo.Aspect02ID in bsPlanets) and {}(oAspectInfo.Aspect02ID in bsAspectAxis);
          tasc_HouseCusp : bOK := {(oAspectInfo.Aspect02ID in bsPlanets) and {}(oAspectInfo.Aspect02ID in bsHouseCusp);
          end;

          bOK := bOK and IsPlanetVisible(oAspectInfo.Aspect01ID);
          if oAspectInfo.Aspect02Type = tasc_Planet then
            bOK := bOK and IsPlanetVisible(oAspectInfo.Aspect02ID);

          if (pos(IntToStr(oAspectInfo.Aspect01ID) + ';', bsAspectPlanets) > 0) and bOK then
            if oAspectInfo.AspectID in bsAspectTypes then
              begin
                { RP kérése, érjen hozzá a fényszög szára a belsõ körhöz... }
                xk1 := Round((r - (GetInnerHouseBorderGap {+ (GetInnerZodiacBorderGap div 4){})) * cos((360 - (iItem01 - Round(ARA) + 180)) * Rads));
                yk1 := Round((r - (GetInnerHouseBorderGap {+ (GetInnerZodiacBorderGap div 4){})) * sin((360 - (iItem01 - Round(ARA) + 180)) * Rads));

                xk2 := Round((r - (GetInnerHouseBorderGap {+ (GetInnerZodiacBorderGap div 4){})) * cos((360 - (iItem02 - Round(ARA) + 180)) * Rads));
                yk2 := Round((r - (GetInnerHouseBorderGap {+ (GetInnerZodiacBorderGap div 4){})) * sin((360 - (iItem02 - Round(ARA) + 180)) * Rads));

                FCanvas.MoveTo(xc + xk1, yc + yk1);
                FCanvas.LineTo(xc + xk2, yc + yk2);

                if (oAspectInfo.AspectID in [cFSZ_OTODFENY..cFSZ_2OTODFENY]) and (FIsPrinting) then // vastag vonalazzunk...
                  begin
                    yk1 := yk1 - 1; yk2 := yk2 - 1;
                    FCanvas.MoveTo(xc + xk1, yc + yk1); FCanvas.LineTo(xc + xk2, yc + yk2);

                    yk1 := yk1 + 2; yk2 := yk2 + 2;
                    FCanvas.MoveTo(xc + xk1, yc + yk1); FCanvas.LineTo(xc + xk2, yc + yk2);
                  end;

                // és akkor itt ide valahogy kirajzoljuk a kis szimbólumát a fényszögnek
                // ez itt a vonal felezõje
                FCanvas.Brush.Style := bsClear;
                xk1 := GetFelezoPont(xc + xk1, xc + xk2) - FCanvas.TextWidth(cFENYSZOGSETTINGS[oAspectInfo.AspectID].cAspectLetter) div 2;
                yk1 := GetFelezoPont(yc + yk1, yc + yk2) - FCanvas.TextHeight(cFENYSZOGSETTINGS[oAspectInfo.AspectID].cAspectLetter) div 2;

                if oAspectInfo.AspectID in FSettingsProvider.GetShownAspectSymbols then
                  FCanvas.TextOut(xk1, yk1, cFENYSZOGSETTINGS[oAspectInfo.AspectID].cAspectLetter);
                  
                FCanvas.Brush.Style := bsSolid;
              end;
        end;
    end;

  FCanvas.Pen.Width := 1;
  FCanvas.Pen.Color := iOrigColor;
  FCanvas.Pen.Style := psSolid;

  FCanvas.Font.Name := cSYMBOLSFONTNAME;
  FCanvas.Font.Size := iOrigFontSize;
end;

procedure TDrawControllerBase.DrawBaseCircles(AListIndexValue: Integer; ARA: double);

    procedure DrawDegreeLines(AVonalHatar, AVonalMagassag, ADegree, AForgatva: integer);
    var xk1, yk1, xk2, yk2 : integer;
    begin
      xk1 := Round((r - AVonalHatar + AVonalMagassag) * cos((ADegree + AForgatva + 180) * Rads));
      yk1 := Round((r - AVonalHatar + AVonalMagassag) * sin((ADegree + AForgatva + 180) * Rads));

      // Ez a zodiákus határvonala - pontja!!!
      xk2 := Round((r - AVonalHatar) * cos((ADegree + AForgatva + 180) * Rads));
      yk2 := Round((r - AVonalHatar) * sin((ADegree + AForgatva + 180) * Rads));

      FCanvas.MoveTo(xc + xk1, yc + yk1);
      FCanvas.LineTo(xc + xk2, yc + yk2);
    end;

var iGap, iGapHazBelso{, iGapHazKulso{}, i : integer;
    iSub, AForgatva : integer; // pontok a körön és sugárhossz
begin
  FCanvas.Brush.Color := GetBaseBackgroundBrushColor;

  FCanvas.Brush.Style := bsSolid;
  FCanvas.FillRect(Rect(0, 0, FParentWinControl.ClientRect.Right, FParentWinControl.ClientRect.Bottom));
  //FCanvas.FillRect(Rect(0, 0, FobjCanvasInfo.GetBottomRightX, FobjCanvasInfo.GetBottomRightY));

  FCanvas.Pen.Style := psSolid;
  if FIsPrinting then
    FCanvas.Pen.Width := 2
  else
    FCanvas.Pen.Width := 1;

{  if FIsPrinting then
    FCanvas.Pen.Width := 4
  else
    FCanvas.Pen.Width := 2;
{}
  FCanvas.Pen.Color := clBlack;

  // Zodiákus külsõ köre, azaz a legkülsõ
  //iGap := GetOuterZodiacBorderGap;

  FCanvas.Ellipse(FobjCanvasInfo.GetTopLeftX, FobjCanvasInfo.GetTopLeftY, FobjCanvasInfo.GetBottomRightX, FobjCanvasInfo.GetBottomRightY);

  // Zodiákus határvonal
  if FSettingsProvider.GetShowZodiacDegsOnOtherCircle then
    begin
      iGap := GetInnerZodiacBorderGap_IfOtherDeg;
      FCanvas.Ellipse(FobjCanvasInfo.GetTopLeftX + iGap, FobjCanvasInfo.GetTopLeftY + iGap, FobjCanvasInfo.GetBottomRightX - iGap, FobjCanvasInfo.GetBottomRightY - iGap);
    end;
{
  if FIsPrinting then
    FCanvas.Pen.Width := 2
  else
    FCanvas.Pen.Width := 1;
{}
  iGap := GetInnerZodiacBorderGap;
  FCanvas.Ellipse(FobjCanvasInfo.GetTopLeftX + iGap, FobjCanvasInfo.GetTopLeftY + iGap, FobjCanvasInfo.GetBottomRightX - iGap, FobjCanvasInfo.GetBottomRightY - iGap);
{
  if FIsPrinting then
    FCanvas.Pen.Width := 2
  else
    FCanvas.Pen.Width := 1;
  FCanvas.Pen.Color := clBlack;
{}
  // +1 pici köröcske körbe házon kívül... - ha nincs belül fokbeosztás...

  //iGap := GetOuterHouseBorderGap + 1;
  //FCanvas.Ellipse(FobjCanvasInfo.GetTopLeftX + iGap, FobjCanvasInfo.GetTopLeftY + iGap, FobjCanvasInfo.GetBottomRightX - iGap, FobjCanvasInfo.GetBottomRightY - iGap);
  {}
  // Ház határvonal külsõ
  iGap := GetOuterHouseBorderGap + 3;
  FCanvas.Ellipse(FobjCanvasInfo.GetTopLeftX + iGap, FobjCanvasInfo.GetTopLeftY + iGap, FobjCanvasInfo.GetBottomRightX - iGap, FobjCanvasInfo.GetBottomRightY - iGap);

  // Ház határvonal belsõ
  iGap := GetInnerHouseBorderGap;
  FCanvas.Ellipse(FobjCanvasInfo.GetTopLeftX + iGap, FobjCanvasInfo.GetTopLeftY + iGap, FobjCanvasInfo.GetBottomRightX - iGap, FobjCanvasInfo.GetBottomRightY - iGap);
  {
  // +1 pici köröcske körbe házon belül... - ha nincs belül fokbeosztás...
  iGap := GetInnerHouseBorderGap + 2;
  FCanvas.Ellipse(FobjCanvasInfo.GetTopLeftX + iGap, FobjCanvasInfo.GetTopLeftY + iGap, FobjCanvasInfo.GetBottomRightX - iGap, FobjCanvasInfo.GetBottomRightY - iGap);
  {}
  if FIsPrinting then
    FCanvas.Pen.Width := 2
  else
    FCanvas.Pen.Width := 1;
  FCanvas.Pen.Color := clBlack;

  AForgatva := Round(ARA); // !!! RA !!!

  iGap := GetInnerZodiacBorderGap;
  iGapHazBelso := GetInnerHouseBorderGap;
  //iGapHazKulso := GetOuterHouseBorderGap;

  for i := 359 downto 0 do
    begin
      //if FSettingsProvider.GetShowZodiacDegsOnOtherCircle then
        begin
          if i mod 30 = 0 then iSub := iGap else   // Jegy = 30°
          if i mod 10 = 0 then iSub := iGap div 8 else  // 10°
          if i mod  5 = 0 then iSub := iGap div 12 else  //  5°
          iSub := iGap div 16; // 1°-ok
        end;
      {
      else
        begin
          // kör "metszéspontok" meghatározása
          if i mod 30 = 0 then iSub := iGap else   // Jegy = 30°
          if i mod 10 = 0 then iSub := iGap div 4 else  // 10°
          if i mod  5 = 0 then iSub := iGap div 6 else  //  5°
          iSub := iGap div 9; // 1°-ok
        end;
      {}

      // ZODIÁKUS JEGYEKEN BELÜLI METSZÉSPONTOK - Kívül
      if (GetCalcResultCount > 1) or FSettingsProvider.GetShowOuterZodiacDegLines then // csak akkor, ha egynél több megjelenítés van!
        DrawDegreeLines(0, -iSub, i, AForgatva);

      // ZODIÁKUS JEGYEKEN BELÜLI METSZÉSPONTOK - Belül
      if FSettingsProvider.GetShowInnerZodiacDegLines then
        begin
          {
          if i mod 30 = 0  then
            DrawDegreeLines(iGap + 1, iSub + 1, i, AForgatva)
          else{}
            DrawDegreeLines(iGap, iSub, i, AForgatva);
        end;

      if i mod 30 = 0  then
        DrawDegreeLines(iGap + 1, iSub + 1, i, AForgatva);

      // azé paramban lehessen beállítani... talán...

      // HÁZ BELSÕ RÉSZÉN METSZÉSPONTOK A FÉNYSZÖGEKHEZ...
      if FSettingsProvider.GetShowInnerAspectDegLines then
        begin
          if i mod 30 = 0 then iSub := iGap div 4;
          DrawDegreeLines(iGapHazBelso, -iSub, i, AForgatva);
        end;
      (**)
      (*
      // HÁZ KÜLSÕ RÉSZÉN METSZÉSPONTOK A FÉNYSZÖGEKHEZ...
      if FSettingsProvider.GetShowOuterAspectDegLines then
        begin
          if i mod 30 = 0 then iSub := iGap div 4;
          DrawDegreeLines(iGapHazKulso, iSub, i, AForgatva);
        end;
      (**)
    end;

  if not FIsPrinting then
    begin
      // Fényszög hátterének színe, a belsõ kör - CSAK a programban, nyomtatáskor NEM!
      FCanvas.Brush.Color := FSettingsProvider.GetColorOfAspectsBackground; //RGB(187, 187, 187);
      ExtFloodFill(FCanvas.Handle, xc, yc, clBlack{Határ vonal szín}, FLOODFILLBORDER);
      FCanvas.Brush.Color := clBtnFace;
    end;
end;

procedure TDrawControllerBase.DrawCalculatedResult(ACalcResult: TCalcResult);
begin
  FCalcResultList.Add(ACalcResult);

  ReDrawCalculatedResults;
end;

procedure TDrawControllerBase.DrawHouseCusps(AListIndexValue: Integer; ARA: double; AHouseCuspList: THouseList);

  procedure PrintFokJegyPerc(AValue, AFontName: string; AFontSize, AHouseRA, AForgatva: integer; APrintType: Char);
  const cFokPercTav = 4;
        cWIDTHHEIGHT = '00';
  var xk1, yk1, iGap, iRA : integer;
      iOrigBrushStyle : TBrushStyle;
  begin
    FCanvas.Font.Name := AFontName;
    FCanvas.Font.Size := AFontSize;

    iOrigBrushStyle := FCanvas.Brush.Style;

    FCanvas.Brush.Style := bsClear;

    iGap := FCanvas.TextWidth(cWIDTHHEIGHT);
    iRA := AHouseRA;

    case APrintType of
    'F' : iRA := iRA - cFokPercTav;
    'J' : iGap := FCanvas.TextWidth(AValue);
    'P' : iRA := iRA + cFokPercTav;
    end;

    xk1 := Round((r + iGap) * cos((360 - (iRA - AForgatva + 180)) * Rads));
    yk1 := Round((r + iGap) * sin((360 - (iRA - AForgatva + 180)) * Rads));

    FCanvas.TextOut
      (
        (xc + xk1) - (FCanvas.TextWidth(AValue) div 2),
        (yc + yk1) - (FCanvas.TextHeight(AValue) div 2),
        AValue
      );

    FCanvas.Brush.Style := iOrigBrushStyle;
  end;

var i : integer;
    objHouseCup : THouseCusp;
    xk1, yk1, xk2, yk2, iGapKulso, iGapBelso, AForgatva : integer;
    sHouseCusps : TByteSet;
    cPenColor : TColor;
    sFok, sJegy, sPerc : string;
begin
  //iGapKulso := GetInnerZodiacBorderGap;
  //iGapBelso := GetInnerHouseBorderGap; 
  AForgatva := Round(ARA);

  sHouseCusps := FSettingsProvider.GetShownHouseBorderSet;

  cPenColor := FCanvas.Pen.Color;
  
  for i := 1 to AHouseCuspList.Count - 1 do
    begin
      if i in sHouseCusps then
        begin
          if AListIndexValue = 0 then
            begin
              iGapKulso := GetInnerZodiacBorderGap;
              iGapBelso := GetInnerHouseBorderGap;
            end
          else
            begin
              iGapKulso := Get_iGap_ForPlanets(AListIndexValue);
              iGapBelso := GetOuterZodiacBorderGap;
            end;

          if i in [1, 4, 7, 10] then
            begin
              if FIsPrinting then
                FCanvas.Pen.Width := 4
              else
                FCanvas.Pen.Width := 2
            end
          else
            begin
              if FIsPrinting then
                FCanvas.Pen.Width := 2
              else
                FCanvas.Pen.Width := 1;
            end;

          objHouseCup := AHouseCuspList.GetHouseCuspInfo(i);

          { RP kérése - ne lógjon ki...
          if i in [1, 4, 7, 10] then
            begin
              if AListIndexValue = 0 then
                begin
                  iGapKulso := iGapKulso + ((iGapKulso - iGapBelso) div 8);
                  iGapBelso := (GetInnerHouseBorderGap) + ((GetInnerHouseBorderGap) div 10);
                end
              else
                begin
                  iGapKulso := iGapKulso - ((iGapKulso - iGapBelso) div 8);
                  iGapBelso := (GetInnerZodiacBorderGap) - (Round((GetInnerZodiacBorderGap) * 0.7));
                end;
            end;
          {}
          {
          case i of
          1 : FCanvas.Pen.Color := GetColorOfType(tcol_Water);
          10: FCanvas.Pen.Color := GetColorOfType(tcol_Fire);
          else
            FCanvas.Pen.Color := cPenColor;
          end;
          {}

          xk1 := Round((r - iGapKulso) * cos((360 - (objHouseCup.RA - AForgatva + 180)) * Rads));
          yk1 := Round((r - iGapKulso) * sin((360 - (objHouseCup.RA - AForgatva + 180)) * Rads));

          //if i in [1, 4, 7, 10] then
          //  iGapBelso := (GetInnerHouseBorderGap) + ((GetInnerHouseBorderGap) div 10);

          xk2 := Round((r - iGapBelso) * cos((360 - (objHouseCup.RA - AForgatva + 180)) * Rads));
          yk2 := Round((r - iGapBelso) * sin((360 - (objHouseCup.RA - AForgatva + 180)) * Rads));

          if i in [1, 7] then
            begin
              if yk1 <> yk2 then yk1 := yk2;
            end;

          FCanvas.MoveTo(xc + xk1, yc + yk1);
          FCanvas.LineTo(xc + xk2, yc + yk2);

          /////////////////////////////////////////////////////////////////////
          // Házak fok-perc beosztásának kirajzolása FokJEGYPerc beosztással //
          /////////////////////////////////////////////////////////////////////
          if FSettingsProvider.GetShowHouseDegValues then
            begin
              if GetCalcResultCount = 1 then // csak ha 1 képlet van!
                begin
                  if objHouseCup.HouseNumber in [1..6] then
                    begin
                      sFok := PaddL(IntToStr(DoubleToOra(objHouseCup.StartDegree)) + '°', 3, '0');
                      sPerc := PaddL(IntToStr(DoubleToPerc(objHouseCup.StartDegree)) + '''', 3, '0');
                      sJegy := cZODIACANDPLANETLETTERS[objHouseCup.InZodiacSign].cZodiacLetter;
                    end
                  else
                    begin
                      sPerc := PaddL(IntToStr(DoubleToOra(objHouseCup.StartDegree)) + '°', 3, '0');
                      sFok := PaddL(IntToStr(DoubleToPerc(objHouseCup.StartDegree)) + '''', 3, '0');
                      sJegy := cZODIACANDPLANETLETTERS[objHouseCup.InZodiacSign].cZodiacLetter;
                    end;

                  // FOK
                  PrintFokJegyPerc(sFok, cBASEFONTNAME3, (GetFontSize div 3) * 2, Round(objHouseCup.RA), AForgatva, 'F');
                  // JEGY
                  PrintFokJegyPerc(sJegy, cSYMBOLSFONTNAME, GetFontSize, Round(objHouseCup.RA), AForgatva, 'J');
                  // PERC
                  PrintFokJegyPerc(sPerc, cBASEFONTNAME3, (GetFontSize div 3) * 2, Round(objHouseCup.RA), AForgatva, 'P');
                end;
            end;
        end;
    end;

  FCanvas.Pen.Color := cPenColor;
end;

procedure TDrawControllerBase.DrawHouseNumbers(AListIndexValue: Integer; ARA: double; AHouseCuspList: THouseList);
var iOrigFontSize, i, iGap : integer;
    hcInduloFok, hcKovetoFok, ARotation : Double;
    dSzogfele : double;
    xk1, yk1 : integer;
    objHouseNumberImage : TBaseGraphicControl;
    sHouseNumberSet : TByteSet;
begin

  // Ház vonal külsõ vonala
  //iGap := round((r div 2) * 0.95);
  iGap := GetOuterHouseBorderGap;

  ARotation := Round(ARA);

  iOrigFontSize := GetFontSize;
  FCanvas.Font.Name := cBASEFONTNAME3;
  FCanvas.Font.Size := iOrigFontSize - 5;

  sHouseNumberSet := FSettingsProvider.GetShowHouseNumberSet;

  for i := 1 to AHouseCuspList.Count - 1 do
    begin
      if i in sHouseNumberSet then
        begin
          hcInduloFok := AHouseCuspList.GetHouseCuspInfo(i).RA;
          hcKovetoFok := AHouseCuspList.GetHouseCuspInfo((i + 12) - (((i + 12) div 12) * 12) + 1).RA;
          if (hcInduloFok <> -1) and (hcInduloFok <> -1) then
            begin
              if hcKovetoFok < hcInduloFok then hcKovetoFok := hcKovetoFok + 360;

              dSzogfele := hcInduloFok + (Abs(hcInduloFok - hcKovetoFok) / 2);

              if i in [1,2,3]     then iGap := round((GetInnerHouseBorderGap {r div 2{}) * 0.95) else
              if i in [4,5,6]       then iGap := round((GetInnerHouseBorderGap {r div 2{}) * 0.94) else
              if i in [7,10,11,12] then iGap := round((GetInnerHouseBorderGap {r div 2{}) * 0.93) else
              if i in [8,9]    then iGap := round((GetInnerHouseBorderGap {r div 2{}) * 0.91);

              xk1 := Round((r - iGap) * cos((360 - (dSzogfele - ARotation + 180)) * Rads));
              yk1 := Round((r - iGap) * sin((360 - (dSzogfele - ARotation + 180)) * Rads));

              objHouseNumberImage := FHouseSignGraphicControlList.GetGraphicItem(AListIndexValue, i);

              if not Assigned(objHouseNumberImage) then
                begin
                  objHouseNumberImage          := THouseNumberGraphicControl.Create(FCanvasControl);
                  objHouseNumberImage.Parent   := FCanvasControl.Parent;
                  objHouseNumberImage.BackGroundColor := FCanvas.Brush.Color;
                  objHouseNumberImage.SignID   := i;
                  objHouseNumberImage.KepletIdx := AListIndexValue;

                  FHouseSignGraphicControlList.AddGraphicItem(objHouseNumberImage);
                end;

              THouseNumberGraphicControl(objHouseNumberImage).FHouseNumArabic := FSettingsProvider.GetShowHouseNumbersByArabicNumbers;
              objHouseNumberImage.Font.Name := FCanvas.Font.Name;
              objHouseNumberImage.FontSize := FCanvas.Font.Size;
              objHouseNumberImage.SignID   := i;
              THouseNumberGraphicControl(objHouseNumberImage).HouseCusp := AHouseCuspList.GetHouseCuspInfo(i);
              objHouseNumberImage.Left := (xc + xk1) - round(objHouseNumberImage.Width / 2);
              objHouseNumberImage.Top  := (yc + yk1) - round(objHouseNumberImage.Width / 2);
            end;
        end;
    end;

  FCanvas.Font.Name := cSYMBOLSFONTNAME;
  FCanvas.Font.Size := iOrigFontSize;
end;

procedure TDrawControllerBase.DrawPlanets(AListIndexValue: Integer; ARA: double; APlanetList: TPlanetList; ASelfMarkerList:
  TSelfMarkerList);
var i : integer;
    objPlanet : TPlanet;
    xk1, yk1, {xkc, ykc, {}AForgatva, iGap, iOrigFontSize, iOrigColor : integer;
    objPlanetImage : TBaseGraphicControl;
    sSetOfPlanets : string;
    objPlanetConstProvider : TPlanetConstInfoProvider;
begin
  AForgatva := round(ARA);

  iGap := Get_iGap_ForPlanets(AListIndexValue);

  iOrigFontSize := FCanvas.Font.Size;

  FCanvas.Font.Size := Round(GetFontSize * 1.5 * FSettingsProvider.GetBetumeretSzorzo);

  if not FSzemelyisegRajz then
    sSetOfPlanets := FSettingsProvider.GetShownPlanetSet
  else
    begin // PlanetID_1;PlanetID_2;
      for i := 0 to ASelfMarkerList.Count - 1 do
        if ASelfMarkerList.GetSelfMarker(i) is TPlanet then
          sSetOfPlanets := sSetOfPlanets + IntToStr(TPlanet(ASelfMarkerList.GetSelfMarker(i)).PlanetID) + ';';
    end;

  for i := 0 to FPlanetGraphicControlList.Count - 1 do
    begin
      objPlanetImage := TPlanetSignGraphicControl(FPlanetGraphicControlList.Items[i]);
      objPlanetImage.Visible := false;
    end;
{}
  objPlanetConstProvider := TPlanetConstInfoProvider.Create;
  
  for i := 0 {SE_SUN {}to APlanetList.Count - 1 do
    begin
      objPlanet := APlanetList.GetPlanet(i);

      //if objPlanet.PlanetID in [SE_SUN..SE_PLUTO, SE_MEAN_NODE, {SE_TRUE_NODE, {}SE_TRUE_MEAN_NODE_DOWN{}] then
      if pos(IntTostr(objPlanet.PlanetID) + ';', sSetOfPlanets) > 0 then
        begin
          //if cPLANETLIST[objPlanet.PlanetID].cPlanetLetter <> ':' then
          if objPlanetConstProvider.cPlanetLetter(objPlanet.PlanetID) <> ':' then
            begin
              xk1 := Round((r - iGap) * cos((360 - (objPlanet.RA - AForgatva + 180)) * Rads));
              yk1 := Round((r - iGap) * sin((360 - (objPlanet.RA - AForgatva + 180)) * Rads));

              objPlanetImage := FPlanetGraphicControlList.GetGraphicItem(AListIndexValue, objPlanet.PlanetID);

              if not Assigned(objPlanetImage) then
                begin
                  objPlanetImage          := TPlanetSignGraphicControl.Create(FCanvasControl);
                  objPlanetImage.Parent   := FCanvasControl.Parent;
                  objPlanetImage.BackGroundColor := FCanvas.Brush.Color;
                  objPlanetImage.FontSize := FCanvas.Font.Size;
                  objPlanetImage.SignID   := objPlanet.PlanetID;
                  objPlanetImage.KepletIdx := AListIndexValue;

                  FPlanetGraphicControlList.AddGraphicItem(objPlanetImage);
                end;

              TPlanetSignGraphicControl(objPlanetImage).FHouseNumArabic := FSettingsProvider.GetShowHouseNumbersByArabicNumbers; 
              objPlanetImage.FontSize := FCanvas.Font.Size;
              objPlanetImage.SignID   := objPlanet.PlanetID;
              objPlanetImage.FontSize := FCanvas.Font.Size;
              TPlanetSignGraphicControl(objPlanetImage).PlanetName := objPlanetConstProvider.sPlanetName(objPlanet.PlanetID);
              TPlanetSignGraphicControl(objPlanetImage).Planet := objPlanet;
              //objPlanetImage.SignID   := objPlanet.PlanetID;
              TPlanetSignGraphicControl(objPlanetImage).OrigLeft := (xc + xk1) - round(objPlanetImage.Width / 2);
              TPlanetSignGraphicControl(objPlanetImage).OrigTop  := (yc + yk1) - round(objPlanetImage.Width / 2);
              TPlanetSignGraphicControl(objPlanetImage).OrigRA := objPlanet.RA;

              objPlanetImage.Visible := true;
            end;
        end;
    end;

  FreeAndNil(objPlanetConstProvider);

  ReArrangePlanets(ARA);

  iOrigColor := FCanvas.Pen.Color;
  FCanvas.Brush.Color := clWhite;
  FCanvas.Brush.Style := bsSolid;

  for i := 0 to FPlanetGraphicControlList.Count - 1 do
    begin
      objPlanetImage := TPlanetSignGraphicControl(FPlanetGraphicControlList.Items[i]);

      if not FIsPrinting and objPlanetImage.Visible then
        begin
          FCanvas.FillRect(objPlanetImage.BoundsRect);
        end;

    end;

  DrawPlanetsInfo(ARA, APlanetList); // ez teszi ki a "kocsányokat" stb stb

  FCanvas.Font.Style := FCanvas.Font.Style - [fsBold];
  FCanvas.Pen.Width := 1;
  FCanvas.Pen.Color := iOrigColor;
  FCanvas.Font.Size := iOrigFontSize;
end;

procedure TDrawControllerBase.DrawPlanetsInfo(ARA: double; APlanetList: TPlanetList);
var i : integer;
    xk1, yk1, xkc, ykc, AForgatva, iOrigFontSize, iOrigColor, iMax, iLetterWidth, iLetterHeight, iPlusTop : integer;
    objPlanetImage : TBaseGraphicControl;
    iLeft, iTop, iWidth, {iHeight, {}iKozepX, iKozepY : integer;
    iOrigBrushStyle : TBrushStyle;
    A, B, C, D, E, Z, APntMetszet : TPoint;
    sDebug : string;
    negyTernegyed: TTerNegyed;
begin
  iOrigColor := FCanvas.Pen.Color;
  FCanvas.Pen.Color := clBlack;
  FCanvas.Pen.Width := 1;

  iOrigBrushStyle := FCanvas.Brush.Style;

  AForgatva := round(ARA);

  iOrigFontSize := FCanvas.Font.Size;

  FCanvas.Font.Size := Round(GetFontSize * 1.5 * FSettingsProvider.GetBetumeretSzorzo);
  iMax := 0;

  // Retrograde miatt
  FCanvas.Font.Name  := cBASEFONTNAME3;
  for i := 0 to FPlanetGraphicControlList.Count - 1 do
    begin
      FCanvas.Brush.Style := bsClear;

      objPlanetImage := TPlanetSignGraphicControl(FPlanetGraphicControlList.Items[i]);

      if objPlanetImage.Visible then
        begin

          // Vonal húzás
          //iMax := Max(objPlanetImage.Width, objPlanetImage.Height); //iMax := iMax - (iMax div 2);
          //iMax := objPlanetImage.Height;
          (*
          case TPlanetSignGraphicControl(objPlanetImage).KepletIdx of
          0 : iMax := Min(objPlanetImage.Height, Abs(GetPlanetBorderLineGap - GetInnerHouseBorderGap) div 3);
          //else
          //  iMax := Min(objPlanetImage.Height, Abs(Get_iGap_ForPlanets(TPlanetSignGraphicControl(objPlanetImage).KepletIdx){GetPlanetBorderLineGap{} - GetOuterZodiacBorderGap) div 3);
          end;
          *)

          case TPlanetSignGraphicControl(objPlanetImage).KepletIdx of
          0 : begin
                //iLeft := TPlanetSignGraphicControl(objPlanetImage).OrigLeft;
                //iTop := TPlanetSignGraphicControl(objPlanetImage).OrigTop;

                iLeft := TPlanetSignGraphicControl(objPlanetImage).Left;
                iTop := TPlanetSignGraphicControl(objPlanetImage).Top;
            
                iWidth := TPlanetSignGraphicControl(objPlanetImage).Width;
                //iHeight := (TPlanetSignGraphicControl(objPlanetImage).Height div 5 ) * 6;

                xk1 := Round((r - GetInnerZodiacBorderGap) * cos((360 - (TPlanetSignGraphicControl(objPlanetImage).OrigRA - AForgatva + 180)) * Rads));
                yk1 := Round((r - GetInnerZodiacBorderGap) * sin((360 - (TPlanetSignGraphicControl(objPlanetImage).OrigRA - AForgatva + 180)) * Rads));

                // Ez a pont a graph objektum középpontja...
                iKozepX := iLeft + iWidth div 2;
                iKozepY := iTop + TPlanetSignGraphicControl(objPlanetImage).Height div 2;

                B.X := iLeft + iWidth; B.Y := iTop;
                C.X := B.X;            C.Y := iTop + TPlanetSignGraphicControl(objPlanetImage).Height; //iHeight;
                D.X := iLeft;          D.Y := C.Y;
                E.X := D.X;            E.Y := B.Y;

                A.X := iKozepX;        A.Y := iKozepY;

                Z.X := xc + xk1;       Z.Y := yc + yk1;

                sDebug := '';

                negyTernegyed := MelyTernegyedben(B, C, D, E, A, Z, sDebug);

                iLeft := TPlanetSignGraphicControl(objPlanetImage).Left;
                iTop := TPlanetSignGraphicControl(objPlanetImage).Top;

                iKozepX := iLeft + iWidth div 2;
                iKozepY := iTop + TPlanetSignGraphicControl(objPlanetImage).Height div 2;

                case negyTernegyed of
                negyNONE : begin
                             APntMetszet.X := GetHarmadoloPont(iKozepX, xc + xk1);
                             APntMetszet.Y := GetHarmadoloPont(iKozepy, yc + yk1);
                           end;
                negyJobb : begin
                             LinesIntersect
                               (
                                 Line(iKozepX, iKozepY, xc + xk1, yc + yk1),
                                 Line(B.X, B.Y, C.X, C.Y),
                                 APntMetszet
                               );
                           end;
                negyAlso : begin
                             LinesIntersect
                               (
                                 Line(iKozepX, iKozepY, xc + xk1, yc + yk1),
                                 Line(D.X, D.Y, C.X, C.Y),
                                 APntMetszet
                               );
                           end;
                negyBal  : begin
                             LinesIntersect
                               (
                                 Line(iKozepX, iKozepY, xc + xk1, yc + yk1),
                                 Line(E.X, E.Y, D.X, D.Y),
                                 APntMetszet
                               );
                           end;
                negyFelso: begin
                             LinesIntersect
                               (
                                 Line(iKozepX, iKozepY, xc + xk1, yc + yk1),
                                 Line(E.X, E.Y, B.X, B.Y),
                                 APntMetszet
                               );
                           end;
                end;

                xkc := APntMetszet.X;
                ykc := APntMetszet.Y;
                //xkc := iKozepX;
                //ykc := iKozepY;

                {$IFDEF SDEBUG}
                  {
                  FCanvas.MoveTo(E.X, E.Y); FCanvas.LineTo(C.X, C.Y);
                  FCanvas.MoveTo(B.X, B.Y); FCanvas.LineTo(D.X, D.Y);
                  {}

                  sDebug := sDebug + #13 + #13 +
                    'XKC: ' + IntToStr(xkc) + #13 +
                    'YKC: ' + IntToStr(ykc) + #13 + #13 + 
                    'OrigRA: ' + FloatToStr(TPlanetSignGraphicControl(objPlanetImage).OrigRA) + #13 +
                    'NewRA: ' + FloatToStr(TPlanetSignGraphicControl(objPlanetImage).NewRA);
                  TPlanetSignGraphicControl(objPlanetImage).Hint := sDebug;
                {$ENDIF}

              end;
          else
            begin // külsõ kör
              xkc := Round((r - (Get_iGap_ForPlanets(TPlanetSignGraphicControl(objPlanetImage).KepletIdx) div 2{ - iMax{})) * cos((360 - (TPlanetSignGraphicControl(objPlanetImage).NewRA - AForgatva + 180)) * Rads));
              ykc := Round((r - (Get_iGap_ForPlanets(TPlanetSignGraphicControl(objPlanetImage).KepletIdx) div 2{ - iMax{})) * sin((360 - (TPlanetSignGraphicControl(objPlanetImage).NewRA - AForgatva + 180)) * Rads));

              xk1 := Round((r - GetOuterZodiacBorderGap) * cos((360 - (TPlanetSignGraphicControl(objPlanetImage).OrigRA - AForgatva + 180)) * Rads));
              yk1 := Round((r - GetOuterZodiacBorderGap) * sin((360 - (TPlanetSignGraphicControl(objPlanetImage).OrigRA - AForgatva + 180)) * Rads));
            end;
          end;

          case TPlanetSignGraphicControl(objPlanetImage).KepletIdx of
          0 : FCanvas.MoveTo(xkc, ykc);
          else
            FCanvas.MoveTo(xc + xkc, yc + ykc);
          end;

          FCanvas.LineTo(xc + xk1, yc + yk1);

          // "R" kirajzolása a retrográd mozgáshoz
          FCanvas.Font.Name := cBASEFONTNAME3;
          //FCanvas.Font.Size  := (Round(GetFontSize * 1.5)) - Round(((Round(GetFontSize * 1.5)) / 5) * 3) - 1;
          FCanvas.Font.Size  := Round( ((Round(GetFontSize * 1.5)) - Round(((Round(GetFontSize * 1.5)) / 5) * 3) - 1) * FSettingsProvider.GetBetumeretSzorzo);

          if FSettingsProvider.GetShowRetrogradeSign then
            begin
              if TPlanetSignGraphicControl(objPlanetImage).FPlanet.Retrograd then
                begin
                  FCanvas.Font.Style := FCanvas.Font.Style + [fsBold];

                  iLetterWidth  := FCanvas.TextWidth(cRETROGRADELETTER);
                  iLetterHeight := FCanvas.TextHeight(cRETROGRADELETTER);

                  iMax :=  (Abs(Get_iGap_ForPlanets(TPlanetSignGraphicControl(objPlanetImage).KepletIdx){GetPlanetBorderLineGap{} - GetOuterHouseBorderGap) div 3)
                          - Round(Max(iLetterHeight, iLetterWidth) * 3.6);

                  //xkc := Round((r - (GetPlanetBorderLineGap - iMax)) * cos((360 - (TPlanetSignGraphicControl(objPlanetImage).NewRA - AForgatva + 180)) * Rads));
                  //ykc := Round((r - (GetPlanetBorderLineGap - iMax)) * sin((360 - (TPlanetSignGraphicControl(objPlanetImage).NewRA - AForgatva + 180)) * Rads));
                  xkc := Round((r - (Get_iGap_ForPlanets(TPlanetSignGraphicControl(objPlanetImage).KepletIdx) - iMax)) * cos((360 - (TPlanetSignGraphicControl(objPlanetImage).NewRA - AForgatva + 180)) * Rads));
                  ykc := Round((r - (Get_iGap_ForPlanets(TPlanetSignGraphicControl(objPlanetImage).KepletIdx) - iMax)) * sin((360 - (TPlanetSignGraphicControl(objPlanetImage).NewRA - AForgatva + 180)) * Rads));

                  FCanvas.TextOut
                    (
                       xc + xkc - round(iLetterWidth / 2),
                       yc + ykc - round(iLetterWidth / 2),
                       cRETROGRADELETTER
                    );
                  {}
                  {
                  FCanvas.TextOut
                    (
                       objPlanetImage.Left + objPlanetImage.Width,
                       objPlanetImage.Top + objPlanetImage.Height - FCanvas.TextHeight(cRETROGRADELETTER),
                       cRETROGRADELETTER
                    );
                  {}
                  FCanvas.Font.Style := FCanvas.Font.Style - [fsBold];
                end;
            end;

          if FSettingsProvider.GetShowPlanetDegs then
            begin
              if TPlanetSignGraphicControl(objPlanetImage).KepletIdx = 0 then // egyelõre csak a belsõ
                begin
                  // Fok°Perc' kirajzolása
                  iLetterWidth  := FCanvas.TextWidth('99');
                  iLetterHeight := FCanvas.TextHeight('9');

                  //FCanvas.Font.Size  := FCanvas.Font.Size + 1;//(Round(GetFontSize * 1.5)) - Round(((Round(GetFontSize * 1.5)) / 5) * 3) - 1;
                  FCanvas.Font.Size  := Round( (FCanvas.Font.Size + 1) * FSettingsProvider.GetBetumeretSzorzo);
                  iLetterWidth  := iLetterWidth + FCanvas.TextWidth('999');
                  iLetterHeight := iLetterHeight + (FCanvas.TextHeight('9') div 2);

                  iMax :=  (Abs(Get_iGap_ForPlanets(TPlanetSignGraphicControl(objPlanetImage).KepletIdx){GetPlanetBorderLineGap{} - GetOuterHouseBorderGap) div 3)
                          - Round(Max(iLetterHeight, iLetterWidth) * 2.2);

                  xkc := Round((r - (Get_iGap_ForPlanets(TPlanetSignGraphicControl(objPlanetImage).KepletIdx){GetPlanetBorderLineGap{} - iMax)) * cos((360 - (TPlanetSignGraphicControl(objPlanetImage).NewRA - AForgatva + 180)) * Rads));
                  ykc := Round((r - (Get_iGap_ForPlanets(TPlanetSignGraphicControl(objPlanetImage).KepletIdx){GetPlanetBorderLineGap{} - iMax)) * sin((360 - (TPlanetSignGraphicControl(objPlanetImage).NewRA - AForgatva + 180)) * Rads));

                  FCanvas.TextOut
                    (
                       xc + xkc - round(iLetterHeight / 2),
                       yc + ykc - round(iLetterHeight / 2),
                       PaddL(IntToStr(DoubleToOra(TPlanetSignGraphicControl(objPlanetImage).FPlanet.StartDegree)), 2, ' ')
                    );

                  iLetterWidth  := FCanvas.TextWidth(IntToStr(DoubleToOra(TPlanetSignGraphicControl(objPlanetImage).FPlanet.StartDegree)));
                  //FCanvas.Font.Size := FCanvas.Font.Size - 3;
                  FCanvas.Font.Size := Round( (FCanvas.Font.Size - 3) * FSettingsProvider.GetBetumeretSzorzo);
                  FCanvas.TextOut
                    (
                       xc + xkc + iLetterWidth div 3,
                       yc + ykc - iLetterHeight div 2,
                       PaddL(IntToStr(DoubleToPerc(TPlanetSignGraphicControl(objPlanetImage).FPlanet.StartDegree)), 2, '0')
                    );

                  {
                  xkc := Round((r - (GetPlanetBorderLineGap + iMax)) * cos((360 - (TPlanetSignGraphicControl(objPlanetImage).NewRA - AForgatva + 180)) * Rads));
                  ykc := Round((r - (GetPlanetBorderLineGap + iMax)) * sin((360 - (TPlanetSignGraphicControl(objPlanetImage).NewRA - AForgatva + 180)) * Rads));

                  xk1 := Round((r - GetOuterHouseBorderGap) * cos((360 - (TPlanetSignGraphicControl(objPlanetImage).OrigRA - AForgatva + 180)) * Rads));
                  yk1 := Round((r - GetOuterHouseBorderGap) * sin((360 - (TPlanetSignGraphicControl(objPlanetImage).OrigRA - AForgatva + 180)) * Rads));

                  FCanvas.MoveTo(xc + xkc, yc + ykc);
                  FCanvas.LineTo(xc + xk1, yc + yk1);
                  {}
                end;
            end;

          //if TPlanetSignGraphicControl(objPlanetImage).KepletIdx = 0 then //
            begin // Házúrság kijelzése
              if FSettingsProvider.GetShowHouseLords then
                if Trim(TPlanetSignGraphicControl(objPlanetImage).FHazursag) <> '' then
                  begin
                    FCanvas.Brush.Style := bsSolid;
                    { RP - legyen akkora font mérete, mint a FokPerc kíírásnál... }
                    //FCanvas.Font.Size := (Round(GetFontSize * 1.5)) - Round(((Round(GetFontSize * 1.5)) / 5) * 3) - 1; // a kiindulási font méret
                    FCanvas.Font.Size := Round( ((Round(GetFontSize * 1.5)) - Round(((Round(GetFontSize * 1.5)) / 5) * 3) - 1) * FSettingsProvider.GetBetumeretSzorzo ); 
                    FCanvas.Font.Name := cBASEFONTNAME3;
                    iPlusTop := 0;
                    if FIsPrinting then
                      iPlusTop := -3;
                    //FCanvas.Font.Size :=
                    FCanvas.TextOut
                      (
                        objPlanetImage.Left + (objPlanetImage.Width - FCanvas.TextWidth(TPlanetSignGraphicControl(objPlanetImage).FHazursag)) div 2,
                        iPlusTop + (objPlanetImage.Top + objPlanetImage.Height) + (objPlanetImage.Height div 11) - FCanvas.TextHeight(TPlanetSignGraphicControl(objPlanetImage).FHazursag),
                        Trim(TPlanetSignGraphicControl(objPlanetImage).FHazursag)
                      );
                  end;
            end;
        end; // if Visible = true
    end; // for end

  FCanvas.Brush.Style := iOrigBrushStyle;

  FCanvas.Font.Style := FCanvas.Font.Style - [fsBold];
  FCanvas.Pen.Width := 1;
  FCanvas.Pen.Color := iOrigColor;
  FCanvas.Font.Size := iOrigFontSize;
end;

procedure TDrawControllerBase.DrawSelfMarkers(AListIndexValue: Integer; ARA: double; ASelfMarkerList: TSelfMarkerList);

  function GetOriginalModifiedRA(APlanetID, AOrigRA, ANewRA : integer) : integer;
  var iRes, j : integer;
      objMarker : TObject;
      bKellIgazitas : boolean;
  begin
    Result := AOrigRA;

    // ha 1.5°-nál közelebb van egy másik énállapot, CSAK akkor tolom el!
    bKellIgazitas := false;
    j := 0;

    while (j <= ASelfMarkerList.Count - 1) and (not bKellIgazitas) do
      begin
        objMarker := ASelfMarkerList.GetSelfMarker(j);
        if (objMarker is TPlanet) and (TPlanet(objMarker).PlanetID <> APlanetID) then // nem ugyanaz
          begin
            bKellIgazitas := Abs(TPlanet(objMarker).RA - AOrigRA) <= 1.5;
          end;

        inc(j);
      end;

    if bKellIgazitas then
      begin
        iRes := Abs(AOrigRA - ANewRA) div 6; // Itt tudom közelebb tenni az énjelölõket

        if ANewRA >= AOrigRA then
          Result := AOrigRA + iRes
        else
          Result := AOrigRA - iRes;
      end;
  end;

var xk1, yk1, i, iRA, iSignID, iGap : integer;
    objSelfMarker : TObject;
    objSelfMarkerImage : TBaseGraphicControl;
begin
  iSignID := 0; iRA := 0; iGap := 0;
  
  if FSettingsProvider.GetShowSelfMarkers then
    begin
      for i := 0 to ASelfMarkerList.Count - 1 do
        begin
          objSelfMarker := ASelfMarkerList.GetSelfMarker(i);

          if objSelfMarker is TPlanet then
            begin
              //iRA := Round(TPlanet(objSelfMarker).RA);
              iSignID := TPlanet(objSelfMarker).PlanetID;
              iRA := -1;
              if Assigned(FPlanetGraphicControlList.GetGraphicItem(AListIndexValue, iSignID)) then
                case FSettingsProvider.GetShowSelfMarkerAtorigPlace of
                true : iRA := GetOriginalModifiedRA
                        (
                          iSignID,
                          Round(TPlanetSignGraphicControl(FPlanetGraphicControlList.GetGraphicItem(AListIndexValue, iSignID)).OrigRA),
                          Round(TPlanetSignGraphicControl(FPlanetGraphicControlList.GetGraphicItem(AListIndexValue, iSignID)).NewRA)
                        );
                false: iRA := Round(TPlanetSignGraphicControl(FPlanetGraphicControlList.GetGraphicItem(AListIndexValue, iSignID)).NewRA);
                end;
              //iGap := r div 10; //FobjCanvasInfo.Margin - (FobjCanvasInfo.Margin div 3);// div 4;
              //iGap := r div 5{8}; //FobjCanvasInfo.Margin - (FobjCanvasInfo.Margin div 3);// div 4;
            end
          else
            if objSelfMarker is THouseCusp then
              begin
                iRA := Round(THouseCusp(objSelfMarker).RA);
                if THouseCusp(objSelfMarker).HouseNumber <> 1 then
                  iRA := iRA + 10; // házközép
                iSignID := 12 + THouseCusp(objSelfMarker).HouseNumber; //13tól indul

                //iGap := r div 5; //FobjCanvasInfo.Margin - (FobjCanvasInfo.Margin div 6);// div 2;
              end
            else
              if objSelfMarker is TZodiacSignForSelfMarkers then
                begin
                  iRA := Round(TZodiacSignForSelfMarkers(objSelfMarker).RA);
                  iSignID := - TZodiacSignForSelfMarkers(objSelfMarker).SignID;

                  //iGap := r div 5; //FobjCanvasInfo.Margin - (FobjCanvasInfo.Margin div 6);// div 2;
                end;

          objSelfMarkerImage := FSelfMarkerGraphicControlList.GetGraphicItem(AListIndexValue, iSignID);

          if not Assigned(objSelfMarkerImage) then
            begin
              objSelfMarkerImage        := TSelfMarkerGraphicControl.Create(FCanvasControl);
              objSelfMarkerImage.Parent := FCanvasControl.Parent;
              objSelfMarkerImage.BackGroundColor := FCanvas.Brush.Color;
              objSelfMarkerImage.FOwnerDraw := true;
              objSelfMarkerImage.SignID := iSignID;

              TSelfMarkerGraphicControl(objSelfMarkerImage).FTriangle := FSettingsProvider.GetEnnalapotJelolesiMod = 1;

              if objSelfMarker is TPlanet then
                begin
                  objSelfMarkerImage.Hint := 'Énállapot: ' + TPlanet(objSelfMarker).PlanetName;
                  objSelfMarkerImage.Canvas.Font.Color := GetZodiacSignColor(TPlanet(objSelfMarker).InZodiacSign);
                end
              else
                if objSelfMarker is THouseCusp then
                  begin
                    if THouseCusp(objSelfMarker).HouseNumber = 1 then
                      objSelfMarkerImage.Hint := 'Énállapot: ' + 'Ascendens'
                    else
                      if FSettingsProvider.GetShowHouseNumbersByArabicNumbers then
                        objSelfMarkerImage.Hint := 'Énállapot: ' + cHOUSECAPTIONS[THouseCusp(objSelfMarker).HouseNumber].sHouseNumberArabic + '. ház'
                      else
                        objSelfMarkerImage.Hint := 'Énállapot: ' + cHOUSECAPTIONS[THouseCusp(objSelfMarker).HouseNumber].sHouseNumberOther + '. ház';
                    objSelfMarkerImage.Canvas.Font.Color := GetZodiacSignColor(THouseCusp(objSelfMarker).InZodiacSign);
                  end
                else
                  if objSelfMarker is TZodiacSignForSelfMarkers then
                    begin
                      objSelfMarkerImage.Canvas.Font.Color := GetZodiacSignColor(TZodiacSignForSelfMarkers(objSelfMarker).SignID - 1);
                      objSelfMarkerImage.Hint := 'Énállapot: ' +  cZODIACANDPLANETLETTERS[TZodiacSignForSelfMarkers(objSelfMarker).SignID - 1].sZodiacName;
                    end;

              objSelfMarkerImage.KepletIdx := AListIndexValue;
              FSelfMarkerGraphicControlList.AddGraphicItem(objSelfMarkerImage);
            end;

          TSelfMarkerGraphicControl(objSelfMarkerImage).FTriangle := FSettingsProvider.GetEnnalapotJelolesiMod = 1;
          TSelfMarkerGraphicControl(objSelfMarkerImage).FPainted := false;
          
          objSelfMarkerImage.FontSize := Round(GetFontSize * 0.8);
          objSelfMarkerImage.SignID   := iSignID;

          // zodiákus - analóg planéta - SelfMarker
          if FSettingsProvider.GetEnnalapotJelolesiMod = 1 then
            iGap := FCanvas.TextWidth('MMII')
          else
            iGap := FCanvas.TextWidth('MMI');

          xk1 := Round((r + iGap) * cos((360 - (iRA - round(ARA) + 180)) * Rads));
          yk1 := Round((r + iGap) * sin((360 - (iRA - round(ARA) + 180)) * Rads));

          objSelfMarkerImage.Left := (xc + xk1) - round(objSelfMarkerImage.Width / 2);
          objSelfMarkerImage.Top  := (yc + yk1) - round(objSelfMarkerImage.Width / 2);

          TSelfMarkerGraphicControl(objSelfMarkerImage).SetSelfMarkerPlanetXY
            (
              xc + Round((r - GetPlanetBorderLineGap) * cos((360 - (iRA - round(ARA) + 180)) * Rads)),
              yc + Round((r - GetPlanetBorderLineGap) * sin((360 - (iRA - round(ARA) + 180)) * Rads))
            );

          objSelfMarkerImage.Invalidate;
        end;
    end;
end;

procedure TDrawControllerBase.DrawZodiacSigns(AListIndexValue: Integer; ARA: double);
var iGap, i : integer;
    xk2, yk2, AForgatva, iOrigFontSize, iOrigBrushColor : integer; // pontok a körön és sugárhossz

    objZodiacImage, objPlanetImage : TBaseGraphicControl;
    sZodiacSignsSet : TByteSet;
    bShowAnalogPlanets : boolean;
begin
  FCanvas.Pen.Width := 1;
  FCanvas.Pen.Color := clBlack;

  AForgatva := Round(ARA); // !!! RA !!!

  iOrigFontSize := GetFontSize;
  iOrigBrushColor := FCanvas.Brush.Color;

  sZodiacSignsSet := FSettingsProvider.GetShownZodiacSigns;
  bShowAnalogPlanets := FSettingsProvider.GetShownAnalogPlanets;

  if FSettingsProvider.GetShowZodiacDegsOnOtherCircle then
    iGap := GetZodiacBorderLineGap_IfOtherDeg
  else
    iGap := GetZodiacBorderLineGap;
  for i := 359 downto 0 do
    begin
      if i mod 30 = 0 then
        begin
          // zodiákus kirakása...
          xk2 := Round((r - iGap + Round((iGap div 2) * 1.0)) * -cos((i + 15 + AForgatva) * Rads));
          yk2 := Round((r - iGap + Round((iGap div 2) * 1.0)) * -sin((i + 15 + AForgatva) * Rads));

          // Kiszinezzük a hátterét a körcikknek, hogy szép szines legyen...
          if not FIsPrinting or FSettingsProvider.GetPrintInColor then
            begin
              case 11 - (i div 30) + 1 of
              1, 5,  9: FCanvas.Brush.Color := GetColorOfType(tcol_Fire);
              2, 6, 10: FCanvas.Brush.Color := GetColorOfType(tcol_Ground);
              3, 7, 11: FCanvas.Brush.Color := GetColorOfType(tcol_Air);
              4, 8, 12: FCanvas.Brush.Color := GetColorOfType(tcol_Water);
              end;
              ExtFloodFill(FCanvas.Handle, xc + xk2, yc + yk2, clBlack{RGB(0, 64, 128){Határ vonal szín}, FLOODFILLBORDER);
            end;

          if 11 - (i div 30) in sZodiacSignsSet then
            begin
              objZodiacImage := FZodiacSignGraphicControlList.GetGraphicItem(AListIndexValue, 11 - (i div 30));

              if not Assigned(objZodiacImage) then
                begin
                  objZodiacImage          := TZodiacSignGraphicControl.Create(FCanvasControl);
                  objZodiacImage.Parent   := FCanvasControl.Parent;
                  objZodiacImage.BackGroundColor := FCanvas.Brush.Color;
                  objZodiacImage.SignID   := 11 - (i div 30);
                  objZodiacImage.KepletIdx := AListIndexValue;

                  FZodiacSignGraphicControlList.AddGraphicItem(objZodiacImage);
                end;

              objZodiacImage.FontSize := Round(iOrigFontSize * 1.3);
              objZodiacImage.SignID   := 11 - (i div 30);
              objZodiacImage.Left := (xc + xk2) - round(Min(objZodiacImage.Height, objZodiacImage.Width) / 2);
              objZodiacImage.Top  := (yc + yk2) - round(Max(objZodiacImage.Height, objZodiacImage.Width) / 2);
            end;

          if bShowAnalogPlanets then
            begin
              // zodiákus - analóg planéta
              xk2 := Round((r - iGap + Round((iGap div 2) * 1.0)) * -cos((i + 25 + AForgatva) * Rads));
              yk2 := Round((r - iGap + Round((iGap div 2) * 1.0)) * -sin((i + 25 + AForgatva) * Rads));

              objPlanetImage := FZodiacPlanetSignGraphicControlList.GetGraphicItem(AListIndexValue, 11 - (i div 30));

              if not Assigned(objPlanetImage) then
                begin
                  objPlanetImage          := TPlanetZodiacSignGraphicControl.Create(FCanvasControl);
                  objPlanetImage.Parent   := FCanvasControl.Parent;
                  objPlanetImage.BackGroundColor := FCanvas.Brush.Color;
                  objPlanetImage.SignID   := 11 - (i div 30);
                  objPlanetImage.KepletIdx := AListIndexValue;

                  FZodiacPlanetSignGraphicControlList.AddGraphicItem(objPlanetImage);
                end;

              objPlanetImage.FontSize := iOrigFontSize - 2;
              objPlanetImage.SignID   := 11 - (i div 30);
              objPlanetImage.Left := (xc + xk2) - round(Min(objPlanetImage.Height, objPlanetImage.Width) / 2); 
              objPlanetImage.Top  := (yc + yk2) - round(Max(objPlanetImage.Height, objPlanetImage.Width) / 2);
            end;

          FCanvas.Brush.Color := iOrigBrushColor;
        end;
    end;

  FCanvas.Font.Size := iOrigFontSize;
end;

function TDrawControllerBase.GetAspectPenColor(AColor: TColor): TColor;
begin
  Result := AColor;
end;

function TDrawControllerBase.GetBaseBackgroundBrushColor: TColor;
begin
//  Result := clBtnFace;
  Result := clWhite;
end;

function TDrawControllerBase.GetCalcResultCount: Integer;
begin
  Result := FCalcResultList.Count;
end;

function TDrawControllerBase.GetColorOfType(AColorType: TColorType): TColor;
begin
  Result := clBlack;
  case AColorType of
  tcol_Fire  : Result := FSettingsProvider.GetColorOfFire; //Result := RGB(251,   3,  27); //RGB(255, 105, 105); // tûz
  tcol_Ground: Result := FSettingsProvider.GetColorOfGround; //Result := RGB( 11, 202,   2); //RGB(104, 232, 104); // föld
  tcol_Air   : Result := FSettingsProvider.GetColorOfAir; //Result := RGB(255, 255,  85); //RGB(255, 255,  30); // levegeõ
  tcol_Water : Result := FSettingsProvider.GetColorOfWater; //Result := RGB( 42, 106, 255); //RGB( 46,  46, 255); // víz
  end;
end;

function TDrawControllerBase.GetFontSize: Integer;
const cDEFSIZE = 450;
begin
  // 675 -> 16os ; 450 -> 12es ; 225 -> 8as ; ...
  // 55 pixelenként 1el változik a méret -> 450 az alap ahol 12es
  Result := 12 - ((cDEFSIZE - FobjCanvasInfo.GetMaxHeightWidth) div 55);
end;

function TDrawControllerBase.GetInnerHouseBorderGap: Integer;
begin
  Result := round((r div 2) * 1.15 {* GetSzorzoErtekFor_iGaps{});//r div 2;
end;

function TDrawControllerBase.GetInnerZodiacBorderGap: Integer;
begin
  Result := r div 6;
end;

function TDrawControllerBase.GetInnerZodiacBorderGap_IfOtherDeg: integer;
begin
  Result := Round(r div 6 * 0.8);
end;

function TDrawControllerBase.GetOuterHouseBorderGap: Integer;
begin
  Result := round((GetInnerHouseBorderGap {r div 2{}) * 0.85 {* GetSzorzoErtekFor_iGaps{});
end;

function TDrawControllerBase.GetOuterZodiacBorderGap: Integer;
begin
  Result := 0;
end;

function TDrawControllerBase.GetPlanetBorderLineGap: Integer;
begin
  Result := (r div 6) - round(((r div 6) - round((r div 2) * 0.80)) / 2);
end;

function TDrawControllerBase.GetPlanetExtBorderLineGap: integer;
begin
  Result := (r div 6) - round(((r div 6) - round((r div 2) * 0.60)) / 2);
end;

function TDrawControllerBase.GetSzorzoErtekFor_iGaps: Double;
begin
  Result := (Int(FSettingsProvider.GetBetumeretSzorzo) + ((FSettingsProvider.GetBetumeretSzorzo - Int(FSettingsProvider.GetBetumeretSzorzo)) * 3 / 10));
end;

function TDrawControllerBase.GetZodiacBorderLineGap: Integer;
begin
  //Result := (r div 6) {div 2{};
  Result := GetInnerZodiacBorderGap;
end;

function TDrawControllerBase.GetZodiacBorderLineGap_IfOtherDeg: integer;
begin
  Result := GetInnerZodiacBorderGap_IfOtherDeg;
end;

function TDrawControllerBase.GetZodiacSignColor(
  AZodiacSignID: integer): TColor;
begin
  Result := clBlack;
  case AZodiacSignID + 1 of
  1, 5,  9: Result := GetColorOfType(tcol_Fire);
  2, 6, 10: Result := GetColorOfType(tcol_Ground);
  3, 7, 11: Result := GetColorOfType(tcol_Air);
  4, 8, 12: Result := GetColorOfType(tcol_Water);
  end;
end;

function TDrawControllerBase.Get_iGap_ForPlanets(AListIndexValue: Integer): Integer;
begin
  if AListIndexValue = 0 then
    Result := Round(GetPlanetBorderLineGap * GetSzorzoErtekFor_iGaps)
  else
    Result := GetOuterZodiacBorderGap - Round(FobjCanvasInfo.Margin * 0.6);
end;

procedure TDrawControllerBase.HideSelfMarkers(AHide: boolean = true);
var i : integer;
begin
  for i := 0 to FSelfMarkerGraphicControlList.Count - 1 do
    TSelfMarkerGraphicControl(FSelfMarkerGraphicControlList.Items[i]).Visible := not AHide;
end;

function TDrawControllerBase.IsPlanetVisible(APlanetID: Integer): Boolean;
var i : integer;
begin
  Result := true;

  for i := 0 to FPlanetGraphicControlList.Count - 1 do
    if TPlanetSignGraphicControl(FPlanetGraphicControlList.Items[i]).Planet.PlanetID = APlanetID then
      begin
        Result := TPlanetSignGraphicControl(FPlanetGraphicControlList.Items[i]).Visible;
        Break;
      end;
end;

procedure TDrawControllerBase.PaintInfoToPrintImage(ACanvas: TCanvas; AWidth, AHeight: integer);
begin
// ÜRES
end;

procedure TDrawControllerBase.ReArrangePlanets(ARA : double);

  function IsAtfedes(APlanet01, APlanet02: TPlanetSignGraphicControl): boolean;
  var rectPlanet01, rectPlanet02 : TRect;
  begin
    rectPlanet01 := APlanet01.BoundsRect;
    rectPlanet02 := APlanet02.BoundsRect;

    Result := (
                // Bal felsõ pont
                PtInRect(rectPlanet01, rectPlanet02.TopLeft) or
                // Jobb felsõ pont
                PtInRect(rectPlanet01, Point(rectPlanet02.Right, rectPlanet02.Top)) or
                // Bal alsó
                PtInRect(rectPlanet01, Point(rectPlanet02.Left, rectPlanet02.Bottom)) or
                // Jobb alsó
                PtInRect(rectPlanet01, rectPlanet02.BottomRight)
              ) or
              (
                // Bal felsõ pont
                PtInRect(rectPlanet02, rectPlanet01.TopLeft) or
                // Jobb felsõ pont
                PtInRect(rectPlanet02, Point(rectPlanet01.Right, rectPlanet01.Top)) or
                // Bal alsó
                PtInRect(rectPlanet02, Point(rectPlanet01.Left, rectPlanet01.Bottom)) or
                // Jobb alsó
                PtInRect(rectPlanet02, rectPlanet01.BottomRight)
              );
    {}
  end;

  procedure SetNewCoordinates(APlanet: TPlanetSignGraphicControl; AGap: integer);
  var xk1, yk1, iGap : integer;
  begin
    iGap := Get_iGap_ForPlanets(APlanet.KepletIdx);

    APlanet.NewRA := APlanet.NewRA + AGap;
    
    if APlanet.NewRA < 0 then APlanet.NewRA := 360 else
    if APlanet.NewRA > 360 then APlanet.NewRA := 0;

    xk1 := Round((r - iGap) * cos((360 - (APlanet.NewRA {+ AGap{} - Round(ARA) + 180)) * Rads));
    yk1 := Round((r - iGap) * sin((360 - (APlanet.NewRA {+ AGap{} - Round(ARA) + 180)) * Rads));

    APlanet.NewLeft := (xc + xk1) - round(APlanet.Width / 2);
    APlanet.NewTop  := (yc + yk1) - round(APlanet.Width / 2);
  end;

const cPIXELNUM = 2;
var bOK : boolean;
    i, j, iMozgat, iSafe : integer;
    oPlanet01, oPlanet02 : TPlanetSignGraphicControl;
begin
  iSafe := 0;
  repeat
    bOK := true;

    for i := 0 to FPlanetGraphicControlList.Count - 1 do
      begin
        oPlanet01 := TPlanetSignGraphicControl(FPlanetGraphicControlList.Items[i]);

        for j := i + 1 to FPlanetGraphicControlList.Count - 1 do
          if j <> i then // nem saját maga
            begin
              oPlanet02 := TPlanetSignGraphicControl(FPlanetGraphicControlList.Items[j]);

              if IsAtfedes(oPlanet01, oPlanet02) then
                begin
                  bOK := false;

                  if Abs(oPlanet01.OrigRA - oPlanet02.OrigRA) >= 330 then
                    begin
                      if oPlanet01.OrigRA >= 330 then iMozgat := - cPIXELNUM else iMozgat := cPIXELNUM;
                    end
                  else
                    begin
                      if oPlanet01.OrigRA < oPlanet02.OrigRA then
                        iMozgat := - cPIXELNUM
                      else
                        iMozgat := + cPIXELNUM;
                    end;

                  SetNewCoordinates(oPlanet01, + iMozgat);
                  SetNewCoordinates(oPlanet02, - iMozgat);

                  inc(iSafe);
                end;
            end;
      end;
    inc(iSafe);
  until bOK or (iSafe > 100);
end;

procedure TDrawControllerBase.ReDrawCalculatedResults;
var i : integer;
    dARA, dBaseRA : Double;
begin
  if FKellLockWindow then
    LockWindowUpdate(FParentWinControl.Handle);

  FCanvas.Font.Name := cSYMBOLSFONTNAME;
  FCanvas.Font.Size := GetFontSize;

  if not FIsPrinting then
    FobjCanvasInfo.RecalcMargin(FIsPrinting);

  r  := FobjCanvasInfo.GetMaxHeightWidth div 2;
  xc := FobjCanvasInfo.GetMidPointX;
  yc := FobjCanvasInfo.GetMidPointY;

  //FCanvas.Rectangle(- 0, - 0, FParentWinControl.ClientRect.BottomRight.X + 0, FParentWinControl.ClientRect.BottomRight.Y + 0);
  //FCanvas.Rectangle(-1, -1, FobjCanvasInfo.GetBottomRightX - 1, FobjCanvasInfo.GetBottomRightY - 1);

  dBaseRA := 0;
  for i := 0 to FCalcResultList.Count - 1 do
    begin
      dARA := TCalcResult(FCalcResultList.Items[i]).AxisList.GetAxisInfo(SE_ASC).RA;

      if i = 0 then
        begin
          dBaseRA := dARA;
          
          DrawBaseCircles(i, dARA);
          DrawZodiacSigns(i, dARA);
          DrawHouseNumbers(i, dARA, TCalcResult(FCalcResultList.Items[i]).HouseCuspList);
//          DrawAspects
//            (
//              i,
//              dARA,
//              TCalcResult(FCalcResultList.Items[i]).AspectList,
//              TCalcResult(FCalcResultList.Items[i]).PlanetList,
//              TCalcResult(FCalcResultList.Items[i]).AxisList,
//              TCalcResult(FCalcResultList.Items[i]).HouseCuspList
//            );
        end
      else
        begin
          //dARA := dARA - AddFokSzam(dBaseRA, -dARA);
          if dBaseRA >= dARA then
            dARA := dARA + (dBaseRA - dARA)
          else
            dARA := dARA - (dARA - dBaseRA);
        end;

      DrawHouseCusps(i, dARA, TCalcResult(FCalcResultList.Items[i]).HouseCuspList);
      DrawPlanets(i, dARA, TCalcResult(FCalcResultList.Items[i]).PlanetList, TCalcResult(FCalcResultList.Items[i]).SelfMarkerList);

      if i = 0 then
        DrawAspects
          (
            i,
            dARA,
            TCalcResult(FCalcResultList.Items[i]).AspectList,
            TCalcResult(FCalcResultList.Items[i]).PlanetList,
            TCalcResult(FCalcResultList.Items[i]).AxisList,
            TCalcResult(FCalcResultList.Items[i]).HouseCuspList
          );

      if GetCalcResultCount = 1 then
        begin
          HideSelfMarkers(false);
          DrawSelfMarkers(i, dARA, TCalcResult(FCalcResultList.Items[i]).SelfMarkerList);
        end
      else
        HideSelfMarkers();
    end;

  // Ekkor a GraphicObject-ek helyett kirajzolunk a helyükre mi kézzel Caption elemeket
  if FIsPrinting then
    PaintInfoToPrintImage(FCanvas, FobjCanvasInfo.FWidth, FobjCanvasInfo.FHeight);

  {
  FCanvas.TextOut(0, 0, 'qwertyuiop[]'); // Zodiákus jegyek
  FCanvas.TextOut(0, 30, 'asdfghjkl;');  // Bolygók
  FCanvas.TextOut(0, 60, '1234567890');  // Számok
  FCanvas.TextOut(0, 90, 'SDTR AQ');  // ASC,MC,IC,DESC, FelszHold,LeszHold
  {}

  LockWindowUpdate(0);
end;

constructor TRectInformations.Create(AWinControl: TWinControl; AWidth: integer = -1; AHeight: integer = -1);
begin
  inherited Create;
  FWinControl := AWinControl;
  FHeight := -1;
  FWidth  := -1;
  FPrinting := false;
  FPrintFromTop := 0;

  if AHeight <> -1 then
    begin
      FHeight := AHeight;
      FWidth  := AWidth;
      FPrinting := true;
    end;

  RecalcMargin(AHeight <> -1);

  if AHeight <> -1 then // Printing van...
    begin
      FMargin := Round(FMargin * 2);
      FPrintFromTop := GetMaxHeightWidth div 20;
    end;
end;

function TRectInformations.GetBottomRightX: Integer;
begin
  if not FPrinting then
    Result := Max(FWidth, FWinControl.Width) - FMargin - (( (Max(FWidth, FWinControl.Width) - 2 * FMargin) - GetMaxHeightWidth) div 2)
  else
    Result := FMargin + GetMaxHeightWidth;
end;

function TRectInformations.GetBottomRightY: Integer;
begin
  if not FPrinting then
    Result := Max(FHeight, FWinControl.Height) - FMargin - (( (Max(FHeight, FWinControl.Height) - 2 * FMargin) - GetMaxHeightWidth) div 2)
  else
    Result := FMargin + FPrintFromTop + GetMaxHeightWidth;
end;

function TRectInformations.GetMaxHeightWidth: Integer;
begin
  Result := Min(Max(FWidth, FWinControl.Width) - 2 * FMargin, Max(FHeight, FWinControl.Height) - 2 * FMargin)
end;

function TRectInformations.GetMidPointX: Integer;
begin
  if not FPrinting then
    Result := Max(FWidth, FWinControl.Width) div 2
  else
    Result := FMargin + GetMaxHeightWidth div 2;
end;

function TRectInformations.GetMidPointY: Integer;
begin
  if not FPrinting then
    Result := Max(FHeight, FWinControl.Height) div 2
  else
    Result := FMargin + FPrintFromTop + GetMaxHeightWidth div 2;
end;

function TRectInformations.GetTopLeftX: Integer;
begin
  if not FPrinting then
    Result := FMargin + 0 + (( (Max(FWidth, FWinControl.Width) - 2 * FMargin) - GetMaxHeightWidth) div 2)
  else
    Result := FMargin;
end;

function TRectInformations.GetTopLeftY: Integer;
begin
  if not FPrinting then
    Result := FMargin + 0 + (( (Max(FHeight, FWinControl.Height) - 2 * FMargin) - GetMaxHeightWidth) div 2)
  else
    Result := FMargin + FPrintFromTop;
end;

procedure TRectInformations.RecalcMargin(APrint: Boolean = false);
begin
  if not APrint then
    FMargin := (Min(Max(FWidth, FWinControl.Width), Max(FHeight, FWinControl.Height))) div 10{15{}
  else
    FMargin := (Min(Max(FWidth, FWinControl.Width), Max(FHeight, FWinControl.Height))) div 15;
end;

procedure TGraphicControlList.AddGraphicItem(AGraphicItem: TBaseGraphicControl);
var iIdx : integer;
begin

  iIdx := GetItemIndexOfGraphicControl(AGraphicItem.KepletIdx, AGraphicItem.SignID);
  if iIdx = -1 then
    Self.Add(AGraphicItem)
  else
    Self.Items[iIdx] := AGraphicItem;

end;

function TGraphicControlList.GetGraphicItem(AKepletIdx: integer; ASignID: integer): TBaseGraphicControl;
var iIdx : integer;
begin
  Result := nil;

  iIdx := GetItemIndexOfGraphicControl(AKepletIdx, ASignID);

  if iIdx <> -1 then
    Result := TBaseGraphicControl(Self.Items[iIdx]);
end;

function TGraphicControlList.GetItemIndexOfGraphicControl(AKepletIdx: integer; ASignID: integer): Integer;
var i : integer;
begin
  Result := -1;

  i := 0;

  while (Result = -1) and (i <= Self.Count - 1) do
    begin
      if (TBaseGraphicControl(Self.Items[i]).SignID = ASignID) and
         (TBaseGraphicControl(Self.Items[i]).KepletIdx = AKepletIdx) then
        Result := i;

      inc(i);
    end;
    
end;

constructor TBaseGraphicControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FSignLetter := '';

  Canvas.Font.Name := cSYMBOLSFONTNAME;

  Height := 2;
  Width := 2;

  ShowHint := true;

  Cursor := crHandPoint;
  FDecHeightValue := 1;
  FDecTextValue := 1;
  FFokPerc := '';
  FHazursag := '';
  FRetrograde := '';

  Transparent := true;

  OnClick := OnBaseImageClick;
  FKepletIdx := 0;
  FIsShortNamePlanet := true;
  FOwnerDraw := False;
end;

procedure TBaseGraphicControl.OnBaseImageClick(Sender: TObject);
begin
  ShowMessage(Hint);
end;

procedure TBaseGraphicControl.RecalcHeight(AKellDecrease: boolean = true);
var iHeight, iWidth, iPlusHeight, iPlusWidth : integer;
begin
  Canvas.Brush.Color := FBackGroundColor;
  if not FOwnerDraw then
    Canvas.FillRect(Rect(0, 0, ClientRect.BottomRight.X, ClientRect.BottomRight.Y));

  iPlusHeight := 0;
  iPlusWidth  := 0;
  {
  if Trim(FRetrograde) <> '' then
    begin
      iPlusHeight := iPlusHeight + Round(Canvas.TextHeight(FRetrograde) / 5);
      iPlusWidth := iPlusWidth + Canvas.TextWidth(FRetrograde) div 2;
    end;
  {}
  if Trim(FHazursag) <> '' then
    begin
      iPlusHeight := iPlusHeight + Round(Canvas.TextHeight(FHazursag) / 5) * 2;
      iPlusWidth := iPlusWidth + Canvas.TextWidth(FHazursag) div 4;
    end;

  if FOwnerDraw and (Self is TSelfMarkerGraphicControl) then
    begin
      if TSelfMarkerGraphicControl(Self).FTriangle then
        begin
          iPlusHeight := iPlusHeight + Round(Canvas.TextHeight(FSignLetter) * 1.0);
          iPlusWidth := iPlusWidth + Round(Canvas.TextWidth(FSignLetter) * 3.0);
        end
      else
        begin
          iPlusHeight := iPlusHeight + Round(Canvas.TextHeight(FSignLetter) * 0.2);
          iPlusWidth := iPlusWidth + Round(Canvas.TextWidth(FSignLetter) * 0.7);
        end;
    end;

  iHeight := Canvas.TextHeight(FSignLetter) + iPlusHeight;
  iWidth := Canvas.TextWidth(FSignLetter) + iPlusWidth;

  if AKellDecrease then
    Height := iHeight + FDecTextValue + FDecHeightValue
  else
    Height := iHeight;

  Width := iWidth + 1{};
end;

procedure TBaseGraphicControl.SetFontSize(const Value: Integer);
begin
  FFontSize := Value;
  Canvas.Font.Size := Value;
end;

procedure TBaseGraphicControl.SetSignID(const Value: Integer);
var //iShiftLeft, iShiftTop : integer;
    sOrigFontName : string;
begin
  FSignID := Value;

  SetSignLetter(FSignID);

  RecalcHeight(FIsShortNamePlanet);

  if not FOwnerDraw then
    begin
      Canvas.Brush.Color := FBackGroundColor;
      ExtFloodFill(Canvas.Handle, 1, 1, clBlack{Határ vonal szín}, FLOODFILLBORDER);
    end;

  //Canvas.Font.Size := FFontSize;
  sOrigFontName := Canvas.Font.Name;

  if not FOwnerDraw then
    begin
      //Canvas.TextOut(0, FDecHeightValue, FSignLetter);
      if FIsShortNamePlanet then
        Canvas.TextOut((Self.Width - Canvas.TextWidth(FSignLetter)) div 2, FDecHeightValue, FSignLetter)
      else
        Canvas.TextOut(1, FDecHeightValue div 2, FSignLetter);
    end;

  Canvas.Font.Size := FFontSize;
  Canvas.Font.Name := sOrigFontName;
  SetHintString(FSignID);
end;

procedure TZodiacSignGraphicControl.SetHintString(AID: integer);
begin
  inherited;
  Hint := cZODIACANDPLANETLETTERS[AID].sZodiacName;
end;

procedure TZodiacSignGraphicControl.SetSignLetter(AID: integer);
begin
  inherited;
  FSignLetter := cZODIACANDPLANETLETTERS[AID].cZodiacLetter;
end;

{ TPlanetZodiacSignGraphicControl }

procedure TPlanetZodiacSignGraphicControl.SetHintString(AID: integer);
begin
  inherited;

  Hint := cZODIACANDPLANETLETTERS[AID].sZodiacName + ' jegy analóg planétája: ' + cZODIACANDPLANETLETTERS[AID].sZodiacPlanetName;
end;

procedure TPlanetZodiacSignGraphicControl.SetSignLetter(AID: integer);
begin
  inherited;
  FSignLetter := cZODIACANDPLANETLETTERS[AID].cZodiacsPlanetLetter;
end;

{ TPlanetSignGraphicControl }

constructor TPlanetSignGraphicControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FNewLeft := 0;
  FNewTop := 0;
  FNewRA := 0;
  FOrigLeft := 0;
  FOrigTop := 0;
  FOrigRA := 0;
  FPainted := false;

  FDecHeightValue := -6;
  FDecTextValue := -6;

  //OnClick := OnImageClick;
  FPlanet := nil;
  FHouseNumArabic := True;
  FPlanetName := '';
end;

procedure TPlanetSignGraphicControl.OnImageClick(Sender: TObject);
begin
{
  ShowMessage('Left: ' + IntToStr(Self.Left) + #13 +
              'Top: ' + IntToStr(Self.Top) + #13 +
              'RA:' + IntToStr(Round(NewRA)) + #13#13 +
              'OrigLeft: ' + IntToStr(Self.OrigLeft) + #13 +
              'OrigTop: ' + IntToStr(Self.OrigTop) + #13 +
              'OrigRA:' + IntToStr(Round(OrigRA)));
{}  
end;

procedure TPlanetSignGraphicControl.Paint;
begin
  inherited;
  {$IFDEF SDEBUG}  
  if not FPainted then
    begin
      Self.Canvas.Rectangle(0, 0, Self.Width, Self.Height);
      FPainted := true;
    end;
  {$ENDIF}
{}
end;

procedure TPlanetSignGraphicControl.SetHintString(AID: integer);
begin
  inherited;
  //Hint := cPLANETLIST[AID].sPlanetName;
end;

procedure TPlanetSignGraphicControl.SetNewLeft(const Value: Integer);
begin
  FNewLeft := Value;
  Left := Value;
end;

procedure TPlanetSignGraphicControl.SetNewRA(const Value: Double);
begin
  FNewRA := Value;
end;

procedure TPlanetSignGraphicControl.SetNewTop(const Value: Integer);
begin
  FNewTop := Value;
  Top := Value;
end;

procedure TPlanetSignGraphicControl.SetOrigLeft(const Value: Integer);
begin
  FOrigLeft := Value;
  FNewLeft := Value;
  Left := Value;
end;

procedure TPlanetSignGraphicControl.SetOrigRA(const Value: Double);
begin
  FOrigRA := Value;
  FNewRA := Value;
end;

procedure TPlanetSignGraphicControl.SetOrigTop(const Value: Integer);
begin
  FOrigTop := Value;
  FNewTop := Value;
  Top := Value;
end;

procedure TPlanetSignGraphicControl.SetPlanet(const Value: TPlanet);
var sHouseNum: string;
begin
  FPlanet := Value;

  case FHouseNumArabic of
  true : sHouseNum := cHOUSECAPTIONS[Value.HouseNumber].sHouseNumberArabic;
  false: sHouseNum := cHOUSECAPTIONS[Value.HouseNumber].sHouseNumberOther;
  end;

  Hint :=
          'Név: ' + FPlanetName + #13 + //cPLANETLIST[Value.PlanetID].sPlanetName + #13 +
          'Jegyben: ' + cZODIACANDPLANETLETTERS[Value.InZodiacSign].sZodiacName + #13 +
          'Fokon: ' + DoubleFokToStr(Value.StartDegree) + #13 +
          'Házban: ' + sHouseNum + '. ház';

  if Trim(Value.FHouseLordsContainer.GetHouseNumberTexts) <> '' then
    Hint := Hint + #13 + 'Házúr: ' + Value.FHouseLordsContainer.GetHouseNumberTexts;

  if Value.Retrograd then
    Hint := Hint + #13 + BoolToRetrogradeAstro(Value.Retrograd);

  SetSignID(FSignID);
end;

procedure TPlanetSignGraphicControl.SetSignLetter(AID: integer);
var objPlanetConstProvider : TPlanetConstInfoProvider;
begin
  inherited;

  objPlanetConstProvider := TPlanetConstInfoProvider.Create;

  FSignLetter := objPlanetConstProvider.cPlanetLetter(AID); //cPLANETLIST[AID].cPlanetLetter;

  FreeAndNil(objPlanetConstProvider);
  
  if Length(FSignLetter) <> 1 then // Ekkor nem Kepler Font
    begin
      Canvas.Font.Name := cBASEFONTNAME;
      Canvas.Font.Size := (Canvas.Font.Size div 3) * 2;
      FFontSize := Canvas.Font.Size;
      FIsShortNamePlanet := false;
    end
  else
    begin
      FHazursag := '';
      FFokPerc := '';
      Canvas.Font.Size := FFontSize;
      if Assigned(FPlanet) then
        begin
          {
          if FPlanet.Retrograd then
            FRetrograde := cRETROGRADELETTER;
          {}
          FHazursag := FPlanet.FHouseLordsContainer.GetHouseNumberTexts;
          FFokPerc := DoubleToFokStrOnlyFokPerc(FPlanet.StartDegree);
        end;
    end;
end;

constructor THouseNumberGraphicControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Canvas.Font.Name := cBASEFONTNAME2;
  FHouseCusp := nil;
  FHouseNumArabic := True;
end;

{ THouseNumberGraphicControl }

procedure THouseNumberGraphicControl.SetHintString(AID: integer);
begin
  inherited;
  Hint := cHOUSECAPTIONS[AID].sHouseDesc;
end;

procedure THouseNumberGraphicControl.SetHouseCusp(const Value: THouseCusp);
var sHouseNum : string;
begin
  case FHouseNumArabic of
  true : sHouseNum := cHOUSECAPTIONS[Value.HouseNumber].sHouseNumberArabic;
  false: sHouseNum := cHOUSECAPTIONS[Value.HouseNumber].sHouseNumberOther;
  end;

  FHouseCusp := Value;

  Hint :=
          cHOUSENAMEENDINGS[Value.HouseNumber] + #13 +
          //sHouseNum + '. ház' + #13 +
          'Jegyben: ' + cZODIACANDPLANETLETTERS[Value.InZodiacSign].sZodiacName + #13 +
          'Fokon: ' + DoubleFokToStr(Value.StartDegree) + #13 +
          'Leírás: ' + cHOUSECAPTIONS[Value.HouseNumber].sHouseDesc;
end;

procedure THouseNumberGraphicControl.SetSignLetter(AID: integer);
begin
  inherited;
  //FSignLetter := cHOUSECAPTIONS[AID].sHouseNumber;
  case FHouseNumArabic of
  true : FSignLetter := cHOUSECAPTIONS[AID].sHouseNumberArabic;
  false: FSignLetter := cHOUSECAPTIONS[AID].sHouseNumberOther;
  end;
end;

constructor TSelfMarkerGraphicControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FPainted := False;
  OnResize := SelfOnResize;
  FSelfMarkerPlanetX := 0;
  FSelfMarkerPlanetY := 0;
end;

procedure TSelfMarkerGraphicControl.DoOwnerPaint;
begin
  if not FPainted and FOwnerDraw then
    begin
      if FTriangle then
        begin // Triangle
          PaintTriangle;
        end
      else
        begin // Circle
          PaintCircle;
        end;
      FPainted := true;
    end;
end;

procedure TSelfMarkerGraphicControl.SetSelfMarkerPlanetXY(X, Y: Integer);
begin
  FSelfMarkerPlanetX := X;
  FSelfMarkerPlanetY := Y;

  DoOwnerPaint;
end;

procedure TSelfMarkerGraphicControl.Paint;
begin
  inherited;
  DoOwnerPaint;
end;

procedure TSelfMarkerGraphicControl.PaintCircle;
begin
  DrawCircleToCanvas
    (
      Self.Canvas,
      Canvas.ClipRect,
      FBackGroundColor,
      Self.Canvas.Font.Color,
      clBlack,
      1,
      Self.Height,
      Self.Width
    );

end;

procedure TSelfMarkerGraphicControl.PaintTriangle;
begin
  DrawTriangleToCanvas
    (
      Self.Canvas,
      Canvas.ClipRect,
      FBackGroundColor,
      Self.Canvas.Font.Color,
      clBlack,
      1,
      Self.Height,
      Self.Width,
      Self.Left,
      Self.Top,
      FSelfMarkerPlanetX,
      FSelfMarkerPlanetY
    );
end;

procedure TSelfMarkerGraphicControl.SelfOnResize(Sender: TObject);
begin
  FPainted := false;
end;

procedure TSelfMarkerGraphicControl.SetHintString(AID: integer);
begin
  inherited;
//  Hint := '';
end;

procedure TSelfMarkerGraphicControl.SetSignLetter(AID: integer);
begin
  inherited;
  Canvas.Font.Name := cSYMBOLSFONTNAME;

  FSignLetter := cSELFMARKERSIGNLETTER;
end;

end.
