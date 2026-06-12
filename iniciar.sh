#!/bin/bash
PORT=7474
DIR="$(cd "$(dirname "$0")" && pwd)"

echo ""
echo " ============================================"
echo "   J.A.R.V.I.S.  |  MM Softwares"
echo "   Gabriel Lombardi - Implantacao e Treinamento"
echo " ============================================"
echo ""

# Verifica se servidor já está rodando
if lsof -i :$PORT > /dev/null 2>&1; then
  echo " [OK] Servidor já está rodando na porta $PORT."
else
  # Tentar Python 3
  if command -v python3 &>/dev/null; then
    echo " [OK] Python 3 encontrado. Iniciando servidor..."
    python3 -m http.server $PORT --directory "$DIR" &
    sleep 2
  elif command -v python &>/dev/null; then
    echo " [OK] Python encontrado. Iniciando servidor..."
    python -m http.server $PORT --directory "$DIR" &
    sleep 2
  elif command -v node &>/dev/null; then
    echo " [OK] Node.js encontrado. Iniciando servidor..."
    npx --yes serve -p $PORT -s "$DIR" &
    sleep 3
  else
    echo " [ERRO] Python ou Node.js não encontrado."
    echo " Instale Python em: https://www.python.org/downloads/"
    exit 1
  fi
fi

echo " [OK] Abrindo J.A.R.V.I.S. no Chrome..."
echo ""
echo " URL: http://localhost:$PORT/jarvis.html"
echo " Mantenha este terminal aberto enquanto usar o JARVIS."
echo ""

# Abrir no Chrome
if command -v google-chrome &>/dev/null; then
  google-chrome "http://localhost:$PORT/jarvis.html"
elif command -v google-chrome-stable &>/dev/null; then
  google-chrome-stable "http://localhost:$PORT/jarvis.html"
elif [[ "$OSTYPE" == "darwin"* ]]; then
  open -a "Google Chrome" "http://localhost:$PORT/jarvis.html"
else
  echo " Abra manualmente no Chrome: http://localhost:$PORT/jarvis.html"
fi

wait
