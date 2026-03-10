@echo off
if "%~1"=="" (
    echo Error: Insert the file name.
    exit /b 1
)

set ARQUIVO=%~1

echo [COBOL] Compiling %ARQUIVO%.COB...
cobc -x "%ARQUIVO%.COB" -I copy -o "%ARQUIVO%"

if %errorlevel% equ 0 (
    echo [OK] Success
    echo ---------------------------------------
    move /y "%ARQUIVO%" "..\objects"
) else (
    echo [ERROR] Compilation failure.
)