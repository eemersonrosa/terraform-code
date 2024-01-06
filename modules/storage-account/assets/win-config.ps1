# Parameters
$desired_hostname = "emerson"
$user_name = "adminuser"
$log_file = "C:\deploy.log"

# Function for error handling and logging
function Write-ErrorLog {
    param (
        [string]$errorMessage
    )

    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $errorEntry = "[ERROR][$timestamp] $errorMessage"
    Write-Output $errorEntry | Out-File -Append -FilePath $log_file
    exit 1
}

# Function for logging
function Write-Log {
    param (
        [string]$message
    )

    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logEntry = "[$timestamp] $message"
    Write-Output $logEntry | Out-File -Append -FilePath $log_file
}

# Redirect all output to the log file
Start-Transcript -Path $log_file

# Main script starts here
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
Write-Log "This is a Terraform Windows deployment script."

# Set hostname
try {
    Write-Log "Setting the hostname to '$desired_hostname'..."
    $env:COMPUTERNAME = $desired_hostname
    Write-Log "Hostname has been changed successfully to '$desired_hostname'."
}
catch {
    Write-ErrorLog "Failed to set hostname to '$desired_hostname'. Error: $_"
}

# Set username (You may need to provide additional details on how to set the username as it depends on your specific requirements.)

# Script execution completed successfully
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
Write-Log "Script execution completed successfully."

# End the transcript
Stop-Transcript
