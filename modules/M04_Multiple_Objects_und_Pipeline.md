# Modul 04 – Multiple Objects & Pipeline-Input

## Lernziele
- Funktionen schreiben, die *mehrere* Objekte verarbeiten
- Pipeline-Input `ByValue` und `ByPropertyName` korrekt nutzen
- `process`-Block für Streaming

## Mehrere Werte – Array-Parameter

```powershell
function Test-Server {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string[]]$ComputerName    # Plural + [string[]]
    )
    foreach ($c in $ComputerName) {
        [pscustomobject]@{
            ComputerName = $c
            Online       = Test-Connection $c -Count 1 -Quiet
        }
    }
}

Test-Server -ComputerName 'srv01','srv02','srv03'
```

## Pipeline-Input ByValue

```powershell
function Test-Server {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, ValueFromPipeline)]
        [string[]]$ComputerName
    )
    process {
        foreach ($c in $ComputerName) {
            [pscustomobject]@{ ComputerName = $c; Online = Test-Connection $c -Count 1 -Quiet }
        }
    }
}

'srv01','srv02' | Test-Server
```

> **Wichtig:** Bei `ValueFromPipeline` immer `process` verwenden – sonst wird nur das *letzte* Objekt verarbeitet.

## Pipeline-Input ByPropertyName

```powershell
function Test-Server {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('CN','Name')]
        [string]$ComputerName
    )
    process {
        [pscustomobject]@{ ComputerName = $ComputerName; Online = Test-Connection $ComputerName -Count 1 -Quiet }
    }
}

Get-ADComputer -Filter * | Test-Server   # nutzt Property "Name" via Alias
```

## Microsoft Learn
- [about_Pipelines](https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_pipelines)

## Übungen
Siehe [`exercises/M04`](../exercises/M04/README.md).
