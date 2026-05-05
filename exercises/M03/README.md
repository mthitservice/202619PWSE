# M03 – Übungen: Parameter & Validation

## Übung 3.1 – Validation
Schreibe `New-UserName`, das aus Vor- und Nachname einen Login generiert.

Anforderungen:
- `-FirstName` und `-LastName`: `[ValidateNotNullOrEmpty()]`, mind. 2 Zeichen
- `-Style`: nur `'flast'`, `'firstl'`, `'first.last'` (per `ValidateSet`)
- Output: kleinbuchstaben, ohne Leerzeichen

Beispiele:
```powershell
New-UserName -FirstName Anna -LastName Müller -Style flast      # amueller
New-UserName -FirstName Anna -LastName Müller -Style first.last # anna.müller
```

Starter: [`New-UserName.ps1`](New-UserName.ps1)

## Übung 3.2 – ValidateScript
Schreibe `Read-ConfigFile -Path` mit einem `ValidateScript`, das prüft, ob die Datei existiert **und** Endung `.json` oder `.xml` hat.

## Übung 3.3 – ParameterSets
Erweitere `Get-AppLog` so, dass entweder `-LogName` **oder** `-Path` (Pfad zur evtx-Datei) angegeben werden kann – aber nicht beides.
