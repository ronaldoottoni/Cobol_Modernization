@echo off
if "%~1"=="" (
    echo Error: Insert the file name.
    exit /b 1
)

set ARQUIVO=%~1

echo [COBOL] Compiling %ARQUIVO%.COB...
cobc -m "%ARQUIVO%.COB" -I copy

if %errorlevel% equ 0 (
    echo [OK] Success!
    echo ---------------------------------------
    move /y "%ARQUIVO%.dll" "..\objects"
) else (
    echo [ERROR] Compilation failure.
)