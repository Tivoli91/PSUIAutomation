Function Move-Cursor($x,$y){
    [void][System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
	[windows.forms.cursor]::Position = [System.Drawing.Point]::new($x,$y)
}
