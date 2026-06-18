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
├── logstash/data/
├── src/
├── .env
├── .env.example
├── .gitignore
├── mvnw
├── mvnw.cmd
├── pom.xml
├── README.md
├── run_project.sh
├── testar_api.sh
└── testes_log.json
```

## 🛠️ Pré-requisitos do Sistema

Antes de iniciar, certifique-se de ter as seguintes ferramentas instaladas e configuradas na sua máquina (Ambiente Linux):

* **Java 17+** (gerenciado via Maven/pom.xml)
* **PostgreSQL:** Deve estar em execução na porta `5432`.
    * **Banco de dados:** `logsdb`
    * **Usuário:** `postgres`
    * **Senha:** `sua_senha_aqui`
* **Logstash (Elastic Stack):** Instalado no diretório padrão `/usr/share/logstash/bin/logstash`.
* **cURL:** Para rodar o script de testes automatizados.

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

## 🚀 Como Executar o Projeto

1. Clone este repositório.
2. Dê permissão de execução para os scripts:
   \`\`\`bash
   chmod +x run_project.sh testar_api.sh start.sh
   \`\`\`
3. Inicie o pipeline completo (API, Banco e Logstash) com um único comando:
   \`\`\`bash
   ./run_project.sh
   \`\`\`
4. Em um novo terminal, dispare os testes simulados (substitui o Postman):
   \`\`\`bash
   ./testar_api.sh
   \`\`\`
5. Verifique o arquivo gerado \`logs_processados.json\` no diretório raiz.

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