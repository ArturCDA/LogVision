#!/bin/bash

echo "========================================="
echo "🧪 Iniciando disparo de logs automatizado"
echo "========================================="

# URL da sua API (ajuste se o endpoint for diferente)
API_URL="http://localhost:8080/logs"

# Função para enviar um log e aguardar
enviar_log() {
  local level=$1
  local message=$2
  
  echo "Enviando: [$level] $message"
  curl -s -X POST "$API_URL" \
       -H "Content-Type: application/json" \
       -d "{\"level\": \"$level\", \"message\": \"$message\"}" > /dev/null
  
  # Espera 2 segundos entre cada envio (igual ao Delay do Postman)
  sleep 2
}

# Disparando a nossa massa de dados
enviar_log "INFO" "Serviço iniciado com sucesso na porta 8080."
enviar_log "WARN" "Uso de memória da API ultrapassou 75%."
enviar_log "ERROR" "Falha ao autenticar usuário: token expirado."
enviar_log "INFO" "Novo usuário cadastrado no sistema."
enviar_log "FATAL" "Queda de conexão com o servidor de pagamentos."

echo "========================================="
echo "✅ Teste concluído! Aguarde 10 segundos e verifique o arquivo logs_processados.json"
echo "========================================="