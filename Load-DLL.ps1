Function Load-Dll(){
	[CmdletBinding()]param(
	    [Parameter(Mandatory=$True)]
	    [string]$dll_file
	)
	[void][System.Reflection.Assembly]::Load([io.file]::ReadAllBytes($dll_file))
}