# Modul 09 – Skript-Fehlerbehandlung

## Lernziele
- Terminating vs. Non-Terminating Errors unterscheiden
- `try/catch/finally` einsetzen
- `$ErrorActionPreference`, `-ErrorAction`, `-ErrorVariable`
- Eigene Fehler werfen mit `throw` und `Write-Error`

## Fehlerarten

| Typ | Beispiele | Verhalten |
|-----|-----------|-----------|
| Non-Terminating | `Get-Item NichtDa` | Skript läuft weiter, Fehler in `$Error` |
| Terminating | `throw`, Syntaxfehler | Skript bricht ab, von `try/catch` fangbar |

Mit `-ErrorAction Stop` wird ein Non-Terminating Error in einen Terminating Error verwandelt – Voraussetzung, damit `catch` greift.

## try / catch / finally

```powershell
try {
    $u = Get-ADUser -Identity $Name -ErrorAction Stop
}
catch [Microsoft.ActiveDirectory.Management.ADIdentityNotFoundException] {
    Write-Warning "User '$Name' nicht gefunden"
}
catch {
    Write-Error "Unerwarteter Fehler: $($_.Exception.Message)"
    throw   # weitergeben
}
finally {
    Write-Verbose "Cleanup"
}
```

## Selbst Fehler werfen

```powershell
throw "Pfad '$Path' existiert nicht"        # terminating
Write-Error  "Service nicht erreichbar"     # non-terminating
$PSCmdlet.ThrowTerminatingError($errorRecord)   # in Advanced Functions
```

## $Error & ErrorVariable

```powershell
Get-Item BLA -ErrorAction SilentlyContinue -ErrorVariable err
if ($err) { ... }
$Error[0]            # letzter Fehler
$Error.Clear()
```

## Microsoft Learn
- [about_Try_Catch_Finally](https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_try_catch_finally)
- [about_CommonParameters](https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_commonparameters)

## Übungen
Siehe [`exercises/M09`](../exercises/M09/README.md).
