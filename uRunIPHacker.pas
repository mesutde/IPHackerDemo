unit uRunIPHacker;

interface

uses
  System.SysUtils, System.Classes, Vcl.Grids;

procedure RunIPHackerWithIP(const ExePath, IP: string; GridTrue, GridFalse: TStringGrid);

implementation

uses
  Winapi.Windows, System.JSON;

function GetJSONStringSafe(Json: TJSONObject; const Key: string): string;
var
  Val: TJSONValue;
begin
  Val := Json.GetValue(Key);
  if (Val <> nil) and (Val is TJSONString) then
    Result := TJSONString(Val).Value
  else
    Result := '';
end;

function GetRegionValue(Json: TJSONValue; const Key: string): string;
begin
  if (Json <> nil) and (Json is TJSONObject) then
    Result := GetJSONStringSafe(Json as TJSONObject, Key)
  else
    Result := '';
end;

procedure RunIPHackerWithIP(const ExePath, IP: string; GridTrue, GridFalse: TStringGrid);
var
  CmdLine: string;
  SA: TSecurityAttributes;
  SI: TStartupInfo;
  PI: TProcessInformation;
  StdOutRead, StdOutWrite: THandle;
  Buffer: array[0..4095] of AnsiChar;
  BytesRead: DWORD;
  RawOutput: AnsiString;
  JSONVal: TJSONValue;
  JSONArray: TJSONArray;
  JSONObject: TJSONObject;
  RegionObj: TJSONValue;
  Provider, RealIP, Country, City: string;
  Success: Boolean;
  I, NoTrue, NoFalse: Integer;
begin
  CmdLine := Format('"%s" --set-ip %s --json', [ExePath, IP]);

  ZeroMemory(@SA, SizeOf(SA));
  SA.nLength := SizeOf(SA);
  SA.bInheritHandle := True;

  if not CreatePipe(StdOutRead, StdOutWrite, @SA, 0) then
    RaiseLastOSError;

  try
    ZeroMemory(@SI, SizeOf(SI));
    SI.cb := SizeOf(SI);
    SI.dwFlags := STARTF_USESTDHANDLES or STARTF_USESHOWWINDOW;
    SI.hStdOutput := StdOutWrite;
    SI.hStdError := StdOutWrite;
    SI.wShowWindow := SW_HIDE;

    ZeroMemory(@PI, SizeOf(PI));

    if not CreateProcess(nil, PChar(CmdLine), nil, nil, True, 0, nil, nil, SI, PI) then
      RaiseLastOSError;

    CloseHandle(StdOutWrite);

    RawOutput := '';
    while ReadFile(StdOutRead, Buffer, SizeOf(Buffer), BytesRead, nil) and (BytesRead > 0) do
      RawOutput := RawOutput + Copy(Buffer, 1, BytesRead);

    JSONVal := TJSONObject.ParseJSONValue(UTF8ToString(RawOutput));
    if not (JSONVal is TJSONArray) then
    begin
    //  ShowMessage('Geçerli bir JSON dizisi deðil!');
      Exit;
    end;

    JSONArray := TJSONArray(JSONVal);

    // Grid baþlýklarý
    GridTrue.RowCount := 1;
    GridTrue.ColCount := 6;
    GridTrue.Cells[0, 0] := 'No';
    GridTrue.Cells[1, 0] := 'Saðlayýcý';
    GridTrue.Cells[2, 0] := 'IP';
    GridTrue.Cells[3, 0] := 'Ülke';
    GridTrue.Cells[4, 0] := 'Þehir';
    GridTrue.Cells[5, 0] := 'Baþarýlý mý?';

    GridFalse.RowCount := 1;
    GridFalse.ColCount := 3;
    GridFalse.Cells[0, 0] := 'No';
    GridFalse.Cells[1, 0] := 'Saðlayýcý';
    GridFalse.Cells[2, 0] := 'Baþarýlý mý?';

    NoTrue := 1;
    NoFalse := 1;

    for I := 0 to JSONArray.Count - 1 do
    begin
      JSONObject := JSONArray.Items[I] as TJSONObject;
      Success := JSONObject.GetValue('success') is TJSONTrue;

      Provider := GetJSONStringSafe(JSONObject, 'provider');
      RealIP := GetJSONStringSafe(JSONObject, 'ip');
      RegionObj := JSONObject.GetValue('region');
      Country := GetRegionValue(RegionObj, 'country');
      City := GetRegionValue(RegionObj, 'city');

      if Success then
      begin
        GridTrue.RowCount := GridTrue.RowCount + 1;
        GridTrue.Cells[0, GridTrue.RowCount - 1] := NoTrue.ToString;
        GridTrue.Cells[1, GridTrue.RowCount - 1] := Provider;
        GridTrue.Cells[2, GridTrue.RowCount - 1] := RealIP;
        GridTrue.Cells[3, GridTrue.RowCount - 1] := Country;
        GridTrue.Cells[4, GridTrue.RowCount - 1] := City;
        GridTrue.Cells[5, GridTrue.RowCount - 1] := 'True';
        Inc(NoTrue);
      end
      else
      begin
        GridFalse.RowCount := GridFalse.RowCount + 1;
        GridFalse.Cells[0, GridFalse.RowCount - 1] := NoFalse.ToString;
        GridFalse.Cells[1, GridFalse.RowCount - 1] := Provider;
        GridFalse.Cells[2, GridFalse.RowCount - 1] := 'False';
        Inc(NoFalse);
      end;
    end;

    WaitForSingleObject(PI.hProcess, INFINITE);
    CloseHandle(PI.hProcess);
    CloseHandle(PI.hThread);
  finally
    CloseHandle(StdOutRead);
  end;
end;

end.

