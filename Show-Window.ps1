Function Show-Window(){
    [CmdletBinding()]param( # DefaultParameterSetName="PSName"
        [Parameter(Mandatory=$True,Position=0,ParameterSetName='PSName')][Parameter(Mandatory=$false,ParameterSetName='PSID')][Parameter(Mandatory=$false,ParameterSetName='PSTitle')]
		[string]$process_name,
		[Parameter(Mandatory=$True,ParameterSetName='PSID')][Parameter(Mandatory=$false,ParameterSetName='PSName')][Parameter(Mandatory=$false,ParameterSetName='PSTitle')]
        [string]$process_id,
		[Parameter(Mandatory=$True,ParameterSetName='PSTitle')][Parameter(Mandatory=$false,ParameterSetName='PSID')][Parameter(Mandatory=$false,ParameterSetName='PSName')]
        [string]$process_title,
		[Parameter(Mandatory=$True,ParameterSetName='PSWindow')]
		[ValidateScript({$_.Current.ControlType.ProgrammaticName -eq 'ControlType.Window'})]
		[Windows.Automation.AutomationElement]$window
	)
	# get the process
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
	if(!$window){$window = Get-UIWindow -process_id $process.id}
	[System.Windows.Automation.Window]::Activate($window.Current.NativeWindowHandle)
}
