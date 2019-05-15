Function Invoke-UICheckBox(){
    [CmdletBinding()]param(
        [Parameter(Mandatory=$True,ValueFromPipeline=$true)]
        [Windows.Automation.AutomationElement]$au_element,
		[ValidateSet("On","Off")]
		[string]$ToggleState="On"
    )
	$toggle_pattern = $au_element.GetCurrentPattern([System.Windows.Automation.TogglePattern]::Pattern)
	If( $ToggleState -ne $toggle_pattern.current.ToggleState ){
	    $toggle_pattern.Toggle()
	}
}
