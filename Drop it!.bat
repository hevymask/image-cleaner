:: Local Settings
@echo off
chcp 65001 > nul
setlocal

title Image Cleaner

set "EXIFTOOL=%~dp0exiftool.exe"

:: Confirm exiftool.exe exists
if not exist "%EXIFTOOL%" (
    echo [ERROR] exiftool.exe not found.
    pause
    exit /b 1
)

:: Confirm file is dropped
if "%~1"=="" (
    echo [ERROR] Drop photos.
    pause
    exit /b 1
)

echo [INFO] Starting cleaning image...

:: Loop through all dropped files
:LOOP

if "%~1"=="" goto END

set "INPUT=%~1"
set "DIR=%~dp1"
set "NAME=%~n1"
set "EXT=%~x1"
set "OUTPUT=%~dp1cleaned"

echo [INFO] %~nx1

:: Make output directory
if not exist "%OUTPUT%" mkdir "%OUTPUT%"

:: Clean
"%EXIFTOOL%" -all= --ICC_Profile -o "%OUTPUT%\%NAME%%EXT%" "%INPUT%"

if errorlevel 1 (
    echo [ERROR] An error has occurred.
) else (
    echo [INFO] Cleaned successfully.
)

shift
goto LOOP

:END

pause
