unit Mensagem;

interface

uses
  Forms, Windows;

type
  TMensagem = class
  public
    class procedure Aviso(const aTexto: String);
    class procedure Erro(const aTexto: String);
    class procedure Informacao(const aTexto: String);
    class function Confirmacao(Texto: String): Boolean;
  end;

implementation

{ TMensagem }

class procedure TMensagem.Aviso(const aTexto: String);
begin
  Application.MessageBox(PWideChar(aTexto), 'ViaCep', MB_OK + MB_ICONWARNING);
end;

class function TMensagem.Confirmacao(Texto: String): Boolean;
begin
  Result := Application.MessageBox(PWideChar(Texto), 'ViaCep',
    MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2) = IDYES;
end;

class procedure TMensagem.Erro(const aTexto: String);
begin
  Application.MessageBox(PWideChar(aTexto), 'ViaCep', MB_OK + MB_ICONERROR);
end;

class procedure TMensagem.Informacao(const aTexto: String);
begin
  Application.MessageBox(PWideChar(aTexto), 'ViaCep',
    MB_OK + MB_ICONINFORMATION);
end;

end.
