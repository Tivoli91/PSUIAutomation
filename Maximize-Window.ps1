Function Maximize-Window(){
#(ps mstsc|?{$_.MainWindowTitle -imatch 'A8613PRICGC014'}).MainWindowHandle | % {Maximize-MstscWindow $_ -ShowInFront}
# (ps mstsc).MainWindowHandle |% {Maximize-MstscWindow $_}
    [CmdletBinding()]param(
        [Parameter(Mandatory=$True,ValueFromPipeline=$true,ValueFromPipelineByPropertyName=$true)]
        [int]$handle,
		[string]$process_name,
        [Switch]$ShowInFront
    )
    Begin {
        $sig = '[DllImport("user32.dll")] public static extern bool ShowWindowAsync(IntPtr hWnd, int nCmdShow);'
        Add-Type -MemberDefinition $sig -name NativeMethods -namespace Win32
    }
    Process {
        [Win32.NativeMethods]::ShowWindowAsync($handle, 3) 1>$nul
        If( $ShowInFront ){
            Show-Window (ps $process_name -ea 4|?{$handle -eq $_.MainWindowHandle}).MainWindowTitle
        }
    }
    End { }
}