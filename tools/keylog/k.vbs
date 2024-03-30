Set objFSO = CreateObject("Scripting.FileSystemObject")

Dim scriptPath, cur_dir
path = WScript.ScriptFullName

cur_dir = objFSO.GetParentFolderName(path)
Set objFSO = Nothing


Set objShell = CreateObject("WScript.Shell" )
strUsername = objShell.ExpandEnvironmentStrings("%USERNAME%")
strFilePath = cur_dir & "\k.ps1"
objShell.Run "powershell.exe -ExecutionPolicy Bypass -WindowStyle Hidden -File """ & strFilePath & """", 0, True
Set objShell = Nothing
