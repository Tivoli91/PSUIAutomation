using System;
using System.Runtime.InteropServices;

namespace KeyStroke
{
    class Program
    {
        private const int WM_CHAR = 0x0102;

        internal static class SafeNativeMethods
        {
            [return: MarshalAs(UnmanagedType.Bool)]
            [DllImport("user32.dll", CharSet = CharSet.Unicode, SetLastError = true)]
            internal static extern bool PostMessage(IntPtr hWnd, uint Msg, IntPtr wParam, IntPtr lParam);
        }


        /// <summary>
        /// Simulates pressing a key
        /// </summary>
        /// <param name="hWindow"></param>
        /// <param name="key"></param>
        public static void PressKey(IntPtr hWindow, string message)
        {
            for (int i = 0; i < message.Length; i++)
            {
                SafeNativeMethods.PostMessage(hWindow, WM_CHAR, (IntPtr)message[i], IntPtr.Zero);
            }

        }
        static void Main(string[] args)
        {
            
            PressKey((IntPtr)399224,"1654651");
            Console.ReadLine();
        }
    }
}
