@echo off
:: Check for Administrator privileges
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo This script requires administrator privileges.
    echo Please run as administrator.
    pause
    exit /b
)

echo Disabling Win + Shift + S and Print Screen hotkeys...

:: Disable Win + Shift + S by adding DisabledHotkeys entry
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v DisabledHotkeys /t REG_SZ /d S /f

:: Disable Print Screen from opening Snipping Tool
reg add "HKEY_CURRENT_USER\Control Panel\Keyboard" /v PrintScreenKeyForSnippingEnabled /t REG_DWORD /d 0 /f

echo.
echo Snippet shortcuts have been removed.
echo Restarting Windows Explorer for changes to take effect.
pause

:: Restart Windows Explorer
taskkill /f /im explorer.exe
start explorer.exe