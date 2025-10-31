# scripts\powershell\Deploy-Autom8ed.ps1
# Requires: PowerShell 7+

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

# --- Config (adjust if you enjoy pain) ---
$ScriptName  = 'Deploy-Autom8ed.ps1'
$DestRoot    = 'C:\Tools\autom8ed'
$DestMods    = Join-Path $DestRoot 'Modules'
$LogDir      = Join-Path $DestRoot 'Logs'

# Resolve repo root from scripts\powershell\
$RepoRoot    = (Resolve-Path "$PSScriptRoot\..\..").Path
$SrcMods     = Join-Path $RepoRoot 'modules'
$SrcProfile  = Join-Path $RepoRoot 'profiles\pwsh7\Microsoft.PowerShell_profile.ps1'
$LiveProfile = $PROFILE.CurrentUserAllHosts

# --- IO bootstrap ---
New-Item -ItemType Directory -Force -Path $LogDir, $DestMods | Out-Null
$LogFile = Join-Path $LogDir ($ScriptName -replace '\.ps1$','.log')

# Robust error message extractor
function Get-ErrorText {
    param($Err)
    if ($null -eq $Err) { return 'Unknown error' }
    if ($Err.PSObject.Properties.Name -contains 'Exception' -and $Err.Exception) {
        return $Err.Exception.Message
    }
    ($Err | Out-String).Trim()
}

# Start transcript after logfile exists
Start-Transcript -Path $LogFile -Append | Out-Null
Write-Host "[*] Deploying Autom8ed from $RepoRoot"

try {
    # 1) Deploy modules (if any)
    if (-not (Test-Path $SrcMods)) {
        Write-Host "[i] No modules folder at $SrcMods (skipping)."
    } else {
        Get-ChildItem -Path $SrcMods -Directory | ForEach-Object {
            $src = $_.FullName
            $dst = Join-Path $DestMods $_.Name
            if (Test-Path $dst) { Remove-Item $dst -Recurse -Force }
            Copy-Item $src $dst -Recurse -Force
            Write-Host "[+] Module deployed: $($_.Name)"
        }
    }

    # 2) Ensure PSModulePath (User) contains destination AND update current process too
    $sep   = [IO.Path]::PathSeparator
    $uPath = [Environment]::GetEnvironmentVariable('PSModulePath','User')
    if ($uPath -notlike "*$DestMods*") {
        $uPath = ($uPath.TrimEnd($sep) + $sep + $DestMods)
        [Environment]::SetEnvironmentVariable('PSModulePath',$uPath,'User')
        Write-Host "[+] PSModulePath (User) updated with $DestMods"
    }
    if ($env:PSModulePath -notlike "*$DestMods*") {
        $env:PSModulePath = $env:PSModulePath.TrimEnd($sep) + $sep + $DestMods
        Write-Host "[+] PSModulePath (Process) updated with $DestMods"
    }

    # 3) Deploy profile (symlink preferred; fallback to copy)
    if (Test-Path $SrcProfile) {
        $liveDir = Split-Path -Parent $LiveProfile
        New-Item -ItemType Directory -Force -Path $liveDir | Out-Null
        if (Test-Path $LiveProfile) { Remove-Item $LiveProfile -Force }
        try {
            New-Item -ItemType SymbolicLink -Path $LiveProfile -Target $SrcProfile | Out-Null
            Write-Host "[+] Profile symlinked -> $SrcProfile"
        } catch {
            Copy-Item $SrcProfile $LiveProfile -Force
            Write-Host "[+] Profile copied -> $LiveProfile"
        }
    } else {
        Write-Host "[i] No profile found at $SrcProfile (skipping)."
    }

    # 4) Verify module import (does not hard-fail the run)
    $mods = @(Get-ChildItem -Path $DestMods -Directory -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Name)
    foreach ($m in $mods) {
        try {
            Import-Module $m -Force -ErrorAction Stop
            Write-Host "[+] Import OK: $m"
        } catch {
            $msg = Get-ErrorText $_
            Write-Warning "Import failed: $m :: $msg"
        }
    }
}
catch {
    $msg = Get-ErrorText $_
    Write-Error $msg
    throw
}
finally {
    $done = "[+] $ScriptName completed at $(Get-Date)"
    try { Stop-Transcript | Out-Null } catch { }
    Add-Content -Path $LogFile -Value $done -Encoding UTF8
    Write-Host $done
}
