# M04 – Übungen: Multiple Objects & Pipeline

## Übung 4.1 – Array-Parameter
Schreibe `Test-Port` mit `[string[]]$ComputerName` und `[int]$Port = 443`.
Für jedes Pärchen Computer/Port soll ein Objekt zurückkommen:

```
ComputerName  Port  Open
------------  ----  ----
srv01         443   True
srv02         443   False
```

## Übung 4.2 – Pipeline ByValue
Erweitere `Test-Port`, sodass `'srv01','srv02' | Test-Port -Port 80` funktioniert.

## Übung 4.3 – Pipeline ByPropertyName
Mache `Test-Port` zusätzlich kompatibel zu Objekten mit Property `ComputerName`/`Name`:

```powershell
Get-ADComputer -Filter * | Test-Port -Port 3389
Import-Csv .\hosts.csv    | Test-Port           # CSV-Spalte "ComputerName"
```

Starter: [`Test-Port.ps1`](Test-Port.ps1)
