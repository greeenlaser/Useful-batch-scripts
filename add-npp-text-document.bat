@echo off
:: Check for Administrator privileges
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo This script requires administrator privileges.
    echo Please run as administrator.
    pause
    exit /b
)

echo Adding Notepad++ Text Document to right-click context menu...

:: Define Notepad++ path
set "NPP_PATH=C:\Program Files\Notepad++\notepad++.exe"

:: Verify if Notepad++ exists
if not exist "%NPP_PATH%" (
    echo Notepad++ not found at %NPP_PATH%.
    echo Please update the script with the correct path to notepad++.exe.
    pause
    exit /b
)

:: Associate .npp extension with Notepad++
reg add "HKEY_CLASSES_ROOT\.npp" /ve /d "NotepadPP.Document" /f
reg add "HKEY_CLASSES_ROOT\NotepadPP.Document" /ve /d "Notepad++ Text Document" /f
reg add "HKEY_CLASSES_ROOT\NotepadPP.Document\DefaultIcon" /ve /d "\"%NPP_PATH%\",0" /f
reg add "HKEY_CLASSES_ROOT\NotepadPP.Document\shell\open\command" /ve /d "\"%NPP_PATH%\" \"%%1\"" /f

:: Enable 'New' context menu for Notepad++ documents
reg add "HKEY_CLASSES_ROOT\.npp\ShellNew" /v NullFile /f

echo.
echo Notepad++ Text Document has been added to the right-click 'New' menu.
echo Restarting Windows Explorer for changes to take effect.
pause

:: Restart Windows Explorer to apply changes immediately
taskkill /f /im explorer.exe
start explorer.exe