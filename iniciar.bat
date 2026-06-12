@echo off
title J.A.R.V.I.S. - Iniciando...
color 0A
cls
echo.
echo  ============================================
echo    J.A.R.V.I.S.  ^|  MM Softwares
echo    Gabriel Lombardi - Implantacao e Treinamento
echo  ============================================
echo.

set PORT=7474
set DIR=%~dp0

:: Verificar se a porta já está em uso
netstat -an | find ":%PORT%" | find "LISTENING" >nul 2>&1
if %errorlevel% == 0 (
  echo  [OK] Servidor ja esta rodando na porta %PORT%.
  goto :open
)

:: Tentar Python 3
python --version >nul 2>&1
if %errorlevel% == 0 (
  echo  [OK] Python encontrado. Iniciando servidor local...
  start /b python -m http.server %PORT% --directory "%DIR%"
  timeout /t 2 /nobreak >nul
  goto :open
)

:: Tentar Python como py
py --version >nul 2>&1
if %errorlevel% == 0 (
  echo  [OK] Python encontrado. Iniciando servidor local...
  start /b py -m http.server %PORT% --directory "%DIR%"
  timeout /t 2 /nobreak >nul
  goto :open
)

:: Tentar Node.js
node --version >nul 2>&1
if %errorlevel% == 0 (
  echo  [OK] Node.js encontrado. Instalando servidor...
  start /b npx --yes serve -p %PORT% -s "%DIR%"
  timeout /t 5 /nobreak >nul
  goto :open
)

echo  [ERRO] Python ou Node.js nao encontrado.
echo.
echo  Instale Python em: https://www.python.org/downloads/
echo  Durante a instalacao, marque a opcao "Add Python to PATH"
echo  Depois feche e reabra este arquivo.
echo.
pause
exit

:open
echo  [OK] Abrindo J.A.R.V.I.S. no Chrome...
echo.
echo  URL: http://localhost:%PORT%/jarvis.html
echo.
echo  Mantenha esta janela aberta enquanto usar o JARVIS.
echo  Para encerrar: feche esta janela ou pressione Ctrl+C
echo.

:: Tentar abrir no Chrome
start "" "chrome" "http://localhost:%PORT%/jarvis.html" >nul 2>&1
if %errorlevel% neq 0 (
  :: Chrome não encontrado no PATH, tentar locais comuns
  start "" "C:\Program Files\Google\Chrome\Application\chrome.exe" "http://localhost:%PORT%/jarvis.html" >nul 2>&1
  if %errorlevel% neq 0 (
    start "" "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" "http://localhost:%PORT%/jarvis.html" >nul 2>&1
    if %errorlevel% neq 0 (
      echo  Chrome nao encontrado automaticamente.
      echo  Abra manualmente: http://localhost:%PORT%/jarvis.html
    )
  )
)

pause
