$wps_path="$home\Documents\WindowsPowerShell"
If( !(test-path $wps_path) ){
    mkdir $wps_path -force | out-null
}
$module_path="$wps_path\Modules"
If( !(test-path $module_path) ){
    mkdir $module_path -force| out-null
}
$module_name=(gi $PSScriptRoot\*.psm1).basename
If( !(test-path ($this_module="$module_path\$module_name")) ){
    mkdir $this_module -force| out-null
}
$this_script=$MyInvocation.MyCommand.Name  # this script name with extension
ls $PSScriptRoot -Recurse -Exclude $this_script|%{
    copy $_.fullname $this_module -force -Verbose
}
read-host "If you see this line, then it means this command completed successfully.  Please re-open powershell to make this module take affect(please enter 'ctrl+c' to exit this powershell console)"
