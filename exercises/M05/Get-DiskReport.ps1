#Requires -Version 5.1
function Get-DiskReport {
    [CmdletBinding()]
    [OutputType('DiskReport')]
    param(
        [Parameter(ValueFromPipeline,ValueFromPipelineByPropertyName)]
        [Alias('Name','CN')]
        [string[]]$ComputerName = $env:COMPUTERNAME
    )
    process {
        # TODO Win32_LogicalDisk, Objekt erzeugen, TypeName setzen, Warning bei <10%
    }
}
