# LogVision - Monitoramento de Logs com Logstash

Projeto desenvolvido para a disciplina de **Banco de Dados II**, com o objetivo de demonstrar, na prática, o funcionamento do Logstash em um pipeline de coleta, armazenamento, processamento e visualização de logs.

## Objetivo

O sistema recebe eventos simulados via Postman, armazena-os em um banco de dados PostgreSQL e utiliza o Logstash para processar os registros. Os dados podem ser visualizados por meio de um dashboard desenvolvido com Bootstrap.

## Arquitetura do Projeto

```text
Postman
   ↓
Spring Boot API
   ↓
PostgreSQL
   ↓
Logstash
   ↓
Dashboard Bootstrap
```

## Tecnologias Utilizadas

* Java 21
* Spring Boot 3
* Maven Wrapper
* PostgreSQL
* Logstash
* Bootstrap 5
* Postman
* VS Code
* Git

## Estrutura do Projeto

```text
monitoramento-logs/

├── .mvn/
├── src/
├── .env
├── .env.example
├── .gitignore
├── mvnw
├── mvnw.cmd
├── pom.xml
├── README.md
└── start.sh
```

## Pré-requisitos

Antes de executar o projeto, certifique-se de possuir os seguintes requisitos instalados:

* Java 21
* Git
* PostgreSQL
* Logstash

### Verificando a instalação do Java

```bash
java --version
```

A saída deve ser semelhante a:

```text
openjdk 21
```

## Configuração do Banco de Dados

Crie um banco de dados PostgreSQL chamado `logdb`.

Exemplo utilizando o terminal:

```bash
sudo -u postgres psql
```

```sql
CREATE DATABASE logdb;
```

Defina uma senha para o usuário `postgres`:

```sql
ALTER USER postgres PASSWORD 'sua_senha';
```

Saia do PostgreSQL:

```sql
\q
```

## Configuração das Variáveis de Ambiente

As credenciais do banco de dados não são armazenadas no código-fonte.

Na primeira execução, o script `start.sh` criará automaticamente o arquivo `.env`, caso ele não exista.

Exemplo do conteúdo esperado:

```env
DB_URL=jdbc:postgresql://localhost:5432/logdb
DB_USER=postgres
DB_PASSWORD=sua_senha
```

O arquivo `.env.example` serve apenas como referência e documentação das variáveis necessárias.

> **Importante:** O arquivo `.env` está listado no `.gitignore` e não deve ser enviado ao repositório.

## Configuração do Spring Boot

O projeto utiliza variáveis de ambiente no arquivo `application.properties`:

```properties
spring.datasource.url=${DB_URL}
spring.datasource.username=${DB_USER}
spring.datasource.password=${DB_PASSWORD}
```

## Executando o Projeto

Clone o repositório:

```bash
git clone https://github.com/ArturCDA/LogVision.git
```

Acesse a pasta do projeto:

```bash
cd monitoramento-logs
```

Execute o script de inicialização:

```bash
./start.sh
```

Se o arquivo `.env` ainda não existir, ele será criado automaticamente e o script será encerrado.

Edite o arquivo:

```bash
nano .env
```

Configure as variáveis e execute novamente:

```bash
./start.sh
```

O script realiza automaticamente as seguintes etapas:

1. Verifica se o Java está instalado;
2. Verifica se o arquivo `.env` existe;
3. Carrega as variáveis de ambiente;
4. Valida as configurações obrigatórias;
5. Inicia a aplicação utilizando o Maven Wrapper.

A aplicação será iniciada em:

```text
http://localhost:8080
```

## Maven Wrapper

O projeto utiliza o Maven Wrapper (`mvnw`).

Portanto, não é necessário instalar o Maven manualmente.

O Wrapper fará o download automático da versão correta do Maven na primeira execução.

## Endpoints da API

### Criar um log

```http
POST /logs
```

Exemplo de requisição:

```json
{
  "level": "ERROR",
  "message": "Falha ao conectar ao banco de dados"
}
```

### Listar logs

```http
GET /logs
```

## Testando com o Postman

Envie uma requisição para:

```text
POST http://localhost:8080/logs
```

Com o seguinte corpo:

```json
{
  "level": "INFO",
  "message": "Usuário autenticado com sucesso"
}
```

## Configuração do Logstash

Crie um arquivo de configuração chamado `logstash.conf`:

```conf
input {
  jdbc {
    jdbc_driver_class => "org.postgresql.Driver"
    jdbc_connection_string => "jdbc:postgresql://localhost:5432/logdb"
    jdbc_user => "postgres"
    jdbc_password => "sua_senha"

    statement => "SELECT * FROM logs"

    schedule => "* * * * *"
  }
}

output {
  stdout {
    codec => rubydebug
  }
}
```

Execute o Logstash:

```bash
/usr/share/logstash/bin/logstash -f logstash.conf
```

## Dashboard

O dashboard desenvolvido com Bootstrap permite visualizar os registros armazenados no banco de dados.

Funcionalidades previstas:

* Listagem de logs;
* Filtro por nível;
* Contagem de eventos;
* Visualização dos registros mais recentes.

## Equipe

* **Artur Crispim de Andrade**
* **Pedro Henrique Santos de Pontes**

## Licença

Este projeto foi desenvolvido exclusivamente para fins acadêmicos.