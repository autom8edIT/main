# Minimal deploy without transcripts or fancy handlers
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$DestRoot  = 'C:\Tools\autom8ed'
$DestMods  = Join-Path $DestRoot 'Modules'
$RepoRoot  = (Resolve-Path "$PSScriptRoot\..\..").Path
$SrcMod    = Join-Path $RepoRoot 'modules\Autom8ed'
$DstMod    = Join-Path $DestMods 'Autom8ed'

New-Item -ItemType Directory -Force -Path $DestMods | Out-Null

if (-not (Test-Path $SrcMod)) {
    [Console]::Error.WriteLine("ERROR: Missing module at $SrcMod")
    exit 1
}

if (Test-Path $DstMod) { Remove-Item $DstMod -Recurse -Force }
Copy-Item $SrcMod $DstMod -Recurse -Force

# Ensure destination is in *this process* path
$sep = [IO.Path]::PathSeparator
if ($env:PSModulePath -notlike "*$DestMods*") {
    $env:PSModulePath = ($env:PSModulePath.TrimEnd($sep) + $sep + $DestMods)
}

# Ensure destination persists for *future sessions* (User scope)
$u = [Environment]::GetEnvironmentVariable('PSModulePath','User')
if ($null -eq $u) { $u = '' }                      # <-- handle null
if ($u -notlike "*$DestMods*") {
    $join = if ($u) { $u.TrimEnd($sep) + $sep } else { '' }
    [Environment]::SetEnvironmentVariable('PSModulePath', $join + $DestMods, 'User')
}

# Import using the manifest path to bypass name resolution weirdness
$manifest = Join-Path $DstMod 'Autom8ed.psd1'
Import-Module $manifest -Force

# Prove it works
"Import OK: $manifest"
(Get-Command Get-Autom8edHello -ErrorAction Stop | Select-Object Name, Source) | Out-Host
"Autom8ed says: $(Get-Autom8edHello)"
"Deploy-Autom8ed-mini: completed at $(Get-Date -Format s)"
