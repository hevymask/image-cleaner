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

set /a SUCCESS=0
set /a ERROR=0

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
echo.
"%EXIFTOOL%" -all= --ICC_Profile -o "%OUTPUT%\%NAME%%EXT%" "%INPUT%"
echo.

if errorlevel 1 (
    echo [ERROR] Cleaning failed with %INPUT%.
    set /a ERROR+=1
) else (
    set /a SUCCESS+=1
)

shift
goto LOOP

:END

set /a TOTAL=SUCCESS+ERROR

echo.
echo Total:   %TOTAL%
echo Success: %SUCCESS%
echo Error:   %ERROR%
echo.

pause
