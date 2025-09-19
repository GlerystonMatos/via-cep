object frmViaCep: TfrmViaCep
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'ViaCep'
  ClientHeight = 439
  ClientWidth = 815
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poScreenCenter
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  TextHeight = 15
  object pnlFiltros: TPanel
    Left = 0
    Top = 0
    Width = 815
    Height = 136
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object pcFiltros: TPageControl
      Left = 9
      Top = 8
      Width = 801
      Height = 120
      ActivePage = tsCep
      TabOrder = 0
      OnChange = pcFiltrosChange
      object tsCep: TTabSheet
        Caption = 'CEP'
        object lbCep: TLabel
          Left = 8
          Top = 8
          Width = 24
          Height = 15
          Caption = 'CEP:'
        end
        object edtCep: TEdit
          Left = 38
          Top = 5
          Width = 60
          Height = 23
          TabOrder = 0
        end
        object btnPesquisarCep: TBitBtn
          Left = 104
          Top = 4
          Width = 75
          Height = 25
          Caption = 'Pesquisar'
          TabOrder = 1
          OnClick = btnPesquisarCepClick
        end
      end
      object tsEndereco: TTabSheet
        Caption = 'Endere'#231'o'
        ImageIndex = 1
        object lbUF: TLabel
          Left = 8
          Top = 9
          Width = 17
          Height = 15
          Caption = 'UF:'
        end
        object lbCidade: TLabel
          Left = 201
          Top = 9
          Width = 40
          Height = 15
          Caption = 'Cidade:'
        end
        object lbLogradouro: TLabel
          Left = 419
          Top = 9
          Width = 65
          Height = 15
          Caption = 'Logradouro:'
        end
        object cbUf: TComboBox
          Left = 32
          Top = 6
          Width = 165
          Height = 23
          Style = csDropDownList
          ItemIndex = 0
          TabOrder = 0
          Text = 'AC '#8211' Acre'
          Items.Strings = (
            'AC '#8211' Acre'
            'AL '#8211' Alagoas'
            'AM '#8211' Amazonas'
            'AP '#8211' Amap'#225
            'BA '#8211' Bahia'
            'CE '#8211' Cear'#225
            'DF '#8211' Distrito Federal'
            'ES '#8211' Esp'#237'rito Santo'
            'GO '#8211' Goi'#225's'
            'MA '#8211' Maranh'#227'o'
            'MG '#8211' Minas Gerais'
            'MS '#8211' Mato Grosso do Sul'
            'MT '#8211' Mato Grosso'
            'PA '#8211' Par'#225
            'PB '#8211' Para'#237'ba'
            'PE '#8211' Pernambuco'
            'PI '#8211' Piau'#237
            'PR '#8211' Paran'#225
            'RJ '#8211' Rio de Janeiro'
            'RN '#8211' Rio Grande do Norte'
            'RO '#8211' Rond'#244'nia'
            'RR '#8211' Roraima'
            'RS '#8211' Rio Grande do Sul'
            'SC '#8211' Santa Catarina'
            'SE '#8211' Sergipe'
            'SP '#8211' S'#227'o Paulo'
            'TO '#8211' Tocantins')
        end
        object edtCidade: TEdit
          Left = 248
          Top = 6
          Width = 165
          Height = 23
          TabOrder = 1
        end
        object edtLogradouro: TEdit
          Left = 491
          Top = 6
          Width = 165
          Height = 23
          TabOrder = 2
        end
        object btnPesquisarEndereco: TBitBtn
          Left = 662
          Top = 5
          Width = 75
          Height = 25
          Caption = 'Pesquisar'
          TabOrder = 3
          OnClick = btnPesquisarEnderecoClick
        end
      end
      object tsConfiguracoes: TTabSheet
        Caption = 'Configura'#231#245'es'
        ImageIndex = 2
        object lbServidor: TLabel
          Left = 7
          Top = 9
          Width = 46
          Height = 15
          Caption = 'Servidor:'
        end
        object lbUsuario: TLabel
          Left = 11
          Top = 38
          Width = 43
          Height = 15
          Caption = 'Usu'#225'rio:'
        end
        object lbSenha: TLabel
          Left = 18
          Top = 67
          Width = 35
          Height = 15
          Caption = 'Senha:'
        end
        object lbBancoDados: TLabel
          Left = 129
          Top = 9
          Width = 88
          Height = 15
          Caption = 'Banco de Dados:'
        end
        object lbPorta: TLabel
          Left = 186
          Top = 37
          Width = 31
          Height = 15
          Caption = 'Porta:'
        end
        object edtServidor: TEdit
          Left = 59
          Top = 4
          Width = 62
          Height = 23
          TabOrder = 0
          Text = '127.0.0.1'
        end
        object edtUsuario: TEdit
          Left = 59
          Top = 33
          Width = 62
          Height = 23
          TabOrder = 1
          Text = 'postgres'
        end
        object edtSenha: TEdit
          Left = 59
          Top = 62
          Width = 62
          Height = 23
          PasswordChar = '*'
          TabOrder = 2
        end
        object edtBancoDados: TEdit
          Left = 223
          Top = 4
          Width = 62
          Height = 23
          TabOrder = 3
          Text = 'ViaCep'
        end
        object btnTestarConexao: TBitBtn
          Left = 291
          Top = 3
          Width = 106
          Height = 25
          Caption = 'Testar Conex'#227'o'
          TabOrder = 5
          OnClick = btnTestarConexaoClick
        end
        object edtPorta: TEdit
          Left = 223
          Top = 33
          Width = 62
          Height = 23
          TabOrder = 4
          Text = '5432'
        end
        object rgTipoRetornoConsulta: TRadioGroup
          Left = 608
          Top = 3
          Width = 182
          Height = 56
          Caption = ' Tipo de retorno na consulta '
          Columns = 2
          ItemIndex = 0
          Items.Strings = (
            'JSON'
            'XML')
          TabOrder = 6
        end
      end
    end
  end
  object pnlDados: TPanel
    Left = 0
    Top = 136
    Width = 815
    Height = 303
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object dbgDados: TDBGrid
      Left = 0
      Top = 0
      Width = 815
      Height = 303
      Align = alClient
      DataSource = ddsDados
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
    end
  end
  object ddsDados: TDataSource
    DataSet = cdsDados
    Left = 672
    Top = 145
  end
  object cdsDados: TClientDataSet
    PersistDataPacket.Data = {
      770100009619E0BD01000000180000000D000000000003000000770103434550
      0100490000000100055749445448020002000A000A4C6F677261646F75726F02
      0049000000010005574944544802000200FF000B436F6D706C656D656E746F02
      0049000000010005574944544802000200FF0007556E69646164650200490000
      00010005574944544802000200FF000642616972726F02004900000001000557
      4944544802000200FF000A4C6F63616C69646164650200490000000100055749
      44544802000200FF000255460100490000000100055749445448020002000300
      0645737461646F01004900000001000557494454480200020064000652656769
      616F020049000000010005574944544802000200FF0004494247450100490000
      0001000557494454480200020014000347494102004900000001000557494454
      4802000200FF0003444444010049000000010005574944544802000200050005
      534941464901004900000001000557494454480200020014000000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'CEP'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'Logradouro'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'Complemento'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'Unidade'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'Bairro'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'Localidade'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'UF'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'Estado'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'Regiao'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'IBGE'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'GIA'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'DDD'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'SIAFI'
        DataType = ftString
        Size = 20
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 672
    Top = 217
    object cdsDadosCEP: TStringField
      FieldName = 'CEP'
      Size = 10
    end
    object cdsDadosLogradouro: TStringField
      DisplayWidth = 30
      FieldName = 'Logradouro'
      Size = 255
    end
    object cdsDadosComplemento: TStringField
      DisplayWidth = 20
      FieldName = 'Complemento'
      Size = 255
    end
    object cdsDadosUnidade: TStringField
      DisplayWidth = 15
      FieldName = 'Unidade'
      Size = 255
    end
    object cdsDadosBairro: TStringField
      DisplayWidth = 20
      FieldName = 'Bairro'
      Size = 255
    end
    object cdsDadosLocalidade: TStringField
      DisplayWidth = 20
      FieldName = 'Localidade'
      Size = 255
    end
    object cdsDadosUF: TStringField
      DisplayWidth = 3
      FieldName = 'UF'
      Size = 3
    end
    object cdsDadosEstado: TStringField
      DisplayWidth = 30
      FieldName = 'Estado'
      Size = 100
    end
    object cdsDadosRegiao: TStringField
      DisplayLabel = 'Regi'#227'o'
      DisplayWidth = 20
      FieldName = 'Regiao'
      Size = 255
    end
    object cdsDadosIBGE: TStringField
      FieldName = 'IBGE'
    end
    object cdsDadosGIA: TStringField
      DisplayWidth = 10
      FieldName = 'GIA'
      Size = 255
    end
    object cdsDadosDDD: TStringField
      FieldName = 'DDD'
      Size = 5
    end
    object cdsDadosSIAFI: TStringField
      FieldName = 'SIAFI'
    end
  end
  object FDConnection: TFDConnection
    Params.Strings = (
      'Password=1234'
      'Server=127.0.0.1'
      'Database=ViaCep'
      'User_Name=postgres'
      'DriverID=PG')
    LoginPrompt = False
    Left = 672
    Top = 289
  end
  object ViaCep: TViaCepComponent
    TipoRetornoConsulta = trcJSON
    Left = 671
    Top = 353
  end
end
