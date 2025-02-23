@echo off
:: Check for Administrator privileges
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo This script requires administrator privileges.
    echo Please run as administrator.
    pause
    exit /b
)

echo Restoring Windows 11 right-click context menu...

:: Remove the registry key to revert to Windows 11 context menu
reg delete "HKEY_CURRENT_USER\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" /f

:: Restart Windows Explorer
taskkill /f /im explorer.exe
start explorer.exe
