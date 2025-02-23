@echo off
:: Check for Administrator privileges
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo This script requires administrator privileges.
    echo Please run as administrator.
    pause
    exit /b
)

echo Removing 'Open Admin CMD Here' from context menu...

:: Remove registry keys
reg delete "HKEY_CLASSES_ROOT\Directory\shell\OpenAdminCMD" /f
reg delete "HKEY_CLASSES_ROOT\Directory\Background\shell\OpenAdminCMD" /f

echo.
echo 'Open Admin CMD Here' has been removed from the context menu.
pause

:: Restart Windows Explorer
taskkill /f /im explorer.exe
start explorer.exe
