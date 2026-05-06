# M12 – Übungen: PowerShell Workflow

> Diese Übungen erfordern **Windows PowerShell 5.1** (kein PS 7).

## Übung 12.1 – Parallel Test
Schreibe einen Workflow `Test-ServerWF` mit `foreach -parallel`, der per `Test-Connection` mehrere Server prüft.

## Übung 12.2 – Sequence in Parallel
Erweitere den Workflow um einen `parallel`-Block, der Disk- und Service-Status parallel abruft, aber Disk-Operationen mit `sequence` in Reihe.

## Übung 12.3 – Migration nach PS 7
Schreibe das Workflow-Beispiel in einer PS 7-Variante mit `ForEach-Object -Parallel` neu. Vergleiche Laufzeit (`Measure-Command`).

Starter: [`Test-ServerWF.ps1`](Test-ServerWF.ps1)
