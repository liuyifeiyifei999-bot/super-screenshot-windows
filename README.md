# Ctrl Screenshot

## Triple Ctrl = Screenshot

**三按 Ctrl = 截图**

Turn `Win + Shift + S` into three simple Left Ctrl taps.

Windows 自带截图已经很好用。Ctrl Screenshot 不重新制作截图工具，只把截图这个高频动作变得更容易触发。

**Free & Open Source · 免费开源 · 无需安装 · 不联网**

![Ctrl Screenshot Pro 真实主界面](docs/images/ctrl-screenshot-pro-main-zh.png)

> 图片展示的是 Ctrl Screenshot Pro。当前公开仓库提供固定三按的免费开源版。

Current version: **1.1.0**

## 为什么 Ctrl Screenshot？ / Why Ctrl Screenshot?

传统方式：`Win + Shift + S`

Ctrl Screenshot：`Triple Ctrl = Screenshot`

Left Ctrl 是左手很容易找到的按键。连续轻按后，截图可以变成自然的肌肉记忆。

> Ctrl Screenshot 不重新发明截图工具。它只是让 Windows 截图变得更容易触发。

> Ctrl Screenshot does not replace the Windows Snipping Tool. It makes it faster to open.

区域选择、截图、剪贴板和通知仍然全部由 Windows 处理。

## 免费版快速开始 / Free Quick Start

1. 下载或克隆本仓库。
2. 打开 `source` 文件夹。
3. 双击 `Start-TripleCtrl-Screenshot.vbs`。
4. 连续轻按三次左 Ctrl。
5. 使用 Windows 截图界面选择区域。

停止监听时，运行 `Stop-TripleCtrl-Screenshot.bat`。完整说明见 [使用教程](docs/USAGE.md)。

1. Download or clone this repository.
2. Open `source`.
3. Run `Start-TripleCtrl-Screenshot.vbs`.
4. Triple-tap Left Ctrl.
5. Select a region in the Windows Snipping Tool.

## Free vs Pro

| 功能 / Feature | Ctrl Screenshot Free | Ctrl Screenshot Pro |
|---|---:|---:|
| 三按左 Ctrl 截图 / Triple Ctrl | ✅ | ✅ |
| 双按左 Ctrl 截图 / Double Ctrl | — | ✅ |
| 原生图形界面 / Native GUI | — | ✅ |
| 中文 / English | — | ✅ |
| 托盘控制 / Tray controls | — | ✅ |
| 隐藏托盘版 / Hidden-tray edition | — | ✅ |
| 开机启动 / Start with Windows | ✅ | ✅ |
| 绿色便携 / Portable | ✅ | ✅ |
| 不上传截图 / No screenshot upload | ✅ | ✅ |
| 价格 / Price | Free | **US$3.99** |

## Ctrl Screenshot Pro

### Double Ctrl or Triple Ctrl = Screenshot

**双按或三按 Ctrl = 截图**

原生 Windows GUI，可自由切换双按或三按，同时包含：

- **Tray Edition**：托盘显示版，可打开、暂停、恢复或退出。
- **Hidden Tray Edition**：隐藏托盘版，无托盘图标，再次运行 EXE 可唤回界面。

**Both editions included — US$3.99 total.**

优先通过微信 `ZZSygwh2025` 联系；也可发送邮件至 `liuyifeiyifei999@gmail.com`。付款确认后提供 GitHub 用户名，受邀进入私有仓库获取两个版本。

[查看完整介绍、截图和购买说明 →](docs/COMMERCIAL_EDITION.md)

## 隐私 / Privacy

- No account / 无需账号
- No screenshot upload / 不上传截图
- No telemetry / 无遥测
- No ads / 无广告
- Screenshot handled by Windows / 截图由 Windows 处理

详细行为和限制见 [隐私与安全](docs/PRIVACY_AND_SECURITY.md)。

## 工作原理 / How It Works

免费版使用 VBScript 启动隐藏的 PowerShell 监听器，只判断左 Ctrl 的独立按下与松开。三次有效轻按后，它通过 `SendInput` 调用 `Win + Shift + S`。右 Ctrl、长按以及 `Ctrl+C`、`Ctrl+V` 等组合键不会累计，原有按键仍会传递给当前软件。

The Free edition launches a hidden PowerShell listener through VBScript. It counts independent Left Ctrl taps and uses `SendInput` to invoke `Win + Shift + S` after three valid taps. It does not replace Windows capture, editing, OCR, or storage features.

## 文档 / Documentation

- [使用教程 / Usage](docs/USAGE.md)
- [常见问题 / Troubleshooting](docs/TROUBLESHOOTING.md)
- [隐私与安全 / Privacy & Security](docs/PRIVACY_AND_SECURITY.md)
- [校验记录 / Validation](docs/VALIDATION.md)
- [更新日志 / Changelog](CHANGELOG.md)
- [Ctrl Screenshot Pro](docs/COMMERCIAL_EDITION.md)

## 联系 / Contact

- GitHub: [liuyifeiyifei999-bot](https://github.com/liuyifeiyifei999-bot)
- Email: [liuyifeiyifei999@gmail.com](mailto:liuyifeiyifei999@gmail.com)
- WeChat: `ZZSygwh2025`

## License

公开仓库中的 Ctrl Screenshot Free 按 [MIT License](LICENSE) 授权。Ctrl Screenshot Pro 的 C 源码、商业 EXE 和私有资料不属于 MIT 授权范围。

Ctrl Screenshot Free is licensed under the [MIT License](LICENSE). The proprietary C source, commercial EXE files, and private materials for Ctrl Screenshot Pro are not covered by the MIT License.
