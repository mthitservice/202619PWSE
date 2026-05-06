# M10 – Übungen: XML

## Daten
Verwende [`servers.xml`](servers.xml).

## Übung 10.1 – Lesen
Lade `servers.xml` und gib für jeden Server `name`, `role`, `ip` als Objekt aus. Filtere danach alle Server mit Rolle `DB`.

## Übung 10.2 – Manipulieren
- Ändere die IP von `srv01` auf `10.0.0.5`.
- Füge einen neuen Server `srv99` (Role `Web`, IP `10.0.0.99`) hinzu.
- Speichere die Änderungen in `servers.modified.xml`.

## Übung 10.3 – CliXml
Hole `Get-Service | Select-Object Name,Status,StartType` und exportiere nach `services.xml` mit `Export-Clixml`. Reimportiere und filtere `Status = Stopped`.

Starter: [`Use-XmlData.ps1`](Use-XmlData.ps1)
