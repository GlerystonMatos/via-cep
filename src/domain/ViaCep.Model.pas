unit ViaCep.Model;

interface

uses
  Endereco.Base.Model;

type
  TViaCep = class(TEnderecoBase)
  public
    function ToString: string; override;
  end;

implementation

{ TViaCep }

function TViaCep.ToString: string;
begin
  Result :=
    'CEP: ' + CEP + sLineBreak +
    'Logradouro: ' + Logradouro + sLineBreak +
    'Complemento: ' + Complemento + sLineBreak +
    'Unidade: ' + Unidade + sLineBreak +
    'Bairro: ' + Bairro + sLineBreak +
    'Localidade: ' + Localidade + sLineBreak +
    'UF: ' + UF + sLineBreak +
    'Estado: ' + Estado + sLineBreak +
    'Região: ' + Regiao + sLineBreak +
    'IBGE: ' + IBGE + sLineBreak +
    'GIA: ' + GIA + sLineBreak +
    'DDD: ' + DDD + sLineBreak +
    'SIAFI: ' + SIAFI;
end;

end.
