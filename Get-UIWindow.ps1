Function Get-UIWindow(){
    [CmdletBinding(DefaultParameterSetName='PSName')]param(
        [Parameter(Mandatory=$True,	Position=0,ParameterSetName='PSName')]
        [string]$process_name,
		[Parameter(Mandatory=$True,Position=0,ParameterSetName='PSID')]
        [int]$process_id,
        [string]$process_title,
        [string]$log_file
    )
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
	        throw "Not found process with name : $process_name"
	    }
	}
	if(!(ps -id $process_id -ea 4)){
		throw "Not found process with ID : $process_id"
	}
    Try{
		return `
		[Windows.Automation.AutomationElement]::RootElement.FindFirst(
			[Windows.Automation.TreeScope]::Children, 
			([Windows.Automation.PropertyCondition]::new(
					[Windows.Automation.AutomationElement]::ProcessIdProperty, 
					$process_id
				)
		    )
		)
    }Catch{
        throw $_
    }Finally{}
}