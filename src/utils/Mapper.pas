unit Mapper;

interface

uses
  Endereco.Base.Model, Endereco.Model;

type
  TMapper = class
  public
    class function BaseToEndereco(const aEndereco: TEnderecoBase): TEndereco;
  end;

implementation

class function TMapper.BaseToEndereco(const aEndereco: TEnderecoBase): TEndereco;
begin
  Result := TEndereco.Create;

  Result.CEP := aEndereco.CEP;
  Result.Logradouro := aEndereco.Logradouro;
  Result.Complemento := aEndereco.Complemento;
  Result.Unidade := aEndereco.Unidade;
  Result.Bairro := aEndereco.Bairro;
  Result.Localidade := aEndereco.Localidade;
  Result.UF := aEndereco.UF;
  Result.Estado := aEndereco.Estado;
  Result.Regiao := aEndereco.Regiao;
  Result.IBGE := aEndereco.IBGE;
  Result.GIA := aEndereco.GIA;
  Result.DDD := aEndereco.DDD;
  Result.SIAFI := aEndereco.SIAFI;
end;

end.
