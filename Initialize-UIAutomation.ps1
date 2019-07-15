Function Initialize-UIAutomation(){
    [void][System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") # for send key and clipboard clear use
	[void][System.Reflection.Assembly]::LoadWithPartialName("Microsoft.VisualBasic")  # for active window use
    [void][System.Reflection.Assembly]::LoadWithPartialName("UIAutomationClient")
    [void][System.Reflection.Assembly]::LoadWithPartialName("UIAutomationTypes")
    [void][System.Reflection.Assembly]::LoadWithPartialName("UIAutomationProvider")
    [void][System.Reflection.Assembly]::LoadWithPartialName("UIAutomationClientsideProviders")
}
