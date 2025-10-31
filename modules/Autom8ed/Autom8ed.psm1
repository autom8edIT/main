Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$pub = Join-Path $PSScriptRoot 'public'
$pri = Join-Path $PSScriptRoot 'private'

if (Test-Path $pub) {
    Get-ChildItem -Path $pub -Filter *.ps1 -File | ForEach-Object { . $_.FullName }
}

if (Test-Path $pri) {
    Get-ChildItem -Path $pri -Filter *.ps1 -File | ForEach-Object { . $_.FullName }
}

Export-ModuleMember -Function * -Alias *
