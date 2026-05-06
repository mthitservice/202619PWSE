# Modul 12 – PowerShell Workflow

> **Hinweis:** PowerShell Workflow basiert auf *Windows Workflow Foundation* und ist nur in **Windows PowerShell 5.1** verfügbar – **nicht** in PowerShell 7+. Für neue Projekte sind `ForEach-Object -Parallel` (PS 7) oder Background-Jobs zu bevorzugen. Dieses Modul dient dem Verständnis bestehender Skripte.

## Lernziele
- Aufbau eines Workflows verstehen
- Aktivitäten und Parallelisierung
- Checkpoints und Wiederaufnahme nach Unterbrechung
- Migration nach PS 7

## Aufbau

```powershell
workflow Test-Servers {
    param([string[]]$ComputerName)

    foreach -parallel ($c in $ComputerName) {
        InlineScript {
            Test-Connection -ComputerName $using:c -Count 1 -Quiet
        }
    }
}

Test-Servers -ComputerName 'srv01','srv02','srv03'
```

## Wichtige Konstrukte

| Konstrukt | Beschreibung |
|-----------|--------------|
| `parallel { ... }` | Block parallel ausführen |
| `foreach -parallel` | Schleifen-Iterationen parallel |
| `sequence { ... }` | innerhalb parallel: erzwingt Reihenfolge |
| `InlineScript { }` | klassisches PS-Skript ausführen |
| `Checkpoint-Workflow` | Zustand persistieren |
| `Suspend-Workflow` | pausieren, später resume |

## Checkpoint-Beispiel

```powershell
workflow Long-Job {
    "Phase 1"
    Checkpoint-Workflow
    "Phase 2"
}
```

Aufruf mit Persistenz: `Long-Job -AsJob -JobName 'demo'`. Bei Reboot: `Resume-Job demo`.

## Migration zu PowerShell 7

| Workflow | PS 7 Äquivalent |
|----------|-----------------|
| `foreach -parallel` | `ForEach-Object -Parallel { } -ThrottleLimit 5` |
| `parallel { }` | `Start-ThreadJob` / `Start-Job` |
| `Checkpoint-Workflow` | externe State-Speicherung (JSON, DB) |

```powershell
'srv01','srv02','srv03' | ForEach-Object -Parallel {
    Test-Connection $_ -Count 1 -Quiet
} -ThrottleLimit 10
```

## Microsoft Learn
- [Getting Started with Windows PowerShell Workflow](https://learn.microsoft.com/system-center/sma/overview-powershell-workflows)
- [ForEach-Object -Parallel](https://learn.microsoft.com/powershell/module/microsoft.powershell.core/foreach-object)

## Übungen
Siehe [`exercises/M12`](../exercises/M12/README.md).
