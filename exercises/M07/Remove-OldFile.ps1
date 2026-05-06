#Requires -Version 5.1
function Remove-OldFile {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='High')]
    param(
        [Parameter(Mandatory)]
        [ValidateScript({Test-Path $_})]
        [string]$Path,
        [int]$Days = 30
    )
    # TODO: alte Dateien finden, ShouldProcess-pro-Datei, ggf. ShouldContinue bei >100
}
