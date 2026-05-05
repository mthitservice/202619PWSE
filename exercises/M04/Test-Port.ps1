#Requires -Version 5.1
function Test-Port {
    [CmdletBinding()]
    param(
        # TODO Pipeline + Validation
        [string[]]$ComputerName,
        [int]$Port = 443
    )
    process {
        # TODO TCP-Connect testen und Objekt ausgeben
    }
}
