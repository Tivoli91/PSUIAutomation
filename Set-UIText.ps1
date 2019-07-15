Function Set-UIText(){
    [CmdletBinding()]param(
        [Parameter(Mandatory=$True,ValueFromPipeline=$true)]
        [Windows.Automation.AutomationElement]$au_element,
        [Parameter(Mandatory=$True)]
        [string]$text,
		[switch]$Clear,
		[switch]$NoNewLine
    )
	$supported_patterns = $au_element.GetSupportedPatterns().ProgrammaticName
	If( "ValuePatternIdentifiers.Pattern" -in $supported_patterns ){
		$au_element.GetCurrentPattern([System.Windows.Automation.ValuePattern]::Pattern).SetValue($text)
	}else{
		throw "Not found supported pattern for text value set, please double check"
	}
}
