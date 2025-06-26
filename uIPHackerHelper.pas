unit uIPHackerHelper;

interface

uses
  System.SysUtils, System.Classes, System.JSON, Vcl.Grids;

procedure RunIPHackerAndFillGrids(const ExePath: string; GridTrue, GridFalse: TStringGrid);

implementation

uses
  Winapi.Windows;

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

procedure RunIPHackerAndFillGrids(const ExePath: string; GridTrue, GridFalse: TStringGrid);
var
  Output: TStringList;
  SA: TSecurityAttributes;
  SI: TStartupInfo;
  PI: TProcessInformation;
  StdOutRead, StdOutWrite: THandle;
  Buffer: array[0..4095] of AnsiChar;
  BytesRead: DWORD;
  JSONArr: TJSONArray;
  JSONObj: TJSONObject;
  RegionObj: TJSONValue;
  Success: Boolean;
  IP, Provider, Country, City: string;
  I, NoTrue, NoFalse: Integer;
  RawOutput: AnsiString;
begin
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

    if not CreateProcess(nil, PChar(ExePath + ' --json'), nil, nil, True, 0, nil, nil, SI, PI) then
      RaiseLastOSError;

    CloseHandle(StdOutWrite);

    Output := TStringList.Create;
    try
      RawOutput := '';
      while ReadFile(StdOutRead, Buffer, SizeOf(Buffer), BytesRead, nil) and (BytesRead > 0) do
        RawOutput := RawOutput + Copy(Buffer, 0, BytesRead);

      Output.Text := UTF8ToString(RawOutput);  // Türkçe karakter desteði

      JSONArr := TJSONObject.ParseJSONValue(Output.Text) as TJSONArray;
      if JSONArr = nil then
        Exit;

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

      for I := 0 to JSONArr.Count - 1 do
      begin
        JSONObj := JSONArr.Items[I] as TJSONObject;
        Success := JSONObj.GetValue('success') is TJSONTrue;

        Provider := GetJSONStringSafe(JSONObj, 'provider');
        IP := GetJSONStringSafe(JSONObj, 'ip');
        RegionObj := JSONObj.GetValue('region');
        Country := GetRegionValue(RegionObj, 'country');
        City := GetRegionValue(RegionObj, 'city');

        if Success then
        begin
          GridTrue.RowCount := GridTrue.RowCount + 1;
          GridTrue.Cells[0, GridTrue.RowCount - 1] := NoTrue.ToString;
          GridTrue.Cells[1, GridTrue.RowCount - 1] := Provider;
          GridTrue.Cells[2, GridTrue.RowCount - 1] := IP;
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

    finally
      Output.Free;
    end;

    WaitForSingleObject(PI.hProcess, INFINITE);
    CloseHandle(PI.hProcess);
    CloseHandle(PI.hThread);
  finally
    CloseHandle(StdOutRead);
  end;
end;

end.

