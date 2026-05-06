# Modul 05 – Komplexer Funktions-Output

## Lernziele
- Strukturierte Objekte mit `[pscustomobject]` zurückgeben
- `Write-Output` korrekt einsetzen, `Write-Host` vermeiden
- Mehrere Output-Streams nutzen (`Write-Verbose`, `-Warning`, `-Error`, `-Debug`, `-Information`)
- `OutputType()`-Attribut für Tooling

## Objekt-Output

```powershell
function Get-DiskReport {
    [CmdletBinding()]
    [OutputType('DiskReport')]
    param([string]$ComputerName = $env:COMPUTERNAME)

    Get-CimInstance Win32_LogicalDisk -ComputerName $ComputerName |
        ForEach-Object {
            $obj = [pscustomobject]@{
                ComputerName = $_.PSComputerName
                Drive        = $_.DeviceID
                SizeGB       = [math]::Round($_.Size/1GB,2)
                FreeGB       = [math]::Round($_.FreeSpace/1GB,2)
                FreePercent  = if ($_.Size) { [math]::Round($_.FreeSpace/$_.Size*100,1) } else { 0 }
            }
            $obj.PSObject.TypeNames.Insert(0,'DiskReport')
            $obj
        }
}
```

## Streams

| Stream | Cmdlet | Sichtbar mit |
|--------|--------|--------------|
| Output | `Write-Output` | immer |
| Verbose | `Write-Verbose` | `-Verbose` |
| Warning | `Write-Warning` | immer (umleitbar) |
| Error  | `Write-Error` | immer |
| Debug  | `Write-Debug` | `-Debug` |
| Information | `Write-Information` | `-InformationAction Continue` |

> **Faustregel:** Funktionen geben *Objekte* aus – nie formatierten Text. Formatierung ist Aufgabe des Aufrufers (Controller-Skript).

## OutputType + Format-Datei (optional)

`DiskReport.format.ps1xml` definiert eine Standard-Tabellenansicht:

```xml
<View>
  <Name>DiskReport</Name>
  <ViewSelectedBy><TypeName>DiskReport</TypeName></ViewSelectedBy>
  <TableControl>
    <TableHeaders><TableColumnHeader/><TableColumnHeader/><TableColumnHeader/></TableHeaders>
    <TableRowEntries><TableRowEntry><TableColumnItems>
      <TableColumnItem><PropertyName>ComputerName</PropertyName></TableColumnItem>
      <TableColumnItem><PropertyName>Drive</PropertyName></TableColumnItem>
      <TableColumnItem><PropertyName>FreeGB</PropertyName></TableColumnItem>
    </TableColumnItems></TableRowEntry></TableRowEntries>
  </TableControl>
</View>
```

Laden via `Update-FormatData -PrependPath .\DiskReport.format.ps1xml`.

## Microsoft Learn
- [about_Output_Streams](https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_output_streams)
- [about_Format.ps1xml](https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_format.ps1xml)

## Übungen
Siehe [`exercises/M05`](../exercises/M05/README.md).
