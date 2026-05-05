#Requires -Version 5.1
function Get-OSInfo {
    [CmdletBinding()]
    param(
        [string]$ComputerName = 'localhost'
    )
    # TODO: Get-CimInstance Win32_OperatingSystem ...
    # TODO: gewünschte Properties zurückgeben
}
