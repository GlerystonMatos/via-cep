unit uViaCep;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons, Mensagem, Utilitarios, Vcl.DBGrids,
  ViaCep.Model, Vcl.ComCtrls, System.Generics.Collections, Data.DB, Vcl.Grids,
  Datasnap.DBClient, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.PG, FireDAC.Phys.PGDef,
  FireDAC.VCLUI.Wait, FireDAC.Comp.Client, IEndereco.Service.Intf,
  Endereco.Service, Endereco.Model, Endereco.Base.Model, Mapper,
  uViaCepComponent;

type
  TfrmViaCep = class(TForm)
    pnlFiltros: TPanel;
    pnlDados: TPanel;
    pcFiltros: TPageControl;
    tsCep: TTabSheet;
    tsEndereco: TTabSheet;
    lbCep: TLabel;
    edtCep: TEdit;
    btnPesquisarCep: TBitBtn;
    lbUF: TLabel;
    cbUf: TComboBox;
    lbCidade: TLabel;
    edtCidade: TEdit;
    edtLogradouro: TEdit;
    lbLogradouro: TLabel;
    btnPesquisarEndereco: TBitBtn;
    dbgDados: TDBGrid;
    ddsDados: TDataSource;
    cdsDados: TClientDataSet;
    cdsDadosBairro: TStringField;
    cdsDadosCEP: TStringField;
    cdsDadosComplemento: TStringField;
    cdsDadosDDD: TStringField;
    cdsDadosEstado: TStringField;
    cdsDadosGIA: TStringField;
    cdsDadosIBGE: TStringField;
    cdsDadosLocalidade: TStringField;
    cdsDadosLogradouro: TStringField;
    cdsDadosRegiao: TStringField;
    cdsDadosSIAFI: TStringField;
    cdsDadosUF: TStringField;
    cdsDadosUnidade: TStringField;
    FDConnection: TFDConnection;
    tsConfiguracoes: TTabSheet;
    lbServidor: TLabel;
    edtServidor: TEdit;
    edtUsuario: TEdit;
    lbUsuario: TLabel;
    lbSenha: TLabel;
    edtSenha: TEdit;
    edtBancoDados: TEdit;
    lbBancoDados: TLabel;
    btnTestarConexao: TBitBtn;
    edtPorta: TEdit;
    lbPorta: TLabel;
    ViaCep: TViaCepComponent;
    rgTipoRetornoConsulta: TRadioGroup;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure btnPesquisarCepClick(Sender: TObject);
    procedure btnPesquisarEnderecoClick(Sender: TObject);
    procedure pcFiltrosChange(Sender: TObject);
    procedure btnTestarConexaoClick(Sender: TObject);
  private
    { Private declarations }
    function ValidarCep: Boolean;
    function ValidarEndereco: Boolean;
    function ValidarConexao: Boolean;
    function TestarConexao: Boolean;
    procedure PesquisarCep;
    procedure PesquisarCepViaCep(aCep: string); overload;
    procedure PesquisarCepViaCep(aUf, aCidade, aLogradouro: string); overload;
    procedure PesquisarEndereco;
    procedure LimparDataSet;
    procedure AddEndereco(const aEnderecoBase: TEnderecoBase);
    procedure AddEnderecos(const aEnderecos: TObjectList<TEndereco>);
    procedure AddCeps(const aCeps: TObjectList<TViaCep>);
    procedure SalvarEndereco(const aEnderecoBase: TEnderecoBase);
    procedure ConfigurarRetornoConsultaViaCep;
  public
    { Public declarations }
  end;

var
  frmViaCep: TfrmViaCep;

implementation

{$R *.dfm}

procedure TfrmViaCep.AddEndereco(const aEnderecoBase: TEnderecoBase);
begin
  cdsDados.Append;
  cdsDadosCEP.AsString := aEnderecoBase.Cep;
  cdsDadosLogradouro.AsString := aEnderecoBase.Logradouro;
  cdsDadosComplemento.AsString := aEnderecoBase.Complemento;
  cdsDadosUnidade.AsString := aEnderecoBase.Unidade;
  cdsDadosBairro.AsString := aEnderecoBase.Bairro;
  cdsDadosLocalidade.AsString := aEnderecoBase.Localidade;
  cdsDadosUF.AsString := aEnderecoBase.UF;
  cdsDadosEstado.AsString := aEnderecoBase.Estado;
  cdsDadosRegiao.AsString := aEnderecoBase.Regiao;
  cdsDadosIBGE.AsString := aEnderecoBase.IBGE;
  cdsDadosGIA.AsString := aEnderecoBase.GIA;
  cdsDadosDDD.AsString := aEnderecoBase.DDD;
  cdsDadosSIAFI.AsString := aEnderecoBase.SIAFI;
  cdsDados.Post;

  SalvarEndereco(aEnderecoBase);
end;

procedure TfrmViaCep.AddCeps(const aCeps: TObjectList<TViaCep>);
var
  Indice: Integer;
begin
  for Indice := 0 to Pred(aCeps.Count) do
  begin
    AddEndereco(aCeps[Indice]);
    SalvarEndereco(aCeps[Indice]);
  end;
end;

procedure TfrmViaCep.AddEnderecos(const aEnderecos: TObjectList<TEndereco>);
var
  Indice: Integer;
begin
  for Indice := 0 to Pred(aEnderecos.Count) do
  begin
    AddEndereco(aEnderecos[Indice]);
    SalvarEndereco(aEnderecos[Indice]);
  end;
end;

procedure TfrmViaCep.btnPesquisarCepClick(Sender: TObject);
begin
  if (ValidarCep) then
    PesquisarCep;
end;

procedure TfrmViaCep.btnPesquisarEnderecoClick(Sender: TObject);
begin
  if (ValidarEndereco) then
    PesquisarEndereco;
end;

procedure TfrmViaCep.btnTestarConexaoClick(Sender: TObject);
begin
  if (ValidarConexao) then
    TMensagem.Informacao('Conexão realizada com sucesso.');
end;

procedure TfrmViaCep.ConfigurarRetornoConsultaViaCep;
const
  TR_JSON = 0;
  TR_XML = 1;
begin
  case (rgTipoRetornoConsulta.ItemIndex) of
    TR_JSON:
      ViaCep.TipoRetornoConsulta := trcJSON;
    TR_XML:
      ViaCep.TipoRetornoConsulta := trcXML;
  end;
end;

procedure TfrmViaCep.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case (Key) of
    VK_ESCAPE:
      Close;
  end;
end;

procedure TfrmViaCep.FormShow(Sender: TObject);
begin
  pcFiltros.ActivePage := tsCep;
  edtCep.SetFocus();
end;

procedure TfrmViaCep.LimparDataSet;
begin
  cdsDados.Close;
  cdsDados.CreateDataSet;
end;

procedure TfrmViaCep.pcFiltrosChange(Sender: TObject);
const
  CEP = 0;
  ENDERECO = 1;
  CONFIGURACOES = 2;
begin
  LimparDataSet;
  case (pcFiltros.ActivePageIndex) of
    CEP:
      edtCep.SetFocus();
    ENDERECO:
      cbUf.SetFocus();
    CONFIGURACOES:
      edtServidor.SetFocus();
  end;
end;

procedure TfrmViaCep.PesquisarCep;
var
  Endereco: TEndereco;
  EnderecoService: IEnderecoService;
begin
  LimparDataSet;

  EnderecoService := TEnderecoService.Create(FDConnection);
  if (EnderecoService.Pesquisar(TUtilitarios.FormatarCEP(edtCep.Text), Endereco))
  then
  begin
    if (TMensagem.Confirmacao('Os dados do endereço foram encontrados na base '
      + 'de dados, deseja visualizá-los?' + sLineBreak + sLineBreak +
      'Observação: Caso selecione não será realizada uma nova consulta e as ' +
      'informações serão atualizadas na base de dados')) then
    begin
      AddEndereco(Endereco);
    end
    else
      PesquisarCepViaCep(Trim(edtCep.Text));
  end
  else
    PesquisarCepViaCep(Trim(edtCep.Text));
end;

procedure TfrmViaCep.PesquisarCepViaCep(aCep: string);
var
  Cep: TViaCep;
begin
  ConfigurarRetornoConsultaViaCep;
  Cep := ViaCep.PesquisarPorCep(aCep);

  if (not Assigned(Cep)) then
    Exit;

  try
    if (Trim(Cep.Cep) <> '') then
      AddEndereco(Cep)
    else
      TMensagem.Informacao('O CEP informado não foi localizado.')
  finally
    Cep.Free;
  end;
end;

procedure TfrmViaCep.PesquisarEndereco;
var
  Enderecos: TObjectList<TEndereco>;
  EnderecoService: IEnderecoService;
begin
  LimparDataSet;

  EnderecoService := TEnderecoService.Create(FDConnection);
  if (EnderecoService.Pesquisar(TUtilitarios.ObterUFPorIndice(cbUf.ItemIndex),
    TUtilitarios.RemoverEspacos(edtCidade.Text),
    TUtilitarios.RemoverEspacos(edtLogradouro.Text), Enderecos)) then
  begin
    if (TMensagem.Confirmacao('Os dados do endereço foram encontrados na base '
      + 'de dados, deseja visualizá-los?' + sLineBreak + sLineBreak +
      'Observação: Caso selecione não será realizada uma nova consulta e as ' +
      'informações serão atualizadas na base de dados')) then
    begin
      AddEnderecos(Enderecos);
    end
    else
      PesquisarCepViaCep(TUtilitarios.ObterUFPorIndice(cbUf.ItemIndex),
        TUtilitarios.RemoverEspacos(edtCidade.Text),
        TUtilitarios.RemoverEspacos(edtLogradouro.Text));
  end
  else
    PesquisarCepViaCep(TUtilitarios.ObterUFPorIndice(cbUf.ItemIndex),
      TUtilitarios.RemoverEspacos(edtCidade.Text),
      TUtilitarios.RemoverEspacos(edtLogradouro.Text));
end;

procedure TfrmViaCep.PesquisarCepViaCep(aUf, aCidade, aLogradouro: string);
var
  Ceps: TObjectList<TViaCep>;
begin
  ConfigurarRetornoConsultaViaCep;
  Ceps := ViaCep.PesquisarPorEndereco(aUf, aCidade, aLogradouro);

  if (not Assigned(Ceps)) then
    Exit;

  try
    if (Ceps.Count > 0) then
      AddCeps(Ceps)
    else
      TMensagem.Informacao('O endereço informado não foi localizado.')
  finally
    Ceps.Free;
  end;
end;

procedure TfrmViaCep.SalvarEndereco(const aEnderecoBase: TEnderecoBase);
var
  Endereco: TEndereco;
  EnderecoService: IEnderecoService;
begin
  Endereco := TMapper.BaseToEndereco(aEnderecoBase);
  EnderecoService := TEnderecoService.Create(FDConnection);
  EnderecoService.InserirOuAtualizar(Endereco, True);
end;

function TfrmViaCep.TestarConexao: Boolean;
begin
  FDConnection.Close;
  FDConnection.DriverName := 'PG';

  FDConnection.Params.Clear;
  FDConnection.Params.Add('Server=' + Trim(edtServidor.Text));
  FDConnection.Params.Add('Database=' + Trim(edtBancoDados.Text));
  FDConnection.Params.Add('User_Name=' + Trim(edtUsuario.Text));
  FDConnection.Params.Add('Password=' + Trim(edtSenha.Text));
  FDConnection.Params.Add('Port=' + Trim(edtPorta.Text));
  FDConnection.Params.Add('DriverID=PG');

  try
    FDConnection.Connected := True;
    Result := True;
  except
    on E: Exception do
    begin
      TMensagem.Erro('Erro ao conectar com o banco de dados: ' + E.Message);
      Result := False;
    end;
  end;
end;

function TfrmViaCep.ValidarCep: Boolean;
begin
  Result := False;

  if (Trim(edtCep.Text) = '') then
  begin
    TMensagem.Aviso('Informe um CEP para realizar a pesquisa.');
    edtCep.SetFocus;
    Exit;
  end;

  if (not TUtilitarios.ValidarCep(Trim(edtCep.Text))) then
  begin
    TMensagem.Aviso('Informe um CEP válido para realizar a pesquisa.');
    edtCep.SetFocus;
    Exit;
  end;

  if (not ValidarConexao) then
    Exit;

  Result := True;
end;

function TfrmViaCep.ValidarConexao: Boolean;
begin
  Result := False;

  if ((Trim(edtServidor.Text) = '') or (Trim(edtUsuario.Text) = '') or
    (Trim(edtSenha.Text) = '') or (Trim(edtBancoDados.Text) = '')) then
  begin
    TMensagem.Aviso('Informações para conexão com banco de dados invalidas');
    pcFiltros.ActivePage := tsConfiguracoes;
    edtServidor.SetFocus;
    Exit;
  end;

  if (not TestarConexao) then
    Exit;

  Result := True;
end;

function TfrmViaCep.ValidarEndereco: Boolean;
const
  TAMANHO_MINIMO = 3;
begin
  Result := False;

  if (Trim(edtCidade.Text) = '') then
  begin
    TMensagem.Aviso('Informe uma cidade para realizar a pesquisa.');
    edtCidade.SetFocus;
    Exit;
  end;

  if (Length(Trim(edtCidade.Text)) < TAMANHO_MINIMO) then
  begin
    TMensagem.Aviso
      ('A cidade deve ter no mínimo 3 caracteres para realizar a pesquisa.');
    edtCidade.SetFocus;
    Exit;
  end;

  if (Trim(edtLogradouro.Text) = '') then
  begin
    TMensagem.Aviso('Informe um logradouro para realizar a pesquisa.');
    edtLogradouro.SetFocus;
    Exit;
  end;

  if (Length(Trim(edtLogradouro.Text)) < TAMANHO_MINIMO) then
  begin
    TMensagem.Aviso
      ('O logradouro deve ter no mínimo 3 caracteres para realizar a pesquisa.');
    edtLogradouro.SetFocus;
    Exit;
  end;

  if (not ValidarConexao) then
    Exit;

  Result := True;
end;

end.
