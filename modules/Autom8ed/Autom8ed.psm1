# Autom8ed.psm1
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# dot-source functions
Get-ChildItem -Path $PSScriptRoot\public -Filter *.ps1 | ForEach-Object { . $_.FullName }
Get-ChildItem -Path $PSScriptRoot\private -Filter *.ps1 | ForEach-Object { . $_.FullName }

Export-ModuleMember -Function * -Alias *
