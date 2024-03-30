object frmServidor: TfrmServidor
  Left = 0
  Top = 0
  Caption = 'frmServidor'
  ClientHeight = 282
  ClientWidth = 281
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 281
    Height = 282
    Align = alClient
    Lines.Strings = (
      'Memo1')
    TabOrder = 0
    ExplicitWidth = 635
    ExplicitHeight = 280
  end
  object ServerSocket1: TServerSocket
    Active = False
    Port = 8080
    ServerType = stNonBlocking
    OnClientConnect = ServerSocket1ClientConnect
    OnClientDisconnect = ServerSocket1ClientDisconnect
    OnClientRead = ServerSocket1ClientRead
    Left = 16
    Top = 16
  end
end
