using System;
using System.Runtime.InteropServices;

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
        }

        public static void Activate(IntPtr hWnd)
        {

            SafeNativeMethods.ShowWindow(hWnd,9); // try to restore window anyway
            SafeNativeMethods.SetForegroundWindow(hWnd); // then active window

        }
		
		public static void Maximize(IntPtr hWnd)
		{
			SafeNativeMethods.ShowWindow(hWnd, 3); // try to Maximize window anyway
			SafeNativeMethods.SetForegroundWindow(hWnd); // then active window
		}
    }

	public static class Mouse
	{

		[DllImport("user32.dll", SetLastError = true)]
		static extern uint SendInput(uint nInputs, ref INPUT pInputs, int cbSize);

		[StructLayout(LayoutKind.Sequential)]
		struct INPUT
		{
			public int type;
			public MouseKeybdhardwareInputUnion mkhi;
		}
		[StructLayout(LayoutKind.Explicit)]
		struct MouseKeybdhardwareInputUnion
		{
			[FieldOffset(0)]
			public MouseInputData mi;
		}

		struct MouseInputData
		{
			public int dx;
			public int dy;
			public uint mouseData;
			public MouseEventFlags dwFlags;
			public uint time;
			public IntPtr dwExtraInfo;
		}
		[Flags]
		enum MouseEventFlags : uint
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
			// mouseInput.mkhi.mi.dwFlags = MouseEventFlags.MOUSEEVENTF_MOVE; 
			SendInput(1, ref mouseInput, Marshal.SizeOf(new INPUT()));

			mouseInput.mkhi.mi.dwFlags = MouseEventFlags.MOUSEEVENTF_LEFTDOWN;
			SendInput(1, ref mouseInput, Marshal.SizeOf(new INPUT()));

			mouseInput.mkhi.mi.dwFlags = MouseEventFlags.MOUSEEVENTF_LEFTUP;
			SendInput(1, ref mouseInput, Marshal.SizeOf(new INPUT()));

		}
	}
}
