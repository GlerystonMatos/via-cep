program ViaCep;

uses
  Vcl.Forms,
  uViaCep in 'ui\uViaCep.pas' {frmViaCep},
  Mensagem in 'utils\Mensagem.pas',
  Utilitarios in 'utils\Utilitarios.pas',
  ViaCep.Model in 'domain\ViaCep.Model.pas',
  IEndereco.Repository.Intf in 'repository\interfaces\IEndereco.Repository.Intf.pas',
  Endereco.Repository in 'repository\Endereco.Repository.pas',
  Endereco.Model in 'domain\Endereco.Model.pas',
  IEndereco.Service.Intf in 'services\interfaces\IEndereco.Service.Intf.pas',
  Endereco.Service in 'services\Endereco.Service.pas',
  Endereco.Base.Model in 'domain\Endereco.Base.Model.pas',
  Mapper in 'utils\Mapper.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmViaCep, frmViaCep);
  Application.Run;
end.
