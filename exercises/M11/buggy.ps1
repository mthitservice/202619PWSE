#Requires -Version 5.1
<#
    Buggy! Finde und behebe die Fehler.
    Erwartet: für 1..5 -> Sum=15 Avg=3
#>
[CmdletBinding()]
param(
    [int[]]$Numbers = @(1,2,3,4,5)
)

$sum = 0
foreach ($n in $Number) {        # Bug 1
    $sum = $sum + $n
}

$avg = $sum / $Numbers.Length + 1   # Bug 2

Write-Output "Sum=$summe Avg=$avg"  # Bug 3
