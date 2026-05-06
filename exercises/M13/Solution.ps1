#Requires -Version 5.1
#Requires -RunAsAdministrator
<#
    M13 Lösung – komplettes JEA-Setup für die Rolle "Helpdesk".
#>

$ModuleRoot = 'C:\Program Files\WindowsPowerShell\Modules\HelpdeskRole'
$RcFolder   = Join-Path $ModuleRoot 'RoleCapabilities'
$RcFile     = Join-Path $RcFolder   'Helpdesk.psrc'
$PsscFolder = 'C:\JEA'
$PsscFile   = Join-Path $PsscFolder 'Helpdesk.pssc'
$Transcript = Join-Path $PsscFolder 'Transcripts'

# Ordner
New-Item $RcFolder, $PsscFolder, $Transcript -ItemType Directory -Force | Out-Null

# Modul-Manifest
$psd1 = Join-Path $ModuleRoot 'HelpdeskRole.psd1'
if (-not (Test-Path $psd1)) {
    New-ModuleManifest -Path $psd1 -RootModule '' -Description 'JEA role module'
}

# Role Capability
New-PSRoleCapabilityFile -Path $RcFile `
    -VisibleCmdlets `
        'Get-Service', `
        @{ Name='Restart-Service'; Parameters=@(@{ Name='Name'; ValidateSet='Spooler','BITS' }) } `
    -VisibleFunctions 'Get-DiskFree' `
    -FunctionDefinitions @{
        Name = 'Get-DiskFree'
        ScriptBlock = {
            Get-CimInstance Win32_LogicalDisk |
                Where-Object DriveType -eq 3 |
                Select-Object DeviceID,
                    @{n='FreePct';e={[math]::Round($_.FreeSpace/$_.Size*100,1)}}
        }
    }

# Session Configuration
New-PSSessionConfigurationFile -Path $PsscFile `
    -SessionType RestrictedRemoteServer `
    -RunAsVirtualAccount `
    -TranscriptDirectory $Transcript `
    -RoleDefinitions @{
        'BUILTIN\Users' = @{ RoleCapabilities = 'Helpdesk' }
    }

# Endpoint registrieren
if (Get-PSSessionConfiguration -Name JEA_Helpdesk -ErrorAction SilentlyContinue) {
    Unregister-PSSessionConfiguration -Name JEA_Helpdesk -Force
}
Register-PSSessionConfiguration -Name JEA_Helpdesk -Path $PsscFile -Force

"Endpoint JEA_Helpdesk bereit. Test:"
"Enter-PSSession -ComputerName localhost -ConfigurationName JEA_Helpdesk"
