unit uGridSaver;

interface

uses
  System.SysUtils, System.Classes, Vcl.Grids, System.IOUtils, Vcl.Forms, Vcl.Dialogs,ShellAPI,Windows;

procedure SaveTxt(Grid: TStringGrid; const FilePrefix: string);
procedure SaveCsv(Grid: TStringGrid; const FilePrefix: string);
procedure SaveGridToFile(Grid: TStringGrid; const FilePrefix, Ext: string; const Separator: string);


implementation

procedure OpenSaveFolder;
var
  FolderPath: string;
begin
  FolderPath := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)) + 'SaveFile');
  ShellExecute(0, 'open', PChar(FolderPath), nil, nil, SW_SHOWNORMAL);
end;


procedure SaveGridToFile(Grid: TStringGrid; const FilePrefix, Ext: string; const Separator: string);
var
  SaveDir, FileName, Line: string;
  SL: TStringList;
  Row, Col: Integer;
  DateStr, TimeStr: string;
begin
  if (Grid = nil) or (Grid.RowCount <= 1) then
  begin
    MessageDlg('Veri bulunamadý!', mtWarning, [mbOK], 0);
    Exit;
  end;

  SaveDir := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName)) + 'SaveFile';

  if not TDirectory.Exists(SaveDir) then
    TDirectory.CreateDirectory(SaveDir);

  DateStr := FormatDateTime('dd-mm-yyyy', Now);
  TimeStr := FormatDateTime('hh-nn-ss', Now);

  FileName := Format('%s_%s_%s.%s', [FilePrefix, DateStr, TimeStr, Ext]);
  FileName := TPath.Combine(SaveDir, FileName);

  SL := TStringList.Create;
  try
    for Row := 0 to Grid.RowCount - 1 do
    begin
      Line := '';
      for Col := 0 to Grid.ColCount - 1 do
      begin
        Line := Line + Grid.Cells[Col, Row];
        if Col < Grid.ColCount - 1 then
          Line := Line + Separator;
      end;
      SL.Add(Line);
    end;

    SL.SaveToFile(FileName, TEncoding.UTF8);
    MessageDlg('Dosya baþarýyla kaydedildi: ' + FileName, mtInformation, [mbOK], 0);
      OpenSaveFolder;
  finally
    SL.Free;
  end;
end;

procedure SaveTxt(Grid: TStringGrid; const FilePrefix: string);
begin
  SaveGridToFile(Grid, FilePrefix, 'txt', #9); // tab delimited

end;

procedure SaveCsv(Grid: TStringGrid; const FilePrefix: string);
begin
  SaveGridToFile(Grid, FilePrefix, 'csv', ';'); // CSV with semicolon

end;

end.

