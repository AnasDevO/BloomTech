#!/bin/bash

# Check if directory is provided as argument
if [ $# -ne 1 ]; then
    echo "Usage: $0 <directory_path>"
    echo "Please provide a directory path where the .mcmeta files are located"
    exit 1
fi

DIRECTORY="$1"

# Check if directory exists
if [ ! -d "$DIRECTORY" ]; then
    echo "Error: Directory '$DIRECTORY' does not exist"
    exit 1
fi

# JSON content to replace with
json_content='{
  "animation": {
    "frametime": 5
  },
  "ctm": {
    "ctm_version": 1,
    "layer": "BLOOM",
    "extra": {
      "light": 4
    }
  }
}'

# Counter for modified files
count=0

# Find all .mcmeta files and replace their contents
find "$DIRECTORY" -type f -name "*.mcmeta" | while read -r file; do
    echo "Updating $file"
    echo "$json_content" > "$file"
    ((count++))
done

echo "Done! Modified $count .mcmeta files in $DIRECTORY"
