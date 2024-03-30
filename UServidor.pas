{
  >>>>>>>>La aplicación se trata de generar un test o prueba<<<<<<<<<<<<<<<
  El funcinamiento del servidor:
  El servidor envia las preguntas al cliente, espera sus respuestas y las valida.
  Una vez que se han enviado todas las preguntas,
  se finaliza la prueba y se informa el su resultado.
}
unit UServidor;

interface

// Se declara las librerias que va a hacer uso la aplicación
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Win.ScktComp, Vcl.StdCtrls,
  Vcl.ExtCtrls;

type
  TClienteInfo = record
    { Se crea un conjunto de datos de tipo "Record" en el cual vamos a manejar
      los clientes que se conecten al servidor, ya que vamos a manejar varios
      clientes usando una sola instancia de servidor. }
    Socket: TCustomWinSocket;
    { TCustomWinSocket :Son propiedades, eventos y métodos para describir un
      punto final en una conexión de socket de Windows.
      Socket: es la variable donde se guarda la conexion establecida
      por el cliente }
    PreguntaActual: Integer;
    // Almacena la pregunta en la que el cliente se encuentra.
    RespuestasCorrectas: Integer;
    // Cada vez que el usuario envía una respuesta correcta, se almacena.
  end;

type

  TfrmServidor = class(TForm)
    // Creamos la clase que va a tener los objetos a manipular

    Memo1: TMemo;
    // TMemo es un contenedor para un control de edición multilínea de Windows.

    ServerSocket1: TServerSocket;
    { TServerSocket: permiten especificar el servicio que está proporcionando
      o el puerto que desea utilizar para escuchar y aceptar solicitudes de
      conexión de clientes. }

    procedure FormCreate(Sender: TObject);
    // Evento que se dispara al crear el formulario.

    procedure ServerSocket1ClientRead(Sender: TObject;
      Socket: TCustomWinSocket);
    // Evento que controla las solicitudes del cliente.

    procedure ServerSocket1ClientConnect(Sender: TObject;
      Socket: TCustomWinSocket);
    // Evento que controla cuando un cliente nuevo se conecta.

    procedure ServerSocket1ClientDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    // Evento que controla cuando un cliente se desconecta.

  private
    { Aquí se encuentran declaradas variables, funciones y procedimientos que
      son privados y no pueden ser usados por otras instancias.
    }

    ListaClientes: array of TClienteInfo;
    // ListaClientes: Es un arreglo de tipo TClienteInfo donde se encuentran
    // todos los clientes conectados.

    Preguntas: array [1 .. 5] of string;
    Respuestas: array [1 .. 5] of string;
    // Creamos un arreglo de string con una dimensión de 5 posiciones y este no
    // inicia en la posición 0.

    procedure IniciarRespuestas;
    procedure IniciarPreguntas;
    // Llenan los arreglos de las "Preguntas" y "Respuestas" del test.

    procedure EnviarPregunta(ClientIndex: Integer);
    // Dependiendo de la pregunta en la que se encuentre el cliente,
    // se le envía una nueva pregunta.

    procedure VerificarRespuestas(ClientIndex: Integer);
    // Al finalizar, se le indica al usuario que terminó el test y
    // la calificación obtenida.
  public
    { Aquí se encuentran declarado variables, funciones y procedimientos que
      son publicos y pueden ser usados por otras instancias }

  end;

var
  frmServidor: TfrmServidor;

  // Aquí inicia la implementación de declaraciones para la clase.
implementation

{$R *.dfm}

procedure TfrmServidor.FormCreate(Sender: TObject);
// Inicializa el arreglo "Respuestas" y "Preguntas" con las respuestas correctas.
// Se abre Socket y se deja log.
begin
  SetLength(ListaClientes, 0);
  // Se inicializa el arreglo ListaClientes con un tamaño de 0 posiciones.

  IniciarRespuestas;
  IniciarPreguntas;

  ServerSocket1.Active := True;
  // Subimos el servidor y abrimos el Socket.

  Memo1.Lines.Add('Servidor corriendo...');
end;

procedure TfrmServidor.IniciarRespuestas;
begin
  // Como podemos evidenciar, el arreglo inicia en la posición 1 ya que lo declaramos
  // para que inicie en esa posición.
  Respuestas[1] := '5';
  Respuestas[2] := '8';
  Respuestas[3] := '2';
  Respuestas[4] := '2';
  Respuestas[5] := '9';
end;

procedure TfrmServidor.IniciarPreguntas;
begin
  // Como podemos evidenciar, el arreglo inicia en la posición 1 ya que lo declaramos
  // para que inicie en esa posición.
  Preguntas[1] := 'Dividir 10 entre 2';
  Preguntas[2] := 'Sumar 5, 3';
  Preguntas[3] := 'Raiz cuadrada 4';
  Preguntas[4] := 'Factorial de 2';
  Preguntas[5] := 'Multiplicar 3 por 3';
end;

procedure TfrmServidor.ServerSocket1ClientConnect(Sender: TObject;
  Socket: TCustomWinSocket);
// Cada vez que se conecta un cliente, se le asigna una posición dentro
// de "ListaClientes" y se genera el log.
var
  Index: Integer;
begin
  Index := Length(ListaClientes);
  // Se obtiene la dimensión actual de "ListaClientes".

  SetLength(ListaClientes, Index + 1);
  // Se aumenta el tamaño de "ListaClientes".

  ListaClientes[Index].Socket := Socket;
  ListaClientes[Index].PreguntaActual := 1;
  ListaClientes[Index].RespuestasCorrectas := 0;
  // Ingresamos al arreglo el nuevo cliente.

  Memo1.Lines.Add('Un Nuevo cliente conectado: ' + Index.ToString);

end;

procedure TfrmServidor.ServerSocket1ClientDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
var
  i: Integer;
begin
  // Recorremos el arreglo "ListaClientes" desde el tamaño más
  // pequeño al más grande y validamos qué cliente se desconectó.
  begin
    if ListaClientes[i].Socket = Socket then
    begin
      Memo1.Lines.Add('Client disconnected:' + i.ToString);
      Exit;
    end;
  end;
end;

procedure TfrmServidor.ServerSocket1ClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
var
  i: Integer;
  DatosRecibidos: AnsiString;
begin

  for i := Low(ListaClientes) to High(ListaClientes) do
  // Recorremos todos los clientes para saber cuál nos está respondiendo.
  begin
    if ListaClientes[i].Socket = Socket then
    // Validamos que el Socket que entra sea el mismo que se encuentra en
    // "ListaClientes".
    begin
      DatosRecibidos := Socket.ReceiveText;
      // Almacenamos el resultado enviado por el cliente.

      if DatosRecibidos <> 'Inicia test' then
      // Validamos que el dato sea diferente a iniciar el test.
      begin
        Memo1.Lines.Add(i.ToString + ' Cliente. Dio respuesta:' +
          IntToStr(ListaClientes[i].PreguntaActual) + ': ' + DatosRecibidos);
        // Almacenamos la respuesta enviada por el cliente.

        if Respuestas[ListaClientes[i].PreguntaActual] = DatosRecibidos then
        // Validamos que la respuesta en la que se encuentra el cliente
        // sea correcta.
        begin
          Inc(ListaClientes[i].RespuestasCorrectas);
        end;

        Inc(ListaClientes[i].PreguntaActual);
        // Procedemos a aumentar "PreguntaActual" para que continúe con la siguiente.
      end;
      EnviarPregunta(i);
      Exit;
      // Terminamos de recorrer el for si ya encontramos la posición del socket, pero antes se le envía la siguiente pregunta.
    end;
  end;
end;

procedure TfrmServidor.EnviarPregunta(ClientIndex: Integer);
// Dependiendo del cliente que envió la respuesta a la pregunta,
// se valida si necesita otra pregunta o ya terminó el test.
begin
  if ListaClientes[ClientIndex].PreguntaActual <= 5 then
  // Si las preguntas son menores o iguales a 5, se debe seguir enviando
  // preguntas al cliente.
  begin
    ListaClientes[ClientIndex].Socket.SendText
      (Preguntas[ListaClientes[ClientIndex].PreguntaActual] +
      ': Cual es la respuesta?');
  end
  else
  begin
    // De lo contrario, se debe finalizar el test y calificarlo.
    Memo1.Lines.Add('Todas las preguntas respuestas. por el cliente' +
      ClientIndex.ToString);
    VerificarRespuestas(ClientIndex);
  end;
end;

procedure TfrmServidor.VerificarRespuestas(ClientIndex: Integer);
// Procedemos a enviar la respuesta al cliente de su test
// y terminamos el intento.
begin

  ListaClientes[ClientIndex].Socket.SendText
    ('Cuestionario finalizado. ¡Gracias por responder! Su calificación es:' +
    #13 + ListaClientes[ClientIndex].RespuestasCorrectas.ToString + '.0');

  Memo1.Lines.Add('Calificación: ' + ListaClientes[ClientIndex]
    .RespuestasCorrectas.ToString + '.0');
  ListaClientes[ClientIndex].Socket.Disconnect(0);
  ListaClientes[ClientIndex].RespuestasCorrectas := 0;
  ListaClientes[ClientIndex].PreguntaActual := 1;

end;

end.
