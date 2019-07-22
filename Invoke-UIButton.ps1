Function Invoke-UIButton(){
    [CmdletBinding()]param(
        [Parameter(Mandatory=$True,ValueFromPipeline=$true)]
        [Windows.Automation.AutomationElement]$au_element,
		[ValidateSet("On","Off")]
		[string]$CheckStatus="On",
		[ValidateSet("Expand","Collapse")]
		[string]$ExpandCollapse="Expand"
    )
	$supported_patterns = $au_element.GetSupportedPatterns().ProgrammaticName
    If("InvokePatternIdentifiers.Pattern" -in $supported_patterns ){
		$au_element.GetCurrentPattern([System.Windows.Automation.InvokePattern]::Pattern).Invoke()
    }elseif("SelectionItemPatternIdentifiers.Pattern" -in $supported_patterns){
		$au_element.GetCurrentPattern([System.Windows.Automation.SelectionItemPattern]::Pattern).Select()
	}elseif("TogglePatternIdentifiers.Pattern" -in $supported_patterns){
		$toggle_pattern = $au_element.GetCurrentPattern([System.Windows.Automation.TogglePattern]::Pattern)
		If( $CheckStatus -ne $toggle_pattern.current.ToggleState ){
			$toggle_pattern.Toggle()
		}
	}ElseIf("ExpandCollapsePatternIdentifiers.Pattern" -in $supported_patterns ){
		$ec_pattern = $au_element.GetCurrentPattern([System.Windows.Automation.ExpandCollapsePattern]::Pattern) # ec  = Expand Collapse
		Switch($ExpandCollapse){
		    "Collapse"{$ec_pattern.Collapse() ; break}
		    default{$ec_pattern.Expand()}
		}
    }else{
		throw "Not found supported pattern for UI button click, please double check"
	}
}