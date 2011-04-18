{
  Konstansok a program mûködéséhez
}
unit uAstro4AllConsts;

interface

uses DateUtils, swe_de32, Graphics;

type TZodiacSignAndPlanet = record
       iZodiacID,
       iPlanetID : integer;
       cZodiacLetter,
       cZodiacsPlanetLetter : char;
       sZodiacName,
       sZodiacPlanetName,
       sBulvarZodiacName,
       sBulvarZodiacItemName : string;
     end;

     TAspectValues = record
       cAspectLetter : char;
       sAspectName,
       sOtherAspectName : string;
       iDeg : integer;
       iOrb : Double;
     end;

     TPlanetNames = record
       cPlanetLetter : string;
       sPlanetName : string;
     end;

     THouseNames = record
       sHouseNumberArabic : string[5];
       sHouseNumberOther  : string[5];
       sHouseDesc : string;
     end;

     TAxisNames = record
       sLongAxisName,
       sShortAxisName  :string;
     end;

     TAssignSettingsINI = record
       sItemName : string[20];
       iAssignedItem : integer;
     end;

    TBulvarType = (tbulv_AjandekAJegySzulotteinek, tbulv_JegyEsEgeszseg, tbulv_JegyEsKoveik, tbulv_JegyArnyoldalai,
                   tbulv_JegyAmitSzeretnek, tbulv_JegyAmitNemSzeretnek, tbulv_JegyErossegei, tbulv_JegyBunok,
                   tbulv_JegyDivat);

    TAspectType = (tasc_None, tasc_Planet, tasc_Axis, tasc_HouseCusp);
    TAspectQualityType = (taqu_None, taqu_Exact, taqu_Grow, taqu_Decrease, taqu_Other);
    TColorType = (tcol_Water, tcol_Ground, tcol_Air, tcol_Fire);

    TPrintType = (ptSzulKeplet, ptDrakonikus, prOsszevetes, ptPrimerDirekcio, ptSzekunderDirekcio, ptSolarRevolution);

    TRegState = (regAll, regBase, regNone);

    TByteSet = set of byte;

    TAspectStyleRec = record
      sItemName : string;
      psPenStyle : TPenStyle;
    end;

    TTerNegyed = (negyNONE, negyJobb, negyAlso, negyBal, negyFelso);

const cFILENAME_CEST     = 'table.cest.dat';      // Téli/Nyár idõszámítás idõpontok
      cFILENAME_CITY     = 'table.city.dat';      // Fõbb települések világszerte 
      cFILENAME_COUNTRY  = 'table.country.dat';   // Országok
      cFILENAME_TIMEZONE = 'table.timezone.dat';  // Idõzóna adatok

      cFILENAME_BULVARJELLEMZESEK = 'bulvar\jellemzesek.ini';
      cFILENAME_IMAGEDLL = 'regmonimages.dll';
      cFILENAME_SETTINGS = 'settings.ini';

      cFILE_SEP = ';'; // A mezõ szeparátor a fájlokban

      cSZULKEPLETFILEFILETER = 'Születési képletek (*.szk)|*.szk|Minden fájl (*.*)|*.*'; 

      cPATH_EPHE_DATA = 'data\sweph\';
      cPATH_DATA = 'data\';
      cPATH_SZULKEPLET = 'hors\';

      cREG_KEYLASTOPENEDFILES = '\Software\Regiomontanus\LastOpenedFiles\';
      cREG_PREFIX_LASTOPENED = 'LastOpened';

      // Horoszkóp INI fájl szerkezete
      cBIRTHINI_SECBIRTHINFO  = 'BirthInfo';
      cBIRTHINI_SECNOTES      = 'Notes';

      cBIRTHINI_Name          = 'Name';
      cBIRTHINI_Gender        = 'Gender';
      cBIRTHINI_Year          = 'Year';
      cBIRTHINI_Month         = 'Month';
      cBIRTHINI_Day           = 'Day';
      cBIRTHINI_Hour          = 'Hour';
      cBIRTHINI_Minute        = 'Minute';
      cBIRTHINI_Second        = 'Second';
      cBIRTHINI_TZoneCode     = 'TZoneCode';
      cBIRTHINI_TZoneWest     = 'TZoneWest';
      cBIRTHINI_TZoneHour     = 'TZoneHour';
      cBIRTHINI_TZoneMinute   = 'TZoneMinute';
      cBIRTHINI_LocCity       ='LocCity';
      cBIRTHINI_LocCountry    ='LocCountry';
      cBIRTHINI_LocCountryID  ='LocCountryID';
      cBIRTHINI_LocAltitude   = 'LocAltitude';
      cBIRTHINI_LocLongDegree = 'LocLongDegree';
      cBIRTHINI_LocLongMinute = 'LocLongMinute';
      cBIRTHINI_LocLongSecond = 'LocLongSecond';
      cBIRTHINI_LocLatDegree  = 'LocLatDegree';
      cBIRTHINI_LocLatMinute  = 'LocLatMinute';
      cBIRTHINI_LocLatSecond  = 'LocLatSecond';
      cBIRTHINI_IsDayLightSavingTime = 'IsDayLightSavingTime';

      cBIRTHINI_NoteBASE = 'Note'; // NoteXX=

      //CountryCode;EVTOL;HOTOL;NAPTOL;ORATOL;EVIG;HOIG;NAPIG;ORAIG
      cDS_CEST_CountryCode = 'CountryCode';
      cDS_CEST_EVTOL       = 'EVTOL';
      cDS_CEST_HOTOL       = 'HOTOL';
      cDS_CEST_NAPTOL      = 'NAPTOL';
      cDS_CEST_ORATOL      = 'ORATOL';
      cDS_CEST_EVIG        = 'EVIG';
      cDS_CEST_HOIG        = 'HOIG';
      cDS_CEST_NAPIG       = 'NAPIG';
      cDS_CEST_ORAIG       = 'ORAIG';

      cDS_DISP_CEST_CountryCode = 'Kód';
      cDS_DISP_CEST_EVTOL       = 'Év';
      cDS_DISP_CEST_HOTOL       = 'Hó';
      cDS_DISP_CEST_NAPTOL      = 'Nap';
      cDS_DISP_CEST_ORATOL      = 'Órától';
      cDS_DISP_CEST_EVIG        = 'Év';
      cDS_DISP_CEST_HOIG        = 'Hó';
      cDS_DISP_CEST_NAPIG       = 'Nap';
      cDS_DISP_CEST_ORAIG       = 'Óráig';

      //CountryCode;CityName;Longitude;Latitude;TimeZoneCode;
      cDS_CITY_CountryCode  = 'CountryCode';
      cDS_CITY_CityName     = 'CityName';
      cDS_CITY_Longitude    = 'Longitude';
      cDS_CITY_Latitude     = 'Latitude';
      cDS_CITY_TimeZoneCode = 'TimeZoneCode';

      //CountryCode;DisplayName;TimeZoneCode
      cDS_COUNTRY_CountryCode  = 'CountryCode';
      cDS_COUNTRY_DisplayName  = 'DisplayName';
      cDS_COUNTRY_TimeZoneCode = 'TimeZoneCode';

      cDS_DISP_COUNTRY_CountryCode  = 'Ország kód';
      cDS_DISP_COUNTRY_DisplayName  = 'Ország neve';
      cDS_DISP_COUNTRY_TimeZoneCode = 'Idõzóna';

      //TimeZoneCode;DisplayName;Delta;Group;Type
      cDS_TZONE_TimeZoneCode = 'TimeZoneCode';
      cDS_TZONE_DisplayName  = 'DisplayName';
      cDS_TZONE_Delta        = 'Delta';
      cDS_TZONE_Group        = 'Group';
      cDS_TZONE_Type         = 'Type';
      cDS_TZONE_Order        = 'Order';

      cY2000 = 730530.0;
      cINITNUMBER = 999;

      // Megnevezések
      cAXISNAMES : array[SE_ASC..SE_NASCMC] of TAxisNames =
        (
          (sLongAxisName: 'Ascendens'; sShortAxisName : 'AC'),
          (sLongAxisName: 'Medium Coeli'; sShortAxisName : 'MC'),
          (sLongAxisName: 'ARMS'; sShortAxisName : ''),
          (sLongAxisName: 'Vertex'; sShortAxisName : ''),
          (sLongAxisName: 'Keletpont'; sShortAxisName : ''),
          (sLongAxisName: 'Koascendens (W.Koch)'; sShortAxisName : ''),
          (sLongAxisName: 'Koascendens (M. Munkasey)'; sShortAxisName : ''),
          (sLongAxisName: 'Sarki Ascendens'; sShortAxisName : ''),
          (sLongAxisName: 'NASCMC'; sShortAxisName : '')
        );

      cDAYNAMES : array[DayMonday..DaySunday] of string =
        (
          'Hétfõ', 'Kedd', 'Szerda', 'Csütörtök', 'Péntek', 'Szombat', 'Vasárnap'
        );

      cZDS_Kos      =  0;
      cZDS_Bika     =  1;
      cZDS_Ikrek    =  2;
      cZDS_Rak      =  3;
      cZDS_Oroszlan =  4;
      cZDS_Szuz     =  5;
      cZDS_Merleg   =  6;
      cZDS_Skorpio  =  7;
      cZDS_Nyilas   =  8;
      cZDS_Bak      =  9;
      cZDS_Vizonto  = 10;
      cZDS_Halak    = 11;

      cHSN_House01 =  1;
      cHSN_House02 =  2;
      cHSN_House03 =  3;
      cHSN_House04 =  4;
      cHSN_House05 =  5;
      cHSN_House06 =  6;
      cHSN_House07 =  7;
      cHSN_House08 =  8;
      cHSN_House09 =  9;
      cHSN_House10 = 10;
      cHSN_House11 = 11;
      cHSN_House12 = 12;

      cHOUSENAMEENDINGS : array[cHSN_House01..cHSN_House12] of string =
        (
          'Elsõ Ház', 'Második Ház', 'Harmadik Ház', 'Negyedik Ház', 'Ötödik Ház', 'Hatodik Ház',
          'Hetedik Ház', 'Nyolcadik Ház', 'Kilencedik Ház', 'Tizedik Ház', 'Tizenegyedik Ház', 'Tizenkettedik Ház'
        );

      // ******************** Bulvár adatok ******************** //

      cBULVARTYPESECTIONS : array[Low(TBulvarType)..High(TBulvarType)] of string =
        (
          'AjandekAJegySzulotteinek', 'JegyEsEgeszseg', 'JegyEsKoveik', 'JegyArnyoldalai',
          'JegyAmitSzeretnek', 'JegyAmitNemSzeretnek', 'JegyErossegei', 'JegyBunok',
          'JegyDivat'
        );

      cBULVAR_Forras = 'Forras';
      cBULVAR_Leiras = 'Leiras';
      cBULVAR_RovidLeiras = 'RovidLeiras';
      cBULVAR_Caption = 'Caption';

      // ******************** Ház adatok ******************** //

      cHOUSECAPTIONS : array[cHSN_House01..cHSN_House12] of THouseNames =
        (
          (sHouseNumberArabic: '1';   sHouseNumberOther: 'I';   sHouseDesc: 'Az "ÉN" világban való megjelenésének területe'),
          (sHouseNumberArabic: '2';   sHouseNumberOther: '2';   sHouseDesc: 'Az "ÉN" létezésének alapja, háttere'),
          (sHouseNumberArabic: '3';   sHouseNumberOther: '3';   sHouseDesc: 'Az "ÉN" környezete, közege, az ebben való mozgás, közlekedés, kommunikáció'),
          (sHouseNumberArabic: '4';   sHouseNumberOther: 'IV';  sHouseDesc: 'Az otthon és a család, amelybe az "ÉN" beleszületik. Korai imprinting hatások'),
          (sHouseNumberArabic: '5';   sHouseNumberOther: '5';   sHouseDesc: 'A kreativitás, az "ÉN" teremtõ erejének megélési területe'),
          (sHouseNumberArabic: '6';   sHouseNumberOther: '6';   sHouseDesc: 'A mindennapos kényszerû vagy kötelezõ rutin, a periodikusan ismétlõdõ tevékenységek háza'),
          (sHouseNumberArabic: '7';   sHouseNumberOther: 'VII'; sHouseDesc: 'A "TE", a társ, a másik ember területe'),
          (sHouseNumberArabic: '8';   sHouseNumberOther: '7';   sHouseDesc: 'A transzformáció területe'),
          (sHouseNumberArabic: '9';   sHouseNumberOther: '9';   sHouseDesc: 'Az idõben, térben távoli ügyek'),
          (sHouseNumberArabic: '10';  sHouseNumberOther: 'X';   sHouseDesc: 'Az egyén szerepe a társadalmi munkamegosztásban'),
          (sHouseNumberArabic: '11';  sHouseNumberOther: '11';  sHouseDesc: 'A függés és függetlenedés háza'),
          (sHouseNumberArabic: '12';  sHouseNumberOther: '12';  sHouseDesc: 'Az élethosszig tartó nehézségek, terhek, korlátozások')
        );

      // ******************** Betûtípusok ******************** //

      cBASEFONTNAME    = 'MS Sans Serif';
      cBASEFONTNAME2   = 'Times New Roman';
      cBASEFONTNAME3   = 'Arial';
      cSYMBOLSFONTNAME = 'Regimontanus Astrological Symbols';

      cRETROGRADELETTER     = 'R';
      cSELFMARKERSIGNLETTER = '€';//'*';
      cASC_KEPLERLETTER = 'S';
      cMC_KEPLERLETTER  = 'D';

      // ******************** Bolygó és Zodiákus adatok ******************** //

      cPLANETLIST : array[SE_SUN..SE_TRUE_MEAN_NODE_DOWN] of TPlanetNames =
        (
          (cPlanetLetter: 'a';   sPlanetName: 'Nap'),
          (cPlanetLetter: 's';   sPlanetName: 'Hold'),
          (cPlanetLetter: 'd';   sPlanetName: 'Merkúr'),
          (cPlanetLetter: 'f';   sPlanetName: 'Vénusz'),
          (cPlanetLetter: 'g';   sPlanetName: 'Mars'),
          (cPlanetLetter: 'h';   sPlanetName: 'Jupiter'),
          (cPlanetLetter: 'j';   sPlanetName: 'Szaturnusz'),
          (cPlanetLetter: 'k';   sPlanetName: 'Uránusz'),
          (cPlanetLetter: 'l';   sPlanetName: 'Neptunusz'),
          (cPlanetLetter: ';';   sPlanetName: 'Plútó'),
          (cPlanetLetter: 'A';   sPlanetName: 'Felsz.holdcs.(közepes)'),
          (cPlanetLetter: 'A';   sPlanetName: 'Felsz.holdcs.(valódi)'),
          (cPlanetLetter: 'Lil'; sPlanetName: 'Lilith'),
          (cPlanetLetter: 'Pri'; sPlanetName: 'Priapus'),
          (cPlanetLetter: 'L';   sPlanetName: 'Föld'),
          (cPlanetLetter: 'K';   sPlanetName: 'Chiron'),
          (cPlanetLetter: 'Pho'; sPlanetName: 'Pholus'),
          (cPlanetLetter: 'F';   sPlanetName: 'Ceres'),
          (cPlanetLetter: 'G';   sPlanetName: 'Pallas Athene'),
          (cPlanetLetter: 'H';   sPlanetName: 'Juno'),
          (cPlanetLetter: 'J';   sPlanetName: 'Vesta'),
          (cPlanetLetter: ':';   sPlanetName: ''),
          (cPlanetLetter: ':';   sPlanetName: ''),
          (cPlanetLetter: ':';   sPlanetName: ''),
          (cPlanetLetter: 'Q';   sPlanetName: 'Leszálló holdcsomó')
        );

      cZODIACANDPLANETLETTERS : array[cZDS_Kos..cZDS_Halak] of TZodiacSignAndPlanet =
        (
          (iZodiacID: cZDS_Kos;      iPlanetID: SE_MARS;    cZodiacLetter: 'q'; cZodiacsPlanetLetter: 'g'; sZodiacName: 'Kos';      sZodiacPlanetName: 'Mars';       sBulvarZodiacName: 'Kos';      sBulvarZodiacItemName: 'Kos [III.21 - IV.20]'),
          (iZodiacID: cZDS_Bika;     iPlanetID: SE_VENUS;   cZodiacLetter: 'w'; cZodiacsPlanetLetter: 'f'; sZodiacName: 'Bika';     sZodiacPlanetName: 'Vénusz';     sBulvarZodiacName: 'Bika';     sBulvarZodiacItemName: 'Bika [IV.21 - V.20]'),
          (iZodiacID: cZDS_Ikrek;    iPlanetID: SE_MERCURY; cZodiacLetter: 'e'; cZodiacsPlanetLetter: 'd'; sZodiacName: 'Ikrek';    sZodiacPlanetName: 'Merkúr';     sBulvarZodiacName: 'Ikrek';    sBulvarZodiacItemName: 'Ikrek [V.21 - VI.21]'),
          (iZodiacID: cZDS_Rak;      iPlanetID: SE_MOON;    cZodiacLetter: 'r'; cZodiacsPlanetLetter: 's'; sZodiacName: 'Rák';      sZodiacPlanetName: 'Hold';       sBulvarZodiacName: 'Rak';      sBulvarZodiacItemName: 'Rák [VI.22 - VII.22]'),
          (iZodiacID: cZDS_Oroszlan; iPlanetID: SE_SUN;     cZodiacLetter: 't'; cZodiacsPlanetLetter: 'a'; sZodiacName: 'Oroszlán'; sZodiacPlanetName: 'Nap';        sBulvarZodiacName: 'Oroszlan'; sBulvarZodiacItemName: 'Oroszlán [VII.23 - VIII.23]'),
          (iZodiacID: cZDS_Szuz;     iPlanetID: SE_MERCURY; cZodiacLetter: 'y'; cZodiacsPlanetLetter: 'd'; sZodiacName: 'Szûz';     sZodiacPlanetName: 'Merkúr';     sBulvarZodiacName: 'Szuz';     sBulvarZodiacItemName: 'Szûz [VIII.24 - IX.23]'),
          (iZodiacID: cZDS_Merleg;   iPlanetID: SE_VENUS;   cZodiacLetter: 'u'; cZodiacsPlanetLetter: 'f'; sZodiacName: 'Mérleg';   sZodiacPlanetName: 'Vénusz';     sBulvarZodiacName: 'Merleg';   sBulvarZodiacItemName: 'Mérleg [IX.24 - X.23'),
          (iZodiacID: cZDS_Skorpio;  iPlanetID: SE_PLUTO;   cZodiacLetter: 'i'; cZodiacsPlanetLetter: ';'; sZodiacName: 'Skorpió';  sZodiacPlanetName: 'Plútó';      sBulvarZodiacName: 'Skorpio';  sBulvarZodiacItemName: 'Skorpió [X.24 - XI.22'),
          (iZodiacID: cZDS_Nyilas;   iPlanetID: SE_JUPITER; cZodiacLetter: 'o'; cZodiacsPlanetLetter: 'h'; sZodiacName: 'Nyilas';   sZodiacPlanetName: 'Jupiter';    sBulvarZodiacName: 'Nyilas';   sBulvarZodiacItemName: 'Nyilas [XI.23 - XII.21]'),
          (iZodiacID: cZDS_Bak;      iPlanetID: SE_SATURN;  cZodiacLetter: 'p'; cZodiacsPlanetLetter: 'j'; sZodiacName: 'Bak';      sZodiacPlanetName: 'Szaturnusz'; sBulvarZodiacName: 'Bak';      sBulvarZodiacItemName: 'Bak [XII.22 - I.20]'),
          (iZodiacID: cZDS_Vizonto;  iPlanetID: SE_URANUS;  cZodiacLetter: '['; cZodiacsPlanetLetter: 'k'; sZodiacName: 'Vízöntõ';  sZodiacPlanetName: 'Uránusz';    sBulvarZodiacName: 'Vizonto';  sBulvarZodiacItemName: 'Vízöntõ [I.21 - II.19]'),
          (iZodiacID: cZDS_Halak;    iPlanetID: SE_NEPTUNE; cZodiacLetter: ']'; cZodiacsPlanetLetter: 'l'; sZodiacName: 'Halak';    sZodiacPlanetName: 'Neptunusz';  sBulvarZodiacName: 'Halak';    sBulvarZodiacItemName: 'Halak [II.20 - III.20]')
        );

      // ******************** Fényszög adatok ******************** //

      cFSZ_EGYUTTALLAS      = 1;
      cFSZ_SZEMBENALLAS     = 2;
      cFSZ_NEGYEDFENY       = 3;
      cFSZ_NYOLCADFENY      = 4;
      cFSZ_3NYOLCADFENY     = 5;
      cFSZ_HARMADFENY       = 6;
      cFSZ_HATODFENY        = 7;
      cFSZ_TIZENKETTEDFENY  = 8;
      cFSZ_5TIZENKETTEDFENY = 9;
      cFSZ_OTODFENY         = 10;
      cFSZ_TIZEDFENY        = 11;
      cFSZ_2OTODFENY        = 12; 

      cFENYSZOGSETTINGS : array[cFSZ_EGYUTTALLAS..cFSZ_2OTODFENY] of TAspectValues =
        (
           // Víz eneregia
           (cAspectLetter: 'z'; sAspectName: 'Együttállás';       sOtherAspectName : 'Konjunkció';      iDeg:   0; iOrb: 15),

           // Föld energia
           (cAspectLetter: 'x'; sAspectName: 'Szembenállás';      sOtherAspectName : 'Oppozíció';       iDeg: 180; iOrb: 7.5),
           (cAspectLetter: 'c'; sAspectName: 'Negyedfény';        sOtherAspectName : 'Kvadrát';         iDeg:  90; iOrb: 4),
           (cAspectLetter: 'm'; sAspectName: 'Nyolcadfény';       sOtherAspectName : 'Semiquadrat';     iDeg:  45; iOrb: 2),   // oktil, semiquadrat, félkvadrát
           (cAspectLetter: '<'; sAspectName: 'Három-nyolcadfény'; sOtherAspectName : 'Szeszkvikvadrát'; iDeg: 135; iOrb: 2),

           // Levegõ energia
           (cAspectLetter: 'b'; sAspectName: 'Harmadfény';        sOtherAspectName : 'Trigon';          iDeg: 120; iOrb: 5),
           (cAspectLetter: 'n'; sAspectName: 'Hatodfény';         sOtherAspectName : 'Szextil';         iDeg:  60; iOrb: 2.5),
           (cAspectLetter: '>'; sAspectName: 'Tizenkettedfény';   sOtherAspectName : 'Szemiszextil';    iDeg:  30; iOrb: 1),
           (cAspectLetter: '?'; sAspectName: 'Öt-tizenkettedfény';sOtherAspectName : 'Kvinkunx';        iDeg: 150; iOrb: 1),

           // Tûz energia
           (cAspectLetter: '„'; sAspectName: 'Ötödfény';          sOtherAspectName : 'Kvintil';         iDeg:  72; iOrb: 3),
           (cAspectLetter: '†'; sAspectName: 'Tizedfény';         sOtherAspectName : 'Decil';           iDeg:  36; iOrb: 2.5),
           (cAspectLetter: '…'; sAspectName: 'Két-ötödfény';      sOtherAspectName : 'Bikvintil';       iDeg: 144; iOrb: 3)
        );

      // ******************** Járt- Háratlan út ******************************** //

      cJARTJARATLANZODIACs: array[1..3, 1..4] of byte =
        (
          (cZDS_Kos,      cZDS_Bak,  cZDS_Merleg,  cZDS_Rak),
          (cZDS_Oroszlan, cZDS_Bika, cZDS_Vizonto, cZDS_Skorpio),
          (cZDS_Nyilas,   cZDS_Szuz, cZDS_Ikrek,   cZDS_Halak)
        );

      // ******************** Beállítások INI file sections ******************** //

      cGRP_chkbZodiakusJelek = 'chkbZodiakusJelek';
      cGRPITM_chkbZodiakusJelek_AnalogPlanet_KELL_E = 'KELL_E_ANALOG';
      cGRPITM_chkbZodiakusJelek : array[0..11] of TAssignSettingsINI =
        (
          (sItemName: 'KOS'; iAssignedItem: cZDS_Kos),
          (sItemName: 'BIKA'; iAssignedItem: cZDS_Bika),
          (sItemName: 'IKREK'; iAssignedItem: cZDS_Ikrek),
          (sItemName: 'RAK'; iAssignedItem: cZDS_Rak),
          (sItemName: 'OROSZLAN'; iAssignedItem: cZDS_Oroszlan),
          (sItemName: 'SZUZ'; iAssignedItem: cZDS_Szuz),
          (sItemName: 'MERLEG'; iAssignedItem: cZDS_Merleg),
          (sItemName: 'SKORPIO'; iAssignedItem: cZDS_Skorpio),
          (sItemName: 'NYILAS'; iAssignedItem: cZDS_Nyilas),
          (sItemName: 'BAK'; iAssignedItem: cZDS_Bak),
          (sItemName: 'VIZONTO'; iAssignedItem: cZDS_Vizonto),
          (sItemName: 'HALAK'; iAssignedItem: cZDS_Halak)
        );

      cGRP_chkbHazHatarok = 'chkbHazHatarok';
      cGRPITM_chkbHazHatarok : array[0..11] of TAssignSettingsINI =
        (
          (sItemName: 'HOUSE_1'; iAssignedItem: cHSN_House01),
          (sItemName: 'HOUSE_2'; iAssignedItem: cHSN_House02),
          (sItemName: 'HOUSE_3'; iAssignedItem: cHSN_House03),
          (sItemName: 'HOUSE_4'; iAssignedItem: cHSN_House04),
          (sItemName: 'HOUSE_5'; iAssignedItem: cHSN_House05),
          (sItemName: 'HOUSE_6'; iAssignedItem: cHSN_House06),
          (sItemName: 'HOUSE_7'; iAssignedItem: cHSN_House07),
          (sItemName: 'HOUSE_8'; iAssignedItem: cHSN_House08),
          (sItemName: 'HOUSE_9'; iAssignedItem: cHSN_House09),
          (sItemName: 'HOUSE_10'; iAssignedItem: cHSN_House10),
          (sItemName: 'HOUSE_11'; iAssignedItem: cHSN_House11),
          (sItemName: 'HOUSE_12'; iAssignedItem: cHSN_House12)
        );

      cGRP_chkbHazSzamok = 'chkbHazSzamok';
      cGRPITM_chkbHazSzamok : array[0..11] of TAssignSettingsINI =
        (
          (sItemName: 'HOUSE_1'; iAssignedItem: cHSN_House01),
          (sItemName: 'HOUSE_2'; iAssignedItem: cHSN_House02),
          (sItemName: 'HOUSE_3'; iAssignedItem: cHSN_House03),
          (sItemName: 'HOUSE_4'; iAssignedItem: cHSN_House04),
          (sItemName: 'HOUSE_5'; iAssignedItem: cHSN_House05),
          (sItemName: 'HOUSE_6'; iAssignedItem: cHSN_House06),
          (sItemName: 'HOUSE_7'; iAssignedItem: cHSN_House07),
          (sItemName: 'HOUSE_8'; iAssignedItem: cHSN_House08),
          (sItemName: 'HOUSE_9'; iAssignedItem: cHSN_House09),
          (sItemName: 'HOUSE_10'; iAssignedItem: cHSN_House10),
          (sItemName: 'HOUSE_11'; iAssignedItem: cHSN_House11),
          (sItemName: 'HOUSE_12'; iAssignedItem: cHSN_House12)
        );

      cGRP_chkbTengelyek = 'chkbTengelyek';
      cGRPITM_chkbTengelyek : array[0..7] of string[10] = 
        ('AC', 'MC', 'DC', 'IC', 'VTX', 'EP', 'CAC', 'PAC');

      cGRP_chkbBolygok = 'chkbBolygok';
      cGRPITM_chkbBolygok : array[0..9] of TAssignSettingsINI =
        (
          (sItemName: 'SUN'; iAssignedItem: SE_SUN),
          (sItemName: 'MOON'; iAssignedItem: SE_MOON),
          (sItemName: 'MERCURY'; iAssignedItem: SE_MERCURY),
          (sItemName: 'VENUS'; iAssignedItem: SE_VENUS),
          (sItemName: 'MARS'; iAssignedItem: SE_MARS),
          (sItemName: 'JUPITER'; iAssignedItem: SE_JUPITER),
          (sItemName: 'SATURN'; iAssignedItem: SE_SATURN),
          (sItemName: 'URANUS'; iAssignedItem: SE_URANUS),
          (sItemName: 'NEPTUNE'; iAssignedItem: SE_NEPTUNE),
          (sItemName: 'PLUTO'; iAssignedItem: SE_PLUTO)
        );

      cGRP_chkbKisBolygok = 'chkbKisBolygok';
      cGRPITM_chkbKisBolygok : array[0..7] of TAssignSettingsINI =
        (
          (sItemName: 'CHIRON'; iAssignedItem: SE_CHIRON),
          (sItemName: 'PHOLUS'; iAssignedItem: SE_PHOLUS),
          (sItemName: 'CERES'; iAssignedItem: SE_CERES),
          (sItemName: 'PALLAS'; iAssignedItem: SE_PALLAS),
          (sItemName: 'JUNO'; iAssignedItem: SE_JUNO),
          (sItemName: 'VESTA'; iAssignedItem: SE_VESTA),
          (sItemName: 'ERIS'; iAssignedItem: SE_ERIS),
          (sItemName: 'LILITH'; iAssignedItem: SE_MEAN_APOG)
        );

      cGRP_chkbHoldcsomo = 'chkbHoldcsomo';
      cGRPITM_chkbHoldcsomo : array[0..1] of string[10] =
        ('FELSZ_NODE', 'LESZ_NODE');

      cGRP_chkbHoldocsomoTipus = 'chkbHoldocsomoTipus';
      cGRPITM_chkbHoldcsomoTipus : array[0..1] of string[10] =
        ('MEAN_NODE', 'TRUE_NODE');

      cGRP_chkbFenyszogek = 'chkbFenyszogek';
      cGRPITM_chkbFenyszogek : array[0..11] of TAssignSettingsINI =
        (
          (sItemName: 'KONJUKCIO'; iAssignedItem: cFSZ_EGYUTTALLAS),
          (sItemName: 'OPPOZICIO'; iAssignedItem: cFSZ_SZEMBENALLAS),
          (sItemName: 'KVADRAT'; iAssignedItem: cFSZ_NEGYEDFENY),
          (sItemName: 'SEMIQUADRAT'; iAssignedItem: cFSZ_NYOLCADFENY),
          (sItemName: 'SZESZKVIKVADRAT'; iAssignedItem: cFSZ_3NYOLCADFENY),
          (sItemName: 'TRIGON'; iAssignedItem: cFSZ_HARMADFENY),
          (sItemName: 'SZEXTIL'; iAssignedItem: cFSZ_HATODFENY),
          (sItemName: 'SZEMISZEXTIL'; iAssignedItem: cFSZ_TIZENKETTEDFENY),
          (sItemName: 'KVINKUNX'; iAssignedItem: cFSZ_5TIZENKETTEDFENY),
          (sItemName: 'KVINTIL'; iAssignedItem: cFSZ_OTODFENY),
          (sItemName: 'DECIL'; iAssignedItem: cFSZ_TIZEDFENY),
          (sItemName: 'BIKVINTIL'; iAssignedItem: cFSZ_2OTODFENY)
        );

      cGRP_chkbFenyszogJelek = 'chkbFenyszogJelek';
      cGRPITM_chkbFenyszogJelek : array[0..11] of string[20] =
        ('KONJUKCIO', 'OPPOZICIO', 'KVADRAT', 'SEMIQUADRAT', 'SZESZKVIKVADRAT', 'TRIGON', 'SZEXTIL', 'SZEMISZEXTIL',
         'KVINKUNX', 'KVINTIL', 'DECIL', 'BIKVINTIL');

      cGRP_chkbFenyszogeltTengelyek = 'chkbFenyszogeltTengelyek';
      cGRPITM_chkbFenyszogeltTengelyek : array[0..3] of TAssignSettingsINI =
        (
          (sItemName: 'AC'; iAssignedItem: SE_ASC),
          (sItemName: 'MC'; iAssignedItem: SE_MC),
          (sItemName: 'DC'; iAssignedItem: 255),
          (sItemName: 'IC'; iAssignedItem: 255)
        );

      cGRP_chkbFenyszogeltCsompontok = 'chkbFenyszogeltCsompontok';
      cGRPITM_chkbFenyszogeltCsompontok : array[0..1] of string[10] =
        ('FELSZ_NODE', 'LESZ_NODE');

      cGRP_chkbFenyszogeltHazak = 'chkbFenyszogeltHazak';
      cGRPITM_chkbFenyszogeltHazak : array[0..11] of TAssignSettingsINI =
        (
          (sItemName: 'HOUSE_1'; iAssignedItem: cHSN_House01),
          (sItemName: 'HOUSE_2'; iAssignedItem: cHSN_House02),
          (sItemName: 'HOUSE_3'; iAssignedItem: cHSN_House03),
          (sItemName: 'HOUSE_4'; iAssignedItem: cHSN_House04),
          (sItemName: 'HOUSE_5'; iAssignedItem: cHSN_House05),
          (sItemName: 'HOUSE_6'; iAssignedItem: cHSN_House06),
          (sItemName: 'HOUSE_7'; iAssignedItem: cHSN_House07),
          (sItemName: 'HOUSE_8'; iAssignedItem: cHSN_House08),
          (sItemName: 'HOUSE_9'; iAssignedItem: cHSN_House09),
          (sItemName: 'HOUSE_10'; iAssignedItem: cHSN_House10),
          (sItemName: 'HOUSE_11'; iAssignedItem: cHSN_House11),
          (sItemName: 'HOUSE_12'; iAssignedItem: cHSN_House12)
        );

      cGRP_chkbFenyszogeltBolygok = 'chkbFenyszogeltBolygok';
      cGRPITM_chkbFenyszogeltBolygok : array[0..9] of TAssignSettingsINI =
        (
          (sItemName: 'SUN'; iAssignedItem: SE_SUN),
          (sItemName: 'MOON'; iAssignedItem: SE_MOON),
          (sItemName: 'MERCURY'; iAssignedItem: SE_MERCURY),
          (sItemName: 'VENUS'; iAssignedItem: SE_VENUS),
          (sItemName: 'MARS'; iAssignedItem: SE_MARS),
          (sItemName: 'JUPITER'; iAssignedItem: SE_JUPITER),
          (sItemName: 'SATURN'; iAssignedItem: SE_SATURN),
          (sItemName: 'URANUS'; iAssignedItem: SE_URANUS),
          (sItemName: 'NEPTUNE'; iAssignedItem: SE_NEPTUNE),
          (sItemName: 'PLUTO'; iAssignedItem: SE_PLUTO)
        );

      cGRP_chkbFenyszogeltKisBolygok = 'chkbFenyszogeltKisBolygok';
      cGRPITM_chkbFenyszogeltKisBolygok : array[0..7] of TAssignSettingsINI =
        (
          (sItemName: 'CHIRON'; iAssignedItem: SE_CHIRON),
          (sItemName: 'PHOLUS'; iAssignedItem: SE_PHOLUS),
          (sItemName: 'CERES'; iAssignedItem: SE_CERES),
          (sItemName: 'PALLAS'; iAssignedItem: SE_PALLAS),
          (sItemName: 'JUNO'; iAssignedItem: SE_JUNO),
          (sItemName: 'VESTA'; iAssignedItem: SE_VESTA),
          (sItemName: 'ERIS'; iAssignedItem: SE_ERIS),
          (sItemName: 'LILITH'; iAssignedItem: SE_MEAN_APOG)
        );

      cGRP_chkbEgyebMegjelenitesek = 'chkbEgyebMegjelenitesek';
      cGRPITM_chkbEgyebMegjelenitesek : array[0..5] of string[30] =
        ('SELFMARKERS', 'RETROGADE', 'PLANETDEG', 'HOUSELORDS', 'HOUSENUMSBYARABICNUMBERS', 'SELFMARKERATORIGPLACE');

      cGRP_chkbFokjelolok = 'chkbFokjelolok';
      cGRPITM_chkbFokjelolok : array[0..4] of string[20] =
        ('OUTERZODIACDEG', 'INNERZODIACDEG', 'INNERASPECTDEG', 'HOUSEDEG', 'ZODIACDEGKULON');

      cGRP_chkbBolygoTablazat = 'chkbBolygoTablazat';
      cGRPITM_chkbBolygoTablazat_KELL_E = 'KELL_E';
      cGRPITM_chkbBolygoTablazat : array[0..3] of string[10] =
        ('PLANETDEG', 'ZODIACSIGN', 'HOUSENUM', 'HOUSELORDS');

      cGRP_chkbHazTablazat = 'chkbHazTablazat';
      cGRPITM_chkbHazTablazat_KELL_E = 'KELL_E';
      cGRPITM_chkbHazTablazat : array[0..1] of string[10] =
        ('HOUSEDEG', 'ZODIACSIGN');

      cGRP_chkbFenyszogTablazat = 'chkbFenyszogTablazat';
      cGRPITM_chkbFenyszogTablazat_KELL_E = 'KELL_E';

      cGRP_chkbFejlecKijelzesek = 'chkbFejlecKijelzesek';
      cGRPITM_chkbFejlecKijelzesek_KELL_E = 'KELL_E';
      cGRPITM_chkbFejlecKijelzesek : array[0..11] of string[15] =
        ('NAME', 'BIRTHDATE', 'BIRTHTIME', 'BIRTHDAY', 'TIMEZONE', 'DST', 'UT', 'ST', 'PRINTTYPE', 'BIRTHPLACE', 'BIRTCOORD', 'HOUSESYSTEM');

      cGRP_chkbLablecKijelzesek = 'chkbLablecKijelzesek';
      cGRPITM_chkbLablecKijelzesek_KELL_E = 'KELL_E';
      cGRPITM_chkbLablecKijelzesek : array[0..1] of string[10] =
        ('BASEINFO', 'REGINFO');

      cGRP_chkbEletStratTablazat = 'chkbEletStratTablazat';
      cGRPITM_chkbEletStratTablazat_KELL_E = 'KELL_E';

      cGRP_chkbNyomtatas = 'chkbNyomtatasSzinesben';
      cGRPITM_chkbNyomtatasSzinesben = 'NyomtatSzinesben';

      cGRP_chkbHazrendszer = 'chkbHazrendszer';
      cGRPITM_chkbHazrendszer = 'Hazrendszer';

      cGRP_chkbZodiakus = 'chkbZodiakus';
      cGRPITM_chkbZodiakus = 'Zodiakus';

      cGRP_chkbInditasTeljesMeret = 'chkbProgramInditas';
      cGRPITM_chkbInditasTeljesMeret = 'InditasTeljesMeretben';

      cGRP_chkbZodiakusBackGroundColor = 'chkbZodiakusBackGroundColor';
      cGRPITM_chkbZodiakusBackGroundColor : array[0..3] of string[15] =
        ('TUZES', 'FOLDES', 'LEVEGOS', 'VIZES');

      cGRP_chkbFenyszogColor = 'chkbFenyszogColor';
      cGRPITM_chkbFenyszogColor : array[cFSZ_EGYUTTALLAS..cFSZ_2OTODFENY] of string[25] =
        ('Konjunkcio', 'Oppozicio', 'Kvadrat', 'Semiquadrat', 'Szeszkvikvadrat', 'Trigon', 'Szextil',
         'Szemiszextil', 'Kvinkunx', 'Kvintil', 'Decil', 'Bikvintil' );

      cGRP_chkbFenyszogHatterSzine = 'chkbFenyszogekBackgroundColor';
      cGRPITM_chkbFenyszogHatterSzine = 'FenyszogBackgroundColor';

      cASPECTITEMSTYLE : array[1..3] of TAspectStyleRec =
        (
          (sItemName : 'Sima';       psPenStyle : psSolid),
          (sItemName : 'Szaggatott'; psPenStyle : psDash),
          (sItemName : 'Pettyezett'; psPenStyle : psDot)
        );

      cGRP_chkbFenyszogStyle = 'chkbFenyszogStyle';
      cGRPITM_chkbFenyszogStlye : array[cFSZ_EGYUTTALLAS..cFSZ_2OTODFENY] of string[25] =
        ('Konjunkcio', 'Oppozicio', 'Kvadrat', 'Semiquadrat', 'Szeszkvikvadrat', 'Trigon', 'Szextil',
         'Szemiszextil', 'Kvinkunx', 'Kvintil', 'Decil', 'Bikvintil' );

      cGRP_chkbEgyebek = 'chkbEgyebek';
      cGRPITM_chkbEgyebek : array[1..3] of string[25] =
        ('TelepulesDB', 'KivalTelepules', 'LastOpenedFilesNum');

      cGRP_rgrpEnallapotJelolMod = 'rgrpEnallapotJelolMod';
      cGRPITM_rgrpEnallapotJelolMod = 'JelolesMod';

      cGRP_dlgExportHelye = 'dlgExportHelye';
      cGRPITM_dlgExportHelye = 'ExportalasHelye';

      cGRP_BetumeretSzorzo = 'grpBetumeretSzorzo';
      cGRPITM_BetumeretSzorzo = 'BetumeretSzorzo';

implementation

end.
