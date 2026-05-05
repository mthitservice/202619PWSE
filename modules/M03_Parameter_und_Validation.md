# Modul 03 – Parameter-Attribute & Input Validation

## Lernziele
- `Parameter`-Attribut umfassend nutzen
- Validierungs-Attribute kennen
- Parametersets entwerfen
- Aliase und dynamische Parameter

## Parameter-Attribut

```powershell
[Parameter(
    Mandatory,
    Position = 0,
    ValueFromPipeline,
    ValueFromPipelineByPropertyName,
    HelpMessage = 'Gib einen Computernamen an',
    ParameterSetName = 'ByName'
)]
[string]$ComputerName
```

## Validierungs-Attribute

| Attribut | Beispiel |
|----------|----------|
| `ValidateNotNullOrEmpty` | `[ValidateNotNullOrEmpty()]` |
| `ValidateSet`            | `[ValidateSet('Dev','Test','Prod')]` |
| `ValidateRange`          | `[ValidateRange(1,65535)]` |
| `ValidateLength`         | `[ValidateLength(3,15)]` |
| `ValidatePattern`        | `[ValidatePattern('^[A-Z]{2}-\d{4}$')]` |
| `ValidateScript`         | `[ValidateScript({ Test-Path $_ })]` |
| `ValidateCount`          | `[ValidateCount(1,10)]` |
| `AllowNull` / `AllowEmptyString` / `AllowEmptyCollection` | bei Mandatory zulassen |

## Aliases

```powershell
[Alias('CN','Server')]
[string]$ComputerName
```

## Parametersets

```powershell
function Get-Item2 {
    [CmdletBinding(DefaultParameterSetName='ByName')]
    param(
        [Parameter(Mandatory, ParameterSetName='ByName')]   [string]$Name,
        [Parameter(Mandatory, ParameterSetName='ById')]     [int]$Id
    )
    Write-Verbose "ParameterSet: $($PSCmdlet.ParameterSetName)"
}
```

## Microsoft Learn
- [about_Functions_Advanced_Parameters](https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_functions_advanced_parameters)

## Übungen
Siehe [`exercises/M03`](../exercises/M03/README.md).
