# Define variables
$updateUrl = "https://catalog.sf.dl.delivery.mp.microsoft.com/filestreamingservice/files/92ac27d7-6832-4bac-8205-922458d3df2b/public/windows11.0-kb5040527-x64_4713766dc272c376bee6d39d39a84a85bcd7f1e7.msu"
$updateFile = "C:\Temp\windows11.0-kb5040527-x64.msu"
$destinationFolder = "C:\Temp"

# Create the destination folder if it doesn't exist
if (-not (Test-Path -Path $destinationFolder)) {
    New-Item -ItemType Directory -Path $destinationFolder
}

# Download the update
Invoke-WebRequest -Uri $updateUrl -OutFile $updateFile

# Check if the file was downloaded successfully
if (Test-Path -Path $updateFile) {
    Write-Host "Update downloaded successfully."
} else {
    Write-Host "Failed to download the update."
    exit 1
}

# Install the update
Write-Host "Installing the update..."
Start-Process -FilePath "wusa.exe" -ArgumentList "$updateFile /quiet /norestart" -Wait

# Check the exit code of the installation
if ($LASTEXITCODE -eq 0) {
    Write-Host "Update installed successfully."
} else {
    Write-Host "Update installation failed with exit code $LASTEXITCODE."
    exit $LASTEXITCODE
}
