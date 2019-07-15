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

# SIG # Begin signature block
# MIIFqwYJKoZIhvcNAQcCoIIFnDCCBZgCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUObKrbeqLqJWi0sbHlqU9glUN
# mPCgggM8MIIDODCCAiSgAwIBAgIQnl9Jdksrfq5MbKKfxlPDMDAJBgUrDgMCHQUA
# MCQxIjAgBgNVBAMTGUNoYW95dWVXYW5nUG93ZXJTaGVsbENlcnQwHhcNMTkwNzEz
# MDkyNzU1WhcNMzkxMjMxMjM1OTU5WjAkMSIwIAYDVQQDExlDaGFveXVlV2FuZ1Bv
# d2VyU2hlbGxDZXJ0MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA1ukS
# e/S6dDvApZueF1sbor4ksbCUQEECBWx+0iiyMpu/LM9WzdwNXoU58MJabYxKvTV8
# DddPxtROu8G8zo5U4ltINAbVJU2DtJIgbWvAaS3mU1w5cPCndpIoi5oz12ZmsSjZ
# Dna+V94sYQTeqbnYExXjiUX51/af30U2QZeShOGqbvLuUrB/etmd3fbCEt4RQCPw
# 6mDhliMnhvEDLVGqfSe4Y6xed1QP0BVSfh2wyD9TDg7JM7ETA6M7Y/0joXSt8+39
# nLCVHxMXSpbSv/m0vLIt7lQ6rb2tYuZM3RCJGIPKxlSr5PFZLYcWfWF68w+hd3Z1
# 6djKPQ2BnBDJz3NtKQIDAQABo24wbDATBgNVHSUEDDAKBggrBgEFBQcDAzBVBgNV
# HQEETjBMgBCrEQlnTAB1PNtkuAgscnlqoSYwJDEiMCAGA1UEAxMZQ2hhb3l1ZVdh
# bmdQb3dlclNoZWxsQ2VydIIQnl9Jdksrfq5MbKKfxlPDMDAJBgUrDgMCHQUAA4IB
# AQBxTzFq8TRrTIid6JxecPOP3oqZcLLKvtSXUjY90qQYr3v2JDCEDz4wzw5zGjF8
# JGvKD0EeFK7ZnG56+lB0wVoM2gZIseYgGoZYUI5g5bfuBhJt6fuYAqJIq+QEEdR0
# Ffw9/1rjRWMCNsFV7qWKbNs/HPkkiQ7bT8P2Gn1QFHii7Wj7uPqX2CgvDVJiW3HQ
# 8aFyWDABJfgBTSAi3qXZxXIc+qU9nmJerOIWtz54SBrhhn8clBbJHJO7cLKzcw2H
# kw6mmgZiHssoXz3QlwGNbtcLANEkA0/n9EaX3TTE/rJVefnXyny00sFGgJOHqZrm
# gG+cLpeFKhD0ygjIVxWVSdCAMYIB2TCCAdUCAQEwODAkMSIwIAYDVQQDExlDaGFv
# eXVlV2FuZ1Bvd2VyU2hlbGxDZXJ0AhCeX0l2Syt+rkxsop/GU8MwMAkGBSsOAwIa
# BQCgeDAYBgorBgEEAYI3AgEMMQowCKACgAChAoAAMBkGCSqGSIb3DQEJAzEMBgor
# BgEEAYI3AgEEMBwGCisGAQQBgjcCAQsxDjAMBgorBgEEAYI3AgEVMCMGCSqGSIb3
# DQEJBDEWBBSBpWsNQQ9vw9zBS1KOV+v0ITSmsjANBgkqhkiG9w0BAQEFAASCAQCR
# 1BWMDzxY9kOcbSo8b05ztV9seqZJJkzvn4+se4wFju5n4bJaTXrYDhJxgO8dzAQk
# wx8rc1P4LhpL/L/VWcZxU0cwsKdp0oJ54sj0C8jYmhREbP15Khwuyc0klZP+LcjZ
# piBVnxWy8z4BuTvEXthJbn7PIefP+FzuP+Tq9sBwcNlCpUZXk0RV724yJRzy5U02
# ewITO4hwrH9vD+KuSCUS5rcEUH70KoUniVm/EAVt0sPyMhu7RQ3tth1vR7dUdP4p
# IldlWExLIZzzRoOAJ9cS2P+5yelAf6nvRUrO5S2+l0WOmwFKSTOIvACqTBtKlVIK
# 4ZXNZpybLynmzlKq16/R
# SIG # End signature block
