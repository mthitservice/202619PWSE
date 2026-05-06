# Modul 08 – Controller-Skripte

## Lernziele
- Tool-Funktionen vs. Controller-Skripte abgrenzen
- Controller-Skripte schreiben, die Funktionen orchestrieren und einen *menschenlesbaren* Output erzeugen
- Wiederverwendbarkeit & Testbarkeit erhöhen

## Konzept

> **Tool-Funktionen** = wiederverwendbare Bausteine, geben Objekte aus.
>
> **Controller-Skripte** = nicht wiederverwendbar, lösen ein konkretes Problem, formatieren Ausgabe (HTML, CSV, Mail), nutzen mehrere Tools.

```
+---------------+         +-----------------+         +----------+
| Get-DiskInfo  |  --->   | Controller.ps1  |  --->   | Report   |
| Get-Service   |         | (orchestriert)  |         | (HTML)   |
+---------------+         +-----------------+         +----------+
```

## Beispiel-Controller

```powershell
<#
    Server-Health-Report.ps1
    Erzeugt einen HTML-Report mit Disk- und Service-Status.
#>
[CmdletBinding()]
param(
    [string[]]$ComputerName = @('localhost'),
    [string]$OutFile = "$env:TEMP\health.html"
)

Import-Module MyTools -Force

$disks   = $ComputerName | Get-DiskInfo
$svcs    = foreach ($c in $ComputerName) {
    Get-Service -ComputerName $c |
        Where-Object Status -ne 'Running' |
        Select-Object @{n='ComputerName';e={$c}}, Name, Status
}

$style = '<style>body{font-family:Segoe UI;} table{border-collapse:collapse;} td,th{border:1px solid #888;padding:4px;}</style>'
$html  = "<html><head>$style</head><body>"
$html += "<h1>Server Health</h1><h2>Disks</h2>"
$html += $disks | ConvertTo-Html -Fragment
$html += "<h2>Stopped Services</h2>"
$html += $svcs  | ConvertTo-Html -Fragment
$html += "</body></html>"

$html | Set-Content -Path $OutFile -Encoding UTF8
Write-Host "Report: $OutFile"
Invoke-Item $OutFile
```

## Best Practices

- Controller-Skript enthält **keine** wiederverwendbare Logik → die wandert in Tool-Funktionen / Module
- Parameter mit sinnvollen Defaults
- Logging über `Write-Verbose` / Transcript
- Exit-Codes (`exit 1`) bei Automatisierung

## Microsoft Learn
- [The Monad Manifesto](https://learn.microsoft.com/powershell/scripting/learn/ps101/01-getting-started)
- [PowerShell Practice and Style](https://poshcode.gitbook.io/powershell-practice-and-style/)

## Übungen
Siehe [`exercises/M08`](../exercises/M08/README.md).
