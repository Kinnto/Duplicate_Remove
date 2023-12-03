@echo off
title Batch Script by Kinnto Lee
setlocal enabledelayedexpansion

REM -- Choose mode
:chooseMode
echo Choose a mode:
echo 1. Fast Mode (Files will be permanently deleted)
echo 2. Normal Mode (Files will be moved to Recycle Bin)
set /p modeChoice="Enter your choice (1 or 2): "

REM -- Confirm choice
if "%modeChoice%"=="1" (
    echo You have chosen Fast Mode. Files will be permanently deleted.
) else if "%modeChoice%"=="2" (
    echo You have chosen Normal Mode. Files will be moved to Recycle Bin.
) else (
    echo Invalid choice. Please try again.
    goto chooseMode
)

set /p confirm="Are you sure? (Y/N): "
if /i not "%confirm%"=="Y" goto chooseMode

REM -- Ask the user for file extension
set /p fileExt="Enter file extension (e.g., txt) or type 'all' for all files: "

REM -- Set the file search pattern based on user input
if /i "%fileExt%"=="all" (
    set "pattern=*.*"
) else (
    set "pattern=*.%fileExt%"
)

REM -- Change directory to the script's location
cd /d "%~dp0"

REM -- Initialize progress bar
set "progress=0"
set "totalFiles=0"

REM -- Count total files for progress calculation
for %%F in (%pattern%) do set /a totalFiles+=1

REM -- Iterate over files based on the pattern
for %%F in (%pattern%) do (
    set /a progress+=1
    set /a percent=progress*100/totalFiles
    cls
    echo Progress: !percent!%% - Script by Kinnto Lee
    echo.

    set "maxName=%%F"
    REM -- Compare with other files
    for %%G in (%pattern%) do (
        REM -- Check if file size is the same and not the same file
        if %%~zF==%%~zG if not "%%F"=="%%G" (
            REM -- Check if the name length is longer
            if "!maxName!"=="%%F" (
                if "%%~nG" gtr "%%~nF" (
                    set "maxName=%%G"
                    if "%modeChoice%"=="1" (
                        del "%%F"
                    ) else (
                        powershell -Command "& {Add-Type -AssemblyName Microsoft.VisualBasic; [Microsoft.VisualBasic.FileIO.FileSystem]::DeleteFile('%%F', 'OnlyErrorDialogs', 'SendToRecycleBin')}"
                    )
                )
            ) else (
                if "%modeChoice%"=="1" (
                    del "%%G"
                ) else (
                    powershell -Command "& {Add-Type -AssemblyName Microsoft.VisualBasic; [Microsoft.VisualBasic.FileIO.FileSystem]::DeleteFile('%%G', 'OnlyErrorDialogs', 'SendToRecycleBin')}"
                )
            )
        )
    )
)

echo Done.
pause
