# <img alt="via-cep" height="20" src="https://viacep.com.br/favicon.ico" style="margin-bottom: -9px !important"> via-cep
Projeto para consulta de CEP utilizando o WebService público  ViaCEP (https://viacep.com.br).

# Recursos implementados
1. Permitir o armazenamento dos resultados das consultas.
2. Permitir consultas tanto por CEP quanto por endereço completo. 
3. Possibilitar a navegação pelos registros inseridos.
4. Caso um CEP ou endereço já exista no banco de dados, será questionado ao usuário se ele deseja atualizar os dados ou não.

# Estrutura
<b>database:</b> Contém script para criação do banco de dados com PostgreSQL (Possui também um backup, caso queira apenas restaurar)<br>
<b>lib:</b> Contém as DLLs necessárias para execução do projeto (SSL e Conexão do FireDAC com PostgreSQL)<br>
<b>sample:</b> Amostra do projeto, pronto para ser utilizado<br>
<b>src:</b> Fontes do projeto<br>

Dentro da pasta <b>src</b>, temos a seguinte extrutura<br>

<b>component:</b> Contém a implementação do componente ViaCep para realizar as consultas (é necessário realizar a instalação)<br>
<b>domain:</b> Contém as classes referente as entidades utilizadas no projeto<br>
<b>repository:</b> Contém as classes responsáveis pelo acesso ao banco de dados da aplicação<br>
<b>service:</b> Contém as classes de serviço, responsáveis por fazer a comunicação entre a interface do usuário e as classes de comunicação com o banco de dados<br>
<b>tests:</b> Contém as classes de teste da aplicação<br>
<b>ui:</b> Contém os formulários da aplicação (Interface do usuário)<br>
<b>utils:</b> Contém classes utilitárias com funções e método para uso da aplicação<br>

<b>Observação:</b> as pastas service e repository possuem subpastas com as interfaces implementadas nos serviços e repositórios

# Informações
O projeto e composto de um grupo com três subprojetos, um é um componente implementado para consumir a WebService da ViaCeps, o outro um projeto VCL que utiliza o componente implementado para realizar as buscas e salvamento dos dados, e o último o projeto com as classes de teste da aplicação.<br>

Foram utilizadas interfaces para promover o baixo acoplamento e utilizando em conjunto com TInterfacedObject, fornece um mecanismo automático de contagem de referência para gerir a vida útil do objeto, simplificando a gestão de memória.<br>

Utilizei uma estrutura em camadas, separando meus recursos de UI (Interface do usuário), Service (Serviços para encapsular o acesso as classes que acessam o banco de dados, e em projetos maiores podemos implementar nossas regras de negócio possibilitando uma reutilização, centralização, e permitindo focar na cobertura de código, a fim de cobrir o core de negócio da aplicação) e Repository (Responsável com encapsular o acesso a dados)<br>

Foi utilizando herança nas classes de modelo, mantendo a definição comum de campos em uma classe base e herdando nas definições utilizadas pelo consumo da API e pelo acesso a dados, possibilitando a utilização de métodos únicos para tratar ambas as entidades.<br>

Foram criados testes para as classes de utilitários com a exceção da classe mensagem, pois a mesma é uma implementação para criar mensagens para o usuário, não tendo necessidade. Um débito técnico foi a criação de testes para as classes de serviço e do componente, para isso é interessante utilizar alguma biblioteca de mock, para evitar a comunicação com o banco de dados e com a web.<br>

<b>Alguns dos componentes utilizados:</b> FireDAC, Indy, RESTComponents, DUnitX<br>

A implementação foi pensada para minimizar a repetição de código, visando o melhor reaproveitamento dos recursos e centralização de regras e tratamento, dando preferência a case, sempre que possível pois tem melhor desempenho em casos de tomadas de decisão com muitas opões. Foram criadas validações para garantir a integridade dos dados inseridos na aplicação afim de evitar erros no seu funcionamento, alguns valores foram sugeridos nas configurações para facilitar seu preenchimento, porem podendo ser modificados, se necessário<br>

<b>Versão do Delphi usada:</b> Delphi 12 and C++Builder 12 Update 1<br/>
<b>Banco de dados:</b> PostgreSQL.<br/>

# Utilização

Recomento a abertura do projeto ser feita utilizando o ViaCepGroup, pois possui os dois projeto, component e VCL.<br/>

Com o grupo de projetos aberto, é necessário realizar a instalação do ViaCepPackage, clicando com o botão direito e selecionado install (Recomento realizar um Clear e Build antes, para validar que todas as dependências do componente foram atendidas)<br/>

Em seguida no projeto ViaCep, realize o mesmo procedimento de Clear e Build, para validar a instalação de seus requisitos, entre eles o ViaCepComponent<br/>

Depois de realizar o build, copie as DLLs da pasta lib para a pasta do exe que foi gerado, normalmente sendo src\Win32\Debug<br/>

Agora já podemos executar o projeto, e realizar os testes de suas funcionalidades<br/>

# Contatos
<a href="https://www.linkedin.com/in/glerystonmatos/" target="_blank">Gleryston Matos</a><br/>
glerystonmatos@gmail.com<br/>