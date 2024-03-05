#REM randomly generated chars
$temp_dir = (-join ((65..90) + (97..122) | Get-Random -Count 5 | % {[char]$_}))

mkdir $env:Temp/$temp_dir
echo "hi" > $env:Temp/$temp_dir/hi.txt
Remove-Item $PSCommandPath -Force 
