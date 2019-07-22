Function Close-UIWindow(){
    [CmdletBinding()]param(
        [Parameter(Mandatory=$True,ValueFromPipeline=$true)]
        [Windows.Automation.AutomationElement]$au_element
    )
	If( $au_element -eq $null ){
	    return
	}
    If( $au_element.Current.ControlType.ProgrammaticName -eq 'ControlType.Window' ){
        $au_element.GetCurrentPattern([System.Windows.Automation.WindowPattern]::Pattern).Close()
    }else{
		throw "The provided element is not a window control type"
	}
}