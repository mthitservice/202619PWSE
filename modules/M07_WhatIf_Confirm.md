# Modul 07 – Unterstützung von -WhatIf und -Confirm

## Lernziele
- `SupportsShouldProcess` aktivieren
- `$PSCmdlet.ShouldProcess()` korrekt aufrufen
- `ConfirmImpact` verstehen und richtig wählen

## Aktivierung

```powershell
function Remove-OldLog {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='High')]
    param(
        [Parameter(Mandatory)]
        [string]$Path,

        [int]$Days = 30
    )

    Get-ChildItem -Path $Path -Filter *.log -File |
        Where-Object LastWriteTime -lt (Get-Date).AddDays(-$Days) |
        ForEach-Object {
            if ($PSCmdlet.ShouldProcess($_.FullName, "Datei löschen")) {
                Remove-Item $_.FullName -Force
            }
        }
}
```

## ConfirmImpact

| Wert | Bedeutung |
|------|-----------|
| `None` (Default) | nie automatisch nachfragen |
| `Low` | nachfragen, wenn `$ConfirmPreference -le Low` |
| `Medium` | Standard für veränderbare Cmdlets |
| `High` | immer nachfragen (außer `-Confirm:$false`) |

`$ConfirmPreference` Standard = `High`.

## ShouldContinue (zusätzliche Frage)

```powershell
if ($PSCmdlet.ShouldContinue('Wirklich alle Logs löschen?', 'Bestätigung')) { ... }
```

## Microsoft Learn
- [about_Functions_CmdletBindingAttribute](https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_functions_cmdletbindingattribute)
- [Everything you wanted to know about ShouldProcess](https://learn.microsoft.com/powershell/scripting/learn/deep-dives/everything-about-shouldprocess)

## Übungen
Siehe [`exercises/M07`](../exercises/M07/README.md).
