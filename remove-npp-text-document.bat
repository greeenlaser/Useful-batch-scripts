@echo off
:: Check for Administrator privileges
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo This script requires administrator privileges.
    echo Please run as administrator.
    pause
    exit /b
)

echo Removing Notepad++ Text Document from right-click context menu...

:: Remove .npp file extension association
reg delete "HKEY_CLASSES_ROOT\.npp" /f

:: Remove Notepad++ Document association
reg delete "HKEY_CLASSES_ROOT\NotepadPP.Document" /f

echo.
echo Notepad++ Text Document has been removed from the right-click 'New' menu.
echo Restarting Windows Explorer to apply changes.
pause

:: Restart Windows Explorer to apply changes immediately
taskkill /f /im explorer.exe
start explorer.exe