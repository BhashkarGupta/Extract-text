#!/bin/bash

# Create or clear the result.txt file
output_file="result.txt"
> "$output_file"

# Add a header and tree command output to the result file
echo "File structure:" >> "$output_file"
tree "$(pwd)" >> "$output_file" 2>/dev/null
echo -e "\n\n" >> "$output_file"  # Add two new lines

# Function to recursively read files
read_files() {
    local dir="$1"

    # Loop through each item in the directory
    for item in "$dir"/*; do
        # Check if the item exists to avoid errors
        if [[ -e $item ]]; then
            if [[ -d $item ]]; then
                # If it's a directory, recursively call the function
                read_files "$item"
            elif [[ -f $item ]]; then
                # If it's a file, write its path and content to the output file
                echo "File path: [$item]" >> "$output_file"  # Write the file path in brackets
                cat "$item" >> "$output_file"  # Append file content
                echo -e "\n\n" >> "$output_file"  # Add two new lines
            fi
        fi
    done
}

# Start reading files from the current directory
read_files "$(pwd)"

echo "Result file created: $output_file"
