# Modul 10 – XML Data Files

## Lernziele
- XML-Dateien lesen mit `[xml]` und `Select-Xml`
- Knoten manipulieren und neue erzeugen
- XML zurückschreiben
- `Export-Clixml` / `Import-Clixml` für PS-Objekte

## Lesen mit `[xml]`

```powershell
[xml]$config = Get-Content .\config.xml
$config.configuration.servers.server   # XPath-artiger Zugriff
foreach ($s in $config.configuration.servers.server) {
    "$($s.name) → $($s.ip)"
}
```

## Lesen mit `Select-Xml`

```powershell
Select-Xml -Path .\config.xml -XPath '//server[@role="DB"]' |
    ForEach-Object { $_.Node.name }
```

## Manipulieren

```powershell
[xml]$config = Get-Content .\config.xml

# Wert ändern
($config.configuration.servers.server | Where-Object name -eq 'srv01').ip = '10.0.0.5'

# Neuen Knoten anlegen
$new = $config.CreateElement('server')
$new.SetAttribute('name','srv99')
$new.SetAttribute('role','Web')
$new.SetAttribute('ip','10.0.0.99')
$config.configuration.servers.AppendChild($new) | Out-Null

$config.Save("$PWD\config.xml")
```

## CliXml (Serialisierung von PS-Objekten)

```powershell
Get-Process | Export-Clixml .\procs.xml
$procs = Import-Clixml .\procs.xml
```

> Eignet sich für Cache, Übergabe zwischen Sessions, Snapshots – **nicht** für Konfiguration, die Menschen editieren.

## Microsoft Learn
- [about_Select-Xml](https://learn.microsoft.com/powershell/module/microsoft.powershell.utility/select-xml)
- [Export-Clixml](https://learn.microsoft.com/powershell/module/microsoft.powershell.utility/export-clixml)

## Übungen
Siehe [`exercises/M10`](../exercises/M10/README.md).
