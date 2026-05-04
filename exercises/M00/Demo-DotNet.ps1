#Requires -Version 5.1
<#
    M00 - Starter zum Erkunden von .NET / Datentypen.
    Trage deine Beobachtungen als Kommentare ein.
#>

# 1) .NET hinter PowerShell
$p = Get-Process -Id $PID
# TODO: Typname ausgeben

# 2) Datentypen
# TODO: vorhersagen, dann ausführen
'10' + 5
10  + '5'
'10' -gt 9

# 3) StrictMode
# Set-StrictMode -Version Latest
$user = [pscustomobject]@{ Name = 'Anna' }
# $user.Mail
