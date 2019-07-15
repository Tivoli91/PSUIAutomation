Function Invoke-UIButton(){
    [CmdletBinding()]param(
        [Parameter(Mandatory=$True,ValueFromPipeline=$true)]
        [Windows.Automation.AutomationElement]$au_element,
		[ValidateSet("Expand","Collapse")]
		[string]$ExpandCollapse="Expand"
    )
	$supported_patterns = $au_element.GetSupportedPatterns().ProgrammaticName
    If("InvokePatternIdentifiers.Pattern" -in $supported_patterns ){
		$au_element.GetCurrentPattern([System.Windows.Automation.InvokePattern]::Pattern).Invoke()
    }ElseIf("ExpandCollapsePatternIdentifiers.Pattern" -in $supported_patterns ){
		$ec_pattern = $au_element.GetCurrentPattern([System.Windows.Automation.ExpandCollapsePattern]::Pattern) # ec  = Expand Collapse
		Switch($ExpandCollapse){
		    "Collapse"{$ec_pattern.Collapse() ; break}
		    default{$ec_pattern.Expand()}
		}
    }
}