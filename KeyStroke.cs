using System;
using System.Runtime.InteropServices;

namespace KeyStroke
{
    class Program
    {
        private const int WM_CHAR = 0x0102;
        private const int WM_CLEAR = 0x00303;
        private const int WM_COPY = 0x0301;
        private const int WM_PASTE = 0x0302;
        private const int WM_CUT = 0x0300;

        internal static class SafeNativeMethods
        {
            [return: MarshalAs(UnmanagedType.Bool)]
            [DllImport("user32.dll", CharSet = CharSet.Unicode, SetLastError = true)]
            internal static extern bool PostMessage(IntPtr hWnd, uint Msg, IntPtr wParam, IntPtr lParam);
        }

        public static void SendString(IntPtr hWindow, string message)
        {
            for (int i = 0; i < message.Length; i++)
            {
                SafeNativeMethods.PostMessage(hWindow, WM_CHAR, (IntPtr)message[i], IntPtr.Zero);
            }

        }

        public static void SendClipboard(IntPtr hWindow, String ActionType)
        {
            int message;
            switch (ActionType)
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
            SafeNativeMethods.PostMessage(hWindow, message, IntPtr.Zero, IntPtr.Zero);
        }
    }
}
