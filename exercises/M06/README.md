# M06 – Übungen: Comment-Based Help

## Übung 6.1
Nimm deine Funktion `Get-DiskReport` aus M05 und ergänze **vollständige** Comment-Based Help mit:
- `.SYNOPSIS`, `.DESCRIPTION`
- `.PARAMETER ComputerName`
- mind. 2 `.EXAMPLE`-Blöcke
- `.INPUTS`, `.OUTPUTS`, `.NOTES`, `.LINK`

Teste:
```powershell
Get-Help Get-DiskReport -Full
Get-Help Get-DiskReport -Examples
Get-Help Get-DiskReport -Online    # sollte deinen .LINK aufrufen
```

## Übung 6.2 – External Help (optional)
Erstelle eine `about_MyTools.help.txt`-Datei in deinem Modul-Ordner und prüfe `Get-Help about_MyTools`.

Starter: [`Get-DiskReport.ps1`](Get-DiskReport.ps1)
