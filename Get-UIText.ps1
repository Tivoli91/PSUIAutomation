Function Get-UIText(){
    [CmdletBinding()]param(
        [Parameter(Mandatory=$True,ValueFromPipeline=$true)]
        [Windows.Automation.AutomationElement]$au_element
    )
	$supported_patterns = $au_element.GetSupportedPatterns().ProgrammaticName
	If( "ValuePatternIdentifiers.Pattern" -in $supported_patterns ){
		$au_element.GetCurrentPattern([System.Windows.Automation.ValuePattern]::Pattern).Current.Value
	}Elseif('TextPatternIdentifiers.Pattern' -in $supported_patterns){
		$au_element.GetCurrentPattern([System.Windows.Automation.TextPattern]::Pattern).DocumentRange.select()
		[System.Windows.Automation.KeyStroke]::SendClipboardWait($au_element.Current.NativeWindowHandle,"COPY")
		return (Get-Clipboard)
	}else{
		throw "Not found supported pattern for text value get, please double check"
	}
}