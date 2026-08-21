# 常见问题 / Troubleshooting

## 启动时提示监听器无法启动

- 确认 `Start-TripleCtrl-Screenshot.vbs` 与 `TripleCtrlScreenshot.ps1` 位于同一目录。
- 检查组织策略是否禁用了 Windows PowerShell、`Add-Type` 或 Windows Script Host。
- 查看安全软件是否拦截了低级键盘 Hook。
- 不需要管理员权限；优先以普通用户权限运行。

## The listener could not start

- Keep `Start-TripleCtrl-Screenshot.vbs` and `TripleCtrlScreenshot.ps1` in the same folder.
- Check whether organizational policy blocks Windows PowerShell, `Add-Type`, or Windows Script Host.
- Check whether security software blocks low-level keyboard hooks.
- Administrator rights are not normally required; run as a standard user first.

## 三按左 Ctrl 没反应 / Triple-tap does not respond

- 必须使用左 Ctrl，不是右 Ctrl。
- 每次间隔不能超过 500ms。
- 不要在连击中按其他键。
- 先确认 `Win + Shift + S` 本身可以打开 Windows 截图。
- 管理员窗口、UAC 和锁屏界面可能受 Windows 权限隔离限制。

- Use Left Ctrl, not Right Ctrl.
- Keep each gap within 500ms.
- Do not press another key during the sequence.
- Confirm that `Win + Shift + S` works on the system.
- Elevated windows, UAC, and the lock screen may be restricted by Windows integrity isolation.

## 关闭脚本显示未运行 / Stop script says not running

监听器已经退出或启动失败。重新运行启动 VBS；如果仍失败，请按上面的启动问题排查。

The listener has already exited or failed to start. Run the launcher again and follow the startup checks above if it still fails.

## 移动目录后无法开机启动 / Startup breaks after moving the folder

在新位置重新运行 `Enable-Startup.bat`。脚本会用当前启动器的完整路径覆盖 Ctrl Screenshot Free 自己的 `CtrlScreenshotFree` 注册表值。

Run `Enable-Startup.bat` again from the new location. It overwrites Ctrl Screenshot Free's `CtrlScreenshotFree` registry value with the launcher's current full path.
