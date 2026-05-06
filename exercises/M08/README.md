# M08 – Übungen: Controller-Skripte

## Übung 8.1 – Server-Health-Report
Schreibe `Server-Health-Report.ps1`, das:

1. eine Liste von Servern aus `-ComputerName` (Default `localhost`) entgegennimmt
2. `Get-DiskReport` (M05) und `Get-Service`/`Test-Port` (M04) nutzt
3. einen **HTML-Report** in `-OutFile` (Default `$env:TEMP\health.html`) erzeugt
4. den Report im Browser öffnet

## Übung 8.2 – CSV statt HTML
Erweitere das Skript um den Schalter `-Format Csv|Html` (per `ValidateSet`) und schreibe entsprechend CSV oder HTML.

## Übung 8.3 – Logging
Aktiviere Transkript-Logging via `Start-Transcript`/`Stop-Transcript` in einen Pfad `$env:TEMP\health.log`.

Starter: [`Server-Health-Report.ps1`](Server-Health-Report.ps1)
