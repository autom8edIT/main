# Step 1: Reset .cmd to cmdfile type
cmd /c "assoc .cmd=cmdfile"

# Step 2: Ensure cmdfile opens with cmd.exe
cmd /c 'ftype cmdfile="%SystemRoot%\System32\cmd.exe" /c "%1" %*'

# Step 3: Remove Notepad++ override from .cmd extension
Remove-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.cmd" -Recurse -Force -ErrorAction SilentlyContinue

# Step 4: Remove openwith association
Remove-Item -Path "HKCU:\Software\Classes\.cmd" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "HKCU:\Software\Classes\Applications\notepad++.exe" -Recurse -Force -ErrorAction SilentlyContinue

# Step 5: Force registry refresh (explorer restart)
Stop-Process -Name explorer -Force
Start-Process explorer
