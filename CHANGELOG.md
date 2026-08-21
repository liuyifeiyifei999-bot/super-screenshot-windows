# Changelog

## Documentation update - 2026-08-21

- Added the native Windows full-edition introduction and real application screenshots.
- Documented the US$3.99 total price for both EXE editions, personal multi-computer use, WeChat contact, and private-repository delivery.
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
