@echo off
setlocal

if not exist "%~dp0Manage-Startup.vbs" (
  echo Manage-Startup.vbs was not found.
  pause
  exit /b 1
)

"%WINDIR%\System32\cscript.exe" //nologo "%~dp0Manage-Startup.vbs" disable
if errorlevel 1 (
  echo The startup entry could not be removed or verified.
  pause
  exit /b 1
)

echo Removed from Windows startup.
pause
