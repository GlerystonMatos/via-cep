unit Mapper.Tests;

interface

uses
  DUnitX.TestFramework, Endereco.Base.Model, Endereco.Model, Mapper, SysUtils;

type
  [TestFixture]
  TMapperTest = class
  private
    FEnderecoBase: TEnderecoBase;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;

    [Test]
    procedure TestBaseToEndereco;
  end;

implementation

{ TMapperTest }

procedure TMapperTest.Setup;
begin
  FEnderecoBase := TEnderecoBase.Create;
  FEnderecoBase.CEP := '91790-072';
  FEnderecoBase.Logradouro := 'Rua Domingos José Poli';
  FEnderecoBase.Complemento := 'Apto 101';
  FEnderecoBase.Unidade := 'Bloco A';
  FEnderecoBase.Bairro := 'Restinga';
  FEnderecoBase.Localidade := 'Porto Alegre';
  FEnderecoBase.UF := 'RS';
  FEnderecoBase.Estado := 'Rio Grande do Sul';
  FEnderecoBase.Regiao := 'Sul';
  FEnderecoBase.IBGE := '4314902';
  FEnderecoBase.GIA := '1234';
  FEnderecoBase.DDD := '51';
  FEnderecoBase.SIAFI := '8765';
end;

procedure TMapperTest.TearDown;
begin
  FEnderecoBase.Free;
end;

procedure TMapperTest.TestBaseToEndereco;
var
  Endereco: TEndereco;
begin
  Endereco := TMapper.BaseToEndereco(FEnderecoBase);
  try
    Assert.AreEqual(FEnderecoBase.CEP, Endereco.CEP);
    Assert.AreEqual(FEnderecoBase.Logradouro, Endereco.Logradouro);
    Assert.AreEqual(FEnderecoBase.Complemento, Endereco.Complemento);
    Assert.AreEqual(FEnderecoBase.Unidade, Endereco.Unidade);
    Assert.AreEqual(FEnderecoBase.Bairro, Endereco.Bairro);
    Assert.AreEqual(FEnderecoBase.Localidade, Endereco.Localidade);
    Assert.AreEqual(FEnderecoBase.UF, Endereco.UF);
    Assert.AreEqual(FEnderecoBase.Estado, Endereco.Estado);
    Assert.AreEqual(FEnderecoBase.Regiao, Endereco.Regiao);
    Assert.AreEqual(FEnderecoBase.IBGE, Endereco.IBGE);
    Assert.AreEqual(FEnderecoBase.GIA, Endereco.GIA);
    Assert.AreEqual(FEnderecoBase.DDD, Endereco.DDD);
    Assert.AreEqual(FEnderecoBase.SIAFI, Endereco.SIAFI);
  finally
    Endereco.Free;
  end;
end;

initialization

TDUnitX.RegisterTestFixture(TMapperTest);

end.
