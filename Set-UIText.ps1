Function Set-UIText(){
    [CmdletBinding()]param(
        [Parameter(Mandatory=$True,Position=0,ValueFromPipeline=$true)]
        [Windows.Automation.AutomationElement]$au_element,
        [Parameter(Mandatory=$True,ParameterSetName='text')]
        [string]$text,
		[ValidateScript({test-path $_})]
		[Parameter(Mandatory=$false,ParameterSetName='file')]
		[string]$text_file,
		# these swithces are mainly for richtextbox set use, default behavier is to overwrite current text
		[switch]$InsertBefore,
		[switch]$Append
    )
	$supported_patterns = $au_element.GetSupportedPatterns().ProgrammaticName
	If( "ValuePatternIdentifiers.Pattern" -in $supported_patterns ){
		$au_element.GetCurrentPattern([System.Windows.Automation.ValuePattern]::Pattern).SetValue($text)
	}Elseif('TextPatternIdentifiers.Pattern' -in $supported_patterns){
		# get current richtextbox text
		$au_element.GetCurrentPattern([System.Windows.Automation.TextPattern]::Pattern).DocumentRange.select()
		[System.Windows.Automation.KeyStroke]::SendClipboardWait($au_element.Current.NativeWindowHandle,"COPY")
		$old_richtextbox_text=(Get-Clipboard).trim()
		if($pscmdlet.ParameterSetName -eq "text"){
			$text|Set-Clipboard
		}elseif($pscmdlet.ParameterSetName -eq "file"){
			cat $text_file -Encoding UTF8 -ea 1|Set-Clipboard
		}
		if([string]::IsNullOrWhiteSpace($old_richtextbox_text)){
			[System.Windows.Automation.KeyStroke]::SendClipboardWait($au_element.Current.NativeWindowHandle,"PASTE")
		}else{
			if($InsertBefore -or $Append){
				if($InsertBefore){
					@((Get-Clipboard),$old_richtextbox_text)|Set-Clipboard
				}elseif($Append){
					@($old_richtextbox_text,(Get-Clipboard))|Set-Clipboard
				}
				[System.Windows.Automation.KeyStroke]::SendClipboardWait($au_element.Current.NativeWindowHandle,"PASTE")
			}else{
				[System.Windows.Automation.KeyStroke]::SendClipboardWait($au_element.Current.NativeWindowHandle,"PASTE")
			}
		}
	}else{
		throw "Not found supported pattern for text value set, please double check"
	}
}
