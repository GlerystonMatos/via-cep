unit Endereco.Repository;

interface

uses
  IEndereco.Repository.Intf, FireDAC.Comp.Client, Endereco.Model,
  FireDAC.Stan.Param, Data.DB, FireDAC.DApt, System.Generics.Collections;

type
  TEnderecoRepository = class(TInterfacedObject, IEnderecoRepository)
  private
    FConnection: TFDConnection;
    FQuery: TFDQuery;
  public
    constructor Create(AConnection: TFDConnection);
    destructor Destroy; override;
    function Pesquisar(const aCep: string; out aEndereco: TEndereco)
      : Boolean; overload;
    function Pesquisar(const aUf, aCidade, aLogradouro: string;
      out aEnderecos: TObjectList<TEndereco>): Boolean; overload;
    procedure InserirOuAtualizar(var aEndereco: TEndereco;
      const aAtualizarSeExistir: Boolean);
  end;

implementation

{ TEnderecoRepository }

constructor TEnderecoRepository.Create(AConnection: TFDConnection);
begin
  inherited Create;
  FConnection := AConnection;
  FQuery := TFDQuery.Create(nil);
  FQuery.Connection := FConnection;
end;

destructor TEnderecoRepository.Destroy;
begin
  FQuery.Free;
  inherited;
end;

function TEnderecoRepository.Pesquisar(const aCep: string;
  out aEndereco: TEndereco): Boolean;
begin
  Result := False;

  FQuery.SQL.Text := 'SELECT codigo, cep, logradouro, complemento, unidade, ' +
    'bairro, localidade, uf, estado, regiao, ibge, gia, ddd, siafi ' +
    'FROM endereco WHERE cep = :cep';
  FQuery.ParamByName('cep').AsString := aCep;
  FQuery.Open;

  try
    if (not FQuery.IsEmpty) then
    begin
      aEndereco := TEndereco.Create;
      aEndereco.Codigo := FQuery.FieldByName('codigo').AsInteger;
      aEndereco.CEP := FQuery.FieldByName('cep').AsString;
      aEndereco.Logradouro := FQuery.FieldByName('logradouro').AsString;
      aEndereco.Complemento := FQuery.FieldByName('complemento').AsString;
      aEndereco.Unidade := FQuery.FieldByName('unidade').AsString;
      aEndereco.Bairro := FQuery.FieldByName('bairro').AsString;
      aEndereco.Localidade := FQuery.FieldByName('localidade').AsString;
      aEndereco.UF := FQuery.FieldByName('uf').AsString;
      aEndereco.estado := FQuery.FieldByName('estado').AsString;
      aEndereco.regiao := FQuery.FieldByName('regiao').AsString;
      aEndereco.ibge := FQuery.FieldByName('ibge').AsString;
      aEndereco.gia := FQuery.FieldByName('gia').AsString;
      aEndereco.ddd := FQuery.FieldByName('ddd').AsString;
      aEndereco.siafi := FQuery.FieldByName('siafi').AsString;
      Result := True;
    end;
  finally
    FQuery.Close;
  end;
end;

function TEnderecoRepository.Pesquisar(const aUf, aCidade, aLogradouro: string;
  out aEnderecos: TObjectList<TEndereco>): Boolean;
var
  Endereco: TEndereco;
begin
  Result := False;

  FQuery.SQL.Text := 'SELECT codigo, cep, logradouro, complemento, unidade, ' +
    'bairro, localidade, uf, estado, regiao, ibge, gia, ddd, siafi ' +
    'FROM endereco WHERE uf = :uf AND localidade ILIKE :cidade AND ' +
    'logradouro ILIKE :logradouro';

  FQuery.ParamByName('uf').AsString := aUf;
  FQuery.ParamByName('cidade').AsString := '%' + aCidade + '%';
  FQuery.ParamByName('logradouro').AsString := '%' + aLogradouro + '%';
  FQuery.Open;

  try
    aEnderecos := TObjectList<TEndereco>.Create(True);

    FQuery.First;
    while (not FQuery.Eof) do
    begin
      Endereco := TEndereco.Create;
      Endereco.Codigo := FQuery.FieldByName('codigo').AsInteger;
      Endereco.CEP := FQuery.FieldByName('cep').AsString;
      Endereco.Logradouro := FQuery.FieldByName('logradouro').AsString;
      Endereco.Complemento := FQuery.FieldByName('complemento').AsString;
      Endereco.Unidade := FQuery.FieldByName('unidade').AsString;
      Endereco.Bairro := FQuery.FieldByName('bairro').AsString;
      Endereco.Localidade := FQuery.FieldByName('localidade').AsString;
      Endereco.UF := FQuery.FieldByName('uf').AsString;
      Endereco.estado := FQuery.FieldByName('estado').AsString;
      Endereco.regiao := FQuery.FieldByName('regiao').AsString;
      Endereco.ibge := FQuery.FieldByName('ibge').AsString;
      Endereco.gia := FQuery.FieldByName('gia').AsString;
      Endereco.ddd := FQuery.FieldByName('ddd').AsString;
      Endereco.siafi := FQuery.FieldByName('siafi').AsString;

      aEnderecos.Add(Endereco);
      FQuery.Next;
    end;

    if (aEnderecos.Count > 0) then
      Result := True;
  finally
    FQuery.Close;
  end;
end;

procedure TEnderecoRepository.InserirOuAtualizar(var aEndereco: TEndereco;
  const aAtualizarSeExistir: Boolean);
var
  EnderecoSalvo: TEndereco;
begin
  if (Pesquisar(aEndereco.CEP, EnderecoSalvo)) then
  begin
    if (aAtualizarSeExistir) then
    begin
      FQuery.SQL.Text := 'UPDATE endereco SET ' + 'logradouro = :logradouro, ' +
        'complemento = :complemento, ' + 'unidade = :unidade, ' +
        'bairro = :bairro, ' + 'localidade = :localidade, ' + 'uf = :uf, ' +
        'estado = :estado, ' + 'regiao = :regiao, ' + 'ibge = :ibge, ' +
        'gia = :gia, ' + 'ddd = :ddd, ' + 'siafi = :siafi ' +
        'WHERE cep = :cep';

      FQuery.ParamByName('logradouro').AsString := aEndereco.Logradouro;
      FQuery.ParamByName('complemento').AsString := aEndereco.Complemento;
      FQuery.ParamByName('unidade').AsString := aEndereco.Unidade;
      FQuery.ParamByName('bairro').AsString := aEndereco.Bairro;
      FQuery.ParamByName('localidade').AsString := aEndereco.Localidade;
      FQuery.ParamByName('uf').AsString := aEndereco.UF;
      FQuery.ParamByName('estado').AsString := aEndereco.estado;
      FQuery.ParamByName('regiao').AsString := aEndereco.regiao;
      FQuery.ParamByName('ibge').AsString := aEndereco.ibge;
      FQuery.ParamByName('gia').AsString := aEndereco.gia;
      FQuery.ParamByName('ddd').AsString := aEndereco.ddd;
      FQuery.ParamByName('siafi').AsString := aEndereco.siafi;
      FQuery.ParamByName('cep').AsString := aEndereco.CEP;

      FQuery.ExecSQL;
    end;
  end
  else
  begin
    FQuery.SQL.Text := 'INSERT INTO endereco(cep, logradouro, complemento, ' +
      'unidade, bairro, localidade, uf, estado, regiao, ibge, gia, ddd, siafi)'
      + 'VALUES (:cep, :logradouro, :complemento, :unidade, :bairro, :localidade, '
      + ':uf, :estado, :regiao, :ibge, :gia, :ddd, :siafi)';

    FQuery.ParamByName('cep').AsString := aEndereco.CEP;
    FQuery.ParamByName('logradouro').AsString := aEndereco.Logradouro;
    FQuery.ParamByName('complemento').AsString := aEndereco.Complemento;
    FQuery.ParamByName('unidade').AsString := aEndereco.Unidade;
    FQuery.ParamByName('bairro').AsString := aEndereco.Bairro;
    FQuery.ParamByName('localidade').AsString := aEndereco.Localidade;
    FQuery.ParamByName('uf').AsString := aEndereco.UF;
    FQuery.ParamByName('estado').AsString := aEndereco.estado;
    FQuery.ParamByName('regiao').AsString := aEndereco.regiao;
    FQuery.ParamByName('ibge').AsString := aEndereco.ibge;
    FQuery.ParamByName('gia').AsString := aEndereco.gia;
    FQuery.ParamByName('ddd').AsString := aEndereco.ddd;
    FQuery.ParamByName('siafi').AsString := aEndereco.siafi;

    FQuery.ExecSQL;
  end;
end;

end.
