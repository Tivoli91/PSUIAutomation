Function Invoke-ClickPoint(){
    [CmdletBinding()]param(
        [int]$x,
        [int]$y
    )
    Move-Cursor $x $y ; sleep 1 ; Enter-LeftMouse
}
