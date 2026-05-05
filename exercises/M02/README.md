# M02 – Übungen: Befehl zu Funktion & Module

## Übung 2.1 – Refactor
Verwandle den folgenden Befehl in eine Funktion `Get-OSInfo` mit Parameter `-ComputerName` (Default = `localhost`):

```powershell
Get-CimInstance Win32_OperatingSystem -ComputerName SRV01 |
    Select-Object CSName, Caption, Version, LastBootUpTime
```

Starter: [`Get-OSInfo.ps1`](Get-OSInfo.ps1)

## Übung 2.2 – Skript-Modul `MyTools`
1. Lege folgenden Ordner an: `MyTools/`
2. Erstelle `MyTools.psm1` mit den Funktionen `Get-OSInfo` (aus 2.1) und `Get-DiskInfo` (aus M02-Theorie).
3. Erstelle ein Manifest `MyTools.psd1` mit `New-ModuleManifest`.
4. Importiere das Modul (`Import-Module .\MyTools -Force`) und teste beide Funktionen.

## Übung 2.3 – Export steuern
Füge in `MyTools.psm1` eine *interne* Helper-Funktion `ConvertTo-GB` hinzu, die nur intern verwendet, aber **nicht exportiert** wird. Prüfe mit `Get-Command -Module MyTools`, dass sie nicht sichtbar ist.
