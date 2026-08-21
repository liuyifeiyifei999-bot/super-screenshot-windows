# 三按左 Ctrl 启动 Windows 区域截图
# 无需安装第三方软件；脚本会在后台监听键盘。
# 规则：每次间隔不超过 500 毫秒，连续轻点三次“左 Ctrl”。
# Ctrl 与其他键组合使用时不会累计次数。

$ErrorActionPreference = "Stop"

Add-Type -AssemblyName System.Windows.Forms

$source = @"
using System;
using System.Diagnostics;
using System.Runtime.InteropServices;
using System.Threading;
using System.Windows.Forms;

public static class TripleCtrlScreenshotListener
{
    private const int WH_KEYBOARD_LL = 13;
    private const int WM_KEYDOWN = 0x0100;
    private const int WM_KEYUP = 0x0101;
    private const int WM_SYSKEYDOWN = 0x0104;
    private const int WM_SYSKEYUP = 0x0105;

    private const int VK_LCONTROL = 0xA2;
    private const byte VK_LWIN = 0x5B;
    private const byte VK_SHIFT = 0x10;
    private const byte VK_S = 0x53;
    private const uint KEYEVENTF_KEYUP = 0x0002;
    private const string MutexName = @"Local\TripleCtrlScreenshot.Listener";
    private const string StopEventName = @"Local\TripleCtrlScreenshot.Stop";

    private static readonly LowLevelKeyboardProc Proc = HookCallback;
    private static IntPtr HookId = IntPtr.Zero;

    private static bool leftCtrlIsDown = false;
    private static bool ctrlWasUsedWithAnotherKey = false;
    private static int tapCount = 0;
    private static long lastTapMilliseconds = 0;
    private const int MaxGapMilliseconds = 500;
    private static System.Windows.Forms.Control uiControl = null;

    public static void Run()
    {
        bool ownsMutex = false;

        using (Mutex singleInstanceMutex = new Mutex(false, MutexName))
        {
            try
            {
                try
                {
                    ownsMutex = singleInstanceMutex.WaitOne(0, false);
                }
                catch (AbandonedMutexException)
                {
                    ownsMutex = true;
                }

                // 已经有一个监听程序在运行时，直接退出，避免重复监听。
                if (!ownsMutex)
                {
                    return;
                }

                using (EventWaitHandle stopEvent = new EventWaitHandle(
                    false,
                    EventResetMode.AutoReset,
                    StopEventName
                ))
                {
                    RegisteredWaitHandle stopRegistration =
                        ThreadPool.RegisterWaitForSingleObject(
                            stopEvent,
                            delegate(Object state, bool timedOut)
                            {
                                if (uiControl != null && uiControl.IsHandleCreated)
                                {
                                    uiControl.BeginInvoke(new Action(() => Application.Exit()));
                                }
                                else
                                {
                                    Application.Exit();
                                }
                            },
                            null,
                            Timeout.Infinite,
                            true
                        );

                    try
                    {
                        uiControl = new System.Windows.Forms.Control();
                        uiControl.CreateControl();

                        HookId = SetHook(Proc);
                        if (HookId == IntPtr.Zero)
                        {
                            throw new InvalidOperationException("无法安装键盘监听。");
                        }

                        Application.Run();
                    }
                    finally
                    {
                        stopRegistration.Unregister(null);

                        if (HookId != IntPtr.Zero)
                        {
                            UnhookWindowsHookEx(HookId);
                            HookId = IntPtr.Zero;
                        }
                    }
                }
            }
            finally
            {
                if (ownsMutex)
                {
                    singleInstanceMutex.ReleaseMutex();
                }
            }
        }
    }

    private static IntPtr SetHook(LowLevelKeyboardProc proc)
    {
        using (Process currentProcess = Process.GetCurrentProcess())
        using (ProcessModule currentModule = currentProcess.MainModule)
        {
            return SetWindowsHookEx(
                WH_KEYBOARD_LL,
                proc,
                GetModuleHandle(currentModule.ModuleName),
                0
            );
        }
    }

    private static IntPtr HookCallback(int nCode, IntPtr wParam, IntPtr lParam)
    {
        if (nCode >= 0)
        {
            int virtualKey = Marshal.ReadInt32(lParam);
            bool isKeyDown =
                wParam == (IntPtr)WM_KEYDOWN ||
                wParam == (IntPtr)WM_SYSKEYDOWN;
            bool isKeyUp =
                wParam == (IntPtr)WM_KEYUP ||
                wParam == (IntPtr)WM_SYSKEYUP;

            if (virtualKey == VK_LCONTROL)
            {
                // 忽略按住 Ctrl 时产生的自动重复
                if (isKeyDown && !leftCtrlIsDown)
                {
                    leftCtrlIsDown = true;
                    ctrlWasUsedWithAnotherKey = false;
                }
                else if (isKeyUp && leftCtrlIsDown)
                {
                    leftCtrlIsDown = false;

                    if (!ctrlWasUsedWithAnotherKey)
                    {
                        long now = DateTime.UtcNow.Ticks / TimeSpan.TicksPerMillisecond;

                        if (lastTapMilliseconds == 0 ||
                            now - lastTapMilliseconds <= MaxGapMilliseconds)
                        {
                            tapCount++;
                        }
                        else
                        {
                            tapCount = 1;
                        }

                        lastTapMilliseconds = now;

                        if (tapCount >= 3)
                        {
                            tapCount = 0;
                            lastTapMilliseconds = 0;

                            ThreadPool.QueueUserWorkItem(delegate
                            {
                                Thread.Sleep(80);
                                OpenWindowsScreenClip();
                            });
                        }
                    }
                    else
                    {
                        // Ctrl+C、Ctrl+V、Ctrl+Space 等组合键不算三连按
                        tapCount = 0;
                        lastTapMilliseconds = 0;
                    }
                }
            }
            else if (isKeyDown)
            {
                if (leftCtrlIsDown)
                {
                    ctrlWasUsedWithAnotherKey = true;
                }

                // 中间按了别的键，取消当前三连按计数
                tapCount = 0;
                lastTapMilliseconds = 0;
            }
        }

        // 不吞掉任何按键，所有原有键盘操作继续正常工作
        return CallNextHookEx(HookId, nCode, wParam, lParam);
    }

    private static void OpenWindowsScreenClip()
    {
        // 模拟 Win + Shift + S，打开 Windows 自带区域截图界面。
        // 使用 SendInput 一次性发送按键序列，比已过时的 keybd_event 更稳定，
        // 且不会干扰单独按 Win 键打开“开始”菜单等正常功能。
        INPUT[] inputs = new INPUT[6];
        inputs[0] = MakeKey(VK_LWIN, 0);
        inputs[1] = MakeKey(VK_SHIFT, 0);
        inputs[2] = MakeKey(VK_S, 0);
        inputs[3] = MakeKey(VK_S, KEYEVENTF_KEYUP);
        inputs[4] = MakeKey(VK_SHIFT, KEYEVENTF_KEYUP);
        inputs[5] = MakeKey(VK_LWIN, KEYEVENTF_KEYUP);

        SendInput((uint)inputs.Length, inputs, Marshal.SizeOf(typeof(INPUT)));
    }

    private static INPUT MakeKey(byte vk, uint flags)
    {
        INPUT input = new INPUT();
        input.type = 1; // INPUT_KEYBOARD
        input.ki.wVk = vk;
        input.ki.wScan = 0;
        input.ki.dwFlags = flags;
        input.ki.time = 0;
        input.ki.dwExtraInfo = IntPtr.Zero;
        return input;
    }

    private delegate IntPtr LowLevelKeyboardProc(
        int nCode,
        IntPtr wParam,
        IntPtr lParam
    );

    [DllImport("user32.dll", CharSet = CharSet.Auto, SetLastError = true)]
    private static extern IntPtr SetWindowsHookEx(
        int idHook,
        LowLevelKeyboardProc lpfn,
        IntPtr hMod,
        uint dwThreadId
    );

    [DllImport("user32.dll", CharSet = CharSet.Auto, SetLastError = true)]
    [return: MarshalAs(UnmanagedType.Bool)]
    private static extern bool UnhookWindowsHookEx(IntPtr hhk);

    [DllImport("user32.dll", CharSet = CharSet.Auto, SetLastError = true)]
    private static extern IntPtr CallNextHookEx(
        IntPtr hhk,
        int nCode,
        IntPtr wParam,
        IntPtr lParam
    );

    [DllImport("kernel32.dll", CharSet = CharSet.Auto, SetLastError = true)]
    private static extern IntPtr GetModuleHandle(string lpModuleName);

    [StructLayout(LayoutKind.Sequential)]
    private struct KEYBDINPUT
    {
        public ushort wVk;
        public ushort wScan;
        public uint dwFlags;
        public uint time;
        public IntPtr dwExtraInfo;
    }

    // 与 INPUT 联合体中等价于 KEYBDINPUT 的成员对齐（x64 下整体 40 字节）。
    [StructLayout(LayoutKind.Explicit, Size = 40)]
    private struct INPUT
    {
        [FieldOffset(0)] public int type;
        [FieldOffset(8)] public KEYBDINPUT ki;
    }

    [DllImport("user32.dll", SetLastError = true)]
    private static extern uint SendInput(
        uint nInputs,
        [MarshalAs(UnmanagedType.LPArray), In] INPUT[] pInputs,
        int cbSize
    );
}
"@

Add-Type -TypeDefinition $source -ReferencedAssemblies @(
    "System.dll",
    "System.Windows.Forms.dll"
)
[TripleCtrlScreenshotListener]::Run()
