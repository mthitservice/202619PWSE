# M09 – Übungen: Fehlerbehandlung

## Übung 9.1 – try/catch
Schreibe `Get-FileFirstLine -Path` mit `try/catch`:
- bei nicht existierender Datei: freundliche Warnung, **keine** Exception
- bei sonstigen Fehlern: Fehler weiterwerfen
- in `finally`: `Write-Verbose 'Cleanup'`

## Übung 9.2 – ErrorAction Stop
Erkläre den Unterschied zwischen
```powershell
Get-Item C:\NichtDa
```
und
```powershell
Get-Item C:\NichtDa -ErrorAction Stop
```
und teste beides innerhalb eines `try/catch`.

## Übung 9.3 – Eigener Fehler
Schreibe `Connect-Service`, das `throw` mit einem konkreten ErrorRecord wirft, wenn der Service nicht erreichbar ist. Zeige, wie der Aufrufer ihn fängt.

Starter: [`Get-FileFirstLine.ps1`](Get-FileFirstLine.ps1)
