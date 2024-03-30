object frmCliente: TfrmCliente
  Left = 0
  Top = 0
  Caption = 'Cliente'
  ClientHeight = 242
  ClientWidth = 781
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object LblPregunta: TLabel
    Left = 0
    Top = 0
    Width = 781
    Height = 24
    Align = alTop
    Alignment = taCenter
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    ExplicitWidth = 6
  end
  object BtnIniciarPrueba: TButton
    Left = 0
    Top = 194
    Width = 781
    Height = 48
    Align = alBottom
    Caption = 'Iniciar prueba'
    TabOrder = 0
    OnClick = BtnIniciarPruebaClick
  end
  object EdRespuesta: TEdit
    AlignWithMargins = True
    Left = 20
    Top = 44
    Width = 741
    Height = 32
    Margins.Left = 20
    Margins.Top = 20
    Margins.Right = 20
    Align = alTop
    Alignment = taCenter
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    MaxLength = 1
    ParentFont = False
    TabOrder = 1
    OnKeyPress = EdRespuestaKeyPress
  end
  object BtnEnviarRespuesta: TButton
    Left = 336
    Top = 115
    Width = 121
    Height = 49
    Caption = 'Enviar Respuesta'
    TabOrder = 2
    OnClick = BtnEnviarRespuestaClick
  end
  object ClientSocket1: TClientSocket
    Active = False
    ClientType = ctNonBlocking
    Host = '127.0.0.1'
    Port = 8080
    OnConnect = ClientSocket1Connect
    OnRead = ClientSocket1Read
    Left = 80
    Top = 8
  end
end
