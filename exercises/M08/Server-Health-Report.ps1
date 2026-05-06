#Requires -Version 5.1
[CmdletBinding()]
param(
    [string[]]$ComputerName = @('localhost'),
    [string]$OutFile        = "$env:TEMP\health.html",
    [ValidateSet('Html','Csv')]
    [string]$Format         = 'Html'
)

# TODO Module importieren, Daten sammeln, formatieren, ausgeben
