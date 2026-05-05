# M01 – Übungen: Erweiterte Funktionen

## Übung 1.1 – Get-FreeMemory
Schreibe eine Advanced Function `Get-FreeMemory`, die den freien RAM (in MB) eines lokalen Computers als Zahl zurückgibt.

**Anforderungen**
- `[CmdletBinding()]`
- Verwende `Get-CimInstance Win32_OperatingSystem` (Property `FreePhysicalMemory` ist in KB)
- `Write-Verbose` für eine aussagekräftige Meldung
- Test: `Get-FreeMemory -Verbose`

Starter: [`Get-FreeMemory.ps1`](Get-FreeMemory.ps1)

## Übung 1.2 – Begin/Process/End
Schreibe `Measure-Items`, die in `begin` einen Counter auf 0 setzt, im `process`-Block jedes Pipeline-Objekt zählt und in `end` die Gesamtzahl ausgibt.

```powershell
1..5 | Measure-Items   # Erwartet: "Insgesamt 5 Objekte"
```

## Übung 1.3 – Refactor
Wandle das folgende Snippet in eine Advanced Function `Get-TopProcess` um, mit Parameter `-Top` (Default = 5) und Verbose-Output:

```powershell
Get-Process | Sort-Object CPU -Descending | Select-Object -First 5 Name, CPU
```
