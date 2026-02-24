@echo off
:: Verifica se um nome de arquivo foi fornecido
if "%~1"=="" (
    echo Erro: Informe o nome do arquivo.
    echo Exemplo: cob.bat meu_programa
    exit /b 1
)

set ARQUIVO=%~1

:: Compilação (-x para executável, -free para formato livre)
echo [COBOL] Compilando %ARQUIVO%.COB...
cobc -x "%ARQUIVO%.COB"

:: Se o erro for 0, executa o programa
if %errorlevel% equ 0 (
    echo [OK] Sucesso! Iniciando execucao...
    echo ---------------------------------------
    move /y "%ARQUIVO%.exe" "..\objects"
) else (
    echo [ERRO] Falha na compilacao.
)