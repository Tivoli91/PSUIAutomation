Function Get-UIText(){
    [CmdletBinding()]param(
        [Parameter(Mandatory=$True,ValueFromPipeline=$true)]
        [Windows.Automation.AutomationElement]$au_element
    )
	$au_element.GetCurrentPattern([System.Windows.Automation.ValuePattern]::Pattern).Current.Value
}
