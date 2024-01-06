#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check for shc and install if not present
if ! command_exists "shc"; then
    echo "shc not found. Installing shc..."
    sudo apt-get update
    sudo apt-get install shc
fi

# Check for gcc (C compiler) and install if not present
if ! command_exists "gcc"; then
    echo "gcc not found. Installing gcc..."
    sudo apt-get update
    sudo apt-get install build-essential
fi

# Path to the folder containing files to be encrypted
folder_path="/path/to/your/folder"

# Directory to store encrypted files
encrypted_folder="$folder_path/encrypted"

# Create the encrypted folder if it doesn't exist
mkdir -p "$encrypted_folder"

# Loop through each file in the folder
for file in "$folder_path"/*; do
    # Check if the file is a regular file
    if [ -f "$file" ]; then
        # Encrypt the file using shc and store it in the encrypted folder
        shc -f "$file"
        mv "${file}.x" "$encrypted_folder"
    fi
done

echo "Encryption completed. Encrypted files stored in $encrypted_folder"