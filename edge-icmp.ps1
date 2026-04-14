$ErrorActionPreference = "Stop"

# Remediate Edge
$edgeUpdater = "C:\Program Files (x86)\Microsoft\EdgeUpdate\MicrosoftEdgeUpdate.exe"
if (Test-Path $edgeUpdater) {
    Start-Process -FilePath $edgeUpdater -ArgumentList '/silent /install appguid={56EB18F8-B008-4CBD-B6D2-8C97FE7E9062}&appname=Microsoft%20Edge&needsadmin=True' -Wait
} else {
    Write-Host "Edge updater not found at $edgeUpdater"
}

# Remediate ICMP Timestamp Request disclosure
if (-not (Get-NetFirewallRule -DisplayName "Block ICMP Timestamp" -ErrorAction SilentlyContinue)) {
    New-NetFirewallRule -DisplayName "Block ICMP Timestamp" -Direction Inbound -Protocol ICMPv4 -IcmpType 13 -Action Block
}

# Verify Edge version
$edgeExe = "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
if (Test-Path $edgeExe) {
    Write-Host "Edge version:" ((Get-Item $edgeExe).VersionInfo.ProductVersion)
}

Write-Host "Done."