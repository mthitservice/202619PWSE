# M07 – Übungen: -WhatIf / -Confirm

## Übung 7.1 – Remove-OldFile
Schreibe `Remove-OldFile` mit:
- `-Path` (Pflicht, Existenz prüfen)
- `-Days` (Default 30)
- `SupportsShouldProcess`, `ConfirmImpact = 'High'`

Lösche alle Dateien in `-Path`, deren `LastWriteTime` älter als `-Days` ist.
Teste:
```powershell
Remove-OldFile -Path C:\Temp -Days 7 -WhatIf
Remove-OldFile -Path C:\Temp -Days 7 -Confirm:$false
```

## Übung 7.2 – ShouldContinue
Erweitere die Funktion, sodass bei mehr als 100 zu löschenden Dateien zusätzlich `ShouldContinue` einen Hinweis zeigt.

Starter: [`Remove-OldFile.ps1`](Remove-OldFile.ps1)
