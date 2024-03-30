program Cliente;

uses
  Vcl.Forms,
  UCliente in 'UCliente.pas' {frmCliente};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmCliente, frmCliente);
  Application.Run;
end.
