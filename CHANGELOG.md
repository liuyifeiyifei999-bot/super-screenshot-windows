# Changelog

## 1.1.1 - 2026-08-22

- Added real Free and Pro operation demos: short GIFs for the repository and full bilingual MP4 videos for the Release.
- Added a ready-to-run Free ZIP with the six runtime/startup-management scripts at the package root.
- Simplified Quick Start to download, extract, double-click, and triple-tap Left Ctrl.
- Updated all Pro screenshots and demo scenes to the v1.1.1 application and EXE version.
- Documented the repair-startup-path confirmation and success flow after moving the EXE.
- Added direct Release download links and final GitHub presentation improvements.
- No change to the Free triple-tap trigger algorithm.

## Ctrl Screenshot brand update - 2026-08-21

- Renamed the product from Super Screenshot to **Ctrl Screenshot**.
- Corrected the Pro startup controls: **Start automatically** remains the lower enable button, while **Repair startup path** is a separate upper button for moved EXE files.
- Rebuilt the repository landing page around **Triple Ctrl = Screenshot**.
- Clearly separated Ctrl Screenshot Free from Ctrl Screenshot Pro.
- Renamed the startup value to `CtrlScreenshotFree` while cleaning up the former value for compatibility.
- Updated screenshots, commercial details, documentation, repository description, and release packaging.

## Documentation update - 2026-08-21

- Added the native Windows full-edition introduction and real application screenshots.
- Documented the one-time US$3.99 price for both EXE editions, personal multi-computer use, WeChat contact, and private-repository delivery.
- Added the annotated startup-path repair explanation and clarified that the repair happens immediately after clicking the button.

## 1.1.0 - 2026-08-21

- Replaced deprecated `keybd_event` calls with one `SendInput` sequence.
- Marshalled stop requests to the WinForms message-loop thread.
- Added launcher self-check for blocked or failed listener startup.
- Replaced locale-dependent Chinese source filenames with portable ASCII names.
- Made startup configuration target the exact launcher filename.
- Moved startup configuration to a dedicated per-user `Run` value after
  detecting that some Windows policies block PowerShell from modifying the
  Startup folder.
- Added verified startup-value creation/removal and bilingual documentation.
- Clarified that historical HTML mockups are not executable features.
