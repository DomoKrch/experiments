# For scr size
Add-Type -AssemblyName System.Windows.Forms
# For img
Add-Type -AssemblyName System.Drawing


while ($true) {
  if (-Not (Test-Path -Path $PSScriptRoot\scr)) {

      New-Item -Path $PSScriptRoot\scr -ItemType Directory

  }

  $global:screen = [System.Windows.Forms.SystemInformation]::VirtualScreen

  $global:scr_width  = $global:screen.Width
  $global:scr_height = $global:screen.Height
  # for leftmost scr
  $global:scr_left = $global:screen.Left
  # same, but top
  $global:scr_top = $global:screen.Top

  # pixel arr
  $global:bitmap = New-Object System.Drawing.Bitmap $global:scr_width, $global:scr_height
  # prepare "canvas" for img
  $global:graphic = [System.Drawing.Graphics]::FromImage($global:bitmap)
  # size of scr to capture
  $global:graphic.CopyFromScreen($global:scr_left, $global:scr_top, 0, 0, $global:bitmap.Size)

  $global:bitmap.Save("$($PSScriptRoot)\scr\scr_$(Get-Date -Format 'yyyy-MM-dd_HH-mm-ss').bmp")

  Start-Sleep -Seconds 30
}
