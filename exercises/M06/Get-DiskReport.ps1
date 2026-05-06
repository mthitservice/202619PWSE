#Requires -Version 5.1
function Get-DiskReport {
    # TODO: Comment-Based Help-Block hier
    [CmdletBinding()]
    [OutputType('DiskReport')]
    param(
        [Parameter(ValueFromPipeline)]
        [string[]]$ComputerName = $env:COMPUTERNAME
    )
    process { <# ... #> }
}
