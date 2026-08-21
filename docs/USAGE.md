# 使用教程 / User Guide

## 1. 系统要求 / Requirements

- Windows 10 or Windows 11, 64-bit
- Windows PowerShell 5.1 or newer
- Windows Script Host enabled

管理员窗口、UAC 安全桌面和锁屏界面可能不会把按键事件传递给普通权限的监听器。这是 Windows 的权限隔离行为。

Elevated windows, the UAC secure desktop, and the lock screen may not deliver keyboard events to a normal-privilege listener. This is a Windows integrity-level limitation.

## 2. 启动和截图 / Start and Capture

1. 保持 `source` 目录中的所有文件在一起。
2. 双击 `Start-TripleCtrl-Screenshot.vbs`。
3. 在每次间隔不超过 500ms 的情况下，连续轻按三次左 Ctrl。
4. 使用 Windows 截图界面选择区域。

1. Keep all files in `source` together.
2. Double-click `Start-TripleCtrl-Screenshot.vbs`.
3. Tap Left Ctrl three times, with no more than 500ms between taps.
4. Select a region using the Windows screenshot overlay.

如果 PowerShell 被组织策略或安全软件禁止，启动脚本会在检测不到监听器时给出错误提示。

If PowerShell is blocked by policy or security software, the launcher reports that the listener did not start.

## 3. 识别规则 / Gesture Rules

- 只识别左 Ctrl。
- 必须完成按下和松开才计一次。
- 长按产生的自动重复不会增加次数。
- 左 Ctrl 与其他键组合使用时，本轮计数清零。
- 三次点击之间按下其他键，本轮计数清零。
- 所有按键继续传递给原应用。

- Only Left Ctrl is recognized.
- A full press and release counts as one tap.
- Auto-repeat from holding the key does not add taps.
- Using Left Ctrl with another key clears the current sequence.
- Pressing another key between taps clears the current sequence.
- All key events continue to the original application.

## 4. 停止监听 / Stop the Listener

运行 `Stop-TripleCtrl-Screenshot.bat`。它只向本工具的命名停止事件发送信号，不会按进程名结束其他 PowerShell 程序。

Run `Stop-TripleCtrl-Screenshot.bat`. It signals this tool's named stop event and does not terminate unrelated PowerShell processes by name.

## 5. 开机启动 / Start with Windows

- 运行 `Enable-Startup.bat` 写入当前用户的 Windows `Run` 启动项。
- 运行 `Disable-Startup.bat` 删除本工具自己的启动项。
- 如果移动了整个 `source` 目录，请重新运行 `Enable-Startup.bat` 更新启动路径。

- Run `Enable-Startup.bat` to write this tool's value under the current user's Windows `Run` key.
- Run `Disable-Startup.bat` to remove only this tool's startup value.
- If you move the `source` folder, run `Enable-Startup.bat` again to update the path.

## 6. 卸载 / Uninstall

1. 运行 `Stop-TripleCtrl-Screenshot.bat`。
2. 运行 `Disable-Startup.bat`。
3. 删除下载或克隆的仓库目录。

1. Run `Stop-TripleCtrl-Screenshot.bat`.
2. Run `Disable-Startup.bat`.
3. Delete the downloaded or cloned repository folder.
