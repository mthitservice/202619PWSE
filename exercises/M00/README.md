# M00 – Übungen: Grundlagen & Werkzeuge

## Übung 0.1 – .NET-Objekte erkunden
Führe folgendes aus und beantworte die Fragen:

```powershell
$p = Get-Process -Id $PID
$p.GetType().FullName
$p | Get-Member -MemberType Property | Select-Object -First 10
$p | Get-Member -MemberType Method   | Select-Object -First 10
```

- Welcher .NET-Typ steckt hinter `Get-Process`?
- Rufe eine Methode des Objektes direkt auf (z.B. `$p.Refresh()`).

## Übung 0.2 – Datentypen-Fallen
Sage *vor* der Ausführung voraus, was passiert:

```powershell
'10' + 5
10 + '5'
'10' -gt 9
[datetime]'2026-12-31' - (Get-Date)
[int]'0123'
```

Erkläre die jeweilige implizite Typkonvertierung.

## Übung 0.3 – StrictMode
Aktiviere `Set-StrictMode -Version Latest` und führe folgendes Skript aus:

```powershell
$user = [pscustomobject]@{ Name = 'Anna' }
$user.Mail   # Property gibt es nicht
```

- Was ist das Verhalten **mit** und **ohne** StrictMode?

## Übung 0.4 – Self-Signed Code-Signing
1. Erzeuge ein Self-Signed Code-Signing-Zertifikat.
2. Signiere `Get-FreeMemory.ps1` aus M01.
3. Setze `Set-ExecutionPolicy AllSigned -Scope CurrentUser` in einer Test-Session.
4. Führe das Skript aus und beobachte die Vertrauensabfrage.

## Übung 0.5 – Lokales Repository
Lege einen lokalen NuGet-„Feed“ als Ordner an und veröffentliche ein Mini-Modul:

```powershell
$feed = "$env:TEMP\LocalFeed"
New-Item $feed -ItemType Directory -Force | Out-Null
Register-PSRepository -Name Local -SourceLocation $feed -InstallationPolicy Trusted
# ... eigenes Modul mit New-ModuleManifest erzeugen ...
Publish-Module -Path .\MyTools -Repository Local -NuGetApiKey 'na'
Find-Module -Repository Local
```

Starter: [`Demo-DotNet.ps1`](Demo-DotNet.ps1)
