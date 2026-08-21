Option Explicit

Dim fso, shell, scriptDir, ps1Path, startCommand, checkCommand, checkResult

Set fso = CreateObject("Scripting.FileSystemObject")
Set shell = CreateObject("WScript.Shell")

scriptDir = fso.GetParentFolderName(WScript.ScriptFullName)
ps1Path = fso.BuildPath(scriptDir, "TripleCtrlScreenshot.ps1")

If Not fso.FileExists(ps1Path) Then
    MsgBox "TripleCtrlScreenshot.ps1 was not found. Keep all source files in the same folder.", 16, "Ctrl Screenshot Free"
    WScript.Quit 1
End If
startCommand = "powershell.exe -NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File """ & ps1Path & """"
shell.Run startCommand, 0, False

' Wait up to five seconds for the listener mutex. This catches policy blocks,
' Add-Type failures, and other startup errors that would otherwise stay hidden.
checkCommand = "powershell.exe -NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -Command ""$ok=$false;for($i=0;$i -lt 20;$i++){try{$m=[Threading.Mutex]::OpenExisting('Local\TripleCtrlScreenshot.Listener');$m.Dispose();$ok=$true;break}catch{Start-Sleep -Milliseconds 250}};if($ok){exit 0}else{exit 1}"""
checkResult = shell.Run(checkCommand, 0, True)

If checkResult <> 0 Then
    MsgBox "The screenshot listener could not start. Check Windows PowerShell permissions or security software, then try again.", 16, "Ctrl Screenshot Free"
    WScript.Quit 1
End If
