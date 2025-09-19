unit Endereco.Base.Model;

interface

type
  TEnderecoBase = class
  private
    FLogradouro: string;
    FRegiao: string;
    FIBGE: string;
    FBairro: string;
    FDDD: string;
    FUF: string;
    FCEP: string;
    FSIAFI: string;
    FLocalidade: string;
    FUnidade: string;
    FComplemento: string;
    FGIA: string;
    FEstado: string;
    procedure SetBairro(const Value: string);
    procedure SetCEP(const Value: string);
    procedure SetComplemento(const Value: string);
    procedure SetDDD(const Value: string);
    procedure SetEstado(const Value: string);
    procedure SetGIA(const Value: string);
    procedure SetIBGE(const Value: string);
    procedure SetLocalidade(const Value: string);
    procedure SetLogradouro(const Value: string);
    procedure SetRegiao(const Value: string);
    procedure SetSIAFI(const Value: string);
    procedure SetUF(const Value: string);
    procedure SetUnidade(const Value: string);
  public
    property CEP: string read FCEP write SetCEP;
    property Logradouro: string read FLogradouro write SetLogradouro;
    property Complemento: string read FComplemento write SetComplemento;
    property Unidade: string read FUnidade write SetUnidade;
    property Bairro: string read FBairro write SetBairro;
    property Localidade: string read FLocalidade write SetLocalidade;
    property UF: string read FUF write SetUF;
    property Estado: string read FEstado write SetEstado;
    property Regiao: string read FRegiao write SetRegiao;
    property IBGE: string read FIBGE write SetIBGE;
    property GIA: string read FGIA write SetGIA;
    property DDD: string read FDDD write SetDDD;
    property SIAFI: string read FSIAFI write SetSIAFI;
  end;

implementation

{ TEnderecoBase }

procedure TEnderecoBase.SetBairro(const Value: string);
begin
  FBairro := Value;
end;

procedure TEnderecoBase.SetCEP(const Value: string);
begin
  FCEP := Value;
end;

procedure TEnderecoBase.SetComplemento(const Value: string);
begin
  FComplemento := Value;
end;

procedure TEnderecoBase.SetDDD(const Value: string);
begin
  FDDD := Value;
end;

procedure TEnderecoBase.SetEstado(const Value: string);
begin
  FEstado := Value;
end;

procedure TEnderecoBase.SetGIA(const Value: string);
begin
  FGIA := Value;
end;

procedure TEnderecoBase.SetIBGE(const Value: string);
begin
  FIBGE := Value;
end;

procedure TEnderecoBase.SetLocalidade(const Value: string);
begin
  FLocalidade := Value;
end;

procedure TEnderecoBase.SetLogradouro(const Value: string);
begin
  FLogradouro := Value;
end;

procedure TEnderecoBase.SetRegiao(const Value: string);
begin
  FRegiao := Value;
end;

procedure TEnderecoBase.SetSIAFI(const Value: string);
begin
  FSIAFI := Value;
end;

procedure TEnderecoBase.SetUF(const Value: string);
begin
  FUF := Value;
end;

procedure TEnderecoBase.SetUnidade(const Value: string);
begin
  FUnidade := Value;
end;

end.
