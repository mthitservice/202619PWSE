# Scripting mit PowerShell für Experten

**Trainer:** Michael Lindner
**Dauer:** 3 Tage
**Voraussetzungen:** Sicherer Umgang mit PowerShell-Basics (Cmdlets, Pipeline, Variablen, einfache Skripte), Windows-Administrationsgrundlagen.

## Lernziele

Nach Abschluss des Kurses können Teilnehmer:innen

- erweiterte PowerShell-Funktionen mit Parameter-Validierung und Pipeline-Unterstützung schreiben
- wiederverwendbare Skript-Module entwickeln und bereitstellen
- Controller-Skripte zur Orchestrierung von Tool-Funktionen erstellen
- robustes Error-Handling implementieren
- XML-Datendateien lesen, manipulieren und schreiben
- bestehende Skripte analysieren und debuggen
- PowerShell-Workflows einsetzen
- Just Enough Administration (JEA) konfigurieren

## Kursplan (3 Tage)

### Tag 1 – Grundlagen, Erweiterte Funktionen & Module
| Modul | Thema |
|-------|-------|
| [M00](modules/M00_Grundlagen_und_Werkzeuge.md) | Grundlagen: .NET-Basis, Datentypen, Tooling, Code-Signing, CI/CD |
| [M01](modules/M01_Erweiterte_Funktionen.md) | Erstellen erweiterter Funktionen |
| [M02](modules/M02_Befehl_zu_Funktion_und_Module.md) | Befehl → Funktion konvertieren, Skript-Module |
| [M03](modules/M03_Parameter_und_Validation.md) | Parameter-Attribute & Input Validation |
| [M04](modules/M04_Multiple_Objects_und_Pipeline.md) | Multiple Objects & Pipeline-Input |

### Tag 2 – Output, Help, Controller
| Modul | Thema |
|-------|-------|
| [M05](modules/M05_Komplexer_Output.md) | Komplexer Funktions-Output |
| [M06](modules/M06_Comment_Based_Help.md) | Dokumentation mit Comment-Based Help |
| [M07](modules/M07_WhatIf_Confirm.md) | -WhatIf und -Confirm |
| [M08](modules/M08_Controller_Skripte.md) | Controller-Skripte |

### Tag 3 – Fehler, XML, Debugging, Workflow, JEA
| Modul | Thema |
|-------|-------|
| [M09](modules/M09_Fehlerbehandlung.md) | Skript-Fehlerbehandlung |
| [M10](modules/M10_XML_Daten.md) | XML Data Files |
| [M11](modules/M11_Debugging_und_Analyse.md) | Analyse & Fehlerbeseitigung in Skripten |
| [M12](modules/M12_PowerShell_Workflow.md) | PowerShell Workflows |
| [M13](modules/M13_JEA.md) | Just Enough Administration (JEA) |

## Verzeichnisstruktur

```
.
├── modules/                # Theorie-Unterlagen pro Modul (.md)
├── exercises/              # Übungsangaben + Starter-Skripte für Teilnehmer
│   └── MXX/                # ein Ordner pro Modul
├── solutions/              # Musterlösungen (per .gitignore ausgeblendet)
│   └── MXX/
└── demos/                  # Live-Demos des Trainers (per .gitignore ausgeblendet)
    └── MXX/
```

## Konventionen

- Alle Skripte verwenden `#Requires -Version 5.1` (oder höher, falls nötig)
- Funktionsnamen folgen Verb-Substantiv (`Get-Verb` für gültige Verben)
- Approved Verbs, PascalCase, sprechende Parameter-Namen
- Comment-Based Help in jeder Funktion ab Modul 6

## Microsoft Learn – Originalunterlagen

- [PowerShell Documentation](https://learn.microsoft.com/powershell/scripting/overview)
- [about_Functions_Advanced](https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_functions_advanced)
- [about_Functions_Advanced_Parameters](https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_functions_advanced_parameters)
- [about_CommonParameters](https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_commonparameters)
- [about_Comment_Based_Help](https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_comment_based_help)
- [about_Try_Catch_Finally](https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_try_catch_finally)
- [JEA Overview](https://learn.microsoft.com/powershell/scripting/learn/remoting/jea/overview)
