 # Define the output file
$outputFile = "result.txt"

# Create or clear the result.txt file
Clear-Content -Path $outputFile -ErrorAction SilentlyContinue
New-Item -Path $outputFile -ItemType File -Force | Out-Null

# Add a header and tree command output to the result file
Add-Content -Path $outputFile -Value "File structure:"
try {
    # Execute the tree command and capture its output
    $treeOutput = tree $PWD.Path /F /A 2>$null
    Add-Content -Path $outputFile -Value $treeOutput
} catch {
    Add-Content -Path $outputFile -Value "Error generating tree structure."
}
# Add two new lines
Add-Content -Path $outputFile -Value "`n`n"

# Function to recursively read files
function Read-Files {
    param (
        [string]$Directory
    )

    # Get all items in the directory
    Get-ChildItem -Path $Directory -Recurse -File | ForEach-Object {
        $filePath = $_.FullName
        # Write the file path in brackets
        Add-Content -Path $outputFile -Value "File path: [$filePath]"
        try {
            # Read the file content
            $content = Get-Content -Path $filePath -ErrorAction Stop
            # Append the file content
            Add-Content -Path $outputFile -Value $content
        } catch {
            Add-Content -Path $outputFile -Value "Could not read file: $_"
        }
        # Add two new lines
        Add-Content -Path $outputFile -Value "`n`n"
    }
}

# Start reading files from the current directory
Read-Files -Directory $PWD.Path

# Completion message
Write-Output "Result file created: $outputFile"

