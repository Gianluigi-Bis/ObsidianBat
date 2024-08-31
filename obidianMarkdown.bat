@echo off
setlocal enabledelayedexpansion

:: File temporaneo per copiare il contenuto del clipboard
set temp_file=%temp%\clipboard_content.txt

:: Copia il contenuto del clipboard in un file temporaneo
powershell -command "Get-Clipboard" > %temp_file%

:: Leggi il contenuto del file temporaneo
set /p header= < %temp_file%
set /a line_count=0

:: Apre il file markdown
echo | set /p="| "
for %%H in (%header%) do (
    echo | set /p="%%H | "
)
echo.
echo | set /p="| "
for %%H in (%header%) do (
    echo | set /p="--- | "
)
echo.

:: Leggi e formatta il resto delle righe
for /f "skip=1 tokens=*" %%A in (%temp_file%) do (
    echo | set /p="| "
    for %%B in (%%A) do (
        echo | set /p="%%B | "
    )
    echo.
)

:: Pulizia
del %temp_file%
pause
