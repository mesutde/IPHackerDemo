unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls,
  uIPHackerHelper,uGridSaver, Vcl.Buttons, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.TabNotBk,uRunIPHacker, Vcl.Mask,System.RegularExpressions;

type
  TFormMain = class(TForm)
    btnGetIPs: TButton;
    sgIPList: TStringGrid;
    sgIPListFalse: TStringGrid;
    btnSaveTxt: TBitBtn;
    btnSaveCsv: TBitBtn;
    btnSaveTxtFalse: TBitBtn;
    btnSaveCsvFalse: TBitBtn;
    btnRunIPHackerWithInput: TBitBtn;
    edtIPMask: TEdit;
    Memo1: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure btnGetIPsClick(Sender: TObject);
    procedure btnSaveTxtClick(Sender: TObject);
    procedure btnSaveCsvClick(Sender: TObject);
    procedure btnSaveCsvFalseClick(Sender: TObject);
    procedure btnSaveTxtFalseClick(Sender: TObject);
    procedure btnRunIPHackerWithInputClick(Sender: TObject);

  private
    procedure SetupGrids;
  public
  end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

function IsValidIPv4(const IP: string): Boolean;
begin
  Result := TRegEx.IsMatch(IP,
    '^((25[0-5]|2[0-4][0-9]|1\d\d|[1-9]?\d)\.){3}' +
    '(25[0-5]|2[0-4][0-9]|1\d\d|[1-9]?\d)$');
end;


procedure TFormMain.btnRunIPHackerWithInputClick(Sender: TObject);
begin
    if IsValidIPv4(Trim(edtIPMask.Text)) then
         RunIPHackerWithIP(ExtractFilePath(Application.ExeName) + 'Tool\IP-Hacker.exe',Trim(edtIPMask.Text), sgIPList, sgIPListFalse)
    else
      ShowMessage('Geçersiz IP!');
end;

procedure TFormMain.btnSaveCsvClick(Sender: TObject);
begin
  SaveGridToFile(sgIPList, 'IPHackerIsTrue', 'csv', ';'); // CSV with semicolon
end;

procedure TFormMain.btnSaveCsvFalseClick(Sender: TObject);
begin
  SaveGridToFile(sgIPListFalse, 'IPHackerIsFalse', 'csv', ';'); // CSV with semicolon
end;

procedure TFormMain.btnSaveTxtClick(Sender: TObject);
begin
    SaveGridToFile(sgIPList, 'IPHackerIsTrue', 'txt', #9); // tab delimited
end;

procedure TFormMain.btnSaveTxtFalseClick(Sender: TObject);
begin
      SaveGridToFile(sgIPListFalse, 'IPHackerIsFalse', 'txt', #9); // tab delimited
end;

procedure TFormMain.FormCreate(Sender: TObject);
begin

  sgIPList.Font.Name := 'Segoe UI';
  sgIPListFalse.Font.Name := 'Segoe UI';

  SetupGrids;

  sgIPList.ColWidths[0] := 30;   // No
  sgIPList.ColWidths[1] := 160;  // Sağlayıcı
  sgIPList.ColWidths[2] := 80;   // IP
  sgIPList.ColWidths[3] := 60;   // Ülke
  sgIPList.ColWidths[4] := 80;   // Şehir
  sgIPList.ColWidths[5] := 80;   // Başarılı mı?

  sgIPListFalse.ColWidths[0] := 30;   // No
  sgIPListFalse.ColWidths[1] := 160;  // Sağlayıcı
  sgIPListFalse.ColWidths[2] := 80;   // Başarılı mı?
end;

procedure TFormMain.SetupGrids;
begin
  sgIPList.RowCount := 1;
  sgIPList.ColCount := 6;
  sgIPList.Cells[0, 0] := 'No';
  sgIPList.Cells[1, 0] := 'Sağlayıcı';
  sgIPList.Cells[2, 0] := 'IP';
  sgIPList.Cells[3, 0] := 'Ülke';
  sgIPList.Cells[4, 0] := 'Şehir';
  sgIPList.Cells[5, 0] := 'Başarılı mı?'; // <-- Buradaki indeks 5 olmalı, 6 değil!

  sgIPListFalse.RowCount := 1;
  sgIPListFalse.ColCount := 3;
  sgIPListFalse.Cells[0, 0] := 'No';          // <-- No sütunu eklenmiş olmalı
  sgIPListFalse.Cells[1, 0] := 'Sağlayıcı';
  sgIPListFalse.Cells[2, 0] := 'Başarılı mı?';
end;

procedure TFormMain.btnGetIPsClick(Sender: TObject);
var
  IPHackerExePath: string;
begin
  IPHackerExePath := ExtractFilePath(Application.ExeName) + 'Tool\IP-Hacker.exe';

  try
    RunIPHackerAndFillGrids(IPHackerExePath, sgIPList, sgIPListFalse);
  except
    on E: Exception do
      ShowMessage('IP-Hacker çalıştırılırken hata oluştu: ' + E.Message);
  end;
end;

end.
