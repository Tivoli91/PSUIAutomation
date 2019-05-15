Function Send-Key($string){  # sendkey & screenshot not working when the user screen is locked
	$sw = switch -regex ($string){
        "tab"   {"`"{TAB}`"";break}
        "enter" {"`"{ENTER}`"";break}
        "down"  {"`"{DOWN}`"";break}
        "right" {"`"{RIGHT}`"";break}
        default {"`"$string`""}
	}
	iex "[System.Windows.Forms.SendKeys]::SendWait($sw)" ;start-sleep -Milliseconds 250
}
