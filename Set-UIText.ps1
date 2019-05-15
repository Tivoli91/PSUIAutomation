Function Set-UIText(){
    [CmdletBinding()]param(
        [Parameter(Mandatory=$True,ValueFromPipeline=$true)]
        [Windows.Automation.AutomationElement]$au_element,
        [Parameter(Mandatory=$True)]
        [string]$text
    )
    $au_element.GetCurrentPattern([System.Windows.Automation.ValuePattern]::Pattern).SetValue($text)
}
