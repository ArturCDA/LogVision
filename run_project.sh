#!/bin/bash

echo "========================================="
echo "🚀 Iniciando o ambiente do LogVision..."
echo "========================================="

# Verificar se o .env existe
if [ ! -f .env ]; then
    echo "⚠️ Arquivo .env não encontrado!"
    echo "Criando um arquivo .env de exemplo para você..."
    cp .env.example .env
    echo "Por favor, edite o arquivo .env com suas configurações e rode o script novamente."
    exit 1
fi

# Carregar as variáveis do .env para a sessão atual
export $(grep -v '^#' .env | xargs)

# 1. Pegar o diretório atual de forma dinâmica
DIR_ATUAL=$(pwd)

# 2. Limpar os arquivos de estado do Logstash dinamicamente
echo "[1/4] Limpando arquivos de controle antigos..."
rm -f "$DIR_ATUAL/logstash/data/plugins/inputs/jdbc/logstash_jdbc_last_run"
rm -f "$DIR_ATUAL/logstash/.last_run"

# 3. Limpar o banco de dados
# Utiliza as credenciais já configuradas no seu projeto (postgres/123456) [cite: 69, 70] e a base logsdb [cite: 68]
echo "[2/4] Resetando a tabela do PostgreSQL..."
sudo PGPASSWORD=ph12345 psql -U postgres -h localhost -d logdb -c "TRUNCATE TABLE logs RESTART IDENTITY;"

# 4. Iniciar o Spring Boot em segundo plano
echo "[3/4] Iniciando a API Spring Boot (rodando em background)..."

# 5. Iniciar o Logstash
echo "[4/4] Iniciando o Logstash..."
# Passamos o PWD como variável de ambiente para o Logstash saber onde salvar o JSON
PWD=$DIR_ATUAL /usr/share/logstash/bin/logstash \
  --path.settings /etc/logstash \
  --path.data "$DIR_ATUAL/logstash/data" \
  -f "$DIR_ATUAL/logstash/logstash.conf"

# Quando o usuário apertar Ctrl+C para parar o Logstash, garantimos que o Spring Boot também pare
kill $SPRING_PID
echo "Ambiente encerrado com sucesso."