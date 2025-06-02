@echo off
setlocal enabledelayedexpansion

:: Check for argument
if "%~1"=="" (
    echo Usage: ytflac_clean.bat "<YouTube URL>"
    pause
    exit /b 1
)

set "YTLINK=%~1"

:: Define words to remove from filename (add more if needed)
set "REMOVEWORDS=language russian english version official video lyrics audio hd live"

:: Download MP3 audio and filter output
echo Downloading...
yt-dlp --cookies-from-browser firefox -x --audio-format mp3 --audio-quality 0 --embed-thumbnail --add-metadata --windows-filenames -o "%%(title)s.%%(ext)s" "!YTLINK!" 2>&1 | findstr /R /C:"\[download\]" /C:"\[ExtractAudio\]" /C:"ERROR" /C:"\[ffmpeg" /C:"Destination"

:: Start renaming
echo Renaming files...

for %%F in (*.mp3) do (
    set "name=%%~nF"

    :: Strip common symbols
    set "name=!name:!=!"
    set "name=!name:#=!"
    set "name=!name:`=!"
    set "name=!name:^=!"
    set "name=!name:~=!"
    set "name=!name:* =!"
    set "name=!name:|=!"
    set "name=!name:< =!"
    set "name=!name:>=!"
    set "name=!name:?=!"
    set "name=!name:'=!"
    set "name=!name:"=!"

    :: Strip brackets/parentheses
    for %%S in ("(" ")" "[" "]") do set "name=!name:%%~S=!"

    :: Remove unwanted words
    for %%W in (%REMOVEWORDS%) do (
        set "name=!name:%%~W=!"
    )

    :: Normalize multiple spaces
    :cleanup
    set "name=!name:  = !"
    if not "!name!"=="!name:  = !" goto cleanup

    :: Trim leading/trailing space (simple workaround)
    for /f "tokens=* delims= " %%a in ("!name!") do set "name=%%a"

    ren "%%F" "!name!.mp3"
)

echo Done downloading and sanitizing.
pause
exit /b 0
