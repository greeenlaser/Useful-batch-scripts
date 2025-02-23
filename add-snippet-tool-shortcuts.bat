@echo off
:: Check for Administrator privileges
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo This script requires administrator privileges.
    echo Please run as administrator.
    pause
    exit /b
)

echo Re-enabling Win + Shift + S and Print Screen hotkeys...

:: Remove DisabledHotkeys entry to re-enable Win + Shift + S
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v DisabledHotkeys /f

:: Re-enable Print Screen for Snipping Tool
reg add "HKEY_CURRENT_USER\Control Panel\Keyboard" /v PrintScreenKeyForSnippingEnabled /t REG_DWORD /d 1 /f

echo.
echo Snippet shortcuts have been restored.
echo Restarting Windows Explorer for changes to take effect.
pause

:: Restart Windows Explorer
taskkill /f /im explorer.exe
start explorer.exe
