Function Invoke-UIButton(){
    [CmdletBinding()]param(
        [Parameter(Mandatory=$True,ValueFromPipeline=$true)]
        [Windows.Automation.AutomationElement]$au_element
    )
    $au_element.GetCurrentPattern([System.Windows.Automation.InvokePattern]::Pattern).Invoke()
}
