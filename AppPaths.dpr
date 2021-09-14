program AppPaths;

uses
  System.StartUpCopy,
  FMX.Forms,
  ufrmAppPaths in 'ufrmAppPaths.pas' {frmAppPaths},
  uOpenURL in 'uOpenURL.pas',
  uSearchRecList in 'uSearchRecList.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmAppPaths, frmAppPaths);
  Application.Run;
end.
