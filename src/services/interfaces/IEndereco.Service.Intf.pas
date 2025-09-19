unit IEndereco.Service.Intf;

interface

uses
  Endereco.Model, System.Generics.Collections;

type
  IEnderecoService = interface
    ['{A3DFC03D-8895-43EA-81CC-036BD8BA9B98}']
    function Pesquisar(const aCep: string; out aEndereco: TEndereco)
      : Boolean; overload;
    function Pesquisar(const aUf, aCidade, aLogradouro: string;
      out aEnderecos: TObjectList<TEndereco>): Boolean; overload;
    procedure InserirOuAtualizar(var aEndereco: TEndereco;
      const aAtualizarSeExistir: Boolean);
  end;

implementation

end.
