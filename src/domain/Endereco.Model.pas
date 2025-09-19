unit Endereco.Model;

interface

uses
  Endereco.Base.Model;

type
  TEndereco = class(TEnderecoBase)
  private
    FCodigo: Integer;
    procedure SetCodigo(const Value: Integer);
  public
    property Codigo: Integer read FCodigo write SetCodigo;
  end;

implementation

{ TEndereco }

procedure TEndereco.SetCodigo(const Value: Integer);
begin
  FCodigo := Value;
end;

end.
