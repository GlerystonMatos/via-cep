unit Endereco.Service;

interface

uses
  IEndereco.Service.Intf, Endereco.Model, IEndereco.Repository.Intf,
  FireDAC.Comp.Client, Endereco.Repository, System.Generics.Collections;

type
  TEnderecoService = class(TInterfacedObject, IEnderecoService)
  private
    FEnderecoRepository: IEnderecoRepository;
  public
    constructor Create(const aConnection: TFDConnection);
    function Pesquisar(const aCep: string; out aEndereco: TEndereco)
      : Boolean; overload;
    function Pesquisar(const aUf, aCidade, aLogradouro: string;
      out aEnderecos: TObjectList<TEndereco>): Boolean; overload;
    procedure InserirOuAtualizar(var aEndereco: TEndereco;
      const aAtualizarSeExistir: Boolean);
  end;

implementation

{ TEnderecoService }

constructor TEnderecoService.Create(const aConnection: TFDConnection);
begin
  FEnderecoRepository := TEnderecoRepository.Create(aConnection);
end;

procedure TEnderecoService.InserirOuAtualizar(var aEndereco: TEndereco;
  const aAtualizarSeExistir: Boolean);
begin
  FEnderecoRepository.InserirOuAtualizar(aEndereco, aAtualizarSeExistir);
end;

function TEnderecoService.Pesquisar(const aUf, aCidade, aLogradouro: string;
  out aEnderecos: TObjectList<TEndereco>): Boolean;
begin
  Result := FEnderecoRepository.Pesquisar(aUf, aCidade, aLogradouro,
    aEnderecos);
end;

function TEnderecoService.Pesquisar(const aCep: string;
  out aEndereco: TEndereco): Boolean;
begin
  Result := FEnderecoRepository.Pesquisar(aCep, aEndereco);
end;

end.
