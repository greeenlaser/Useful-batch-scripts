@echo off
:: Check for Administrator privileges
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo This script requires administrator privileges.
    echo Please run as administrator.
    pause
    exit /b
)

echo Restoring Xbox Game Bar overlay via registry settings...

:: Restore Game Bar startup panel
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\GameBar" /v "ShowStartupPanel" /t REG_DWORD /d 1 /f

:: Restore Game DVR functionalities that bring up the overlay
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d 1 /f
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v "GameDVR_Enabled" /t REG_DWORD /d 1 /f

echo.
echo Xbox Game Bar overlay restored via registry settings.
echo Restarting Windows Explorer to apply changes.
pause

:: Restart Windows Explorer to apply changes immediately
taskkill /f /im explorer.exe
start explorer.exe
