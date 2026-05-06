#Requires -Version 5.1
# nur Windows PowerShell 5.1
workflow Test-ServerWF {
    param([string[]]$ComputerName)
    # TODO foreach -parallel + Test-Connection
}

# Test-ServerWF -ComputerName 'localhost','127.0.0.1','8.8.8.8'
