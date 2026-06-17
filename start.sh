#!/bin/bash

echo "🚀 Iniciando verificação do ambiente..."

if ! command -v java >/dev/null 2>&1; then
    echo ""
    echo "❌ Java não encontrado."
    echo "Instale o Java 21 antes de continuar."
    exit 1
fi

if [ ! -f ".env" ]; then

    cat > .env << EOF

DB_URL=
DB_USER=
DB_PASSWORD=
EOF

    echo ""
    echo "⚠️ Arquivo .env criado automaticamente."
    echo "⚠️ Configure as variáveis antes de executar o projeto."
    echo ""
    echo "Exemplo:"
    echo "DB_URL=jdbc:postgresql://localhost:5432/logdb"
    echo "DB_USER=postgres"
    echo "DB_PASSWORD=sua_senha"
    echo ""
    echo "Arquivo de referência disponível em:"
    echo ".env.example"
    echo ""
    echo "Após configurar o .env, execute novamente:"
    echo "./start.sh"

    exit 1
fi

set -a
source .env
set +a

: "${DB_URL:?❌ DB_URL não configurada.}"
: "${DB_USER:?❌ DB_USER não configurada.}"
: "${DB_PASSWORD:?❌ DB_PASSWORD não configurada.}"

echo ""
echo "✅ Variáveis carregadas com sucesso."
echo "🚀 Iniciando aplicação..."
echo ""

./mvnw spring-boot:run