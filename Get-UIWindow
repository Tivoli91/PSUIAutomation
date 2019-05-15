Function Get-UIWindow(){
    [CmdletBinding()]param(
        [Parameter(Mandatory=$True,ParameterSetName='PSName')]
        [string]$process_name,
		[Parameter(Mandatory=$True,ParameterSetName='PSID')]
        [int]$process_id,
        [string]$process_title,
        [string]$log_file
    )
    # reference link https://msdn.microsoft.com/en-us/library/system.windows.automation(v=vs.110).aspx
	If( $pscmdlet.ParameterSetName -eq "PSName" ){
	    If( ($process=ps $process_name -ea 4) ){
	        If($process.count -gt 1 ){
				If( [string]::IsNullOrWhiteSpace($process_title ) ){
					throw "Thera are more than one `"$process_name`" process, but process title has not been provided!"
				}
				$process_id=($process|?{$_.MainWindowTitle -imatch $process_title}|select -first 1).id
			}else{
				$process_id = $process.id
			}
	    }Else{
	        throw "Not found process $process_name"
	    }
	}
    Try{
		$root_element = [Windows.Automation.AutomationElement]::RootElement
		$wapc = New-Object Windows.Automation.PropertyCondition([Windows.Automation.AutomationElement]::ProcessIdProperty, $process_id)
		return $root_element.FindFirst([Windows.Automation.TreeScope]::Children, $wapc)
    }Catch{
        throw $_
    }Finally{}
}
