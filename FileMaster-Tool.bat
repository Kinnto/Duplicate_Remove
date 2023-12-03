@echo off
title Batch Script by Kinnto Lee
setlocal enabledelayedexpansion

REM -- Get the full path of the batch script
set "batchFilePath=%~f0"

REM -- Initial Choice
echo Choose a function:
echo 1. ExtOrganizer
echo 2. Duplicate Remove
set /p functionChoice="Enter your choice (1 or 2): "

REM -- Confirm choice
if "%functionChoice%"=="1" (
    echo You have chosen ExtOrganizer.
    goto extOrganizer
) else if "%functionChoice%"=="2" (
    echo You have chosen Duplicate Remove.
    goto duplicateRemove
) else (
    echo Invalid choice. Please try again.
    goto :EOF
)

:duplicateRemove
REM -- Duplicate Remove functionality
echo Starting Duplicate Remove...
echo.

REM -- Choose mode for Duplicate Remove
:chooseModeDuplicateRemove
echo Choose a mode for Duplicate Remove:
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
    goto chooseModeDuplicateRemove
)

set /p confirm="Are you sure? (Y/N): "
if /i not "%confirm%"=="Y" goto chooseModeDuplicateRemove

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

REM -- Initialize progress bar
set "progress=0"
set "totalFiles=0"

REM -- Count total files for progress calculation
for %%F in (%pattern%) do set /a totalFiles+=1

REM -- Iterate over files based on the pattern for duplicate removal
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

echo Duplicate Remove Complete.
goto deleteEmptyFolders

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

:deleteEmptyFolders
REM -- Delete empty folders and folders with a size of 0 bytes
for /f %%D in ('dir /ad /s /b ^| sort /R') do (
    dir "%%D" | findstr /C:"File(s)" /C:"Dir(s)" | findstr /C:"0 File(s)" /C:"0 Dir(s)" > nul && (
        rmdir "%%D"
    )
)

echo ExtOrganizer Complete.

:endScript
echo Done.
pause
goto :EOF
