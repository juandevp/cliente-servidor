{
  >>>>>>>>La aplicación se trata de generar un test o prueba<<<<<<<<<<<<<<<
  El funcinamiento del cliente:
  El cliente envia las respuestas al Servidor, espera las preguntas y envia las respuestas.
  Una vez que se han enviado todas las respuestas,
  se finaliza la prueba y se informa el su resultado.
}
unit UCliente;

interface

// Se declara las librerias que va a hacer uso la aplicación
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.Win.ScktComp;

type
  TfrmCliente = class(TForm)
    // Creamos la clase que va a tener los objetos a manipular

    ClientSocket1: TClientSocket;
    // Gestiona conexiones de socket para un servidor TCP/IP.

    BtnEnviarRespuesta: TButton;
    BtnIniciarPrueba: TButton;
    // Botones
    LblPregunta: TLabel;
    // Textos
    EdRespuesta: TEdit;
    // Cuadros de edición

    procedure BtnIniciarPruebaClick(Sender: TObject);
    // Evento clic del botón que inicia la prueba y realiza
    // la conexión con el servidor.

    procedure ClientSocket1Read(Sender: TObject; Socket: TCustomWinSocket);
    // Evento que controla los datos enviados por el servidor

    procedure BtnEnviarRespuestaClick(Sender: TObject);
    // Evento clic de botón que envia la respuesta a las preguntas

    procedure ClientSocket1Connect(Sender: TObject; Socket: TCustomWinSocket);
    // Evento Indica que la conexión se inicio

    procedure EdRespuestaKeyPress(Sender: TObject; var Key: Char);
    // Evento que captura las entradas del teclado

  end;

var
  frmCliente: TfrmCliente;

implementation

{$R *.dfm}

procedure TfrmCliente.BtnIniciarPruebaClick(Sender: TObject);
begin
  ClientSocket1.Active := True;
  // Se establece conexión con el servidor
end;

procedure TfrmCliente.BtnEnviarRespuestaClick(Sender: TObject);
// Se envía la respuesta ingresada en el cuadro de texto
begin
  ClientSocket1.Socket.SendText(EdRespuesta.Text);
  EdRespuesta.Clear;
end;

procedure TfrmCliente.ClientSocket1Connect(Sender: TObject;
  Socket: TCustomWinSocket);
// Si la conexión se establece con exito se le indica al servidor que
// el cliente puede iniciar a responder el test
begin
  ClientSocket1.Socket.SendText('Inicia test');
end;

procedure TfrmCliente.ClientSocket1Read(Sender: TObject;
  Socket: TCustomWinSocket);
// Obtiene los mensajes enviados por el servidor y se los muestra al usario
var
  Response: string;
begin
  Response := Socket.ReceiveText;
  LblPregunta.Caption := Response;
end;

procedure TfrmCliente.EdRespuestaKeyPress(Sender: TObject; var Key: Char);
begin
  // Validamos que lo que se ingrese en "EdRespuesta" solo sea números y chr(8)
  // es la tecla "BackSpace"
  if (StrScan('0123456789' + chr(8), Key) = nil) then
    Key := #0;
end;

end.
