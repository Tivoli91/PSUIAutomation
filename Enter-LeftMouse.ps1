Function Enter-LeftMouse(){
    $signature=@' 
        [DllImport("user32.dll",CharSet=CharSet.Auto, CallingConvention=CallingConvention.StdCall)]
        public static extern void mouse_event(long dwFlags, long dx, long dy, long cButtons, long dwExtraInfo);
'@ 
	$SendMouseClick = Add-Type -memberDefinition $signature -name "Win32MouseEventNew" -namespace Win32Functions -passThru 
	$SendMouseClick::mouse_event(0x00000002, 0, 0, 0, 0); #0x00000002 corresponds to a left-mouse-down move
	$SendMouseClick::mouse_event(0x00000004, 0, 0, 0, 0); #0x00000004 corresponds to a left-mouse-up move   
}