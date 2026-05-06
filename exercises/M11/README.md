# M11 – Übungen: Debugging

## Übung 11.1 – Bug-Hunt
In [`buggy.ps1`](buggy.ps1) verstecken sich **drei Fehler** (Logik / Schreibfehler / Typ).
Finde sie mit:
1. `Set-StrictMode -Version Latest`
2. `Invoke-ScriptAnalyzer .\buggy.ps1`
3. Breakpoint setzen und schrittweise debuggen

Korrigiere die Fehler und teste mit:
```powershell
.\buggy.ps1 -Numbers 1,2,3,4,5    # erwartet: Sum=15 Avg=3
```

## Übung 11.2 – PSBreakpoint
Setze:
- einen Line-Breakpoint in `buggy.ps1`
- einen Variable-Breakpoint, der bei jedem Schreibzugriff auf `$sum` hält
- prüfe `Get-PSBreakpoint`

## Übung 11.3 – PSScriptAnalyzer
Lass Analyzer auf den gesamten Repository-Ordner laufen und behebe alle Severity `Error`/`Warning`-Findings im eigenen Code.

```powershell
Invoke-ScriptAnalyzer -Path . -Recurse -Severity Error,Warning
```
