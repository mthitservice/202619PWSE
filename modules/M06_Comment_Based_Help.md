# Modul 06 – Comment-Based Help

## Lernziele
- Funktionen mit `Get-Help` dokumentieren
- Hilfe-Schlüsselwörter kennen
- Beispiele und Parameter-Beschreibungen pflegen

## Aufbau

Comment-Based Help steht als spezieller Block-Kommentar **vor** oder **am Anfang von** der Funktion:

```powershell
function Get-DiskInfo {
<#
.SYNOPSIS
    Liefert Disk-Informationen eines Computers.

.DESCRIPTION
    Get-DiskInfo nutzt CIM, um lokale Festplatten abzufragen
    und Größe/Freier Platz als Objekt zurückzugeben.

.PARAMETER ComputerName
    Ein oder mehrere Computernamen. Akzeptiert Pipeline-Input.

.EXAMPLE
    Get-DiskInfo -ComputerName srv01

.EXAMPLE
    'srv01','srv02' | Get-DiskInfo -Verbose

.INPUTS
    System.String

.OUTPUTS
    DiskReport

.NOTES
    Autor: Michael Lindner
    Datum: 2026-05
.LINK
    https://learn.microsoft.com/powershell
#>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, ValueFromPipeline)]
        [string[]]$ComputerName
    )
    process { <# ... #> }
}
```

## Verfügbare Schlüsselwörter

`.SYNOPSIS`, `.DESCRIPTION`, `.PARAMETER <Name>`, `.EXAMPLE`, `.INPUTS`, `.OUTPUTS`, `.NOTES`, `.LINK`, `.COMPONENT`, `.ROLE`, `.FUNCTIONALITY`, `.FORWARDHELPTARGETNAME`.

## Test

```powershell
Get-Help Get-DiskInfo -Full
Get-Help Get-DiskInfo -Examples
Get-Help Get-DiskInfo -Parameter ComputerName
```

## Microsoft Learn
- [about_Comment_Based_Help](https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_comment_based_help)

## Übungen
Siehe [`exercises/M06`](../exercises/M06/README.md).
