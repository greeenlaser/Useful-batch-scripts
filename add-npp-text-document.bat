@echo off
:: Check for Administrator privileges
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo This script requires administrator privileges.
    echo Please run as administrator.
    pause
    exit /b
)

echo Creating .txt registry keys for 'New -> Text Document'...

:: Define Notepad++ path
set "NPP_PATH=C:\Program Files\Notepad++\notepad++.exe"

:: Verify if Notepad++ exists
if not exist "%NPP_PATH%" (
    echo Notepad++ not found at %NPP_PATH%.
    echo Please update the script with the correct path to notepad++.exe.
    pause
    exit /b
)

:: Ensure .txt uses the 'txtfile' ProgID
reg add "HKEY_CLASSES_ROOT\.txt" /ve /d "txtfile" /f

:: Enable 'New' context menu for .txt files
reg add "HKEY_CLASSES_ROOT\.txt\ShellNew" /v NullFile /t REG_SZ /d "" /f

:: Set perceived type and content type
reg add "HKEY_CLASSES_ROOT\.txt" /v PerceivedType /t REG_SZ /d "text" /f
reg add "HKEY_CLASSES_ROOT\.txt" /v "Content Type" /t REG_SZ /d "text/plain" /f

:: Define txtfile class (friendly name and open command)
reg add "HKEY_CLASSES_ROOT\txtfile" /ve /t REG_SZ /d "Text Document" /f
reg add "HKEY_CLASSES_ROOT\txtfile\shell" /ve /t REG_SZ /d "open" /f
reg add "HKEY_CLASSES_ROOT\txtfile\shell\open\command" /ve /t REG_SZ /d "\"%NPP_PATH%\" \"%%1\"" /f

:: Associate .txt with Notepad++
assoc .txt=txtfile
ftype txtfile="%NPP_PATH%" "%%1"

echo.
echo Notepad++ Text Document has been added to the right-click 'New' menu.
echo Restarting Windows Explorer for changes to take effect.
pause

:: Restart Windows Explorer to apply changes immediately
taskkill /f /im explorer.exe
start explorer.exe
