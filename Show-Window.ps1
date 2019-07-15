Function Show-Window(){
    [CmdletBinding(DefaultParameterSetName="PSName")]param(
        [Parameter(Mandatory=$True,Position=0,ParameterSetName='PSName')][Parameter(Mandatory=$false,ParameterSetName='PSID')][Parameter(Mandatory=$false,ParameterSetName='PSTitle')]
		[string]$process_name,
		[Parameter(Mandatory=$True,ParameterSetName='PSID')][Parameter(Mandatory=$false,ParameterSetName='PSName')][Parameter(Mandatory=$false,ParameterSetName='PSTitle')]
        [string]$process_id,
		[Parameter(Mandatory=$True,ParameterSetName='PSTitle')][Parameter(Mandatory=$false,ParameterSetName='PSID')][Parameter(Mandatory=$false,ParameterSetName='PSName')]
        [string]$process_title
	)
	Begin{
		$sig = '[DllImport("user32.dll")] public static extern bool ShowWindowAsync(IntPtr hWnd, int nCmdShow);'
		Add-Type -MemberDefinition $sig -name NativeMethods -namespace Win32
	}
	Process{
		If( $pscmdlet.ParameterSetName -eq "PSID" ){
			if(!($process = ps -id $process_id -ea 4)){
				Throw "Not found process with ID $process_id"
			}
		}elseif($pscmdlet.ParameterSetName -eq "PSName"){
			If( ($process=ps $process_name -ea 4) ){
				If($process.count -gt 1 ){
					If( [string]::IsNullOrWhiteSpace($process_title ) ){
						throw "Thera are more than one `"$process_name`" process, but process title has not been provided!"
					}
					$process= $process|?{$_.MainWindowTitle -eq $process_title}
					if(!$process){
						throw "Not found process with name $process_name"
					}
				}
			}Else{
				throw "Not found process with name $process_name"
			}
		}elseif($pscmdlet.ParameterSetName -eq "PSTitle"){
			If( ($process=ps $process_name -ea 4) ){
				If($process.count -gt 1 ){
					If( [string]::IsNullOrWhiteSpace($process_title ) ){
						throw "Thera are more than one `"$process_name`" process, but process title has not been provided!"
					}
					$process= $process|?{$_.MainWindowTitle -eq $process_title}
					if(!$process){
						throw "Not found process with name $process_name"
					}
				}
			}Else{
				throw "Not found process with name $process_name"
			}
		
		}
		[Win32.NativeMethods]::ShowWindowAsync($process.MainWindowHandle, 2) 1>$nul
		[Win32.NativeMethods]::ShowWindowAsync($process.MainWindowHandle, 4) 1>$nul
	}
}
