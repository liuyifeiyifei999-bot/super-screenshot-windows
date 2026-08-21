Option Explicit

Const RunValuePath = "HKCU\Software\Microsoft\Windows\CurrentVersion\Run\SuperScreenshotScript"

Dim fso, shell, mode, scriptDir, launcherPath, wscriptPath, runCommand
Dim savedValue, readError

If WScript.Arguments.Count <> 1 Then
    WScript.Echo "Usage: Manage-Startup.vbs enable|disable"
    WScript.Quit 2
End If

mode = LCase(WScript.Arguments(0))
Set fso = CreateObject("Scripting.FileSystemObject")
Set shell = CreateObject("WScript.Shell")

scriptDir = fso.GetParentFolderName(WScript.ScriptFullName)
launcherPath = fso.BuildPath(scriptDir, "Start-TripleCtrl-Screenshot.vbs")
wscriptPath = shell.ExpandEnvironmentStrings("%WINDIR%\System32\wscript.exe")
runCommand = """" & wscriptPath & """ """ & launcherPath & """"

If mode = "enable" Then
    If Not fso.FileExists(launcherPath) Then
        WScript.Echo "Start-TripleCtrl-Screenshot.vbs was not found."
        WScript.Quit 1
    End If

    On Error Resume Next
    shell.RegWrite RunValuePath, runCommand, "REG_SZ"
    If Err.Number <> 0 Then
        WScript.Echo "Failed to write the startup registry value."
        WScript.Quit 1
    End If
    Err.Clear
    savedValue = shell.RegRead(RunValuePath)
    readError = Err.Number
    On Error GoTo 0

    If readError <> 0 Or StrComp(savedValue, runCommand, vbBinaryCompare) <> 0 Then
        WScript.Echo "The startup registry value could not be verified."
        WScript.Quit 1
    End If

    WScript.Quit 0
End If

If mode = "disable" Then
    On Error Resume Next
    shell.RegDelete RunValuePath
    Err.Clear
    savedValue = shell.RegRead(RunValuePath)
    readError = Err.Number
    On Error GoTo 0

    If readError = 0 Then
        WScript.Echo "The startup registry value still exists."
        WScript.Quit 1
    End If

    WScript.Quit 0
End If

WScript.Echo "Unknown mode. Use enable or disable."
WScript.Quit 2
