program Servidor;

uses
  Vcl.Forms,
  UServidor in 'UServidor.pas' {frmServidor};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmServidor, frmServidor);
  Application.Run;
end.
