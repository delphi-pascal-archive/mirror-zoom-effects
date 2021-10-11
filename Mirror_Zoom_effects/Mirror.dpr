program Mirror;

uses
  Forms,
  UMiroir in 'UMiroir.pas' {frmMain};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
