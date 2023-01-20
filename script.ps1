Start-Transcript -Path "C:\transcript.txt"

$dir = [Environment]::GetFolderPath("Desktop")
New-Item -Path $dir -Name "got_hacked_lmao.txt" -Value "Azpekt was here lol"

Stop-Transcript