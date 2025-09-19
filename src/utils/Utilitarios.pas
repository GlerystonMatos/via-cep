unit Utilitarios;

interface

uses
  System.SysUtils, System.RegularExpressions;

type
  TUtilitarios = class
  public
    class function ValidarCEP(const aCEP: string): Boolean;
    class function ObterUFPorIndice(const aIndex: Integer): string;
    class function RemoverEspacos(const aString: string): string;
    class function FormatarCEP(const aCEP: string): string;
  end;

implementation

{ TUtilitarios }

class function TUtilitarios.RemoverEspacos(const aString: string): string;
var
  Resultado: string;
begin
  Resultado := Trim(aString);
  Resultado := StringReplace(Resultado, ' ', '', [rfReplaceAll]);

  Result := Resultado;
end;

class function TUtilitarios.ValidarCEP(const aCEP: string): Boolean;
var
  Cep: string;
begin
  Cep := StringReplace(aCEP, '-', '', [rfReplaceAll]);
  Cep := StringReplace(Cep, '.', '', [rfReplaceAll]);
  Cep := Trim(Cep);

  Result := TRegEx.IsMatch(Cep, '^\d{8}$');
end;

class function TUtilitarios.ObterUFPorIndice(const aIndex: Integer): string;
const
  UFs: array [0 .. 26] of string = ('AC', 'AL', 'AM', 'AP', 'BA', 'CE', 'DF',
    'ES', 'GO', 'MA', 'MG', 'MS', 'MT', 'PA', 'PB', 'PE', 'PI', 'PR', 'RJ',
    'RN', 'RO', 'RR', 'RS', 'SC', 'SE', 'SP', 'TO');
begin
  if (aIndex >= Low(UFs)) and (aIndex <= High(UFs)) then
    Result := UFs[aIndex]
  else
    raise Exception.CreateFmt('Índice inválido: %d', [aIndex]);
end;

class function TUtilitarios.FormatarCEP(const aCEP: string): string;
var
  Cep: string;
begin
  Cep := StringReplace(aCEP, '-', '', [rfReplaceAll]);
  Cep := StringReplace(Cep, '.', '', [rfReplaceAll]);
  Cep := Trim(Cep);

  if (Length(Cep) = 8) then
    Result := Copy(Cep, 1, 5) + '-' + Copy(Cep, 6, 3)
  else
    Result := aCEP;
end;

end.
