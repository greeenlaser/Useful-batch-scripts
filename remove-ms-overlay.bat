@echo off
:: Check for Administrator privileges
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo This script requires administrator privileges.
    echo Please run as administrator.
    pause
    exit /b
)

echo Disabling Xbox Game Bar overlay...

:: Disable Game Bar startup panel
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\GameBar" /v "ShowStartupPanel" /t REG_DWORD /d 0 /f

:: Disable Game DVR functionalities that bring up the overlay
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d 0 /f
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v "GameDVR_Enabled" /t REG_DWORD /d 0 /f

echo.
echo Disabled Xbox Game Bar overlay via registry settings.
echo Restarting Windows Explorer to apply changes.
pause

:: Restart Windows Explorer to apply changes immediately
taskkill /f /im explorer.exe
start explorer.exe