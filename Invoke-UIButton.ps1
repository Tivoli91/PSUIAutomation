Function Invoke-UIButton(){
    [CmdletBinding()]param(
        [Parameter(Mandatory=$True,ValueFromPipeline=$true)]
        [Windows.Automation.AutomationElement]$au_element,
		[ValidateSet("On","Off")]
		[string]$CheckStatus="On"
    )
	$supported_patterns = $au_element.GetSupportedPatterns().ProgrammaticName
    If("InvokePatternIdentifiers.Pattern" -in $supported_patterns ){
		write-host "Invoke"
		$au_element.GetCurrentPattern([System.Windows.Automation.InvokePattern]::Pattern).Invoke()
    }elseif("SelectionItemPatternIdentifiers.Pattern" -in $supported_patterns){
		$au_element.GetCurrentPattern([System.Windows.Automation.SelectionItemPattern]::Pattern).Select()
		write-host "Selection"
	}elseif("TogglePatternIdentifiers.Pattern" -in $supported_patterns){
		$toggle_pattern = $au_element.GetCurrentPattern([System.Windows.Automation.TogglePattern]::Pattern)
		If( $CheckStatus -ne $toggle_pattern.current.ToggleState ){
			$toggle_pattern.Toggle()
		}
		write-host "Toggle"
	}else{
		throw "Not found supported pattern for UI button click, please double check"
	}
}