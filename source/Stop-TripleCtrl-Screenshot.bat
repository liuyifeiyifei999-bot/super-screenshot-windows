@echo off
setlocal

powershell.exe -NoProfile -ExecutionPolicy Bypass -Command ^
  "try {$e=[Threading.EventWaitHandle]::OpenExisting('Local\TripleCtrlScreenshot.Stop'); [void]$e.Set(); $e.Dispose(); exit 0} catch [Threading.WaitHandleCannotBeOpenedException] {exit 1}"

if errorlevel 1 (
    echo The screenshot listener is not running.
    pause
    exit /b 1
)

echo The screenshot listener has been stopped.
pause
exit /b 0
