unit dxmdaset;

INTERFACE

uses
  Windows, SysUtils, Variants, Classes, Forms, ActiveX, FmtBcd, DbConsts, DBCommon, DB;

type
  TdxMemData = class;
  TdxMemFields = class;

  TMemBlobData = string;
  PMemBlobData = ^TMemBlobData;

  TMemBlobDataArray = array[0..99] of TMemBlobData;
  PMemBlobDataArray = ^TMemBlobDataArray;

  TdxMemField = class (TObject)
  private
    FDataSize: Integer;
    FDataType: TFieldType;
    FField: TField;
    FIndex: Integer;
    FIsNeedAutoInc: Boolean;
    FIsRecId: Boolean;
    FIsWideString: Boolean;
    FMaxIncValue: Integer;
    FOffSet: Integer;
    FOwner: TdxMemFields;
    FValueOffSet: Integer;
    procedure SetAutoIncValue(Value:PChar; const Buffer:PChar);
    function GetDataSet: TdxMemData;
    function GetHasValues(Index:Integer): Char;
    procedure SetHasValues(Index:Integer; Value: Char);
    function GetMemFields: TDxMemFields;
    function GetValues(Index:Integer): PChar;
  protected
    procedure CreateField(Field:TField); virtual;
    property MemFields: TDxMemFields read GetMemFields;
  public
    constructor Create(AOwner:TdxMemFields);
    procedure AddValue(const Buffer:PChar);
    procedure InsertValue(AIndex:Integer; const Buffer:PChar);
    property DataSet: TdxMemData read GetDataSet;
    property Field: TField read FField;
    property HasValues[Index:Integer]: Char read GetHasValues write SetHasValues;
    property Index: Integer read FIndex;
    property OffSet: Integer read FValueOffSet;
    property Values[Index:Integer]: PChar read GetValues;
  end;
  
  TdxMemFields = class (TObject)
  private
    FCalcFields: TList;
    FDataSet: TdxMemData;
    FIsNeedAutoIncList: TList;
    FItems: TList;
    FValues: TList;
    FValuesSize: Integer;
    FWideStringFields: TList;
    function GetItem(Index:Integer): TdxMemField;
    function GetRecordCount: Integer;
  protected
    function Add(AField:TField): TdxMemField;
    procedure AddField(Field:TField);
    procedure Clear;
    procedure DeleteRecord(AIndex:Integer);
    procedure InsertRecord(Buffer:Pointer; AIndex:Integer; Append:Boolean);
    procedure RemoveField(Field:TField);
    procedure WideStringDeleteRecord(AIndex:Integer);
  public
    constructor Create(ADataSet:TdxMemData);
    destructor Destroy; override;
    function GetActiveBuffer(ActiveBuffer, Buffer:Pointer; Field:TField): Boolean;
    procedure GetBuffer(Buffer:Pointer; AIndex:Integer);
    function GetHasValue(mField:TdxMemField; Index:Integer): Char;
    function GetValue(mField:TdxMemField; Index:Integer): PChar;
    function IndexOf(Field:TField): TdxMemField;
    procedure SetActiveBuffer(ActiveBuffer, Buffer:Pointer; Field:TField);
    procedure SetBuffer(Buffer:Pointer; AIndex:Integer);
    procedure SetHasValue(mField:TdxMemField; Index:Integer; Value:char);
    procedure SetValue(mField:TdxMemField; Index:Integer; Buffer:PChar);
    function GetCount: Integer;
    property Count: Integer read GetCount;
    property DataSet: TdxMemData read FDataSet;
    property Items[Index:Integer]: TdxMemField read GetItem;
    property RecordCount: Integer read GetRecordCount;
    property Values: TList read FValues;
  end;
  
  PdxRecInfo = ^TdxRecInfo;
  TdxRecInfo = packed record
    Bookmark     :Integer;
    BookmarkFlag :TBookmarkFlag;
  end;

  { TBlobStream }
  TMemBlobStream = class (TStream)
  private
    FBuffer: PChar;
    FCached: Boolean;
    FDataSet: TdxMemData;
    FField: TBlobField;
    FMode: TBlobStreamMode;
    FModified: Boolean;
    FOpened: Boolean;
    FPosition: LongInt;
    function GetBlobSize: LongInt;
  public
    constructor Create(Field:TBlobField; Mode:TBlobStreamMode);
    destructor Destroy; override;
    function Read(var Buffer; Count:Longint): LongInt; override;
    function Seek(Offset:Longint; Origin:Word): LongInt; override;
    procedure Truncate;
    function Write(const Buffer; Count:Longint): LongInt; override;
  end;
  
  { TdxMemData }
  TdxSortOption = (soDesc, soCaseInsensitive);
  TdxSortOptions = set of TdxSortOption;

  TdxMemIndex = class (TCollectionItem)
  private
    fField: TField;
    FFieldName: string;
    fIndexList: TList;
    FIsDirty: Boolean;
    fList: TList;
    fLoadedFieldName: string;
    FSortOptions: TdxSortOptions;
    procedure DeleteRecord(pRecord:Pointer);
    procedure SetFieldNameAfterMemdataLoaded;
    procedure UpdateRecord(pRecord:Pointer);
    procedure SetFieldName(Value: string);
    procedure SetIsDirty(Value: Boolean);
    procedure SetSortOptions(Value: TdxSortOptions);
  protected
    function GotoNearest(const Buffer:PChar; var Index:Integer): Boolean;
    procedure Prepare;
    function GetMemData: TdxMemData;
    property IsDirty: Boolean read FIsDirty write SetIsDirty;
  public
    constructor Create(Collection:TCollection); override;
    destructor Destroy; override;
    property MemData: TdxMemData read GetMemData;
  published
    property FieldName: string read FFieldName write SetFieldName;
    property SortOptions: TdxSortOptions read FSortOptions write SetSortOptions;
  end;
  
  TdxMemIndexes = class (TCollection)
  private
    FMemData: TdxMemData;
  protected
    procedure AfterMemdataLoaded;
    procedure CheckFields;
    procedure DeleteRecord(pRecord:Pointer);
    function GetOwner: TPersistent; override;
    procedure RemoveField(AField:TField);
    procedure SetIsDirty;
    procedure UpdateRecord(pRecord:Pointer);
  public
    function Add: TdxMemIndex;
    function GetIndexByField(AField:TField): TdxMemIndex;
    property MemData: TdxMemData read FMemData;
  end;
  
  TdxMemPersistentOption = (poNone, poActive, poLoad);

  TdxMemPersistent = class (TPersistent)
  private
    FIsLoadFromPersistent: Boolean;
    FMemData: TdxMemData;
    FOption: TdxMemPersistentOption;
    FStream: TMemoryStream;
    procedure ReadData(Stream:TStream);
    procedure WriteData(Stream:TStream);
  protected
    procedure DefineProperties(Filer:TFiler); override;
  public
    constructor Create(AMemData:TdxMemData);
    destructor Destroy; override;
    procedure Assign(Source:TPersistent); override;
    function HasData: Boolean;
    procedure LoadData;
    procedure SaveData;
    property MemData: TdxMemData read FMemData;
  published
    property Option: TdxMemPersistentOption read FOption write FOption default poActive;
  end;
  
  TdxMemData = class (TDataSet)
  private
    FActive: Boolean;
    FBlobList: TList;
    FBookMarks: TList;
    FCurRec: Integer;
    FData: TdxMemFields;
    FDelimiterChar: Char;
    FFilterCurRec: Integer;
    FFilterList: TList;
    FGotoNearestMax: Integer;
    FGotoNearestMin: Integer;
    FIndexes: TdxMemIndexes;
    FIsFiltered: Boolean;
    FLastBookmark: Integer;
    FLoadFlag: Boolean;
    FPersistent: TdxMemPersistent;
    FProgrammedFilter: Boolean;
    FReadOnly: Boolean;
    FRecBufSize: Integer;
    FRecIdField: TField;
    FRecInfoOfs: Integer;
    FSaveChanges: Boolean;
    FSortedField: TField;
    FSortedFieldName: string;
    FSortOptions: TdxSortOptions;
    function CheckFields(FieldsName:string): Boolean;
    procedure CreateRecIDField;
    procedure DoSort(List:TList; AOffSet:Integer; Size:Integer; DataType:TFieldType; ASortOptions:TdxSortOptions; ExhangeList:TList);
    function GetActiveRecBuf(var RecBuf:PChar): Boolean;
    procedure GetLookupFields(List:TList);
    function InternalIsFiltering: Boolean;
    function InternalLocate(const KeyFields:string; const KeyValues:Variant; Options:TLocateOptions): Integer;
    procedure MakeSort;
    procedure UpdateRecordFilteringAndSorting(AIsMakeSort:Boolean);
    procedure SetIndexes(Value: TdxMemIndexes);
    procedure SetPersistent(Value: TdxMemPersistent);
    procedure SetSortedField(Value: string);
    function GetSortOptions: TdxSortOptions;
    procedure SetSortOptions(Value: TdxSortOptions);
  protected
    function AllocRecordBuffer: PChar; override;
    procedure BlobClear;
    procedure ClearCalcFields(Buffer:PChar); override;
    procedure CloseBlob(Field:TField); override;
    function CompareValues(const Buffer1,Buffer2:PChar; DataType:TFieldType): Integer;
    procedure DoAfterCancel; override;
    procedure DoAfterClose; override;
    procedure DoAfterInsert; override;
    procedure DoAfterOpen; override;
    procedure DoAfterPost; override;
    procedure DoBeforeClose; override;
    procedure DoBeforeInsert; override;
    procedure DoBeforeOpen; override;
    procedure DoBeforePost; override;
    procedure DoOnNewRecord; override;
    procedure FreeRecordBuffer(var Buffer:PChar); override;
    function GetActiveBlobData(Field:TField): TMemBlobData;
    function GetBlobData(Field:TField; Buffer:PChar): TMemBlobData;
    procedure GetBookmarkData(Buffer:PChar; Data:Pointer); override;
    function GetBookmarkFlag(Buffer:PChar): TBookmarkFlag; override;
    function GetBooleanValue(const Buffer:PChar): Boolean;
    function GetCanModify: Boolean; override;
    function GetCurrencyValue(const Buffer:PChar): System.Currency;
    function GetDateTimeValue(const Buffer:PChar; DataType:TFieldType): TDateTime;
    function GetFloatValue(const Buffer:PChar): Double;
    function GetIntegerValue(const Buffer:PChar; DataType:TFieldType): Integer;
    function GetLargeIntValue(const Buffer:PChar; DataType:TFieldType): Int64;
    procedure GetMemBlobData(Buffer:PChar);
    function GetRecNo: Integer; override;
    function GetRecord(Buffer:PChar; GetMode:TGetMode; DoCheck:Boolean): TGetResult; override;
    function GetRecordCount: Integer; override;
    function GetRecordSize: Word; override;
    function GetStringValue(const Buffer:PChar): string;
    function GetVariantValue(const Buffer:PChar; DataType:TFieldType): Variant;
    function GetWideStringValue(const Buffer:PChar): WideString;
    function GotoNearest(const Buffer:PChar; ASortOptions:TdxSortOptions; var Index:Integer): Boolean;
    procedure InternalAddFilterRecord;
    procedure InternalAddRecord(Buffer:Pointer; Append:Boolean); override;
    procedure InternalClose; override;
    function InternalCompareValues(const Buffer1,Buffer2:PChar; DataType:TFieldType; IsCaseInSensitive:Boolean): Integer;
    procedure InternalDelete; override;
    procedure InternalFirst; override;
    procedure InternalGotoBookmark(Bookmark:Pointer); override;
    function InternalGotoNearest(List:TList; AOffSet:Integer; DataType:TFieldType; const Buffer:PChar; ASortOptions:TdxSortOptions; var Index:Integer): Boolean;
    procedure InternalHandleException; override;
    procedure InternalInitFieldDefs; override;
    procedure InternalInitRecord(Buffer:PChar); override;
    procedure InternalInsert; override;
    procedure InternalLast; override;
    procedure InternalOpen; override;
    procedure InternalPost; override;
    procedure InternalRefresh; override;
    procedure InternalSetToRecord(Buffer:PChar); override;
    function IsCursorOpen: Boolean; override;
    procedure Loaded; override;
    procedure MakeRecordSort;
    procedure SetBlobData(Field:TField; Buffer:PChar; const Value:TMemBlobData); virtual;
    procedure SetBookmarkData(Buffer:PChar; Data:Pointer); override;
    procedure SetBookmarkFlag(Buffer:PChar; Value:TBookmarkFlag); override;
    procedure SetFieldData(Field:TField; Buffer:Pointer); overload; override;
    procedure SetFieldData(Field:TField; Buffer:Pointer; NativeFormat:Boolean); overload; override;
    procedure SetFiltered(Value:Boolean); override;
    procedure SetMemBlobData(Buffer:PChar);
    procedure SetOnFilterRecord(const Value:TFilterRecordEvent); override;
    procedure SetRecNo(Value:Integer); override;
    procedure UpdateFilterRecord; virtual;
  public
    constructor Create(AOwner:TComponent); override;
    destructor Destroy; override;
    function BookmarkValid(Bookmark:TBookmark): Boolean; override;
    function CompareBookmarks(Bookmark1,Bookmark2:TBookmark): Integer; override;
    procedure CopyFromDataSet(DataSet:TDataSet);
    function CreateBlobStream(Field:TField; Mode:TBlobStreamMode): TStream; override;
    procedure CreateFieldsFromDataSet(DataSet:TDataSet);
    procedure CreateFieldsFromStream(Stream:TStream);
    procedure FillBookMarks;
    function GetCurrentRecord(Buffer:PChar): Boolean; override;
    function GetFieldClass(FieldType:TFieldType): TFieldClass; override;
    function GetFieldData(Field:TField; Buffer:Pointer): Boolean; overload; override;
    function GetFieldData(Field:TField; Buffer:Pointer; NativeFormat:Boolean): Boolean; overload; override;
    function GetRecNoByFieldValue(Value:Variant; FieldName:String): Integer; virtual;
    function GetValueCount(FieldName:String; Value:Variant): Integer;
    procedure LoadFromBinaryFile(FileName:String);
    procedure LoadFromDataSet(DataSet:TDataSet);
    procedure LoadFromStream(Stream:TStream);
    procedure LoadFromTextFile(FileName:String); dynamic;
    function Locate(const KeyFields:string; const KeyValues:Variant; Options:TLocateOptions): Boolean; override;
    function Lookup(const KeyFields:string; const KeyValues:Variant; const ResultFields:string): Variant; override;
    procedure MoveCurRecordTo(Index:Integer);
    procedure Notification(AComponent:TComponent; Operation:TOperation); override;
    procedure SaveToBinaryFile(FileName:String);
    procedure SaveToStream(Stream:TStream);
    procedure SaveToTextFile(FileName:String); dynamic;
    procedure SetFilteredRecNo(Value:Integer);
    function SupportedFieldType(AType:TFieldType): Boolean; virtual;
    procedure UpdateFilters; virtual;
    property BlobFieldCount;
    property BlobList: TList read FBlobList;
    property CurRec: Integer read FCurRec write FCurRec;
    property Data: TdxMemFields read FData;
    property DelimiterChar: Char read FDelimiterChar write FDelimiterChar;
    property Filter;
    property FilterList: TList read FFilterList;
    property IsLoading: Boolean read FLoadFlag write FLoadFlag;
    property ProgrammedFilter: Boolean read FProgrammedFilter write FProgrammedFilter;
    property RecIdField: TField read FRecIdField;
  published
    property Active;
    property AfterCancel;
    property AfterClose;
    property AfterDelete;
    property AfterEdit;
    property AfterInsert;
    property AfterOpen;
    property AfterPost;
    property AfterScroll;
    property BeforeCancel;
    property BeforeClose;
    property BeforeDelete;
    property BeforeEdit;
    property BeforeInsert;
    property BeforeOpen;
    property BeforePost;
    property BeforeScroll;
    property Indexes: TdxMemIndexes read FIndexes write SetIndexes;
    property OnCalcFields;
    property OnDeleteError;
    property OnEditError;
    property OnFilterRecord;
    property OnNewRecord;
    property OnPostError;
    property Persistent: TdxMemPersistent read FPersistent write SetPersistent;
    property ReadOnly: Boolean read FReadOnly write FReadOnly default False;
    property SortedField: string read FSortedFieldName write SetSortedField;
    property SortOptions: TdxSortOptions read GetSortOptions write SetSortOptions;
  end;
  
procedure DateTimeToMemDataValue(Value:TDateTime; pt:Pointer; Field:TField);
function VariantToMemDataValue(Value:Variant; pt:Pointer; Field:TField):Boolean;

const
  MemDataVer = 1.8;

IMPLEMENTATION

const
  IncorrectedData = 'The data is incorrect';

procedure MemDataCopyWideString(buf:Pointer; const St:WideString);
var
  ws:PWideChar;
begin
  ws := SysAllocString(nil);
  Move(ws, buf^, SizeOf(WideString));
  PWideString(buf)^ := St;
end;

procedure DateTimeToMemDataValue(Value:TDateTime; pt:Pointer; Field:TField);
var
  TimeStamp:TTimeStamp;
  Data:TDateTimeRec;
  DataSize:Integer;
begin
  TimeStamp := DateTimeToTimeStamp(Value);
  DataSize := 4;
  case Field.DataType of
    ftDate:Data.Date := TimeStamp.Date;
    ftTime:Data.Time := TimeStamp.Time;
  else
    begin
      Data.DateTime := TimeStampToMSecs(TimeStamp);
      DataSize := 8;
    end;
  end;
  Move(Data, pt^, DataSize);
end;

function VariantToMemDataValue(Value:Variant; pt:Pointer; Field:TField):Boolean;
var
  St :String; //TStringField
  int:Integer; //TIntegerField
  sml:SmallInt; //TSmallIntField
  wrd:Word; //TWordField
  dbl:Double; //TFloatField
  wrdbool:WordBool; //TBooleanField
  bcd:System.Currency; //TBCDField
  bcdvalue:TBCD;
  Int64_:Int64;
  wString:WideString;
begin
  Result := True;
  case Field.DataType of
    ftString:
      begin
        St := Value;
        if (Length(St) > Field.DataSize) then
          St := Copy(St, 1, Field.DataSize);
        StrPCopy(pt, St);
      end;
    ftWideString:
      begin
        wString := Value;
        if (Length(wString) > Field.Size {div 2}) then
          SetLength(wString, Field.Size {div 2});
        MemDataCopyWideString(pt, wString);
      end;
    ftDate, ftTime, ftDateTime:
      DateTimeToMemDataValue(Value, pt, Field);
    ftSmallint:
      begin
        sml := Value;
        Move(sml, pt^, Field.DataSize);
      end;
    ftInteger, ftAutoInc:
      begin
        int := Value;
        Move(int, pt^, Field.DataSize);
      end;
    ftWord:
      begin
        wrd := Value;
        Move(wrd, pt^, Field.DataSize);
      end;
    ftBoolean:
      begin
        wrdbool := Value;
        Move(wrdbool, pt^, Field.DataSize);
      end;
    ftFloat, ftCurrency:
      begin
        dbl := Value;
        Move(dbl, pt^, Field.DataSize);
      end;
    ftBCD:
      begin
        bcd := Value;
        CurrToBCD(bcd, bcdvalue);
        Move(bcdvalue, pt^, SizeOf(TBCD));
      end;
    ftLargeInt:
      begin
        Int64_ := LongInt(Value);
        Move(Int64_, pt^, Field.DataSize);
      end;
    else
      Result := False;
    end;
end;

function GetNoByFieldType(FieldType:TFieldType):Integer;
const
  dxFieldType:array[TFieldType] of Integer =
    (-1, //ftUnknown
     1, //ftString
     2, //ftSmallint
     3, //ftInteger
     4, //ftWord,
     5, //ftBoolean,
     6, //ftFloat,
     7, //ftCurrency,
     8, //ftBCD,
     9,  //ftDate,
     10, //ftTime,
     11, //ftDateTime,
     -1, //ftBytes,
     -1, //ftVarBytes,
     12, //ftAutoInc,
     13, // ftBlob,
     14, //ftMemo,
     15, //ftGraphic,
     16, //ftFmtMemo,
     17, //ftParadoxOle,
     18, //ftDBaseOle,
     19, //ftTypedBinary
     -1, //  ftCursor
     -1, //ftFixedChar
     20, //ftWideString
     21, //ftLargeInt
     -1, //ftADT
     -1, //ftArray
     -1, //ftReference
     -1, //ftDataSet
     -1, // tOraBlob
     -1, // ftOraClob
     -1, // ftVariant
     -1, //ftInterface
     -1, //ftIDispatch
     -1, //ftGuid
     -1, //ftTimeStamp
     -1 //ftFMTBcd
);
begin
  Result := dxFieldType[FieldType];
end;

const SupportFieldCount = 21;

function GetFieldTypeByNo(No:Integer):TFieldType;
const
  dxFieldType:array[1..SupportFieldCount] of TFieldType = (ftString, ftSmallint, ftInteger, ftWord, ftBoolean, ftFloat, ftCurrency,
    ftBCD, ftDate, ftTime, ftDateTime, ftAutoInc, ftBlob, ftMemo, ftGraphic, ftFmtMemo, ftParadoxOle, ftDBaseOle, ftTypedBinary,
    ftWideString, ftLargeInt);
begin
  if (No < 1) or (No > SupportFieldCount) then
     result := ftUnknown
  else
    Result := dxFieldType[No];
end;

function CorrectFieldName(AFieldName:String):String;
var
  I:Integer;
begin
  Result := AFieldName;
  for I := 1 to Length(Result) do
    if not ((Result[I] in ['A'..'z']) or (Result[I] in ['0'..'9'])) then
      Result[I] := '_';
end;

type
  TdxReadField = class (TObject)
  private
    BlobData: TMemBlobData;
    buffer: PChar;
    DataType: TFieldType;
    Field: TField;
    FieldTypeNo: Integer;
    fSize: Integer;
    HasValue: Byte;
    tSize: Integer;
  end;
  
{ TMemBlobStream }
constructor TMemBlobStream.Create(Field:TBlobField; Mode:TBlobStreamMode);
begin
  FMode := Mode;
  FField := Field;
  FDataSet := TdxMemData(FField.DataSet);
  if not FDataSet.GetActiveRecBuf(FBuffer) then Exit;
  if not FField.Modified and (Mode <> bmRead) then
  begin
    FCached := True;
    if FField.ReadOnly then DatabaseErrorFmt(SFieldReadOnly, [FField.DisplayName]);
    if not (FDataSet.State in [dsEdit, dsInsert]) then DatabaseError(SNotEditing);
  end else FCached := (FBuffer = FDataSet.ActiveBuffer);
  FOpened := True;
  if Mode = bmWrite then Truncate;
end;

destructor TMemBlobStream.Destroy;
begin
  if FOpened then
    if FModified then FField.Modified := True;
  if FModified then
  try
    FDataSet.DataEvent(deFieldChange, Longint(FField));
  except
    Application.HandleException(Self);
  end;
end;

function TMemBlobStream.GetBlobSize: LongInt;
begin
  Result := 0;
  if FOpened then
    if FCached then
      Result := Length(FDataSet.GetBlobData(FField, FBuffer))
    else Result :=  Length(FDataSet.GetActiveBlobData(FField));
end;

function TMemBlobStream.Read(var Buffer; Count:Longint): LongInt;
begin
  Result := 0;
  if FOpened then
  begin
    if FCached then
    begin
      if Count > Size - FPosition then
        Result := Size - FPosition else
        Result := Count;
      if Result > 0 then
      begin
        Move(PChar(FDataSet.GetBlobData(FField, FBuffer))[FPosition], Buffer, Result);
        Inc(FPosition, Result);
      end;
    end else
    begin
      Move(PChar(FDataSet.GetActiveBlobData(FField))[FPosition], Buffer, Result);
      Inc(FPosition, Result);
    end;
  end;
end;

function TMemBlobStream.Seek(Offset:Longint; Origin:Word): LongInt;
begin
  case Origin of
    0:FPosition := Offset;
    1:Inc(FPosition, Offset);
    2:FPosition := GetBlobSize + Offset;
  end;
  Result := FPosition;
end;

procedure TMemBlobStream.Truncate;
begin
  if FOpened then begin
    FDataSet.SetBlobData(FField, FBuffer, '');
    FModified := True;
  end;
end;

function TMemBlobStream.Write(const Buffer; Count:Longint): LongInt;
var
  Temp: TMemBlobData;
begin
  Result := 0;
  if FOpened and FCached  then
  begin
    Temp := FDataSet.GetBlobData(FField, FBuffer);
    if Length(Temp) < FPosition + Count then
      SetLength(Temp, FPosition + Count);
    Move(Buffer, PChar(Temp)[FPosition], Count);
    FDataSet.SetBlobData(FField, FBuffer, Temp);
    Inc(FPosition, Count);
    Result := Count;
    FModified := True;
  end;
end;

{ TdxMemPersistent }
constructor TdxMemPersistent.Create(AMemData:TdxMemData);
begin
  inherited Create;
  FStream := TMemoryStream.Create;
  FOption := poActive;
  FMemData := AMemData;
  FIsLoadFromPersistent := False;
end;

destructor TdxMemPersistent.Destroy;
begin
  FStream.Free;
  inherited Destroy;
end;

procedure TdxMemPersistent.Assign(Source:TPersistent);
begin
  if (Source is TdxMemPersistent) then
  begin
    Option := TdxMemPersistent(Source).Option;
    FStream.LoadFromStream(TdxMemPersistent(Source).FStream);
  end else
    inherited;
end;

procedure TdxMemPersistent.DefineProperties(Filer:TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineBinaryProperty('Data', ReadData, WriteData, HasData);
end;

function TdxMemPersistent.HasData: Boolean;
begin
  Result := FStream.Size > 0;
end;

procedure TdxMemPersistent.LoadData;
begin
  if HasData and not FIsLoadFromPersistent then
  begin
    FIsLoadFromPersistent := True;
    try
      FStream.Position := 0;
      FMemData.LoadFromStream(FStream);
    finally
      FIsLoadFromPersistent := False;
    end;
  end;
end;

procedure TdxMemPersistent.ReadData(Stream:TStream);
begin
  FStream.Clear;
  FStream.LoadFromStream(Stream);
end;

procedure TdxMemPersistent.SaveData;
begin
  FStream.Clear;
  FMemData.SaveToStream(FStream);
end;

procedure TdxMemPersistent.WriteData(Stream:TStream);
begin
  FStream.SaveToStream(Stream);
end;

{ TdxMemField }
constructor TdxMemField.Create(AOwner:TdxMemFields);
begin
  FOwner := AOwner;
  FIndex := FOwner.FItems.Count;
end;

procedure TdxMemField.AddValue(const Buffer:PChar);
begin
  if FIndex = 0 then
    InsertValue(FOwner.FValues.Count, Buffer)
  else
    InsertValue(FOwner.FValues.Count-1, Buffer);
end;

procedure TdxMemField.CreateField(Field:TField);
var
  i: Integer;
  mField: TdxMemField;
begin
  FField := Field;
  FDataType := Field.DataType;
  FDataSize := Field.DataSize;
  FIsRecId := UpperCase(Field.FieldName) = 'RECID';
  FIsNeedAutoInc := FIsRecId or (FDataType = ftAutoInc);
  FIsWideString := (FDataType = ftWideString);
  if FIsWideString then
    FOwner.FWideStringFields.Add(self);
  if FIsNeedAutoInc then
    FOwner.FIsNeedAutoIncList.Add(self);
  if FIndex = 0 then
  begin
    FOffSet := 0;
    fOwner.FValuesSize := 0;
  end else begin
    mField := TdxMemField(FOwner.FItems[FIndex-1]);
    FOffSet := mField.FOffSet + mField.FDataSize + 1;
  end;
  FValueOffSet := FOffSet + 1;
  Inc(FOwner.FValuesSize, FDataSize+1);
  FMaxIncValue := 0;
  for i := 0 to DataSet.RecordCount-1 do
    AddValue(nil);
end;

procedure TdxMemField.InsertValue(AIndex:Integer; const Buffer:PChar);
var
  p: PChar;
begin
  if AIndex = FOwner.FValues.Count then
  begin
    p := StrAlloc(FOwner.FValuesSize);
    FOwner.FValues.Insert(AIndex, p);
  end else
    p := PChar(FOwner.FValues.Last) + FOffSet;
  if Buffer = nil then
    p[0] := Char(0)
  else begin
    p[0] := Char(1);
    if FIsWidestring then
    begin
      FillChar(PChar(p+1)^, Field.DataSize, 0);
      MemDataCopyWideString(p+1, PWideString(Buffer)^)
    end else
      Move(Buffer^, (p+1)^, FDataSize);
  end;
  if FIsNeedAutoInc then
    SetAutoIncValue(p, Buffer);
end;

procedure TdxMemField.SetAutoIncValue(Value:PChar; const Buffer:PChar);
var
  AMaxValue: Integer;
begin
  if (Buffer <> nil) then
    Move(Buffer^, AMaxValue, SizeOf(Integer))
  else
    AMaxValue := -1;
  if (Buffer <> nil) and  (FMaxIncValue < AMaxValue) then
    FMaxIncValue := AMaxValue
  else
  begin
    if (not DataSet.IsLoading) or (Buffer = nil) then
    begin
      Inc(FMaxIncValue);
      Value[0] := Char(1);
      Move(FMaxIncValue, (Value+1)^, FDataSize);
    end;
  end;
end;

function TdxMemField.GetDataSet: TdxMemData;
begin
  Result := MemFields.DataSet;
end;

function TdxMemField.GetHasValues(Index:Integer): Char;
begin
  Result := (PChar(FOwner.FValues.List^[Index]) + FOffSet)[0];
end;

procedure TdxMemField.SetHasValues(Index:Integer; Value: Char);
var
  buf: PChar;
  ws: PWideChar;
begin
  if (FIsWidestring) then
  begin
    buf := PChar(FOwner.FValues.List^[Index]) + FOffSet;
    if (Value = Char(0)) and (buf[0] = Char(1)) then
      SysFreeString(PWideChar(Pointer(buf + 1)^));
    if (Value = Char(1)) and (buf[0] = Char(0)) then
    begin
      ws := SysAllocString(nil);
      Move(ws, PChar(buf+1)^, SizeOf(WideString));
    end;
  end;
  (PChar(FOwner.FValues.List^[Index]) + FOffSet)[0] := Value;
end;

function TdxMemField.GetMemFields: TDxMemFields;
begin
  Result := FOwner;
end;

function TdxMemField.GetValues(Index:Integer): PChar;
begin
  Result := PChar(FOwner.FValues.List^[Index]) + FValueOffSet;
end;

{ TdxMemFields }
constructor TdxMemFields.Create(ADataSet:TdxMemData);
begin
  FDataSet := ADataSet;
  FItems := TList.Create;
  FCalcFields := TList.Create;
  FIsNeedAutoIncList := TList.Create;
  FWideStringFields := TList.Create;
end;

destructor TdxMemFields.Destroy;
begin
  Clear;
  FItems.Free;
  FCalcFields.Free;
  FIsNeedAutoIncList.Free;
  FWideStringFields.Free;
  inherited Destroy;
end;

function TdxMemFields.Add(AField:TField): TdxMemField;
begin
  Result := TdxMemField.Create(self);
  FItems.Add(Result);
  TdxMemField(Result).CreateField(AField);
end;

procedure TdxMemFields.AddField(Field:TField);
var
  mField: TdxMemField;
begin
  mField := IndexOf(Field);
  if mField = nil then
    Add(Field);
end;

procedure TdxMemFields.Clear;
var
  i: Integer;
begin
  if FValues <> nil then
  begin
    for i := 0 to FValues.Count-1 do
    begin
      WideStringDeleteRecord(i);
      StrDispose(FValues.List^[i]);
    end;
    FValues.Free;
    FValues := nil;
  end;
  for i := 0 to FItems.Count-1 do
    TdxMemField(FItems[i]).Free;
  FItems.Clear;
  FCalcFields.Clear;
  FIsNeedAutoIncList.Clear;
  FWideStringFields.Clear;
end;

procedure TdxMemFields.DeleteRecord(AIndex:Integer);
begin
  WideStringDeleteRecord(AIndex);
  StrDispose(FValues[AIndex]);
  FValues.Delete(AIndex);
end;

function TdxMemFields.GetActiveBuffer(ActiveBuffer, Buffer:Pointer; Field:TField): Boolean;
var
  mField: TdxMemField;
  p: PChar;
begin
  mField := IndexOf(Field);
  if mField <> nil then
  begin
    p := ActiveBuffer;
    p := p + mField.FOffSet;
    Result := Byte(p[0]) <> 0;
    if Field.DataType = ftWideString then
    begin
      if Result then
         MemDataCopyWideString(Buffer, PWideString(p+1)^)
       else
         PWideString(Buffer)^ := '';
    end else
      Move((p+1)^, Buffer^, mField.FDataSize);
  end else
    Result := False;
end;

procedure TdxMemFields.GetBuffer(Buffer:Pointer; AIndex:Integer);
begin
  Move(FValues.List^[AIndex]^, Buffer^, FValuesSize);
end;

function TdxMemFields.GetHasValue(mField:TdxMemField; Index:Integer): Char;
begin
  Result := mField.GetHasValues(Index);
end;

function TdxMemFields.GetValue(mField:TdxMemField; Index:Integer): PChar;
begin
  Result := PChar(FValues.List^[Index]) + mField.FValueOffSet;
end;

function TdxMemFields.IndexOf(Field:TField): TdxMemField;
var
  i: Integer;
begin
  Result := Nil;
  for i := 0 to FItems.Count - 1 do
    if(TdxMemField(FItems.List^[i]).Field = Field) then
    begin
      Result := TdxMemField(FItems.List^[i]);
      break;
    end;
end;

procedure TdxMemFields.InsertRecord(Buffer:Pointer; AIndex:Integer; Append:Boolean);
var
  i: Integer;
  p: PChar;
  mField: TdxMemField;
begin
  if AIndex = -1 then
    AIndex := 0;
  p := StrAlloc(FValuesSize);
  Move(Buffer^, p^, FValuesSize);
  if Append then
    FValues.Add(p)
  else
    FValues.Insert(AIndex, p);
  for i := 0 to FIsNeedAutoIncList.Count-1 do
  begin
    mField := TdxMemField(FIsNeedAutoIncList[i]);
    mField.SetAutoIncValue(p + mField.FOffSet, PChar(Buffer) + mField.FValueOffSet);
  end;
end;

procedure TdxMemFields.RemoveField(Field:TField);
var
  mField: TdxMemField;
begin
  mField := IndexOf(Field);
  if(mField <> Nil) then
    mField.Free;
end;

procedure TdxMemFields.SetActiveBuffer(ActiveBuffer, Buffer:Pointer; Field:TField);
var
  mField: TdxMemField;
  p: PChar;
begin
  if Field.Calculated and (DataSet.State = dsCalcFields) then
    Exit;
  mField := IndexOf(Field);
  p := PChar(ActiveBuffer) + mField.FOffSet;
  if Buffer <> nil then
  begin
    p[0] := Char(1);
    if (Field.DataType = ftWideString) then
    begin
      MemDataCopyWideString(p+1, PWideString(Buffer)^);
    end else
      Move(Buffer^, (p+1)^, mField.FDataSize);
  end else
    p[0] := Char(0);
end;

procedure TdxMemFields.SetBuffer(Buffer:Pointer; AIndex:Integer);
var
  i: Integer;
  buf: PChar;
begin
  if AIndex = -1 then
    exit;
  if FWideStringFields.Count > 0 then
  begin
    for i := 0 to FItems.Count-1 do
    begin
      buf := PChar(Buffer) + TdxMemField(FItems[i]).FOffSet;
      SetHasValue(TdxMemField(FItems[i]), AIndex, buf[0]);
      if (buf[0] = #1) then
        SetValue(TdxMemField(FItems[i]), AIndex, buf + 1);
    end;
  end else
    Move(Buffer^, FValues.List^[AIndex]^, FValuesSize);
end;

procedure TdxMemFields.SetHasValue(mField:TdxMemField; Index:Integer; Value:char);
begin
  mField.SetHasValues(Index, Value);
end;

procedure TdxMemFields.SetValue(mField:TdxMemField; Index:Integer; Buffer:PChar);
  
  const
    HasValueArr:Array[False..True] of Char = (char(0), char(1));
  
begin
  SetHasValue(mField, Index, HasValueArr[Buffer <> nil]);
  if (Buffer = nil) then
    Exit;
  if not (mField.FIsWideString) then
    Move(Buffer^, (PChar(FValues.List^[Index]) + mField.FValueOffSet)^, mField.FDataSize)
  else
    MemDataCopyWideString(PChar(FValues.List^[Index]) + mField.FValueOffSet, PWideString(Buffer)^);
end;

procedure TdxMemFields.WideStringDeleteRecord(AIndex:Integer);
var
  i: Integer;
begin
  for i := 0 to FWideStringFields.Count-1 do
    TdxMemField(FWideStringFields[i]).SetHasValues(AIndex, Char(0));
end;

function TdxMemFields.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TdxMemFields.GetItem(Index:Integer): TdxMemField;
begin
  Result := TdxMemField(FItems[Index]);
end;

function TdxMemFields.GetRecordCount: Integer;
begin
  if(FValues = nil) then
    Result := 0
  else
    Result := FValues.Count;
end;

{ TdxMemIndex }
constructor TdxMemIndex.Create(Collection:TCollection);
begin
  inherited Create(Collection);
  fIsDirty := True;
  fList := TList.Create;
  fIndexList := TList.Create;
end;

destructor TdxMemIndex.Destroy;
begin
  fList.Free;
  fIndexList.Free;
  inherited Destroy;
end;

procedure TdxMemIndex.DeleteRecord(pRecord:Pointer);
begin
  if not fIsDirty then
    fList.Remove(pRecord);
end;

function TdxMemIndex.GotoNearest(const Buffer:PChar; var Index:Integer): Boolean;
var
  mField: TdxMemField;
begin
  Result := False;
  Prepare;
  if IsDirty then
    Exit;
  with GetMemData do
  begin
    mField := fData.IndexOf(fField);
    if (mField <> nil) then
      Result := GetMemData.InternalGotoNearest(fList, mField.FValueOffSet, fField.DataType, Buffer, SortOptions, Index);
      if Result then
        Index := Integer(fIndexList.List^[Index]);
  end;
end;

procedure TdxMemIndex.Prepare;
var
  i: Integer;
  mField: TdxMemField;
  tempList: TList;
begin
  if not IsDirty or (fField = nil) then
    Exit;
  fList.Clear;
  fIndexList.Clear;
  with GetMemData do
  begin
    mField := fData.IndexOf(fField);
    if (mField <> nil) then
    begin
      fList.Capacity := fData.FValues.Count;
      fIndexList.Capacity := fList.Capacity;
      for i := 0 to fData.FValues.Count-1 do
      begin
        fList.Add(fData.FValues.List^[i]);
        fIndexList.Add(Pointer(i));
      end;
      tempList := TList.Create;
      tempList.Add(fIndexList);
      try
        DoSort(fList, mField.FValueOffSet, mField.FDataSize, fField.DataType, SortOptions, tempList);
      finally
        tempList.Free;
      end;
      IsDirty := False;
    end;
  end;
end;

procedure TdxMemIndex.SetFieldNameAfterMemdataLoaded;
begin
  if (fLoadedFieldName <> '') then
    FieldName := fLoadedFieldName;
end;

procedure TdxMemIndex.UpdateRecord(pRecord:Pointer);
var
  i, Index: Integer;
  mField: TdxMemField;
begin
  if fIsDirty then
    exit;
  i := fList.IndexOf(pRecord);
  if i > -1 then
  begin
    Index := GetMemData.Data.FValues.IndexOf(fList.List^[i]);
    if Index > - 1 then
    begin
      mField := GetMemData.Data.IndexOf(fField);
      with GetMemData, GetMemData.Data do
      begin
        if ((Index = 0) or
        (InternalCompareValues(GetValue(mField, Index-1), GetValue(mField, Index), fField.DataType, soCaseinsensitive in SortOptions) <= 0))
        and ((Index = RecordCount-1) or
        (InternalCompareValues(GetValue(mField, Index), GetValue(mField, Index+1), fField.DataType, soCaseinsensitive in SortOptions) <= 0)) then
          exit;
      end;
    end;
  end;
  fIsDirty := True;
end;

procedure TdxMemIndex.SetFieldName(Value: string);
var
  AField: TField;
begin
  if (GetMemdata <> nil) and (csLoading in GetMemdata.ComponentState) then
  begin
    fLoadedFieldName := Value;
    exit;
  end;
  if (CompareText(fFieldName, Value) <> 0) then
  begin
    AField := GetMemData.FieldByName(Value);
    if AField <> nil then
    begin
      fFieldName := AField.FieldName;
      fField := AField;
      IsDirty := True;
    end;
  end;
end;

procedure TdxMemIndex.SetIsDirty(Value: Boolean);
begin
  if not Value and (fField = nil) then
    Value := True;
  if (fIsDirty <> Value) then
  begin
    fIsDirty := Value;
    if (Value) then
      fList.Clear;
  end;
end;

function TdxMemIndex.GetMemData: TdxMemData;
begin
  Result := TdxMemIndexes(Collection).fMemData;
end;

procedure TdxMemIndex.SetSortOptions(Value: TdxSortOptions);
begin
  if (SortOptions <>  Value) then
  begin
    FSortOptions :=  Value;
    IsDirty := True;
  end;
end;

{ TdxMemIndexes }
function TdxMemIndexes.Add: TdxMemIndex;
begin
  Result := TdxMemIndex(inherited Add);
end;

procedure TdxMemIndexes.AfterMemdataLoaded;
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
    TdxMemIndex(Items[i]).SetFieldNameAfterMemdataLoaded;
end;

procedure TdxMemIndexes.CheckFields;
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
  begin
    TdxMemIndex(Items[i]).fField := fMemData.FindField(TdxMemIndex(Items[i]).FieldName);
    TdxMemIndex(Items[i]).IsDirty := True;
  end;
end;

procedure TdxMemIndexes.DeleteRecord(pRecord:Pointer);
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
    TdxMemIndex(Items[i]).DeleteRecord(pRecord);
end;

function TdxMemIndexes.GetIndexByField(AField:TField): TdxMemIndex;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Count - 1 do
    if(TdxMemIndex(Items[i]).fField = AField) then
    begin
      Result := TdxMemIndex(Items[i]);
      break;
    end;
end;

function TdxMemIndexes.GetOwner: TPersistent;
begin
  Result := fMemData;
end;

procedure TdxMemIndexes.RemoveField(AField:TField);
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
    if(TdxMemIndex(Items[i]).fField = AField) then
    begin
      TdxMemIndex(Items[i]).fField := nil;
      TdxMemIndex(Items[i]).IsDirty := True;
    end;
end;

procedure TdxMemIndexes.SetIsDirty;
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
    TdxMemIndex(Items[i]).IsDirty := True;
end;

procedure TdxMemIndexes.UpdateRecord(pRecord:Pointer);
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
    TdxMemIndex(Items[i]).UpdateRecord(pRecord);
end;

{ TdxMemData }
constructor TdxMemData.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  FData := TdxMemFields.Create(self);
  FData.FDataSet := self;
  FBookMarks := TList.Create;
  FBlobList := TList.Create;
  FFilterList := TList.Create;
  FDelimiterChar := Char(VK_TAB);
  FGotoNearestMin := -1;
  FGotoNearestMax := -1;
  fIndexes := TdxMemIndexes.Create(TdxMemIndex);
  fIndexes.fMemData := self;
  fPersistent := TdxMemPersistent.Create(self);
  CreateRecIDField;
end;

destructor TdxMemData.Destroy;
begin
  fIndexes.Free;
  BlobClear;
  FBlobList.Free;
  FBlobList := nil;
  FBookMarks.Free;
  FFilterList.Free;
  FData.Free;
  FData := nil;
  FActive := False;
  fPersistent.Free;
  inherited Destroy;
end;

function TdxMemData.AllocRecordBuffer: PChar;
begin
  GetMem( Result, FRecBufSize + (BlobFieldCount * SizeOf(Pointer)));
  if BlobFieldCount > 0 then
    Initialize(PMemBlobDataArray(Result+FRecBufSize)[0], BlobFieldCount);
end;

procedure TdxMemData.BlobClear;
var
  i: Integer;
  p: PChar;
begin
  if BlobFieldCount > 0 then
    for i := 0 to FBlobList.Count - 1 do
    begin
      p := FBlobList[i];
      if(p <> nil) then
      begin
        Finalize(PMemBlobDataArray(p)[0], BlobFieldCount);
        FreeMem(FBlobList[i], BlobFieldCount * SizeOf(Pointer));
      end;
    end;
  FBlobList.Clear;
end;

function TdxMemData.BookmarkValid(Bookmark:TBookmark): Boolean;
var
  Index: Integer;
begin
  Result := (Bookmark <> nil);
  if(Result) then
  begin
    Index := FBookMarks.IndexOf(TObject(PInteger(Bookmark)^));
    Result := (Index > -1) and (Index < Data.RecordCount);
    if  FIsFiltered then
      Result := FFilterList.IndexOf(Pointer(Index + 1)) > -1;
  end;
end;

function TdxMemData.CheckFields(FieldsName:string): Boolean;
var
  FieldList: TList;
  i: Integer;
begin
  FieldList := TList.Create;
  GetFieldList(FieldList, FieldsName);
  Result := FieldList.Count > 0;
  if Result then
  begin
    for i := 0 to FieldList.Count - 1 do
      if(FieldList[i] = nil) then
      begin
        Result := False;
        break;
      end;
  end;
  FieldList.Free;
end;

procedure TdxMemData.ClearCalcFields(Buffer:PChar);
var
  i: Integer;
  mField: TdxMemField;
begin
  if (Data.Count < 2) or (State = dsCalcFields) then exit;
  for i := 1 to Data.FCalcFields.Count - 1 do
  begin
    mField := fData.IndexOf(TField(FData.FCalcFields[i]));
    Buffer[mField.FOffSet] := #0;
  end;
end;

procedure TdxMemData.CloseBlob(Field:TField);
var
  i: Integer;
begin
  if (FBlobList <> nil) and (FCurRec >= 0) and (FCurRec < RecordCount) and (State = dsEdit) then
  begin
    i := FCurRec;
    PMemBlobDataArray(ActiveBuffer + FRecBufSize)[Field.Offset] := PMemBlobDataArray(FBlobList[i])[Field.Offset]
  end else
    PMemBlobDataArray(ActiveBuffer + FRecBufSize)[Field.Offset] := '';
end;

function TdxMemData.CompareBookmarks(Bookmark1,Bookmark2:TBookmark): Integer;
  
  const
    RetCodes:array[Boolean, Boolean] of ShortInt = ((2, -1), (1, 0));
  var
    r1, r2:Integer;
  
begin
  Result := RetCodes[Bookmark1 = nil, Bookmark2 = nil];
  if(Result = 2) then
  begin
    Move(Bookmark1^, r1, SizeOf(Integer));
    Move(Bookmark2^, r2, SizeOf(Integer));
    if(r1 = r2) then
       Result := 0
    else begin
      if FSortedField <> nil then
      begin
        r1 := FBookMarks.IndexOf(TObject(r1));
        r2 := FBookMarks.IndexOf(TObject(r2));
      end;
      if(r1 > r2) then
        Result := 1
      else Result := -1;
    end;
  end;
end;

function TdxMemData.CompareValues(const Buffer1,Buffer2:PChar; DataType:TFieldType): Integer;
begin
  Result := InternalCompareValues(Buffer1, Buffer2, DataType, soCaseInsensitive in FSortOptions);
end;

procedure TdxMemData.CopyFromDataSet(DataSet:TDataSet);
begin
  Close;
  CreateFieldsFromDataSet(DataSet);
  LoadFromDataSet(DataSet);
end;

function TdxMemData.CreateBlobStream(Field:TField; Mode:TBlobStreamMode): TStream;
begin
  Result := TMemBlobStream.Create(TBlobField(Field), Mode);
end;

procedure TdxMemData.CreateFieldsFromDataSet(DataSet:TDataSet);
var
  AField: TField;
  i: Integer;
begin
  if (DataSet = nil) or (DataSet.FieldCount = 0) then exit;
  Close;
  while FieldCount > 1 do
    Fields[FieldCount - 1].Free;
  if DataSet.FieldCount > 0 then
  begin
    for i := 0 to DataSet.FieldCount - 1 do
      if SupportedFieldType(DataSet.Fields[i].DataType)
      and (CompareText(DataSet.Fields[i].FieldName, 'RECID') <> 0) then
      begin
        AField := DefaultFieldClasses[DataSet.Fields[i].DataType].Create(self);
        with  DataSet.Fields[i] do
        begin
          AField.Name := self.Name + CorrectFieldName(FieldName);
          AField.DisplayLabel := DataSet.Fields[i].DisplayLabel;
          AField.DisplayWidth := DataSet.Fields[i].DisplayWidth;
          AField.EditMask := DataSet.Fields[i].EditMask;
          AField.FieldName := FieldName;
          if AField is TStringField then
            TStringField(AField).Size := Size;
          if AField is TBlobField then
            TBlobField(AField).Size := Size;
          if AField is TFloatField then
          begin
            TFloatField(AField).Currency := TFloatField(DataSet.Fields[i]).Currency;
            TFloatField(AField).Precision := TFloatField(DataSet.Fields[i]).Precision;
          end;
          AField.DataSet := self;
          AField.Calculated := Calculated;
          AField.Lookup := Lookup;
          if Lookup then
          begin
            AField.KeyFields := KeyFields;
            AField.LookupDataSet := LookupDataSet;
            AField.LookupKeyFields := LookupKeyFields;
            AField.LookupResultField := LookupResultField;
          end;
        end;
      end;
  end else
  begin
    DataSet.FieldDefs.Update;
    for i := 0 to DataSet.FieldDefs.Count - 1 do
      if SupportedFieldType(DataSet.FieldDefs[i].DataType) then
      begin
        AField := DefaultFieldClasses[DataSet.Fields[i].DataType].Create(self);
        with  DataSet.FieldDefs[i] do
        begin
          AField.Name := self.Name + Name;
          AField.FieldName := Name;
          if AField is TStringField then
                TStringField(AField).Size := Size;
          if AField is TBlobField then
                TBlobField(AField).Size := Size;
          AField.DataSet := self;
        end;
      end;
  end;
end;

procedure TdxMemData.CreateFieldsFromStream(Stream:TStream);
var
  i, j, Count: Integer;
  fbuf: PChar;
  AField: TField;
  iByte, iByte1: SmallInt;
  VerNo: Double;
begin
  Close;
  fbuf := StrAlloc(255);
  Stream.Read(fbuf^, 3);
  fbuf[3] := #0;
  if fbuf = 'Ver' then
  begin
    Stream.Read(VerNo, sizeof(Double));
    if VerNo < 1 then
      VerNo := 1;
  end else
  begin
    Stream.Position := 0;
    VerNo := 0;
  end;
  Stream.Read(Count, 4);
  for i := 0 to Count - 1 do
  begin
    if (Stream.Read(j, 4) < 4) then
      break;
    if (Stream.Read(iByte, 2) < 2) then
      break;
    if (Stream.Read(iByte1, 2) < 2) then
      break;
    if( Stream.Read(fbuf^, iByte1) < iByte1) then
      break;
    AField := FindField(String(fbuf));
    if AField = nil then
    begin
      if (GetFieldTypeByNo(iByte) <> ftUnknown) then
      begin
        AField := GetFieldClass(GetFieldTypeByNo(iByte)).Create(self);
        with AField do
        begin
          FieldName := String(fbuf);
          DataSet := self;
          Name := self.Name + CorrectFieldName(String(fbuf));
          Calculated := False;
          if (AField.DataType = ftWideString) then
            Size := j;
          if (AField.DataType = ftString) then
            Size := j - 1;
        end;
      end;
    end;
  end;
  StrDispose(fbuf);
end;

procedure TdxMemData.CreateRecIDField;
begin
  if (FRecIdField <> nil) then exit;
  FRecIdField := TIntegerField.Create(self);
  with FRecIdField do
  begin
    FieldName := 'RecId';
    DataSet := self;
    Name := self.Name + FieldName;
    Calculated := True;
    Visible := False;
  end;
end;

procedure TdxMemData.DoAfterCancel;
begin
  if not IsLoading then
    inherited DoAfterCancel;
end;

procedure TdxMemData.DoAfterClose;
begin
  if not IsLoading then
    inherited DoAfterClose;
end;

procedure TdxMemData.DoAfterInsert;
begin
  if not IsLoading then
    inherited DoAfterInsert;
end;

procedure TdxMemData.DoAfterOpen;
begin
  if (Persistent.Option = poActive) then
    Persistent.LoadData;
  if not IsLoading then
    inherited DoAfterOpen;
end;

procedure TdxMemData.DoAfterPost;
begin
  if not IsLoading then
    inherited DoAfterPost;
end;

procedure TdxMemData.DoBeforeClose;
begin
  if not IsLoading then
    inherited DoBeforeClose;
end;

procedure TdxMemData.DoBeforeInsert;
begin
  if not IsLoading then
    inherited;
end;

procedure TdxMemData.DoBeforeOpen;
begin
  if not IsLoading then
    inherited;
end;

procedure TdxMemData.DoBeforePost;
begin
  if not IsLoading then
    inherited DoBeforePost;
end;

procedure TdxMemData.DoOnNewRecord;
begin
  if not IsLoading then
    inherited DoOnNewRecord;
end;

procedure TdxMemData.DoSort(List:TList; AOffSet:Integer; Size:Integer; DataType:TFieldType; ASortOptions:TdxSortOptions; ExhangeList:TList);
  
  function CompareNodes(const V1, V2:Pointer; vI1, vI2:PChar):Integer;
  begin
    Result := InternalCompareValues(PChar(V1), PChar(V2), DataType, soCaseInsensitive in ASortOptions);
    if (Result = 0) and (FRecIdField <> nil) then
    begin
      Result := InternalCompareValues(vI1+1, vI2+1, FRecIdField.DataType, soCaseInsensitive in ASortOptions);
    end;
    if soDesc in ASortOptions then
      Result := - Result;
  end;
  
  procedure QuickSort(L:TList; iLo,iHi:Integer);
  var
    Lo, Hi, M:Integer;
    Mid, T:PChar;
  
    procedure DoExchangeList(FList:TList);
    begin
      T := FList[Lo];
      FList[Lo] := FList[Hi];
      FList[Hi] := T;
    end;
  
  var
    i:Integer;
  begin
    Lo := iLo;
    Hi := iHi;
    M := (Lo + Hi) div 2;
    Mid := PChar(L[M]);
    repeat
      while (Lo < iHi) do
      begin
        if CompareNodes(PChar(L[Lo]) + AOffSet, Mid + AOffSet, PChar(L[Lo]), Mid) < 0 then
          Inc(Lo)
        else break;
      end;
      while (Hi > iLo) do
      begin
        if CompareNodes(PChar(L[Hi]) + AOffSet, Mid + AOffSet, PChar(L[Hi]), Mid) > 0 then
          Dec(Hi)
        else break;
      end;
      if Lo <= Hi then
      begin
        DoExchangeList(L);
        if (ExhangeList <> nil) then
        begin
          for i := 0 to ExhangeList.Count - 1 do
            DoExchangeList(TList(ExhangeList.List^[i]));
        end;
        Inc(Lo);
        Dec(Hi);
      end;
    until Lo > Hi;
    if Hi > iLo then QuickSort(L, iLo, Hi);
    if Lo < iHi then QuickSort(L, Lo, iHi);
  end;
  
begin
  if List.Count > 0 then
    QuickSort(List, 0, List.Count-1);
end;

procedure TdxMemData.FillBookMarks;
var
  i: Integer;
begin
  FBookMarks.Clear;
  for i := 1 to FData.RecordCount do
    FBookMarks.Add(Pointer(i));
  FLastBookmark := FData.RecordCount;
end;

procedure TdxMemData.FreeRecordBuffer(var Buffer:PChar);
begin
  if BlobFieldCount > 0 then
    Finalize(PMemBlobDataArray(Buffer + FRecBufSize)[0], BlobFieldCount);
  FreeMem(Buffer, FRecBufSize + (BlobFieldCount * SizeOf(Pointer)));
  Buffer := nil;
end;

function TdxMemData.GetActiveBlobData(Field:TField): TMemBlobData;
var
  i: Integer;
begin
  Result := '';
  i := FCurRec;
  if (i < 0) and (RecordCount > 0) then i := 0
  else if i >= RecordCount then i := RecordCount - 1;
  if (i >= 0) and (i < RecordCount) then
  begin
    if FIsFiltered then
      i := Integer(FFilterList[FFilterCurRec]) - 1;
    Result := PMemBlobDataArray(FBlobList[i])[Field.Offset];
  end;
end;

function TdxMemData.GetActiveRecBuf(var RecBuf:PChar): Boolean;
begin
  case State of
    dsBrowse:if IsEmpty then RecBuf := nil else RecBuf := ActiveBuffer;
    dsEdit, dsInsert:RecBuf := ActiveBuffer;
    dsCalcFields:RecBuf := CalcBuffer;
  else
    RecBuf := nil;
  end;
  Result := RecBuf <> nil;
end;

function TdxMemData.GetBlobData(Field:TField; Buffer:PChar): TMemBlobData;
begin
  Result := PMemBlobDataArray(Buffer + FRecBufSize)[Field.Offset];
end;

procedure TdxMemData.GetBookmarkData(Buffer:PChar; Data:Pointer);
begin
  PInteger(Data)^ := PdxRecInfo(Buffer + FRecInfoOfs).Bookmark;
end;

function TdxMemData.GetBookmarkFlag(Buffer:PChar): TBookmarkFlag;
begin
  Result := PdxRecInfo(Buffer + FRecInfoOfs).BookmarkFlag;
end;

function TdxMemData.GetBooleanValue(const Buffer:PChar): Boolean;
begin
  Move(Buffer^, Result, SizeOf(Boolean));
end;

function TdxMemData.GetCanModify: Boolean;
begin
  Result := not FReadOnly or FLoadFlag;
end;

function TdxMemData.GetCurrencyValue(const Buffer:PChar): System.Currency;
begin
  Move(Buffer^, Result, SizeOf(System.Currency));
end;

function TdxMemData.GetCurrentRecord(Buffer:PChar): Boolean;
begin
  if ActiveBuffer <> nil then
  begin
    Move(ActiveBuffer^, Buffer^, RecordSize);
    Result := True;
  end else Result := False;
end;

function TdxMemData.GetDateTimeValue(const Buffer:PChar; DataType:TFieldType): TDateTime;
var
  TimeStamp: TTimeStamp;
  Data: TDateTimeRec;
begin
  Move(Buffer^, Data, SizeOf(Double));
  case DataType of
    ftDate:
       begin
          TimeStamp.Time := 0;
          TimeStamp.Date := Data.Date;
        end;
      ftTime:
        begin
          TimeStamp.Time := Data.Time;
          TimeStamp.Date := DateDelta;
        end;
    else
      try
        TimeStamp := MSecsToTimeStamp(Data.DateTime);
      except
        TimeStamp.Time := 0;
        TimeStamp.Date := 0;
      end;
  end;
  if (TimeStamp.Time < 0) or (TimeStamp.Date <= 0) then
    Result := 0
  else
    Result := TimeStampToDateTime(TimeStamp);
end;

function TdxMemData.GetFieldClass(FieldType:TFieldType): TFieldClass;
begin
  Result := inherited GetFieldClass(FieldType);
end;

function TdxMemData.GetFieldData(Field:TField; Buffer:Pointer): Boolean;
var
  RecBuf: PChar;
  BufIsNil: Boolean;
begin
  Result := False;
  if not GetActiveRecBuf(RecBuf) then Exit;
  if Field.IsBlob then
  begin
      Result := Length(GetBlobData(Field, RecBuf)) > 0;
      exit;
  end;
  BufIsNil := Buffer = nil;
  if BufIsNil then
   GetMem(Buffer, Field.DataSize);
  try
    Result := FData.GetActiveBuffer(RecBuf, Buffer, Field)
  finally
    if BufIsNil then
      FreeMem(Buffer, Field.DataSize);
  end;
end;

function TdxMemData.GetFieldData(Field:TField; Buffer:Pointer; NativeFormat:Boolean): Boolean;
begin
  if Field.DataType = ftWideString then
    Result := GetFieldData(Field, Buffer)
  else
    Result := inherited GetFieldData(Field, Buffer, NativeFormat)
end;

function TdxMemData.GetFloatValue(const Buffer:PChar): Double;
begin
  Move(Buffer^, Result, SizeOf(Double));
end;

function TdxMemData.GetIntegerValue(const Buffer:PChar; DataType:TFieldType): Integer;
var
  Data: record case Integer of 0:(I:Smallint); 1:(W:Word); 2:(L:Longint); end;
  FSize: Integer;
begin
  case DataType of
    ftSmallint:FSize := SizeOf(SmallInt);
    ftWord:FSize := SizeOf(Word);
  else
    FSize := SizeOf(LongInt);
  end;
  Move(Buffer^, Data, FSize);
  case DataType of
    ftSmallint:Result := Data.I;
    ftWord:Result := Data.W;
  else
    Result := Data.L;
    end;
end;

function TdxMemData.GetLargeIntValue(const Buffer:PChar; DataType:TFieldType): Int64;
begin
  Result := 0;
  Copy(Buffer^, Result, SizeOf(Int64));
end;

procedure TdxMemData.GetLookupFields(List:TList);
var
  i: Integer;
begin
  for i := 0 to FieldCount-1 do
    if Fields[i].Lookup and (Fields[i].LookupDataSet <> nil) and Fields[i].LookupDataSet.Active then
    begin
      List.Add(Fields[i]);
    end;
end;

procedure TdxMemData.GetMemBlobData(Buffer:PChar);
var
  i, j: Integer;
begin
  if BlobFieldCount > 0 then
  begin
    if (FCurRec >= 0) and (FCurRec < FData.RecordCount) then
    begin
      j := FCurRec;
      for i := 0 to BlobFieldCount - 1 do
        if FBlobList[j] <> nil then
          PMemBlobDataArray(Buffer + FRecBufSize)[i] := PMemBlobDataArray(FBlobList[j])[i]
        else
          PMemBlobDataArray(Buffer + FRecBufSize)[i] := '';
    end;
  end;
end;

function TdxMemData.GetRecNo: Integer;
begin
  UpdateCursorPos;
  if (FCurRec = -1) and (RecordCount > 0) then
    Result := 1
  else
  begin
    if Not FIsFiltered then
      Result := FCurRec + 1
    else Result := FFilterCurRec + 1;
  end;
end;

function TdxMemData.GetRecNoByFieldValue(Value:Variant; FieldName:String): Integer;
var
  Buf: Pointer;
  Field: TField;
  mField: TdxMemField;
  i: Integer;
begin
  Result := -1;
  Field := FindField(FieldName);
  if(Field <> nil) then
  begin
    buf := nil;
    mField := FData.IndexOf(Field);
    if (mField <> nil) then
    try
      GetMem(buf, Field.DataSize);
      DisableControls;
      Insert;
      Field.Value := Value;
      FData.GetActiveBuffer(ActiveBuffer, buf, Field);
      Cancel;
      EnableControls;
      for i := 0 to FData.RecordCount - 1 do
        if(CompareValues(PChar(Buf), mField.Values[i], Field.DataType) = 0) then
        begin
          Result := i + 1;
          break;
        end;
    finally
      FreeMem(buf, Field.DataSize);
    end;
  end;
end;

function TdxMemData.GetRecord(Buffer:PChar; GetMode:TGetMode; DoCheck:Boolean): TGetResult;
begin
  if (FData = nil) then
  begin
    Result := grError;
    exit;
  end;
  if FData.RecordCount < 1 then
    Result := grEOF else
  begin
    Result := grOK;
    if Not FIsFiltered then
      case GetMode of
        gmNext:
          if FCurRec >= RecordCount - 1  then
            Result := grEOF else
            Inc(FCurRec);
        gmPrior:
          if FCurRec <= 0 then
            Result := grBOF else
            Dec(FCurRec);
        gmCurrent:
          if (FCurRec < 0) or (FCurRec >= RecordCount) then
            Result := grError;
        else GetCalcFields(Buffer);
      end
    else
    begin
      case GetMode of
        gmNext:
          if FFilterCurRec >= RecordCount - 1 then
            Result := grEOF else
            Inc(FFilterCurRec);
        gmPrior:
          if FFilterCurRec <= 0 then
            Result := grBOF else
            Dec(FFilterCurRec);
        gmCurrent:
          if (FFilterCurRec < 0) or (FFilterCurRec >= RecordCount) then
            Result := grError;
        else GetCalcFields(Buffer);
      end;
      if (Result = grOK) then
        FCurRec := Integer(FFilterList[FFilterCurRec]) - 1
      else FCurRec := -1;
    end;
    if Result = grOK then
    begin
      FData.GetBuffer(Buffer, FCurRec);
      with PdxRecInfo(Buffer + FRecInfoOfs)^ do
      begin
        BookmarkFlag := bfCurrent;
        Bookmark := Integer(FBookMarks[FCurRec]);
      end;
      GetMemBlobData(Buffer);
    end else
      if (Result = grError) and DoCheck then DatabaseError('No Records');
  end;
end;

function TdxMemData.GetRecordCount: Integer;
begin
  if not FIsFiltered then
    Result := FData.RecordCount
  else
    Result := FFilterList.Count;
end;

function TdxMemData.GetRecordSize: Word;
begin
  Result := FRecInfoOfs;
end;

function TdxMemData.GetStringValue(const Buffer:PChar): string;
begin
  Result := Buffer;
end;

function TdxMemData.GetValueCount(FieldName:String; Value:Variant): Integer;
var
  buf: PChar;
  i: Integer;
  FieldType: TFieldType;
  mField: TdxMemField;
  Field: TField;
begin
  Result := -1;
  Field := FindField(FieldName);
  if (Field = nil) then exit;
  GetMem(buf, Field.DataSize);
  try
    mField := FData.IndexOf(Field);
    if VariantToMemDataValue(Value, buf, Field) and (mField <> nil) then
    begin
      Result := 0;
      FieldType := Field.DataType;
      for i := 0 to FData.RecordCount-1 do
        if CompareValues(buf, mField.Values[i], FieldType) = 0 then
          Inc(Result);
    end;
  finally
    FreeMem(buf);
  end;
end;

function TdxMemData.GetVariantValue(const Buffer:PChar; DataType:TFieldType): Variant;
var
  bcd: System.Currency;
begin
   case DataType of
    ftString: Result := GetStringValue(Buffer);
    ftWideString:Result := GetWideStringValue(Buffer);
    ftSmallint, ftInteger, ftWord, ftAutoInc:
        Result := GetIntegerValue(Buffer, DataType);
    ftFloat:
        Result := GetFloatValue(Buffer);
    ftCurrency:
      Result := GetCurrencyValue(Buffer);
    ftDate, ftTime, ftDateTime:
      Result := GetDateTimeValue(Buffer, DataType);
    ftBCD:
      begin
        BCDToCurr(PBCD(Buffer)^, bcd);
        Result := bcd;
      end;
    ftBoolean:Result := GetBooleanValue(Buffer);
    ftLargeInt:Result := LongInt(GetLargeIntValue(Buffer, DataType));
   else
     Result := NULL;
  end;
end;

function TdxMemData.GetWideStringValue(const Buffer:PChar): WideString;
begin
  Result := WideString(PWideString(Buffer)^);
end;

function TdxMemData.GotoNearest(const Buffer:PChar; ASortOptions:TdxSortOptions; var Index:Integer): Boolean;
begin
  Index := -1;
  Result := False;
  if FLoadFlag then exit;
  if(FSortedField <> nil) then
    Result := InternalGotoNearest(FData.FValues, FData.IndexOf(FSortedField).FValueOffSet, FSortedField.DataType, Buffer, ASortOptions, Index);
end;

procedure TdxMemData.InternalAddFilterRecord;
var
  i: Integer;
begin
  if InternalIsFiltering then
  begin
    i := FCurRec;
    if i < 0 then
     i := 0;
    if(i >= FFilterList.Count) then
    begin
      if (FCurRec = -1) then
        FCurRec := 0;
      FFilterList.Add(Pointer(FCurRec + 1));
      FFilterCurRec := FFilterList.Count - 1;
    end else
    begin
      FFilterList.Insert(i, Pointer(FCurRec + 1));
      FFilterCurRec := i;
      Inc(i);
      while i < FFilterList.Count do
      begin
        FFilterList[i] := Pointer(Integer(FFilterList[i]) + 1);
        Inc(i);
      end;
    end;
  end;
end;

procedure TdxMemData.InternalAddRecord(Buffer:Pointer; Append:Boolean);
begin
  FSaveChanges := True;
  Inc(FLastBookmark);
  if Append then
    InternalLast;
  FData.InsertRecord(ActiveBuffer, FCurRec, True);
  FBookMarks.Add(Pointer(FLastBookmark));
  if BlobFieldCount > 0 then
  begin
    if Append then
      FBlobList.Add(nil)
    else FBlobList.Insert(FCurRec, nil);
    SetMemBlobData(Buffer);
  end;
  InternalAddFilterRecord;
  UpdateRecordFilteringAndSorting(True);
end;

procedure TdxMemData.InternalClose;
begin
  if (csDestroying in ComponentState) then exit;
  FData.Clear;
  FBookMarks.Clear;
  FFilterList.Clear;
  BlobClear;
  FSortedField := nil;
  if DefaultFields then DestroyFields;
  FLastBookmark := 0;
  FCurRec := -1;
  FFilterCurRec := -1;
  FActive := False;
end;

function TdxMemData.InternalCompareValues(const Buffer1,Buffer2:PChar; DataType:TFieldType; IsCaseInSensitive:Boolean): Integer;
var
  In1, In2: Integer;
  Db1, Db2: Double;
  BCD1, BCD2: System.Currency;
  Bool1, Bool2: Boolean;
  largeint1, largeint2: Int64;
begin
  if (Buffer1 = nil) or (Buffer2 = nil) then
  begin
    if(Buffer1 = Buffer2) then
      Result := 0
    else
      if Buffer1 = nil then
        Result := -1
      else Result := 1;
    exit;
  end;
  case DataType of
    ftString:
      begin
        if (IsCaseInSensitive) then
          Result := AnsiStrIComp(Buffer1, Buffer2)
        else Result := AnsiStrComp(Buffer1, Buffer2);
        if(Result <> 0) then
          Result := Result div abs(Result);
      end;
    ftWideString:
      begin
        if (IsCaseInSensitive) then
          Result := AnsiCompareText(String(PWideString(Buffer1)^), String(PWideString(Buffer2)^))
        else Result := AnsiCompareStr(String(PWideString(Buffer1)^), String(PWideString(Buffer2)^));
        if(Result <> 0) then
          Result := Result div abs(Result);
      end;
    ftSmallint, ftInteger, ftWord, ftAutoInc:
      begin
        In1 := GetIntegerValue(Buffer1, DataType);
        In2 := GetIntegerValue(Buffer2, DataType);
        if(In1 > In2) then Result := 1
          else if(In1 < In2) then Result := -1
            else Result := 0;
      end;
    ftLargeInt:
      begin
        largeint1 := GetIntegerValue(Buffer1, DataType);
        largeint2 := GetIntegerValue(Buffer2, DataType);
        if(largeint1 > largeint2) then Result := 1
          else if(largeint1 < largeint2) then Result := -1
            else Result := 0;
      end;
    ftFloat, ftCurrency:
      begin
        Db1 := GetFloatValue(Buffer1);
        Db2 := GetFloatValue(Buffer2);
        if(Db1 > Db2) then Result := 1
          else if(Db1 < Db2) then Result := -1
            else Result := 0;
      end;
    ftBCD:
      begin
        BCDToCurr(PBcd(Buffer1)^, BCD1);
        BCDToCurr(PBcd(Buffer2)^, BCD2);
        if(BCD1 > BCD2) then Result := 1
          else if(BCD1 < BCD2) then Result := -1
            else Result := 0;
      end;
    ftDate, ftTime, ftDateTime:
      begin
        Db1 := GetDateTimeValue(Buffer1, DataType);
        Db2 := GetDateTimeValue(Buffer2, DataType);
        if(Db1 > Db2) then Result := 1
          else if(Db1 < Db2) then Result := -1
            else Result := 0;
      end;
    ftBoolean:
      begin
        Bool1 := GetBooleanValue(Buffer1);
        Bool2 := GetBooleanValue(Buffer2);
        if(Bool1 > Bool2) then Result := 1
          else if(Bool1 < Bool2) then Result := -1
            else Result := 0;
      end;
    else Result := 0;
  end;
end;

procedure TdxMemData.InternalDelete;
var
  i: Integer;
  p: PChar;
begin
  FSaveChanges := True;
  Indexes.DeleteRecord(FData.FValues.List^[FCurRec]);
  FData.DeleteRecord(FCurRec);
  FBookMarks.Delete(FCurRec);
  if BlobFieldCount > 0 then
  begin
    p := FBlobList[FCurRec];
    if (p <> nil) then
    begin
      Finalize(PMemBlobDataArray(p)[0], BlobFieldCount);
      FreeMem(FBlobList[FCurRec], BlobFieldCount * SizeOf(Pointer));
    end;
    FBlobList.Delete(FCurRec);
  end;
  if not FIsFiltered then
  begin
    if FCurRec >= FData.RecordCount then
      Dec(FCurRec);
  end else
  begin
    FFilterList.Delete(FFilterCurRec);
    if(FFilterCurRec < FFilterList.Count) then
      for i := FFilterCurRec to FFilterList.Count - 1 do
        FFilterList[i] := Pointer(Integer(FFilterList[i]) - 1);
    if FFilterCurRec >= RecordCount then
      Dec(FFilterCurRec);
    if(FFilterCurRec > -1) then
      FCurRec := Integer(FFilterList[FFilterCurRec])
    else FCurRec := -1;
  end;
end;

procedure TdxMemData.InternalFirst;
begin
  FCurRec := -1;
  FFilterCurRec := -1;
end;

procedure TdxMemData.InternalGotoBookmark(Bookmark:Pointer);
var
  Index, IndexF: Integer;
begin
  Index := FBookMarks.IndexOf(TObject(PInteger(Bookmark)^));
  if Index > -1 then
  begin
    if FIsFiltered then
    begin
      IndexF := FFilterList.IndexOf(Pointer(Index + 1));
      if(IndexF > -1) then
      begin
        FFilterCurRec := IndexF;
        FCurRec := Index;
      end;
    end else FCurRec := Index
  end else
    DatabaseError('Bookmark not found');
end;

function TdxMemData.InternalGotoNearest(List:TList; AOffSet:Integer; DataType:TFieldType; const Buffer:PChar; ASortOptions:TdxSortOptions; var Index:Integer): Boolean;
  
    function _CompareValues(AIndex:Integer):Integer;
    begin
      Result := InternalCompareValues(Buffer, PChar(List[AIndex]) + AOffSet, DataType, soCaseInsensitive in ASortOptions);
    end;
  
  var
    Min, Max, cmp:Integer;
  
begin
  Result := False;
  if (List.Count = 0) then
  begin
    Index := -1;
    exit;
  end;
  if FGotoNearestMin = -1 then
    Min := 0
  else Min := FGotoNearestMin;
  if FGotoNearestMax = -1 then
    Max := List.Count - 1
  else Max := FGotoNearestMax;
  if (((soDesc in ASortOptions) and (_CompareValues(Min) >= 0))
  or (not (soDesc in ASortOptions) and (_CompareValues(Min) <= 0))) then begin
    cmp := _CompareValues(Min);
    Result := cmp = 0;
    if Result then
      Index := 0
    else Index := -1;
    exit;
  end;
  if ((soDesc in ASortOptions) and (_CompareValues(Max) <= 0))
  or (not (soDesc in ASortOptions) and (_CompareValues(Max) >= 0))then begin
    cmp := _CompareValues(Max);
    Result := cmp = 0;
    if Result then
      Index := Max
    else Index := -1;
    Exit;
  end;
  repeat
    if ((Max - Min) = 1) then begin
      if(Min = Index) then Min := Max;
      if(Max = Index) then Max := Min;
    end;
    Index := Min + ((Max - Min) div 2);
    cmp := _CompareValues(Index);
    if cmp = 0 then break;
    if (soDesc in ASortOptions) then
      cmp := cmp * -1;
    if (cmp > 0) then
      Min := Index
    else  Max := Index;
  until (Min = Max);
  cmp := _CompareValues(Index);
  if (soDesc in ASortOptions) then
    cmp := cmp * -1;
  if Not (cmp = 0) then begin
    if (Index < List.Count - 1) And (cmp > 0) then
     Inc(Index);
  end else
  begin
    while (Index > 0)
    and (_CompareValues(Index - 1) = 0) do
      Dec(Index);
    Result := True;
  end;
end;

procedure TdxMemData.InternalHandleException;
begin
  Application.HandleException(Self);
end;

procedure TdxMemData.InternalInitFieldDefs;
var
  i: Integer;
begin
  FieldDefs.Clear;
  for i := 0 to  FieldCount - 1 do
    with Fields[i] do
      if not (Calculated  or Lookup) then
        FieldDefs.Add(FieldName, DataType, Size, Required)
      else
        if Calculated then
          FData.FCalcFields.Add(Fields[i]);
end;

procedure TdxMemData.InternalInitRecord(Buffer:PChar);
var
  i: Integer;
begin
  FillChar(Buffer^, FRecInfoOfs, 0);
  for i := 0 to BlobFieldCount - 1 do
    PMemBlobDataArray(Buffer + FRecBufSize)[i] := '';
end;

procedure TdxMemData.InternalInsert;
var
  buf: PChar;
  Value: Integer;
  mField: TdxMemField;
begin
  if (FRecIdField <> nil) then
  begin
    mField := FData.IndexOf(FRecIdField);
    if (mField <> nil) then
    begin
      buf := ActiveBuffer + mField.fOffSet;
      Value := mField.FMaxIncValue + 1;
      buf[0] := Char(1);
      Move(Value, (buf + 1)^, mField.FDataSize);
    end;
  end;
end;

function TdxMemData.InternalIsFiltering: Boolean;
begin
  Result := Assigned(OnFilterRecord) and Filtered;
end;

procedure TdxMemData.InternalLast;
begin
  if not FIsFiltered then
    FCurRec := FData.RecordCount
  else begin
    FFilterCurRec := RecordCount;
    FCurRec := FData.RecordCount;
  end;
end;

function TdxMemData.InternalLocate(const KeyFields:string; const KeyValues:Variant; Options:TLocateOptions): Integer;
var
  AKeyValues: Variant;
  
    function CompareLocate_SortCaseSensitive:Boolean;
    begin
      Result := ((loCaseInsensitive in Options) and (soCaseInsensitive in SortOptions))
       or ( not (loCaseInsensitive in Options) and not (soCaseInsensitive in SortOptions))
    end;
  
    procedure AllocPCharByVariant(AValue:Variant; AField:TField; var ABuf:PChar);
     var
      ws:PWideChar;
    begin
      GetMem(ABuf, AField.DataSize + 1);
      if (AField.DataType = ftWideString) then
      begin
        ws := SysAllocString(nil);
        Move(ws, ABuf^, SizeOf(WideString));
      end;
      VariantToMemDataValue(AValue, ABuf, AField);
    end;
  
    procedure FreePChar(AField:TField; ABuf:PChar);
    begin
      if ABuf = nil then
       exit;
      if (AField.DataType = ftWideString) then
      begin
        SysFreeString(PWideChar(Pointer(ABuf)^));
      end;
      FreeMem(ABuf, AField.DataSize + 1);
    end;
  
    function CompareLocStr(DataType:TFieldType; buf1, buf2:PChar; AStSize:Integer):Integer;
    var
      tempbuf:PChar;
      fStr2Len:Integer;
      tempwStr:WideString;
    begin
      Result := -1;
      if (DataType = ftWideString) then
      begin
        fStr2Len := Length(PWideString(buf2)^);
        if fStr2Len = AStSize then
          Result := InternalCompareValues(buf1, buf2, DataType, loCaseInsensitive in Options)
        else
          if (loPartialKey in Options) and (fStr2Len > AStSize) then
          begin
            tempwStr := PWideString(buf2)^;
            SetLength(tempwStr, AStSize);
            Result := InternalCompareValues(buf1, PChar(@tempwStr), DataType, loCaseInsensitive in Options);
          end;
      end else
      begin
        fStr2Len := StrLen(buf2);
        if fStr2Len = AStSize then
          Result := InternalCompareValues(buf1, buf2, DataType, loCaseInsensitive in Options)
        else
          if (loPartialKey in Options) and (fStr2Len > AStSize) and (AStSize > 0) then
          begin
            tempbuf := StrAlloc(AStSize + 1);
            tempbuf := StrMove(tempbuf, buf2, AStSize);
            tempbuf[AStSize] := #0;
            Result := InternalCompareValues(buf1, tempbuf, DataType, loCaseInsensitive in Options);
            StrDispose(tempbuf);
          end;
      end;
    end;
  
    function LocateByIndexField(AIndex:TdxMemIndex; AField:TField; AValue:Variant):Integer;
    var
      FStSize:Integer;
      mField:TdxMemField;
      fBuf:PChar;
    begin
      if VarIsNull(AValue) then
        fBuf := nil
      else AllocPCharByVariant(AValue, AField, fBuf);
      if AIndex = nil then
      begin
        if not GotoNearest(fBuf, SortOptions, Result) and not (loPartialKey in Options) then
          Result := -1;
      end else
      begin
        if not AIndex.GotoNearest(fBuf, Result) then
           Result := -1;
      end;
      if (Result > -1) then
      begin
        mField := FData.IndexOf(AField);
        if (AField.DataType in [ftString, ftWideString])then
        begin
          if FBuf <> nil then
            FStSize := StrLen(fBuf)
          else FStSize := 0;
          if CompareLocStr(AField.DataType, fBuf, mField.Values[Result], FStSize) <> 0 then
            Result := -1;
        end else
        begin
          if (InternalCompareValues(fBuf, mField.Values[Result], AField.DataType, False) <> 0) then
            Result := -1;
        end;
      end;
      if FBuf <> nil then
        FreePChar(AField, FBuf);
   end;
  
   procedure PrepareLocate;
   begin
     CheckBrowseMode;
     CursorPosChanged;
     UpdateCursorPos;
   end;
  
   function GetLocateValue(Index:Integer):Variant;
   begin
     if VarIsArray(AKeyValues) then
       Result := AKeyValues[Index]
     else Result := AKeyValues;
   end;
  
  var
    buf:PChar;
    fValueList, fFieldList, fmFieldList:TList;
    StartId:Integer;
    Field:TField;
    i, j, k, RealRec, RealRecordCount:Integer;
    StSize:Integer;
    IsIndexed :Boolean;
  
begin
  Result := -1;
  if not CheckFields(KeyFields) then
    raise Exception.CreateFmt(SFieldNotFound, [KeyFields]);
  if (RecordCount = 0) then
    Exit;
  Field := FindField(KeyFields);
  if (Field = nil) and not VarIsArray(KeyValues)  then
    Exit;
  if (Field <> nil) and VarIsArray(KeyValues) then
    AKeyValues := KeyValues[0]
  else
    AKeyValues := KeyValues;
  PrepareLocate;
  if (Field <> nil) and (not FIsFiltered) and
  ((Field = FSortedField) or (Indexes.GetIndexByField(Field) <> nil)) and CompareLocate_SortCaseSensitive then
  begin
    if (Field = FSortedField) then
      Result := LocateByIndexField(nil, Field, AKeyValues)
    else
      Result := LocateByIndexField(Indexes.GetIndexByField(Field), Field, AKeyValues);
    Exit;
  end;
  fFieldList := TList.Create;
  fValueList := TList.Create;
  fmFieldList := TList.Create;
  GetFieldList(fFieldList, KeyFields);
  for i := 0 to fFieldList.Count-1 do
  begin
     if VarIsNull(GetLocateValue(i)) then
      fValueList.Add(nil)
    else
    begin
      AllocPCharByVariant(GetLocateValue(i), TField(fFieldList[i]), Buf);
      fValueList.Add(buf);
    end;
    fmFieldList.Add(FData.IndexOf(TField(fFieldList[i])));
  end;
  StartId := 0;
  IsIndexed := False;
  if not FIsFiltered then
  begin
    RealRecordCount := FData.RecordCount - 1;
    if CompareLocate_SortCaseSensitive and
    ((TField(fFieldList[0]) = FSortedField) or (Indexes.GetIndexByField(TField(fFieldList[0])) <> nil)) then
    begin
      Field := TField(fFieldList[0]);
      if Field = FSortedField then
        StartId := LocateByIndexField(nil, Field, GetLocateValue(0))
      else
        StartId := LocateByIndexField(Indexes.GetIndexByField(Field), Field, AKeyValues);
      IsIndexed := True;
    end;
  end else
    RealRecordCount := FFilterList.Count - 1;
  if StartId > -1 then
  begin
    for i := StartId to RealRecordCount do
    begin
      if not FIsFiltered then
        RealRec := i
      else
        RealRec := Integer(FFilterList[i]) - 1;
      j := 0;
      for k := 0 to fFieldList.Count-1 do
      if TField(fFieldList[k]) <> nil then
      begin
        if fValueList[k] = nil then
        begin
          if TdxMemField(fmFieldList[k]).HasValues[RealRec] <> #0 then
            j := -1;
        end else
        begin
          if (TField(fFieldList[k]).DataType in [ftString, ftWideString]) and (Options <> []) then
          begin
            if(TField(fFieldList[k]).DataType = ftWideString) then
              StSize := Length(PWideString(PChar(fValueList[k]))^)
            else
              StSize := StrLen(PChar(fValueList[k]));
              j := CompareLocStr(TField(fFieldList[k]).DataType, PChar(fValueList[k]), TdxMemField(fmFieldList[k]).Values[RealRec], StSize)
          end else
            j := InternalCompareValues(PChar(fValueList[k]), TdxMemField(fmFieldList[k]).Values[RealRec], TField(fFieldList[k]).DataType, (loCaseInsensitive in Options));
        end;
        if IsIndexed and (k = 0) and (j <> 0) then
        begin
          RealRec := -1;
          Break;
        end;
        if j <> 0 then
          Break;
      end;
      if RealRec = -1 then
        Break;
      if j = 0 then
      begin
        Result := i;
        Break;
      end;
    end;
  end;
  for i := 0 to fValueList.Count-1 do
    FreePChar(TField(fFieldList[i]), fValueList[i]);
  fFieldList.Free;
  fValueList.Free;
  fmFieldList.Free;
end;

procedure TdxMemData.InternalOpen;
var
  i: Integer;
begin
  for i := 0 to FieldCount-1 do
    if not SupportedFieldType(Fields[i].DataType) then
    begin
      DatabaseErrorFmt('Unsupported field type:%s', [Fields[i].FieldName]);
      Exit;
    end;
  FillBookMarks;
  FCurRec := -1;
  FFilterCurRec := -1;
  FRecInfoOfs := 0;
  for i := 0 to FieldCount-1 do
    if not Fields[i].IsBlob then
      Inc(FRecInfoOfs, Fields[i].DataSize+1);
  FRecBufSize := FRecInfoOfs + SizeOf(TdxRecInfo);
  BookmarkSize := SizeOf(Integer);
  InternalInitFieldDefs;
  if DefaultFields then
    CreateFields;
  for i := 0 to FieldCount-1 do
   if not Fields[i].IsBlob then
     FData.Add(Fields[i]);
  FData.FValues := TList.Create;
  BindFields(True);
  FActive := True;
  MakeSort;
  Indexes.CheckFields;
end;

procedure TdxMemData.InternalPost;
var
  Buf: Pointer;
  IsMakeSort: Boolean;
  mField: TdxMemField;
begin
  inherited InternalPost;
  FSaveChanges := True;
  IsMakeSort := (FSortedField <> nil);
  if State = dsEdit then
  begin
    if IsMakeSort then
    begin
      mField := FData.IndexOf(FSortedField);
      buf := AllocMem(mField.FDataSize);
      if FData.GetActiveBuffer(ActiveBuffer, Buf, FSortedField) then
        IsMakeSort := InternalCompareValues(mField.Values[FCurRec], Buf, FSortedField.DataType, soCaseInsensitive in SortOptions) <> 0
      else
        IsMakeSort := False;
      FreeMem(Buf);
    end;
    FData.SetBuffer(ActiveBuffer, FCurRec);
  end else
  begin
    Inc(FLastBookmark);
    if FCurRec < 0 then
      FCurRec := 0;
    FData.InsertRecord(ActiveBuffer, FCurRec, False);
    FBookMarks.Add(Pointer(FLastBookmark));
    if BlobFieldCount > 0 then
    begin
      if (FCurRec < 0) or (FCurRec = RecordCount - 1)  then
        FBlobList.Add(nil)
      else
        FBlobList.Insert(FCurRec, nil);
    end;
    InternalAddFilterRecord;
  end;
  if BlobFieldCount > 0 then
    SetMemBlobData(ActiveBuffer);
  UpdateRecordFilteringAndSorting(IsMakeSort);
end;

procedure TdxMemData.InternalRefresh;
var
  FSaveRecNo: Integer;
  i, j: Integer;
  LList: TList;
begin
  LList := TList.Create;
  GetLookupFields(LList);
  if (CalcFieldsSize <> 0) and (RecordCount > 0) and (Assigned(OnCalcFields) or (LList.Count > 0)) then
  begin
    FLoadFlag := True;
    FSaveRecNo := RecNo;
    DisableControls;
    for i := 1 to RecordCount do
    begin
      RecNo := i;
      Edit;
      DoOnCalcFields;
      for j := 0 to LList.Count-1 do
        TField(LList[j]).Value := TField(LList[j]).LookupDataSet.Lookup(TField(LList[j]).LookupKeyFields,
          FindField(TField(LList[j]).KeyFields).Value, TField(LList[j]).LookupResultField);
      Post;
    end;
    RecNo := FSaveRecNo;
    EnableControls;
    FLoadFlag := False;
  end;
  LList.Free;
end;

procedure TdxMemData.InternalSetToRecord(Buffer:PChar);
begin
  InternalGotoBookmark(@PdxRecInfo(Buffer + FRecInfoOfs).Bookmark);
end;

function TdxMemData.IsCursorOpen: Boolean;
begin
  Result := FActive;
end;

procedure TdxMemData.Loaded;
begin
  inherited Loaded;
  Indexes.AfterMemdataLoaded;
  if Active and (Persistent.Option = poLoad) then
    Persistent.LoadData;
end;

procedure TdxMemData.LoadFromBinaryFile(FileName:String);
var
  AStream: TMemoryStream;
begin
  AStream := TMemoryStream.Create;
  try
    AStream.LoadFromFile(FileName);
    LoadFromStream(AStream);
  finally
    AStream.Free;
  end;
end;

procedure TdxMemData.LoadFromDataSet(DataSet:TDataSet);
var
  i: Integer;
  AField: TField;
  
  function CanAssignTo(ASource, ADestination:TFieldType):Boolean;
  begin
    Result := ASource = ADestination;
    if not Result then
      Result := (ASource = ftAutoInc) and (ADestination = ftInteger);
  end;
  
begin
  if (DataSet = nil) or (DataSet.FieldCount = 0) or (not DataSet.Active) then
    Exit;
  if FieldCount < 2 then
    CreateFieldsFromDataSet(DataSet);
  DataSet.DisableControls;
  DataSet.First;
  DisableControls;
  Open;
  while not DataSet.EOF do
  begin
    Append;
    for i := 0 to DataSet.FieldCount-1 do
    begin
      AField := FindField(DataSet.Fields[i].FieldName);
      if (AField <> nil) and CanAssignTo(DataSet.Fields[i].DataType, AField.DataType) then
      begin
        if (AField.DataType = ftLargeInt) and (DataSet.Fields[i].DataType = ftLargeInt) then
          TLargeintField(AField).AsLargeInt := TLargeintField(DataSet.Fields[i]).AsLargeInt
        else
          AField.Value := DataSet.Fields[i].Value;
      end;
    end;
    Post;
    DataSet.Next;
  end;
  DataSet.EnableControls;
  EnableControls;
end;

procedure TdxMemData.LoadFromStream(Stream:TStream);
var
  i, j, ibuf, Count: Integer;
  fbuf: PChar;
  List: TList;
  AField: TField;
  EOFFlag: Boolean;
  dxrField: TdxReadField;
  iByte, iByte1: SmallInt;
  p: Pointer;
  VerNo: Double;
  mField: TdxMemField;
  pwideCh: PChar;
  wS: PWideChar;
  
    function GetReadFieldByField(AField:TField):TdxReadField;
    var
      i:Integer;
    begin
      Result := nil;
      for i := 0 to List.Count - 1 do
        if(TdxReadField(List[i]).Field = AField) then
        begin
          Result := TdxReadField(List[i]);
          break;
        end;
    end;
  var
    mFields:TList;
  
begin
  DisableControls;
  Close;
  Open;
  fbuf := StrAlloc(255);
  Stream.Read(fbuf^, 3);
  fbuf[3] := #0;
  if fbuf = 'Ver' then
  begin
    Stream.Read(VerNo, SizeOf(Double));
    if VerNo < 1 then
      VerNo := 1;
  end else
  begin
    Stream.Position := 0;
    VerNo := 0;
  end;
  Stream.Read(Count, 4);
  List := TList.Create;
  ibuf := 0;
  for i := 0 to Count - 1 do
  begin
    if (Stream.Read(j, 4) < 4) then
      break;
    if (Stream.Read(iByte, 2) < 2) then
      break;
    if (Stream.Read(iByte1, 2) < 2) then
      break;
    if (iByte1 > 255) then
      raise Exception.Create(IncorrectedData);
    if (Stream.Read(fbuf^, iByte1) < iByte1) then
      break;
    AField := FindField(String(fbuf));
    if (AField <> nil) then
    begin
      Inc(ibuf);
      List.Add(TdxreadField.Create);
      with TdxReadField(List.Last) do
      begin
        Field := AField;
        fSize := j;
        if (fSize < AField.DataSize) then
          tSize := AField.DataSize
        else
          tSize := fSize;
        if (Field.DataType = ftWideString) then
           Buffer := StrAlloc(SizeOf(WideString))
         else  Buffer := StrAlloc(tSize + 1);
        HasValue := 1;
      end;
    end else  begin
      List.Add(TdxreadField.Create);
      with TdxReadField(List.Last) do
      begin
        Field := nil;
        fSize := j;
        buffer := nil;
        FieldTypeNo := iByte;
        DataType := GetFieldTypeByNo(iByte);
      end;
    end;
  end;
  StrDispose(fbuf);
  EOFFlag := not ((Stream.Position < Stream.Size) and (ibuf > 0));
  mFields := TList.Create;
  FLoadFlag := True;
  try
    for i := 0 to FieldCount - 1 do
      mFields.Add(FData.IndexOf(Fields[i]));
    Count := 1;
    while not EOFFlag do
    begin
      for i := 0 to List.Count - 1 do
        if not EOFFlag then
          with TdxReadField(List[i]) do
            if(Field <> nil) then begin
              if(Field.DataType in [ftString, ftWideString]) or Field.IsBlob then
              begin
                EOFFlag := Stream.Read(ibuf, 4) <> 4;
                if iBuf > 1 then
                  HasValue := 1
                else HasValue := 0;
                if not EOFFlag then
                begin
                  if not Field.IsBlob then
                  begin
                    if(Field.DataType = ftString) then
                    begin
                      if ibuf > tsize then
                      begin
                        Stream.Read(buffer^, tsize);
                        Stream.Position := Stream.Position + (ibuf-tsize);
                        EOFFlag := Stream.Position >= Stream.Size;
                      end
                      else EOFFlag := Stream.Read(buffer^, ibuf) <> ibuf;
                    end else
                    begin
                       Stream.Read(HasValue, 1);
                       if (HasValue = 1) then
                       begin
                         pwideCh := StrAlloc(ibuf * 2 + 1);
                         EOFFlag := Stream.Read(Pointer(pWideCh)^, ibuf * 2) <> ibuf * 2;
                         wS := SysAllocStringByteLen(pWideCh, ibuf * 2);
                         strDispose(pWideCh);
                         Move(wS, buffer^, SizeOf(WideString));
                       end;
                    end;
                  end else begin
                    BlobData := '';
                    if Length(BlobData) < ibuf then
                      SetLength(BlobData, ibuf);
                    EOFFlag := Stream.Read(PChar(BlobData)^, ibuf) <> ibuf
                  end;
                end;
              end else
              begin
                if VerNo > 0 then
                  Stream.Read(HasValue, 1);
                EOFFlag := Stream.Read(buffer^, fSize) <> fSize;
              end;
            end else
            begin
              if (TdxReadField(List[i]).DataType in [ftString, ftWideString, ftBlob,
              ftMemo, ftGraphic, ftFmtMemo, ftParadoxOle, ftDBaseOle, ftTypedBinary]) then
              begin
                Stream.Read(ibuf, 4);
                Stream.Position := Stream.Position + ibuf;
              end else
              begin
                if VerNo > 0 then
                  Stream.Position := Stream.Position + 1;
                Stream.Position := Stream.Position + fSize;
              end;
            end;
      if EOFFlag then
        Break;
      Data.Items[0].AddValue(@Count);
      if BlobFieldCount > 0 then
      begin
        GetMem(p, BlobFieldCount * SizeOf(Pointer));
        Initialize(PMemBlobDataArray(p)[0], BlobFieldCount);
        FBlobList.Add(p);
      end;
      j := 0;
      for i := 1 to FieldCount - 1 do
      begin
        dxrField := GetReadFieldByField(Fields[i]);
        mField := TdxMemField(mFields[i]);
        if (mField <> nil) then
        begin
          if (dxrField <> nil) and (dxrField.HasValue <> 0) then
          begin
            if (mField.FField.DataType = ftWideString) then
            begin
               mField.AddValue(PChar(PWideString(dxrField.Buffer)));
               SysFreeString(PWideChar(Pointer(dxrField.Buffer)^));
             end else
               mField.AddValue(dxrField.Buffer);
          end else
            mField.AddValue(nil);
        end else begin
          if (FBlobList.Last <> nil) and (dxrField <> nil) then
            PMemBlobDataArray(FBlobList.Last)[j] := dxrField.BlobData;
          Inc(j);
        end;
      end;
      Inc(Count);
      EOFFlag := Stream.Position >= Stream.Size;
    end;
  finally
    FLoadFlag := False;
    mFields.Free;
  end;
  FillBookmarks;
  for i := 0 to List.Count - 1 do
    with TdxReadField(List[i]) do
    begin
      if(Field <> nil) then
        StrDispose(buffer);
      Free;
    end;
  List.Free;
  MakeSort;
  UpdateFilters;
  if not FIsFiltered then
    First;
  Resync([]);
  Refresh;
  EnableControls;
end;

procedure TdxMemData.LoadFromTextFile(FileName:String);
var
  Sts: TStringList;
  St, St1: string;
  i, j, p: Integer;
  List: TList;
  Field: TField;
begin
  Sts := TStringList.Create;
  try
    Sts.LoadFromFile(FileName);
  except
    raise;
  end;
  if(Sts.Count = 0) then
  begin
    Sts.Free;
    exit;                                                                       
  end;
  FLoadFlag := True;
  DisableControls;
  Close;
  Open;
  List := TList.Create;
  St := Sts[0];
  p := 1;
  while (St <> '') and (p > 0) do
  begin
    p := Pos(FDelimiterChar, St);
    if(p = 0) then
      St1 := St
    else begin
      St1 := Copy(St, 1, p - 1);
      St :=  Copy(St, p + 1, Length(St));
    end;
    Field := FindField(St1);
    if(Field <> nil) and (Field.Calculated or Field.Lookup or Field.IsBlob) then
      Field := nil;
    List.Add(Field);
  end;
  for i := 1 to Sts.Count - 1 do
  begin
    Append;
    St := Sts[i];
    p := 1;
    j := 0;
    while (St <> '') and (p > 0) do
    begin
      p := Pos(FDelimiterChar, St);
      if(p = 0) then
        St1 := St
      else begin
        St1 := Copy(St, 1, p - 1);
        St :=  Copy(St, p + 1, Length(St));
      end;
      if(List[j] <> nil) and (St1 <> '') then
        try
          TField(List[j]).Text := St1;
        except
          List[j] := nil;
          raise;
        end;
      Inc(j);
    end;
    Post;
  end;
  FLoadFlag := False;
  First;
  MakeSort;
  EnableControls;
  List.Free;
  Sts.Free;
end;

function TdxMemData.Locate(const KeyFields:string; const KeyValues:Variant; Options:TLocateOptions): Boolean;
var
  AIndex: Integer;
begin
  AIndex := InternalLocate(KeyFields, KeyValues, Options);
  Result := AIndex > -1;
  if Result then
  begin
    Inc(AIndex);
    if RecNo <> AIndex then
      RecNo := AIndex
    else
      Resync([]);
  end;
end;

function TdxMemData.Lookup(const KeyFields:string; const KeyValues:Variant; const ResultFields:string): Variant;
var
  Field: TField;
  mField: TdxMemField;
  FLookupIndex: Integer;
begin
  Field := FindField(ResultFields);
  if (Field is TStringField) then
    Result := ''
  else
    Result := False;
  if Field <> nil  then
  begin
    FLookupIndex := InternalLocate(KeyFields, KeyValues, []);
    if FLookupIndex > -1 then
    begin
      if FIsFiltered then
        FLookupIndex := Integer(FFilterList[FLookupIndex]) - 1;
      if not (Field is TBlobField) then
      begin
        mField := FData.IndexOf(Field);
        if mField <> nil then
        begin
          if mField.HasValues[FLookupIndex] <> #0 then
            Result := GetVariantValue(mField.Values[FLookupIndex], Field.DataType)
          else
            Result := Null;
        end;
      end else
        Result := PMemBlobDataArray(FBlobList[FLookupIndex])[Field.Offset];
    end;
  end;
end;

procedure TdxMemData.MakeRecordSort;
var
  mField: TdxMemField;
  NewCurRec: Integer;
  Descdx: Integer;
  
  function GetValue(Index:Integer):PChar;
  begin
    Result := mField.Values[Index];
  end;
  
  function GetFilterValue(Index:Integer):PChar;
  begin
    Result := GetValue(Integer(FFilterList[Index]) - 1);
  end;
  
  procedure ExchangeLists;
  var
    i:Integer;
  begin
    if FIsFiltered then
    begin
      FFilterList[FFilterCurRec] := Pointer(NewCurRec + 1);
      if FCurRec < NewCurRec then
      begin
        for i := FFilterCurRec to FFilterList.Count - 2 do
        begin
          if (InternalCompareValues(GetValue(FCurRec), GetFilterValue(i + 1), mField.FDataType,
                soCaseInsensitive in SortOptions) <> DescDX) then
             break
          else FFilterList[i + 1] := Pointer(Integer(FFilterList[i + 1]) - 1);
        end
      end else
      begin
        for i := FFilterCurRec downto 1 do
          if (InternalCompareValues(GetValue(FCurRec), GetFilterValue(i - 1), mField.FDataType,
                soCaseInsensitive in SortOptions) <> DescDX * -1) then
            break
         else FFilterList[i - 1] := Pointer(Integer(FFilterList[i - 1]) + 1);
      end;
      FFilterList.Move(FFilterCurRec, i);
      FFilterCurRec := i;
    end;
    FData.FValues.Move(FCurRec, NewCurRec);
    FBookMarks.Move(FCurRec, NewCurRec);
    if FBlobList.Count > 0 then
      FBlobList.Move(FCurRec, NewCurRec);
    FCurRec := NewCurRec;
  end;
  
begin
  if FLoadFlag or not FActive or (FData.RecordCount < 2) then exit;
  if(FSortedField <> nil) then
  begin
    if not (soDesc in FSortOptions) then
      Descdx := 1
    else Descdx := -1;
    mField := FData.IndexOf(FSortedField);
    NewCurRec := -1;
    if (mField <> nil) then
    begin
      if(FCurRec > 0) and (CompareValues(GetValue(FCurRec), GetValue(FCurRec - 1), FSortedField.DataType) = -Descdx) then
        FGotoNearestMax := FCurRec - 1
      else
        if (FCurRec < FData.RecordCount - 1) then
          FGotoNearestMin := FCurRec + 1;
      GotoNearest(GetValue(FCurRec), FSortOptions, NewCurRec);
      FGotoNearestMax := -1;
      FGotoNearestMin := -1;
      if NewCurRec = -1 then
        NewCurRec := 0;
      if (fCurRec < NewCurRec)
      and (CompareValues(GetValue(NewCurRec), GetValue(FCurRec), FSortedField.DataType) = Descdx) then
        NewCurRec := NewCurRec - 1;
      if NewCurRec = -1 then
        NewCurRec := 0;
      if NewCurRec = fData.RecordCount then
        NewCurRec := fData.RecordCount - 1;
      ExchangeLists;
    end;
  end;
end;

procedure TdxMemData.MakeSort;
var
  mField: TdxMemField;
  List: TList;
begin
  FSortedField := nil;
  if FLoadFlag or (not FActive) then
    Exit;
  FSortedField := FindField(FSortedFieldName);
  if FSortedField <> nil then
  begin
    mField := FData.IndexOf(FSortedField);
    if mField <> nil then
    begin
      UpdateCursorPos;
      List := TList.Create;
      List.Add(FBookMarks);
      if FBlobList.Count > 0 then
        List.Add(FBlobList);
      try
        DoSort(FData.FValues, mField.FValueOffSet, mField.FDataSize, FSortedField.DataType, SortOptions, List);
      finally
        List.Free;
      end;
      UpdateFilters;
      if not FIsFiltered then
        SetRecNo(FCurRec+1);
      if Active then
        Resync([]);
    end;
  end;
end;

procedure TdxMemData.MoveCurRecordTo(Index:Integer);
var
  i, FRealRec, FRealIndex: Integer;
begin
  if (Index > 0) and (Index <= RecordCount) and (RecNo <> Index) then
  begin
    if not FIsFiltered then
    begin
      FRealRec := FCurRec;
      FRealIndex := Index - 1;
    end else
    begin
      FRealRec := Integer(FFilterList[FFilterCurRec]) - 1;
      FRealIndex := Integer(FFilterList[Index-1]) - 1;
    end;
    FData.FValues.Move(FRealRec, FRealIndex);
    FBookMarks.Move(FRealRec, FRealIndex);
    if FBlobList.Count > 0 then
      FBlobList.Move(FRealRec, FRealIndex);
    if FIsFiltered then
    begin
      if RecNo <  Index then
      begin
        for i := RecNo to Index-1 do
          FFilterList[i] := Pointer(Integer(FFilterList[i]) - 1);
      end else
      begin
        for i := RecNo-2 downto Index-1  do
          FFilterList[i] := Pointer(Integer(FFilterList[i]) + 1);
      end;
      FFilterList[FFilterCurRec] := Pointer(FRealIndex + 1);
      FFilterList.Move(FFilterCurRec, Index-1);
    end;
    SetRecNo(Index);
  end;
end;

procedure TdxMemData.Notification(AComponent:TComponent; Operation:TOperation);
begin
  if Active and (not (csLoading in ComponentState)) and (not (csDestroying in ComponentState)) then
  begin
    if (AComponent is TField) and (TField(AComponent).DataSet = self) then
    begin
      if(Operation = opInsert) then
        FData.AddField(AComponent as TField)
      else
      begin
        if FRecIdField = AComponent then
          FRecIdField := nil;
        FData.RemoveField(AComponent as TField);
        Indexes.RemoveField(AComponent as TField);
      end;
    end;
  end;
  inherited Notification(AComponent, Operation);
end;

procedure TdxMemData.SaveToBinaryFile(FileName:String);
var
  fMem: TMemoryStream;
begin
  if Not Active then exit;
  fMem := TMemoryStream.Create;
  SaveToStream(fMem);
  try
    fMem.SaveToFile(FileName);
  except
    raise;
  end;
  fMem.Free;
end;

procedure TdxMemData.SaveToStream(Stream:TStream);
var
  i, j, ibuf, blobIndex: Integer;
  iByte: SmallInt;
  List: TList;
  verfl: Double;
  mField: TdxMemField;
  mFields: TList;
begin
  if Not Active then exit;
  List := TList.Create;
  for i := 1 to FieldCount - 1 do
  begin
    if not Fields[i].Lookup and not Fields[i].Calculated then
      List.Add(Fields[i]);
  end;
  ibuf := List.Count;
  Stream.Write('Ver', 3);
  verfl := MemDataVer;
  Stream.Write(verfl, sizeof(Double));
  Stream.Write(ibuf, 4);
  for i := 0 to List.Count - 1 do
  begin
    if (TField(List[i]).DataType = ftWideString) then
      ibuf := TField(List[i]).Size
    else ibuf := TField(List[i]).DataSize;
    Stream.Write(ibuf, 4);
    iByte := GetNoByFieldType(TField(List[i]).DataType);
    Stream.Write(iByte, 2);
    iByte := Length(TField(List[i]).FieldName) + 1;
    Stream.Write(iByte, 2);
    Stream.Write(PChar(TField(List[i]).FieldName)^, iByte);
  end;
  mFields := TList.Create;
  try
    for j := 0 to List.Count - 1 do
      mFields.Add(FData.IndexOf(TField(List[j])));
    for i := 0 to FData.RecordCount - 1 do
    begin
      blobIndex := 0;
      for j := 0 to List.Count - 1 do
      begin
        if not TField(List[j]).IsBlob then
        begin
          mField := TdxMemField(mFields[j]);
          if (TField(List[j]).DataType in [ftString, ftWideString]) then
          begin
            if (TField(List[j]).DataType = ftString) then
            begin
              if  mField.HasValues[i] = #1 then
                iBuf := StrLen(mField.Values[i]) + 1
              else iBuf := 1;
              Stream.Write(iBuf, 4);
              Stream.Write(mField.Values[i]^, iBuf);
            end else
            begin
              if ((mField.Values[i] - 1)[0] = Char(1)) then
              begin
                iBuf := Length(PWideString(Pointer(mField.Values[i]))^);
                Stream.Write(iBuf, 4);
                Stream.Write((mField.Values[i] - 1)^, 1);
                Stream.Write(PWideString(Pointer(mField.Values[i])^)^, iBuf * 2);
              end else
              begin
                iBuf := 0;
                Stream.Write(iBuf, 4);
              end;
            end;
          end else
          begin
            Stream.Write((mField.Values[i] - 1)^, 1);
            Stream.Write(mField.Values[i]^, TField(List[j]).DataSize);
          end;
        end else
        begin
          if (PMemBlobDataArray(FBlobList[i]) <> nil) then
            iBuf := Length(PMemBlobDataArray(FBlobList[i])[blobIndex])
          else iBuf := 0;
          Stream.Write(iBuf, 4);
          if (iBuf > 0) then
            Stream.Write(PChar(PMemBlobDataArray(FBlobList[i])[blobIndex])^, iBuf);
          Inc(blobIndex);
        end;
      end;
    end;
  finally
    List.Free;
    mFields.Free;
  end;
end;

procedure TdxMemData.SaveToTextFile(FileName:String);
var
  Sts: TStringList;
  St: string;
  i: Integer;
  bm: TBookMark;
  List: TList;
begin
  if Not Active then
    Exit;
  Sts := TStringList.Create;
  List := TList.Create;
  DisableControls;
  bm := GetBookmark;
  St := '';
  for i := 0 to FieldCount - 1 do
    if not Fields[i].Calculated and not Fields[i].Lookup and not Fields[i].IsBlob then
      List.Add(Fields[i]);
  for i := 0 to List.Count - 1 do
  begin
    if i <> 0 then
      St := St + FDelimiterChar;
    St := St + TField(List[i]).FieldName;
  end;
  Sts.Add(St);
  First;
  while not EOF do
  begin
    St := '';
    for i := 0 to List.Count - 1 do
    begin
      if i <> 0 then
        St := St + FDelimiterChar;
      St := St + TField(List[i]).Text;
    end;
    Sts.Add(St);
    Next;
  end;
  GotoBookmark(bm);
  FreeBookmark(bm);
  EnableControls;
  List.Free;
  try
    Sts.SaveToFile(FileName);
  except
    raise;
  end;
  Sts.Free;
end;

procedure TdxMemData.SetBlobData(Field:TField; Buffer:PChar; const Value:TMemBlobData);
begin
  if (Buffer = ActiveBuffer) and (State <> dsFilter) then
    PMemBlobDataArray(Buffer + FRecBufSize)[Field.Offset] := Value;
end;

procedure TdxMemData.SetBookmarkData(Buffer:PChar; Data:Pointer);
begin
  PdxRecInfo(Buffer + FRecInfoOfs).Bookmark := PInteger(Data)^;
end;

procedure TdxMemData.SetBookmarkFlag(Buffer:PChar; Value:TBookmarkFlag);
begin
  PdxRecInfo(Buffer + FRecInfoOfs).BookmarkFlag := Value;
end;

procedure TdxMemData.SetFieldData(Field:TField; Buffer:Pointer);
var
  RecBuf: PChar;
begin
  if not (State in dsWriteModes) then
    DatabaseError(SNotEditing, Self);
  if not GetActiveRecBuf(RecBuf) then Exit;
  Field.Validate(Buffer);
  FData.SetActiveBuffer(RecBuf, Buffer, Field);
  if not (State in [dsCalcFields, dsFilter, dsNewValue]) then
    DataEvent(deFieldChange, Longint(Field));
end;

procedure TdxMemData.SetFieldData(Field:TField; Buffer:Pointer; NativeFormat:Boolean);
begin
  if (Field.DataType = ftWideString) then
    SetFieldData(Field, Buffer)
  else
    inherited SetFieldData(Field, Buffer, NativeFormat)
end;

procedure TdxMemData.SetFiltered(Value:Boolean);
var
  AOldFiltered: Boolean;
begin
  AOldFiltered := Filtered;
  inherited SetFiltered(Value);
  if AOldFiltered <> Filtered then
    UpdateFilters;
end;

procedure TdxMemData.SetFilteredRecNo(Value:Integer);
var
  Index: Integer;
begin
  Index := FFilterList.IndexOf(Pointer(Value));
  if Index >= 0 then
    SetRecNo(Index + 1);
end;

procedure TdxMemData.SetMemBlobData(Buffer:PChar);
var
  p: PChar;
  i, Pos: Integer;
begin
  if BlobFieldCount > 0 then
  begin
    Pos := FCurRec;
    if (Pos < 0) and (FData.RecordCount > 0) then Pos := 0
    else if Pos >= FData.RecordCount then Pos := FData.RecordCount - 1;
    if (Pos >= 0) and (Pos < FData.RecordCount) then
    begin
      p := FBlobList[Pos];
      if p = nil then
      begin
        GetMem(p, BlobFieldCount * SizeOf(Pointer));
        Initialize(PMemBlobDataArray(p)[0], BlobFieldCount);
      end;
      for i := 0 to BlobFieldCount - 1 do
        PMemBlobDataArray(p)[i] := PMemBlobDataArray(Buffer + FRecBufSize)[i];
      FBlobList[Pos] := p;
    end;
  end;
end;

procedure TdxMemData.SetOnFilterRecord(const Value:TFilterRecordEvent);
begin
  inherited SetOnFilterRecord(Value);
  UpdateFilters;
end;

procedure TdxMemData.SetRecNo(Value:Integer);
var
  NewCurRec: Integer;
begin
  if Active then
    CheckBrowseMode;
  if (Value > 0) and (Value <= FData.RecordCount) then
  begin
    DoBeforeScroll;
    if Not FIsFiltered then
      NewCurRec := Value - 1
    else begin
      FFilterCurRec := Value - 1;
      NewCurRec := Integer(FFilterList[FFilterCurRec]) - 1;
    end;
    if (NewCurRec <> FCurRec) then
    begin
      FCurRec := NewCurRec;
      Resync([rmCenter]);
      DoAfterScroll;
    end;
  end;
end;

function TdxMemData.SupportedFieldType(AType:TFieldType): Boolean;
begin
  Result := AType in [ftString, ftSmallint, ftInteger, ftWord, ftBoolean,
    ftFloat, ftCurrency, ftBCD, ftDate, ftTime, ftDateTime, ftAutoInc,
    ftBlob, ftMemo, ftGraphic, ftFmtMemo, ftParadoxOle, ftDBaseOle, ftTypedBinary, ftWideString, ftLargeInt];
end;

procedure TdxMemData.UpdateFilterRecord;
var
  Accepted: Boolean;
begin
  if not InternalIsFiltering then exit;
  Accepted := True;
  OnFilterRecord(self, Accepted);
  if not Accepted and (FFilterCurRec > -1) and (FFilterCurRec < FFilterList.Count) then
  begin
    FFilterList.Delete(FFilterCurRec);
    FIsFiltered := True;
  end;
end;

procedure TdxMemData.UpdateFilters;
var
  Accepted, OldControlsDisabled: Boolean;
  fCount: Integer;
begin
  if not Active then exit;
  OldControlsDisabled := ControlsDisabled;
  if not OldControlsDisabled then
    DisableControls;
  if not FProgrammedFilter then
  begin
    FFilterList.Clear;
    if InternalIsFiltering then
    begin
      FIsFiltered := False;
      First;
      fCount := 1;
      while not EOF do
      begin
        Accepted := True;
        OnFilterRecord(self, Accepted);
        if(Accepted) then
          FFilterList.Add(Pointer(fCount));
        Inc(fCount);
        Next;
      end;
    end;
  end;
  ClearBuffers;
  FIsFiltered := FProgrammedFilter or ((FFilterList.Count <> FData.RecordCount) and (FFilterList.Count > 0)) or InternalIsFiltering;
  if(FIsFiltered) then
  begin
    if(RecordCount > 0) then
      RecNo := 1;
    if FFilterCurRec >= FFilterList.Count then
      FFilterCurRec := FFilterList.Count -1;
    Resync([]);
  end else
    First;
  if not OldControlsDisabled then
    EnableControls;
end;

procedure TdxMemData.UpdateRecordFilteringAndSorting(AIsMakeSort:Boolean);
begin
  if (FSortedField <> nil) and AIsMakeSort then
    MakeRecordSort;
  UpdateFilterRecord;
  if (State = dsEdit) then
    Indexes.UpdateRecord(Data.FValues[fCurRec])
  else Indexes.SetIsDirty;
end;

procedure TdxMemData.SetIndexes(Value: TdxMemIndexes);
begin
  fIndexes.Assign(Value);
end;

procedure TdxMemData.SetPersistent(Value: TdxMemPersistent);
begin
  fPersistent.Assign(Value);
end;

procedure TdxMemData.SetSortedField(Value: string);
begin
  if(FSortedFieldName <> Value) then
  begin
    FSortedFieldName := Value;
    MakeSort;
  end else FSortedField := FindField(FSortedFieldName);
end;

function TdxMemData.GetSortOptions: TdxSortOptions;
begin
  Result := FSortOptions;
end;

procedure TdxMemData.SetSortOptions(Value: TdxSortOptions);
begin
  if(FSortOptions <> Value) then
  begin
    FSortOptions := Value;
    MakeSort;
  end;
end;

END.
