# 校验记录 / Validation

Validation date: 2026-08-21

## Tested environment

- Windows 10 Pro 64-bit, build 19045
- zh-CN system and UI language
- Windows PowerShell 5.1
- Repository path containing Chinese characters
- Temporary English-only path containing spaces

Windows 11 and a native English Windows installation were not available in the current test environment. The launchable files use ASCII names; the PowerShell core is UTF-8 with BOM, so script decoding does not depend on the active ANSI code page.

## Source review findings addressed

1. The old launcher selected the first `.ps1` file in its directory. The new launcher targets `TripleCtrlScreenshot.ps1` exactly.
2. A prior project note claimed startup verification existed, but the launcher did not perform it. The new launcher waits for the named listener mutex and reports startup failure.
3. The original trigger used deprecated `keybd_event`. Version 1.1.0 uses one correctly aligned x64 `SendInput` sequence.
4. The stop callback previously called `Application.Exit()` from a worker callback. It now marshals the request to the WinForms message-loop thread.
5. Chinese ANSI launcher filenames created cross-locale risk. Public executable-script filenames are now ASCII, and the PowerShell core retains a UTF-8 BOM.
6. Startup-folder shortcut changes were blocked by policy in the tested environment. Startup configuration now uses one verified per-user registry value: `SuperScreenshotScript`.
7. Historical HTML pages described GUI and double-tap features that are not in the script edition. They are excluded, and the documentation states the actual feature set only.

## Checks completed

- PowerShell parser: passed
- Embedded C# `Add-Type` compilation under Windows PowerShell 5.1: passed
- Controlled launcher startup and named mutex detection: passed
- Dedicated stop event and listener shutdown: passed
- End-to-end triple Left Ctrl injection: passed
- Foreground screenshot overlay detected as `Windows.UI.Core.CoreWindow | 屏幕截图`: passed
- `ScreenClippingHost` process detected after the gesture: passed
- Escape cleanup after the screenshot-overlay test: passed
- Startup registry enable, exact command verification, disable, and state restoration: passed
- Launch and stop from an English path containing spaces: passed
- Launch and stop from the repository's Chinese parent path: passed
- Public-scope scan for EXE, C source, `.workbuddy`, ZIP, and historical HTML: passed

## Not automated

- Physical keyboard feel across different hardware
- Windows 11 behavior
- Native English Windows UI text
- Elevated/UAC/lock-screen input, which is intentionally limited by Windows integrity isolation
