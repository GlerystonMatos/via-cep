unit Utilitarios.Tests;

interface

uses
  DUnitX.TestFramework, System.SysUtils, Utilitarios;

type
  [TestFixture]
  TUtilitariosTest = class
  public
    [Test]
    [TestCase('CEPValido1', '91790072,true')]
    [TestCase('CEPValido2', '91790-072,true')]
    [TestCase('CEPValido3', '91.790-072,true')]
    [TestCase('CEPInvalido1', '1234567,false')]
    [TestCase('CEPInvalido2', 'ABC123,false')]
    procedure TestValidarCEP(const aValue: string; const aExpected: Boolean);

    [Test]
    [TestCase('Indice0', '0,AC')]
    [TestCase('Indice25', '25,SP')]
    [TestCase('Indice26', '26,TO')]
    procedure TestObterUFPorIndice(const aIndex: Integer; const aExpected: string);

    [Test]
    procedure TestObterUFPorIndiceInvalido;

    [Test]
    [TestCase('ComEspacos', '  Rua  Teste ,RuaTeste')]
    [TestCase('SemEspacos', 'RuaTeste,RuaTeste')]
    procedure TestRemoverEspacos(const aValue: string; const aExpected: string);

    [Test]
    [TestCase('CEPFormatado1', '91790072,91790-072')]
    [TestCase('CEPFormatado2', '91.790-072,91790-072')]
    [TestCase('CEPFormatado3', '91790-072,91790-072')]
    [TestCase('CEPInvalido', '12345,12345')]
    procedure TestFormatarCEP(const aValue: string; const aExpected: string);
  end;

implementation

{ TUtilitariosTest }

procedure TUtilitariosTest.TestValidarCEP(const aValue: string; const aExpected: Boolean);
begin
  Assert.AreEqual(aExpected, TUtilitarios.ValidarCEP(aValue));
end;

procedure TUtilitariosTest.TestObterUFPorIndice(const aIndex: Integer; const aExpected: string);
begin
  Assert.AreEqual(aExpected, TUtilitarios.ObterUFPorIndice(aIndex));
end;

procedure TUtilitariosTest.TestObterUFPorIndiceInvalido;
begin
  Assert.WillRaise(
    procedure
    begin
      TUtilitarios.ObterUFPorIndice(99);
    end,
    Exception);
end;

procedure TUtilitariosTest.TestRemoverEspacos(const aValue, aExpected: string);
begin
  Assert.AreEqual(aExpected, TUtilitarios.RemoverEspacos(aValue));
end;

procedure TUtilitariosTest.TestFormatarCEP(const aValue, aExpected: string);
begin
  Assert.AreEqual(aExpected, TUtilitarios.FormatarCEP(aValue));
end;

initialization
  TDUnitX.RegisterTestFixture(TUtilitariosTest);

end.
