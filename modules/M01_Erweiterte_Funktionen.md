# Modul 01 – Erstellen erweiterter Funktionen

## Lernziele
- Unterschied zwischen einfachen Funktionen und *Advanced Functions* kennen
- `[CmdletBinding()]` verstehen und einsetzen
- Common Parameters automatisch erhalten (`-Verbose`, `-ErrorAction`, …)
- `Begin`/`Process`/`End`-Blöcke gezielt nutzen

## Theorie

### Einfache Funktion vs. Advanced Function

Eine *einfache* Funktion ist nur ein benannter ScriptBlock:

```powershell
function Get-Square {
    param($Number)
    $Number * $Number
}
```

Mit `[CmdletBinding()]` wird daraus eine **Advanced Function** – sie verhält sich wie ein Cmdlet:

```powershell
function Get-Square {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [int]$Number
    )
    Write-Verbose "Berechne Quadrat von $Number"
    $Number * $Number
}
```

### Vorteile

- Common Parameters: `-Verbose`, `-Debug`, `-ErrorAction`, `-WarningAction`, `-OutVariable`, …
- Pipeline-Fähigkeit, Parametersets, Validierung
- `$PSCmdlet`-Objekt für `ShouldProcess`, `ThrowTerminatingError`, …

### Begin / Process / End

```powershell
function Get-Demo {
    [CmdletBinding()]
    param([Parameter(ValueFromPipeline)]$InputObject)

    begin   { Write-Verbose "Initialisiere"; $count = 0 }
    process { $count++; "Verarbeite $InputObject" }
    end     { Write-Verbose "Insgesamt $count Objekte" }
}
```

| Block | Wann läuft er? |
|-------|----------------|
| `begin`   | einmal vor dem ersten Pipeline-Objekt |
| `process` | einmal pro Pipeline-Objekt |
| `end`     | einmal, nachdem die Pipeline geschlossen ist |

## Microsoft Learn
- [about_Functions_Advanced](https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_functions_advanced)
- [about_Functions_CmdletBindingAttribute](https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_functions_cmdletbindingattribute)

## Übungen
Siehe [`exercises/M01`](../exercises/M01/README.md).
