unit uViaCepComponent;

interface

uses
  ViaCep.Model, IdHTTP, IdSSLOpenSSL, System.Classes, System.Json,
  System.SysUtils, REST.Json, System.Generics.Collections, Xml.XMLDoc,
  Xml.XMLIntf;

type
  TTipoRetornoConsulta = (trcJSON, trcXML);

  TViaCepComponent = class(TComponent)
  private
    FIdHTTP: TIdHTTP;
    FIdSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL;
    FTipoRetornoConsulta: TTipoRetornoConsulta;
    function TratarRetorno(aRetorno: string): string;
    procedure SetTipoRetornoConsulta(const Value: TTipoRetornoConsulta);
    function LerRetornoJson(aJson: string): TViaCep;
    function LerRetornoXml(aXml: string): TViaCep;
    function LerListaRetornoJson(aJson: string): TObjectList<TViaCep>;
    function LerListaRetornoXml(aXml: string): TObjectList<TViaCep>;
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
  published
    { Published declarations }
    function PesquisarPorCep(const aCep: string): TViaCep;
    function PesquisarPorEndereco(const aUf, aCidade, aLogradouro: string)
      : TObjectList<TViaCep>; overload;
    property TipoRetornoConsulta: TTipoRetornoConsulta read FTipoRetornoConsulta
      write SetTipoRetornoConsulta;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Other', [TViaCepComponent]);
end;

{ TViaCepComponent }

constructor TViaCepComponent.Create(aOwner: TComponent);
begin
  inherited;
  FIdHTTP := TIdHTTP.Create;
  FIdSSLIOHandlerSocketOpenSSL := TIdSSLIOHandlerSocketOpenSSL.Create;
  FIdHTTP.IOHandler := FIdSSLIOHandlerSocketOpenSSL;
  FIdSSLIOHandlerSocketOpenSSL.SSLOptions.SSLVersions :=
    [sslvTLSv1, sslvTLSv1_1, sslvTLSv1_2];
end;

destructor TViaCepComponent.Destroy;
begin
  FIdSSLIOHandlerSocketOpenSSL.Free;
  FIdHTTP.Free;
  inherited;
end;

function TViaCepComponent.TratarRetorno(aRetorno: string): string;
begin
  Result := UTF8ToString(PAnsiChar(AnsiString(aRetorno)));
end;

function TViaCepComponent.PesquisarPorCep(const aCep: string): TViaCep;
const
  URL = 'https://viacep.com.br/ws/%s/%s';
var
  FormatoRetorno: string;
  Response: TStringStream;
begin
  Result := nil;
  Response := TStringStream.Create;
  try
    case FTipoRetornoConsulta of
      trcJSON:
        FormatoRetorno := 'json';
      trcXML:
        FormatoRetorno := 'xml';
    end;

    FIdHTTP.Get(Format(URL, [aCep.Trim, FormatoRetorno]), Response);
    if (FIdHTTP.ResponseCode = 200) then
    begin
      case FTipoRetornoConsulta of
        trcJSON:
          Result := LerRetornoJson(Response.DataString);
        trcXML:
          Result := LerRetornoXml(Response.DataString);
      end;
    end
    else
      raise Exception.Create('Erro ao consultar o CEP. Código HTTP: ' +
        FIdHTTP.ResponseCode.ToString);
  finally
    Response.Free;
  end;
end;

function TViaCepComponent.LerRetornoJson(aJson: string): TViaCep;
begin
  if (aJson.Contains('"erro": true')) then
    raise Exception.Create('Ocorreu um erro ao consultar o CEP no ViaCep.')
  else
    Result := TJson.JsonToObject<TViaCep>(TratarRetorno(aJson));
end;

function TViaCepComponent.LerRetornoXml(aXml: string): TViaCep;
var
  XMLDoc: IXMLDocument;
  ErroNode: IXMLNode;
begin
  XMLDoc := TXMLDocument.Create(nil);
  XMLDoc.LoadFromXML(TratarRetorno(aXml));
  XMLDoc.Active := True;

  ErroNode := XMLDoc.DocumentElement.ChildNodes.FindNode('erro');
  if (Assigned(ErroNode) and SameText(Trim(ErroNode.Text), 'true')) then
    raise Exception.Create('Ocorreu um erro ao consultar o CEP no ViaCep.')
  else
  begin
    Result := TViaCep.Create;
    Result.CEP := XMLDoc.DocumentElement.ChildNodes['cep'].Text;
    Result.Logradouro := XMLDoc.DocumentElement.ChildNodes['logradouro'].Text;
    Result.Complemento := XMLDoc.DocumentElement.ChildNodes['complemento'].Text;
    Result.Unidade := XMLDoc.DocumentElement.ChildNodes['unidade'].Text;
    Result.Bairro := XMLDoc.DocumentElement.ChildNodes['bairro'].Text;
    Result.Localidade := XMLDoc.DocumentElement.ChildNodes['localidade'].Text;
    Result.UF := XMLDoc.DocumentElement.ChildNodes['uf'].Text;
    Result.Estado := XMLDoc.DocumentElement.ChildNodes['estado'].Text;
    Result.Regiao := XMLDoc.DocumentElement.ChildNodes['regiao'].Text;
    Result.IBGE := XMLDoc.DocumentElement.ChildNodes['ibge'].Text;
    Result.GIA := XMLDoc.DocumentElement.ChildNodes['gia'].Text;
    Result.DDD := XMLDoc.DocumentElement.ChildNodes['ddd'].Text;
    Result.SIAFI := XMLDoc.DocumentElement.ChildNodes['siafi'].Text;
  end;
end;

function TViaCepComponent.PesquisarPorEndereco(const aUf, aCidade,
  aLogradouro: string): TObjectList<TViaCep>;
const
  URL = 'https://viacep.com.br/ws/%s/%s/%s/%s/';
var
  FormatoRetorno: string;
  Response: TStringStream;
begin
  Result := nil;
  Response := TStringStream.Create;
  try
    case FTipoRetornoConsulta of
      trcJSON:
        FormatoRetorno := 'json';
      trcXML:
        FormatoRetorno := 'xml';
    end;

    FIdHTTP.Get(Format(URL, [Trim(aUf), Trim(aCidade), Trim(aLogradouro),
      FormatoRetorno]), Response);

    if (FIdHTTP.ResponseCode = 200) then
    begin
      case FTipoRetornoConsulta of
        trcJSON:
          Result := LerListaRetornoJson(Response.DataString);
        trcXML:
          Result := LerListaRetornoXml(Response.DataString);
      end;
    end
    else
      raise Exception.Create('Erro ao consultar o CEP. Código HTTP: ' +
        FIdHTTP.ResponseCode.ToString);
  finally
    Response.Free;
  end;
end;

function TViaCepComponent.LerListaRetornoJson(aJson: string)
  : TObjectList<TViaCep>;
var
  Indice: Integer;
  ViaCep: TViaCep;
  JSONString: string;
  ItemJSON: TJSONValue;
  JSONValue: TJSONValue;
  JSONArray: TJSONArray;
begin
  if (aJson.Contains('"erro": true')) then
    raise Exception.Create('Ocorreu um erro ao consultar o CEP no ViaCep.')
  else
  begin
    JSONString := TratarRetorno(aJson);
    JSONValue := TJSONObject.ParseJSONValue(JSONString);
    try
      if (JSONValue is TJSONArray) then
      begin
        Result := TObjectList<TViaCep>.Create(True);
        JSONArray := (JSONValue as TJSONArray);
        for Indice := 0 to Pred(JSONArray.Count) do
        begin
          ItemJSON := JSONArray.Items[Indice];
          ViaCep := TJson.JsonToObject<TViaCep>(ItemJSON.ToString);
          Result.Add(ViaCep);
        end;
      end
      else
        raise Exception.Create('Resposta inesperada da API ViaCEP.');
    finally
      JSONValue.Free;
    end;
  end;
end;

function TViaCepComponent.LerListaRetornoXml(aXml: string)
  : TObjectList<TViaCep>;
var
  Indice: Integer;
  ViaCep: TViaCep;
  ErroNode: IXMLNode;
  XMLDoc: IXMLDocument;
  EnderecoNode: IXMLNode;
  EnderecosNode: IXMLNode;
begin
  XMLDoc := TXMLDocument.Create(nil);
  XMLDoc.LoadFromXML(TratarRetorno(aXml));
  XMLDoc.Active := True;

  ErroNode := XMLDoc.DocumentElement.ChildNodes.FindNode('erro');
  if (Assigned(ErroNode) and SameText(Trim(ErroNode.Text), 'true')) then
    raise Exception.Create('Ocorreu um erro ao consultar o CEP no ViaCep.')
  else
  begin
    EnderecosNode := XMLDoc.DocumentElement.ChildNodes.FindNode('enderecos');
    if (not Assigned(EnderecosNode)) then
      raise Exception.Create('Resposta inesperada da API ViaCEP.');

    Result := TObjectList<TViaCep>.Create(True);
    for Indice := 0 to (Pred(EnderecosNode.ChildNodes.Count)) do
    begin
      EnderecoNode := EnderecosNode.ChildNodes[Indice];
      if (SameText(EnderecoNode.NodeName, 'endereco')) then
      begin
        ViaCep := TViaCep.Create;
        ViaCep.CEP := EnderecoNode.ChildNodes['cep'].Text;
        ViaCep.Logradouro := EnderecoNode.ChildNodes['logradouro'].Text;
        ViaCep.Complemento := EnderecoNode.ChildNodes['complemento'].Text;
        ViaCep.Unidade := EnderecoNode.ChildNodes['unidade'].Text;
        ViaCep.Bairro := EnderecoNode.ChildNodes['bairro'].Text;
        ViaCep.Localidade := EnderecoNode.ChildNodes['localidade'].Text;
        ViaCep.UF := EnderecoNode.ChildNodes['uf'].Text;
        ViaCep.Estado := EnderecoNode.ChildNodes['estado'].Text;
        ViaCep.Regiao := EnderecoNode.ChildNodes['regiao'].Text;
        ViaCep.IBGE := EnderecoNode.ChildNodes['ibge'].Text;
        ViaCep.GIA := EnderecoNode.ChildNodes['gia'].Text;
        ViaCep.DDD := EnderecoNode.ChildNodes['ddd'].Text;
        ViaCep.SIAFI := EnderecoNode.ChildNodes['siafi'].Text;
        Result.Add(ViaCep);
      end;
    end;
  end;
end;

procedure TViaCepComponent.SetTipoRetornoConsulta
  (const Value: TTipoRetornoConsulta);
begin
  FTipoRetornoConsulta := Value;
end;

end.
