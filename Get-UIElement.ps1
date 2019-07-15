Function Get-UIElement(){
    [CmdletBinding()]param(
        [Parameter(Mandatory=$True,ValueFromPipeline=$true)]
        [Windows.Automation.AutomationElement]$au_element,
        [Parameter(Mandatory=$True)]
        [string]$control_type,
        [Parameter(Mandatory=$True)]
        [string]$ui_value,
        [string]$log_file,
        [switch]$CheckClass,
        [switch]$CheckName
    )
    Try{
        $control_type_pro = [Windows.Automation.PropertyCondition]::new([Windows.Automation.AutomationElement]::ControlTypeProperty, [System.Windows.Automation.ControlType]::$control_type)
        If( $CheckClass ){
            $2nd_cond = "ClassNameProperty"
        }ElseIf($CheckName){
            $2nd_cond = "NameProperty"
        }Else{
            $2nd_cond = "AutomationIdProperty"
        }
        $2nd_cond = [Windows.Automation.PropertyCondition]::new([Windows.Automation.AutomationElement]::$2nd_cond, $ui_value)
        return $au_element.FindAll([Windows.Automation.TreeScope]::Descendants, (New-Object Windows.Automation.AndCondition($control_type_pro, $2nd_cond)))
    }Catch{
        If( [string]::IsNullOrWhiteSpace($log_file ) ){
            $_
        }Else{
            Write-Log Error $_.Exception.Message $log_file
        }
    }
}