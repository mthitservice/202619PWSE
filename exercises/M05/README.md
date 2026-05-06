# M05 – Übungen: Komplexer Output

## Übung 5.1 – DiskReport
Implementiere `Get-DiskReport` (siehe Theorie), gib pro Laufwerk ein Objekt mit eigenem TypeName `DiskReport` aus.

## Übung 5.2 – Streams
Erweitere die Funktion so, dass sie:
- bei `< 10%` freiem Platz `Write-Warning` ausgibt
- mit `-Verbose` jede abgefragte Maschine meldet
- mit `-Information "Done"` einen Information-Stream liefert

## Übung 5.3 – Format-Datei
Erstelle `DiskReport.format.ps1xml` (siehe Theorie) und lade sie mit `Update-FormatData`. Prüfe, dass `Get-DiskReport` ohne `Format-Table` schon hübsch erscheint.

Starter: [`Get-DiskReport.ps1`](Get-DiskReport.ps1)
