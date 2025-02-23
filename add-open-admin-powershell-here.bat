@echo off
:: Check for Administrator privileges
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo This script requires administrator privileges.
    echo Please run as administrator.
    pause
    exit /b
)

echo Adding 'Open Admin PowerShell Here' to right-click context menu...

:: Add registry key for folders
reg add "HKEY_CLASSES_ROOT\Directory\shell\OpenAdminPS" /ve /d "Open Admin PowerShell Here" /f
reg add "HKEY_CLASSES_ROOT\Directory\shell\OpenAdminPS" /v "Icon" /d "powershell.exe" /f
reg add "HKEY_CLASSES_ROOT\Directory\shell\OpenAdminPS\command" /ve /d "powershell -Command \"Start-Process powershell.exe -ArgumentList '-NoExit', '-Command', 'cd ''%%V''' -Verb RunAs\"" /f

:: Add registry key for desktop background (empty area)
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\OpenAdminPS" /ve /d "Open Admin PowerShell Here" /f
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\OpenAdminPS" /v "Icon" /d "powershell.exe" /f
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\OpenAdminPS\command" /ve /d "powershell -Command \"Start-Process powershell.exe -ArgumentList '-NoExit', '-Command', 'cd ''%%V''' -Verb RunAs\"" /f

echo.
echo 'Open Admin PowerShell Here' has been added to the context menu.
pause

:: Restart Windows Explorer to apply changes
taskkill /f /im explorer.exe
start explorer.exe
