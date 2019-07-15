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
		write-host "ValuePattern"
		$au_element.GetCurrentPattern([System.Windows.Automation.ValuePattern]::Pattern).SetValue($text)
	}Elseif('TextPatternIdentifiers.Pattern' -in $supported_patterns){
		write-host "TextPattern"
		
		# I searched google and found out TextPattern doesn't support set text, it's designed for text retrieve only
		Show-Window (ps -id $au_element.Current.ProcessId).MainWindowTitle | out-null
		$au_click_point = $au_element.GetClickablePoint()
		Move-Cursor $au_click_point.x $au_click_point.y
		Enter-LeftMouse
		If( $Clear ){
			Send-key "^(a)"
		}else{
			Send-key "^{END}"
			If( !$NoNewLine -and ![string]::IsNullOrWhiteSpace((Get-UIText $au_element)) ){
				Send-key "enter"
			}
		}
		Send-key $text
		<#
		$text.ToCharArray()|%{
			$this_char=$_
			$char_int = [int][char]$this_char
			If( ($char_int -in 65..90)  -and ![console]::CapsLock){ # we need to switch caps lock to send uppercase/lowercase char
				Send-Key "CAPS LOCK"
			}
			If( [string]::IsNullOrWhiteSpace($this_char ) ){
				$this_char="SPACE"
			}
			If( $char_int -in 48..57 ){ # for number
				Set-Variable "this_char" ("D{0}" -f ($char_int - 48))
			}
			[System.Windows.Automation.KeyStroke]::PressKey($au_element.Current.NativeWindowHandle,[System.Windows.Input.Key]::$this_char)
		}
		#>
	}else{
		throw "Not found supported pattern for text value set, please double check"
	}
}

# $key_list = New-Object System.Collections.Generic.List[[System.Windows.Input.Key]]
# $key_list.Add([System.Windows.Input.Key]::H)
# $key_list.Add([System.Windows.Input.Key]::I)
