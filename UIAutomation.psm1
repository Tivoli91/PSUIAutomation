[void][System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") # for send key and clipboard clear use
[void][System.Reflection.Assembly]::LoadWithPartialName("Microsoft.VisualBasic")  # for active window use
[void][System.Reflection.Assembly]::LoadWithPartialName("UIAutomationClient")
[void][System.Reflection.Assembly]::LoadWithPartialName("UIAutomationTypes")
# [void][System.Reflection.Assembly]::LoadWithPartialName("UIAutomationProvider")
# [void][System.Reflection.Assembly]::LoadWithPartialName("UIAutomationClientsideProviders")
ls "$PSScriptRoot\*.ps1" -Exclude "Install-ThisModule.ps1"|%{. $_.fullname}

# SIG # Begin signature block
# MIIFqwYJKoZIhvcNAQcCoIIFnDCCBZgCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQU9WxHvjUR4NkKlBqGvt/f1f0Q
# XtagggM8MIIDODCCAiSgAwIBAgIQnl9Jdksrfq5MbKKfxlPDMDAJBgUrDgMCHQUA
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
# DQEJBDEWBBT798F3VnaolCKp50HBUgdR5rxD1DANBgkqhkiG9w0BAQEFAASCAQCr
# AkPFa3qTQBBHBIap5KX28lt64Kcl1Mp3GHld0DFOObjIzXIgmsyyf3gF5YuPoOAu
# SnWl7WT8/ESeO4MB6Lmzzsqtcyd1jkiJ6bBkD+umlSFFnvOJ5i7CU0WocGgo/cem
# UgKC9NrZ63N6zt+bAg22s1awH7KRtxWqA9zGqb2Yvglveb4XsPdXdildu1Isyrof
# qTWCjsJ7BuADW6c+Oanhngx0lqCGJIBZxoDMGH89CEIo6HlmgPvw+XPCLc7JfW3K
# sWg41oSOlG1JVxgvrGpnKqmheF4NnAow2Wyc9fb/x4Na7p2I03Nz/R167P+eUMWi
# 3YRsKzKSzl+U1vNWpJAN
# SIG # End signature block
