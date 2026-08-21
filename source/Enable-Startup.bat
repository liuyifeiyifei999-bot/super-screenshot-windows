@echo off
setlocal

if not exist "%~dp0Manage-Startup.vbs" (
  echo Manage-Startup.vbs was not found.
  pause
  exit /b 1
)

"%WINDIR%\System32\cscript.exe" //nologo "%~dp0Manage-Startup.vbs" enable
if errorlevel 1 (
  echo The startup entry could not be created or verified.
  pause
  exit /b 1
)

echo Added to Windows startup.
echo The script will start automatically after the next sign-in.
pause
