# Modul 11 – Analyse & Debugging

## Lernziele
- Set-PSBreakpoint und Debug-Sessions nutzen
- VS Code Debugger einsetzen
- Strict-Mode aktivieren
- `Trace-Command` und `Set-PSDebug` kennen

## Breakpoints

```powershell
Set-PSBreakpoint -Script .\demo.ps1 -Line 25
Set-PSBreakpoint -Command Get-Process
Set-PSBreakpoint -Variable count -Mode Write

Get-PSBreakpoint
Remove-PSBreakpoint -Id 1
```

In der Debug-Session: `s` (Step into), `v` (Step over), `o` (Step out), `c` (Continue), `q` (Quit), `k` (Stack), `?` (Hilfe).

## VS Code

- `F5`     – Skript starten / fortsetzen
- `F9`     – Breakpoint setzen
- `F10/F11` – Step Over / Step Into
- *Watch* / *Locals* / *Call Stack* Panels

## Strict Mode

```powershell
Set-StrictMode -Version 3.0
```

Findet u.a.:
- nicht initialisierte Variablen
- Zugriff auf nicht existierende Properties
- Funktionsaufrufe wie Methoden (`Get-Date()`)

## Trace-Command

```powershell
Trace-Command -Name ParameterBinding -Expression { Get-Process -Name pwsh } -PSHost
```

## PSScriptAnalyzer

```powershell
Install-Module PSScriptAnalyzer -Scope CurrentUser
Invoke-ScriptAnalyzer -Path .\demo.ps1
```

## Vorgehen bei fremden Skripten

1. Lesen + Kommentare verstehen
2. `PSScriptAnalyzer` laufen lassen
3. `Set-StrictMode -Version Latest` setzen
4. Mit kleinen Inputs in Debug-Session schrittweise durchlaufen
5. Fehler klassifizieren (Logik / Syntax / API-Change)

## Microsoft Learn
- [about_Debuggers](https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_debuggers)
- [PSScriptAnalyzer](https://learn.microsoft.com/powershell/utility-modules/psscriptanalyzer/overview)

## Übungen
Siehe [`exercises/M11`](../exercises/M11/README.md).
