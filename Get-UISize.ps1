Function Get-UISize(){
    [CmdletBinding()]param(
        [Parameter(Mandatory=$True,ValueFromPipeline=$true)]
        [Windows.Automation.AutomationElement]$au_element
    )
    return $au_element.GetCurrentPropertyValue([System.Windows.Automation.AutomationElement]::BoundingRectangleProperty)
}