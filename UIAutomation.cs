using System;
using System.Runtime.InteropServices;
using System.Drawing;

namespace System.Windows.Automation
{
    public static class KeyStroke
    {
        private const uint WM_CHAR = 0x0102;
        private const uint WM_CLEAR = 0x00303;
        private const uint WM_COPY = 0x0301;
        private const uint WM_PASTE = 0x0302;
        private const uint WM_CUT = 0x0300;

        internal static class SafeNativeMethods
        {
            [return: MarshalAs(UnmanagedType.Bool)]
            [DllImport("user32.dll", CharSet = CharSet.Unicode, SetLastError = true)]
            internal static extern bool PostMessage(IntPtr hWnd, uint Msg, IntPtr wParam, IntPtr lParam);

            [return: MarshalAs(UnmanagedType.SysUInt)]
            [DllImport("user32.dll", CharSet = CharSet.Unicode, SetLastError = true)]
            internal static extern IntPtr SendMessage(IntPtr hWnd, uint Msg, IntPtr wParam, IntPtr lParam);
        }

        public static void Send(IntPtr hWindow, string message)
        {
            for (int i = 0; i < message.Length; i++)
            {
                SafeNativeMethods.PostMessage(hWindow, WM_CHAR, (IntPtr)message[i], IntPtr.Zero);
            }
        }
        public static void SendWait(IntPtr hWindow, string message)
        {
            for (int i = 0; i < message.Length; i++)
            {
                SafeNativeMethods.SendMessage(hWindow, WM_CHAR, (IntPtr)message[i], IntPtr.Zero);
            }
        }

        private static uint GetClipboardActionType(String ActionType)
        {
            uint message = WM_COPY;
            switch (ActionType.ToUpper())
            {
                case "COPY":
                    message = WM_COPY;
                    break;
                case "PASTE":
                    message = WM_PASTE;
                    break;
                case "CUT":
                    message = WM_CUT;
                    break;
                case "CLEAR":
                    message = WM_CLEAR;
                    break;
            }
            return message;
        }

        public static void SendClipboard(IntPtr hWindow, String ActionType)
        {
            SafeNativeMethods.PostMessage(hWindow, GetClipboardActionType(ActionType), IntPtr.Zero, IntPtr.Zero);
        }
        public static void SendClipboardWait(IntPtr hWindow, String ActionType)
        {
            SafeNativeMethods.SendMessage(hWindow, GetClipboardActionType(ActionType), IntPtr.Zero, IntPtr.Zero);
        }
    }

    public static class Window
    {
        internal static class SafeNativeMethods
        {
            [return: MarshalAs(UnmanagedType.Bool)]
            [DllImport("user32.dll", SetLastError = true)]
            internal static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);

            [return: MarshalAs(UnmanagedType.Bool)]
            [DllImport("user32.dll")]
            internal static extern bool SetForegroundWindow(IntPtr hWnd);

            [DllImport("user32.dll")]
            [return: MarshalAs(UnmanagedType.Bool)]
            internal static extern bool GetWindowPlacement(IntPtr hWnd, ref WINDOWPLACEMENT lpwndpl);
        }

        public struct WINDOWPLACEMENT
        {
            public int length;
            public int flags;
            public int showCmd;
            public Point ptMinPosition;
            public Point ptMaxPosition;
            public Rectangle rcNormalPosition;
            public Rectangle rcDevice;
        }

        public static void Activate(IntPtr hWnd)
        {
            SafeNativeMethods.ShowWindow(hWnd, 9); // try to restore window anyway
            SafeNativeMethods.SetForegroundWindow(hWnd); // then active window

        }

        public static void Maximize(IntPtr hWnd)
        {
            SafeNativeMethods.ShowWindow(hWnd, 3); // try to Maximize window anyway
            SafeNativeMethods.SetForegroundWindow(hWnd); // then active window
        }

        public static int GetWindowState(IntPtr handle)
        {
            WINDOWPLACEMENT placement = new WINDOWPLACEMENT();
            placement.length = Marshal.SizeOf(placement);
            SafeNativeMethods.GetWindowPlacement(handle, ref placement);
            return placement.showCmd;
        }
    }

    public static class Mouse
    {
        private const int WM_LBUTTONDOWN = 0x0201;
        private const int WM_LBUTTONUP = 0x0202;

        internal static class SafeNativeMethods
        {
            [return: MarshalAs(UnmanagedType.Bool)]
            [DllImport("user32.dll", CharSet = CharSet.Unicode, SetLastError = true)]
            internal static extern bool PostMessage(IntPtr hWnd, uint Msg, int wParam, int lParam);

            [return: MarshalAs(UnmanagedType.SysUInt)]
            [DllImport("user32.dll", CharSet = CharSet.Unicode, SetLastError = true)]
            internal static extern IntPtr SendMessage(IntPtr hWnd, uint Msg, IntPtr wParam, IntPtr lParam);

            [DllImport("user32.dll", SetLastError = true)]
            internal static extern uint SendInput(uint nInputs, ref INPUT pInputs, int cbSize);

            [DllImport("user32.dll")]
            internal static extern bool ScreenToClient(IntPtr hWnd, ref Point lpPoint);
        }


        [StructLayout(LayoutKind.Sequential)]
        public struct INPUT
        {
            public int type;
            public MouseKeybdhardwareInputUnion mkhi;
        }
        [StructLayout(LayoutKind.Explicit)]
        public struct MouseKeybdhardwareInputUnion
        {
            [FieldOffset(0)]
            public MouseInputData mi;
        }

        public struct MouseInputData
        {
            public int dx;
            public int dy;
            public uint mouseData;
            public MouseEventFlags dwFlags;
            public uint time;
            public IntPtr dwExtraInfo;
        }
        [Flags]
        public enum MouseEventFlags : uint
        {
            MOUSEEVENTF_MOVE = 0x0001,
            MOUSEEVENTF_LEFTDOWN = 0x0002,
            MOUSEEVENTF_LEFTUP = 0x0004,
            MOUSEEVENTF_ABSOLUTE = 0x8000
        }

        enum SystemMetric
        {
            SM_CXSCREEN = 0,
            SM_CYSCREEN = 1,
        }

        [DllImport("user32.dll")]
        static extern int GetSystemMetrics(SystemMetric smIndex);

        private static int CalculateAbsoluteCoordinateX(int x)
        {
            return (x * 65536) / GetSystemMetrics(SystemMetric.SM_CXSCREEN);
        }

        private static int CalculateAbsoluteCoordinateY(int y)
        {
            return (y * 65536) / GetSystemMetrics(SystemMetric.SM_CYSCREEN);
        }

        public static void ClickLeftButton(int x, int y)
        {
            INPUT mouseInput = new INPUT
            {
                type = 0
            };
            mouseInput.mkhi.mi.dx = CalculateAbsoluteCoordinateX(x);
            mouseInput.mkhi.mi.dy = CalculateAbsoluteCoordinateY(y);
            mouseInput.mkhi.mi.mouseData = 0;

            mouseInput.mkhi.mi.dwFlags = MouseEventFlags.MOUSEEVENTF_MOVE | MouseEventFlags.MOUSEEVENTF_ABSOLUTE;
            SafeNativeMethods.SendInput(1, ref mouseInput, Marshal.SizeOf(new INPUT()));

            mouseInput.mkhi.mi.dwFlags = MouseEventFlags.MOUSEEVENTF_LEFTDOWN;
            SafeNativeMethods.SendInput(1, ref mouseInput, Marshal.SizeOf(new INPUT()));

            mouseInput.mkhi.mi.dwFlags = MouseEventFlags.MOUSEEVENTF_LEFTUP;
            SafeNativeMethods.SendInput(1, ref mouseInput, Marshal.SizeOf(new INPUT()));
        }

        public static void SendLeftClick(IntPtr hWnd, int x, int y) {
            //Point p = new Point(x, y);
            //SafeNativeMethods.ScreenToClient(hWnd, ref p);
            //Console.WriteLine(p.Y);
            //Console.WriteLine(p.X);
            //int coordinates = (short)(p.Y << 16) | (short)(p.X & 0xFFFF); 
			
            //int coordinates = y << 16 |x & 0xFFFF; 
			
            // SafeNativeMethods.PostMessage(hWnd, WM_LBUTTONDOWN, 1, coordinates);
            // SafeNativeMethods.PostMessage(hWnd, WM_LBUTTONUP, 0, coordinates);
            SafeNativeMethods.PostMessage(hWnd, WM_LBUTTONDOWN, 1, 31);
            SafeNativeMethods.PostMessage(hWnd, WM_LBUTTONUP, 0, 51);
        }
    }

    public static class Screen {
        internal static class SafeNativeMethods
        {
            [DllImport("gdi32.dll")]
            public static extern IntPtr CreateDC(
                string lpszDriver, // driver name驱动名
                string lpszDevice, // device name设备名
                string lpszOutput, // not used; should be NULL
                IntPtr lpInitData // optional printer data
            );

            [DllImport("gdi32.dll")]
            public static extern IntPtr CreateCompatibleDC(IntPtr hdc);    // handle to DC

            [DllImport("gdi32.dll")]
            public static extern IntPtr CreateCompatibleBitmap(
                IntPtr hdc, // handle to DC
                int nWidth, // width of bitmap, in pixels
                int nHeight // height of bitmap, in pixels
            );

            [DllImport("gdi32.dll")]
            public static extern IntPtr SelectObject(
                IntPtr hdc, // handle to DC
                IntPtr hgdiobj // handle to object
            );

            [DllImport("gdi32.dll")]
            public static extern int DeleteDC(IntPtr hdc);   // handle to DC


            [DllImport("gdi32.dll")]
            public static extern IntPtr DeleteObject(IntPtr hObject);


            [DllImport("user32.dll")]
            public static extern bool PrintWindow(
                IntPtr hwnd, // Window to copy,Handle to the window that will be copied. 
                IntPtr hdcBlt, // HDC to print into,Handle to the device context. 
                UInt32 nFlags // Optional flags,Specifies the drawing options. It can be one of the following values. 
            );

            [DllImport("user32.dll")]
            public static extern IntPtr GetWindowDC(IntPtr hwnd);

            [DllImport("user32.dll")]
            public static extern IntPtr ReleaseDC(IntPtr hWnd, IntPtr hDC);
        }
        public static void TakeWindowScreenshot(IntPtr hWnd, string SaveFile) { //hWnd可以是窗口、控件等的handle
            IntPtr hscrdc = SafeNativeMethods.GetWindowDC(hWnd);
            Control control = Control.FromHandle(hWnd);
            IntPtr hbitmap = SafeNativeMethods.CreateCompatibleBitmap(hscrdc, control.Width, control.Height);
            IntPtr hmemdc = SafeNativeMethods.CreateCompatibleDC(hscrdc);
            SafeNativeMethods.SelectObject(hmemdc, hbitmap);
            bool re = SafeNativeMethods.PrintWindow(hWnd, hmemdc, 0);
            Bitmap bmp = null;
            if (re)
            {
                bmp = Bitmap.FromHbitmap(hbitmap);
            }
            SafeNativeMethods.DeleteObject(hbitmap);
            SafeNativeMethods.DeleteDC(hmemdc);//删除用过的对象       
            SafeNativeMethods.ReleaseDC(hWnd, hscrdc);
            return bmp;
        }
    }
}
