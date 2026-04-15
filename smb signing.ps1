Set-SmbServerConfiguration -RequireSecuritySignature $true -EnableSecuritySignature $true -Force
Get-SmbServerConfiguration | Select RequireSecuritySignature, EnableSecuritySignature