# Modul 02 – Befehl in Funktion konvertieren & Skript-Module

## Lernziele
- Einen einzeiligen Befehl in eine wiederverwendbare Funktion überführen
- Ein Skript-Modul (`.psm1`) erstellen
- Manifest-Datei (`.psd1`) verstehen
- Module in `$env:PSModulePath` veröffentlichen und laden

## Theorie

### Vom Befehl zur Funktion (Refactoring-Schritte)

1. **Befehl identifizieren** und zwischen Backticks ausführen lassen
   ```powershell
   Get-CimInstance Win32_LogicalDisk -ComputerName SRV01 |
       Select-Object DeviceID, @{n='FreeGB';e={[math]::Round($_.FreeSpace/1GB,2)}}
   ```
2. **Werte parametrisieren** (hier: Computer-Name)
3. **`function`-Wrapper + `[CmdletBinding()]` + `param`-Block**
4. **Verb-Substantiv-Naming** (`Get-DiskInfo`)
5. **Pipeline- und Validierungslogik** ergänzen

```powershell
function Get-DiskInfo {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, ValueFromPipeline)]
        [string]$ComputerName
    )
    process {
        Get-CimInstance Win32_LogicalDisk -ComputerName $ComputerName |
            Select-Object PSComputerName, DeviceID,
                @{n='FreeGB';e={[math]::Round($_.FreeSpace/1GB,2)}}
    }
}
```

### Skript-Module

Ein Skript-Modul ist eine `.psm1`-Datei in einem gleichnamigen Ordner:

```
MyTools/
├── MyTools.psm1     # Funktionen
└── MyTools.psd1     # Manifest (optional, aber empfohlen)
```

Manifest erzeugen:

```powershell
New-ModuleManifest -Path .\MyTools\MyTools.psd1 `
    -RootModule MyTools.psm1 `
    -ModuleVersion '1.0.0' `
    -Author 'Michael Lindner' `
    -FunctionsToExport @('Get-DiskInfo','Get-Square')
```

Modul-Pfade:

```powershell
$env:PSModulePath -split ';'
# Empfohlener User-Pfad:
# %UserProfile%\Documents\PowerShell\Modules     (PS 7+)
# %UserProfile%\Documents\WindowsPowerShell\Modules (5.1)
```

Laden / Entladen:

```powershell
Import-Module MyTools -Force
Get-Command -Module MyTools
Remove-Module MyTools
```

### Export-Steuerung

In `.psm1`:
```powershell
Export-ModuleMember -Function 'Get-*'
```
Im Manifest:
```powershell
FunctionsToExport = @('Get-DiskInfo')
```

## Microsoft Learn
- [Writing a Windows PowerShell Module](https://learn.microsoft.com/powershell/scripting/developer/module/writing-a-windows-powershell-module)
- [How to Write a PowerShell Script Module](https://learn.microsoft.com/powershell/scripting/developer/module/how-to-write-a-powershell-script-module)

## Übungen
Siehe [`exercises/M02`](../exercises/M02/README.md).
