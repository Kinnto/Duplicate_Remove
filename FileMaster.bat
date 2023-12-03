@echo off
title Batch Script by Kinnto Lee
setlocal enabledelayedexpansion

REM -- Get the full path of the batch script
set "batchFilePath=%~f0"

REM -- Initial Choice
echo Choose a function:
echo 1. Duplicate Remove
echo 2. ExtOrganizer
set /p functionChoice="Enter your choice (1 or 2): "

REM -- Confirm choice
if "%functionChoice%"=="1" (
    echo You have chosen Duplicate Remove.
    goto duplicateRemove
) else if "%functionChoice%"=="2" (
    echo You have chosen ExtOrganizer.
    goto extOrganizer
) else (
    echo Invalid choice. Please try again.
    goto :EOF
)

:duplicateRemove
REM -- Duplicate Remove functionality
echo Starting Duplicate Remove...
echo.

REM -- Ask the user for file extension for duplicate removal
set /p fileExt="Enter file extension for Duplicate Remove (e.g., txt) or type 'all' for all files: "

REM -- Set the file search pattern based on user input
if /i "%fileExt%"=="all" (
    set "pattern=*.*"
) else (
    set "pattern=*.%fileExt%"
)

REM -- Change directory to the script's location
cd /d "%~dp0"

REM -- Iterate over files based on the pattern for duplicate removal
for %%F in (%pattern%) do (
    for %%G in (%pattern%) do (
        if %%~zF==%%~zG if not "%%F"=="%%G" (
            if "%%~nG" gtr "%%~nF" (
                del "%%F"
            ) else (
                del "%%G"
            )
        )
    )
)

echo Duplicate Remove Complete.
goto endScript

:extOrganizer
REM -- ExtOrganizer functionality
echo Starting ExtOrganizer...
echo.

REM -- Change directory to the script's location
cd /d "%~dp0"

REM -- Create folders based on extensions and move files
for /r %%F in (*) do (
    if "%%~fF" neq "%batchFilePath%" (
        set "ext=%%~xF"
        set "extFolder=!ext:~1!"
        if not exist "!extFolder!" (
            mkdir "!extFolder!"
        )
        move "%%F" "!extFolder!\%%~nxF"
    )
)

REM -- Delete original folders if empty
for /d %%D in (*) do (
    dir "%%D" | find "0 File(s)" > nul && rmdir "%%D"
)

echo ExtOrganizer Complete.

:endScript
echo Done.
pause
goto :EOF
