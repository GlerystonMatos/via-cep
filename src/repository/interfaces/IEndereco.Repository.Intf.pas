unit IEndereco.Repository.Intf;

interface

uses
  Endereco.Model, System.Generics.Collections;

type
  IEnderecoRepository = interface
    ['{EC4B6E33-B7B3-4620-962F-84BF5EFAD228}']
    function Pesquisar(const aCep: string; out aEndereco: TEndereco)
      : Boolean; overload;
    function Pesquisar(const aUf, aCidade, aLogradouro: string;
      out aEnderecos: TObjectList<TEndereco>): Boolean; overload;
    procedure InserirOuAtualizar(var aEndereco: TEndereco;
      const aAtualizarSeExistir: Boolean);
  end;

implementation

end.
