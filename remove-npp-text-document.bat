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

:: Remove .txt registry keys
reg delete "HKEY_CLASSES_ROOT\.txt\ShellNew" /f
reg delete "HKEY_CLASSES_ROOT\.txt" /v PerceivedType /f
reg delete "HKEY_CLASSES_ROOT\.txt" /v "Content Type" /f

:: Remove txtfile class association
reg delete "HKEY_CLASSES_ROOT\txtfile\shell\open\command" /f
reg delete "HKEY_CLASSES_ROOT\txtfile\shell" /f
reg delete "HKEY_CLASSES_ROOT\txtfile" /f

:: Restore default Notepad association
assoc .txt=txtfile
ftype txtfile="C:\Windows\System32\notepad.exe" "%%1"

echo.
echo Notepad++ Text Document has been removed from the right-click 'New' menu.
echo Restarting Windows Explorer to apply changes.
pause

:: Restart Windows Explorer to apply changes immediately
taskkill /f /im explorer.exe
start explorer.exe
