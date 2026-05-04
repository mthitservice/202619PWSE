# Modul 00 – Grundlagen & Werkzeuge

> Pflicht-Einstieg vor allen weiteren Modulen. Klärt das *Warum*, das richtige Werkzeug und die Production-Readiness von PowerShell-Code.

## Lernziele

- Verstehen, dass PowerShell auf **.NET** aufbaut und was das praktisch bedeutet
- Die Bedeutung von **Datentypen** sicher einordnen
- Den richtigen **Editor** wählen (VS Code) und konfigurieren
- **Code-Signing** im produktiven Umfeld umsetzen
- Den Mehrwert eines **CI/CD-Systems** für Paketmanagement und Code-Security verstehen

---

## 1) PowerShell baut auf .NET auf

PowerShell ist **kein** eigenständiger Skript-Interpreter wie Bash – es ist eine **Shell auf der .NET-Runtime**.

| Edition | Runtime |
|---------|---------|
| Windows PowerShell 5.1 | .NET Framework 4.x |
| PowerShell 7.x         | .NET (Core) 6/8/9 – plattformübergreifend |

Praktische Konsequenzen:

- **Alles ist ein .NET-Objekt**: Pipeline-Objekte sind keine Textzeilen, sondern typisierte Instanzen.
- Du kannst direkt **.NET-Klassen** und -Methoden aufrufen:
  ```powershell
  [System.Net.Dns]::GetHostByName('localhost')
  [System.IO.Path]::Combine('C:\','tmp','x.log')
  [guid]::NewGuid()
  ```
- **Typ-Operatoren** statt Stringvergleichen:
  ```powershell
  $obj -is [string]
  $obj.GetType().FullName
  ```
- Du kannst eigene **Klassen** definieren (PS 5+):
  ```powershell
  class Server { [string]$Name; [int]$Port }
  ```

---

## 2) Datentypen sind kritisch

Falsche Typen sind Fehlerquelle Nummer 1 in Produktiv-Skripten. PowerShell konvertiert *implizit* – das fühlt sich angenehm an, kann aber gefährlich werden.

```powershell
'10' + 5         # -> '105'   (String-Konkatenation!)
10  + '5'        # -> 15      (Zahl-Addition)
'10' -gt 9       # -> $false  (String-Vergleich!)
[int]'10' -gt 9  # -> $true
```

### Empfehlungen

1. **Parameter immer typisieren** – `[int]`, `[string[]]`, `[datetime]`, `[ipaddress]`, `[guid]`, ...
2. **Cast früh** – nicht erst bei der Ausgabe, sondern beim Eintritt in die Funktion.
3. **`Set-StrictMode -Version Latest`** in jedem Skript-Kopf:
   ```powershell
   Set-StrictMode -Version Latest
   ```
4. Bei Berechnungen: `[double]`, `[decimal]` (Geld!), `[long]` (Bytes!) gezielt wählen.
5. **`PSCustomObject`** statt Hashtable, sobald Output stabil sein muss (Reihenfolge, Typ-Tag).

### Typ-Beschleuniger (häufig genutzt)

`[int] [long] [double] [decimal] [bool] [string] [char]`
`[datetime] [timespan] [guid] [version] [uri] [ipaddress] [mailaddress]`
`[xml] [regex] [scriptblock] [hashtable] [pscustomobject] [ordered]`

---

## 3) Editor – Visual Studio Code

**Empfehlung:** VS Code + Extension **PowerShell** (Microsoft) oder **PowerShell Preview**.

Vorteile gegenüber ISE und reinem Editor:

- IntelliSense, Parameter-Hilfen, Hover-Doku
- Debugging mit Breakpoints, Watch, Call-Stack
- Integriertes Terminal mit Profil-Auswahl
- **PSScriptAnalyzer** automatisch beim Tippen
- Git-Integration, Multi-Root, Remote-Dev (SSH/WSL/Container)
- **Cross-Platform** (Windows / macOS / Linux)
- Kostet nichts und wird aktiv weiterentwickelt – die ISE wird **nicht** mehr weiterentwickelt.

Empfohlene Extensions:
- `ms-vscode.powershell`
- `editorconfig.editorconfig`
- `ms-vscode-remote.remote-ssh` (optional)

Empfohlene Settings (`settings.json`):
```jsonc
{
  "powershell.codeFormatting.preset": "OTBS",
  "powershell.scriptAnalysis.enable": true,
  "powershell.codeFormatting.useCorrectCasing": true,
  "files.encoding": "utf8bom",
  "files.trimTrailingWhitespace": true,
  "editor.formatOnSave": true
}
```

---

## 4) Code-Signing im produktiven Umfeld

Skripte aus Mailanhängen, Downloads oder Shares sind ein klassischer Angriffsvektor. Daher gilt:

> **Produktive Skripte werden signiert. Punkt.**

### Execution Policy

```powershell
Get-ExecutionPolicy -List
```

Empfohlen für produktive Server: **`AllSigned`** oder **`RemoteSigned`** mit Code-Signing-Zertifikat.

### Skript signieren

1. Zertifikat besorgen (interne PKI / öffentlich / Self-Signed nur für Tests):
   ```powershell
   New-SelfSignedCertificate -Type CodeSigningCert `
       -Subject 'CN=PowerShell Trainer' `
       -CertStoreLocation Cert:\CurrentUser\My
   ```
2. Signieren:
   ```powershell
   $cert = Get-ChildItem Cert:\CurrentUser\My -CodeSigningCert | Select-Object -First 1
   Set-AuthenticodeSignature -FilePath .\Deploy.ps1 -Certificate $cert -TimestampServer 'http://timestamp.digicert.com'
   ```
3. Prüfen:
   ```powershell
   Get-AuthenticodeSignature .\Deploy.ps1
   ```

### Was wird signiert?

`.ps1`, `.psm1`, `.psd1`, `.ps1xml`, `.pssc`, `.psrc` – jede Datei, die ausgeführt oder importiert wird.

---

## 5) CI/CD für PowerShell – Paketmanagement & Code-Security

In professionellen Umgebungen sollten Skripte/Module wie *richtige Software* behandelt werden.

### Paketmanagement (Module)

- **PowerShellGet / PSResourceGet** als Client
- **NuGet-Feed** als Repository – z. B. Azure Artifacts, GitHub Packages, ProGet, Nexus, Artifactory
- Eigene Module per `Publish-Module` / `Publish-PSResource` veröffentlichen
- Versionierung **SemVer** (`1.2.3`), Manifest (`.psd1`) pflegen

```powershell
Register-PSRepository -Name CorpFeed `
    -SourceLocation 'https://pkgs.dev.azure.com/.../_packaging/CorpFeed/nuget/v2' `
    -InstallationPolicy Trusted

Install-Module MyTools -Repository CorpFeed
```

### CI/CD-Pipeline für PowerShell-Module

Empfohlene Stufen (z.B. **GitHub Actions** oder **Azure DevOps**):

| Stage | Tools |
|-------|-------|
| Lint            | `Invoke-ScriptAnalyzer` |
| Test            | `Pester` (Unit + Integration) |
| Security-Scan   | `Invoke-ScriptAnalyzer -IncludeRule PSAvoidUsingPlainTextForPassword,...`<br>Secret-Scan (z.B. GitHub Advanced Security, gitleaks)<br>Dependency-Scan (z.B. Dependabot) |
| Build           | Manifest-Update, Help generieren |
| Sign            | `Set-AuthenticodeSignature` mit gehärtetem Cert (HSM/Key-Vault) |
| Publish         | `Publish-Module` an internen Feed |
| Release         | Tag in Git, Release-Notes, optional Public-Gallery |

Beispiel `azure-pipelines.yml` (Auszug):

```yaml
steps:
- pwsh: |
    Install-Module Pester, PSScriptAnalyzer -Force -Scope CurrentUser
    Invoke-ScriptAnalyzer -Path . -Recurse -Severity Error,Warning -EnableExit
- pwsh: Invoke-Pester -Path .\tests -CI
- task: AzureKeyVault@2
  inputs: { ... }     # Cert holen
- pwsh: Set-AuthenticodeSignature ...
- pwsh: Publish-Module -Path .\MyTools -Repository CorpFeed -NuGetApiKey $env:KEY
```

### Vorteile

- **Reproduzierbar** statt „läuft auf meinem Rechner“
- **Nachvollziehbar** (Git-History, signierte Releases)
- **Sicher** (kein manuelles Kopieren auf Server, keine ungeprüften Snippets)
- **Skalierbar** (mehrere Teams konsumieren denselben Feed)

---

## Microsoft Learn

- [PowerShell auf .NET](https://learn.microsoft.com/powershell/scripting/overview)
- [about_Types.ps1xml](https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_types.ps1xml)
- [Set-StrictMode](https://learn.microsoft.com/powershell/module/microsoft.powershell.core/set-strictmode)
- [VS Code für PowerShell](https://learn.microsoft.com/powershell/scripting/dev-cross-plat/vscode/using-vscode)
- [about_Signing](https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_signing)
- [PowerShell Gallery & PSResourceGet](https://learn.microsoft.com/powershell/gallery/overview)
- [Pester](https://pester.dev)
- [PSScriptAnalyzer](https://learn.microsoft.com/powershell/utility-modules/psscriptanalyzer/overview)

## Übungen
Siehe [`exercises/M00`](../exercises/M00/README.md).
