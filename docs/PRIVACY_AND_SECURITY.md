# 隐私与安全 / Privacy & Security

## 中文

脚本版在本机使用 `SetWindowsHookEx` 安装 `WH_KEYBOARD_LL` 低级键盘 Hook。回调只维护以下临时状态：左 Ctrl 是否按下、是否与其他键组合使用、当前点击次数和上次点击时间。

本工具不会：

- 保存按键日志或用户输入文字
- 读取密码或文本框内容
- 读取、保存或上传截图
- 读取截图剪贴板数据
- 连接服务器、检查更新或发送遥测
- 强制终止其他 PowerShell 进程

完成三次左 Ctrl 手势后，工具通过 `SendInput` 模拟一次 `Win + Shift + S`。区域选择、截图和剪贴板处理全部由 Windows 完成。

源码需要全局按键监听和后台 PowerShell，因此部分安全软件可能提示风险。请从本仓库获取源码并自行审查；不要关闭系统安全功能，也不要把未知来源的同名脚本加入白名单。

## English

The script edition installs a `WH_KEYBOARD_LL` hook with `SetWindowsHookEx`. Its callback keeps only temporary gesture state: whether Left Ctrl is down, whether it was combined with another key, the current tap count, and the last tap time.

The tool does not:

- save key logs or typed text
- read passwords or text-field contents
- read, save, or upload screenshots
- inspect screenshot clipboard data
- contact servers, check for updates, or send telemetry
- terminate unrelated PowerShell processes

After the triple-tap gesture, the tool uses `SendInput` once to simulate `Win + Shift + S`. Windows handles region selection, capture, and clipboard behavior.

Global keyboard hooks and hidden PowerShell processes can trigger security warnings. Obtain the source from this repository and review it yourself. Do not disable system security features or whitelist similarly named scripts from unknown sources.
