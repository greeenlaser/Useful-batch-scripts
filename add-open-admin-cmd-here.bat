@echo off
:: Check for Administrator privileges
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo This script requires administrator privileges.
    echo Please run as administrator.
    pause
    exit /b
)

echo Adding 'Open Admin CMD Here' to right-click context menu...

:: Add registry key for folders
reg add "HKEY_CLASSES_ROOT\Directory\shell\OpenAdminCMD" /ve /d "Open Admin CMD Here" /f
reg add "HKEY_CLASSES_ROOT\Directory\shell\OpenAdminCMD" /v "Icon" /d "cmd.exe" /f
reg add "HKEY_CLASSES_ROOT\Directory\shell\OpenAdminCMD\command" /ve /d "powershell -Command \"Start-Process cmd.exe -ArgumentList '/k cd %%V' -Verb RunAs\"" /f

:: Add registry key for desktop background (empty area)
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\OpenAdminCMD" /ve /d "Open Admin CMD Here" /f
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\OpenAdminCMD" /v "Icon" /d "cmd.exe" /f
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\OpenAdminCMD\command" /ve /d "powershell -Command \"Start-Process cmd.exe -ArgumentList '/k cd %%V' -Verb RunAs\"" /f

echo.
echo 'Open Admin CMD Here' has been added to the context menu.
pause

:: Restart Windows Explorer to apply changes
taskkill /f /im explorer.exe
start explorer.exe
