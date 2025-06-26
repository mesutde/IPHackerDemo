program IPHackerDemo;

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {FormMain},
  uIPHackerHelper in 'uIPHackerHelper.pas',
  uGridSaver in 'uGridSaver.pas',
  uRunIPHacker in 'uRunIPHacker.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.