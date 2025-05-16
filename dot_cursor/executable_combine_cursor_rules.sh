#!/bin/bash

# Script to combine Cursor rules into a single plain text file
OUTPUT_FILE="combined_cursor_rules.txt"

# Create the file with a header
echo "# Combined Cursor Rules - Plain Text Version" > $OUTPUT_FILE
echo "" >> $OUTPUT_FILE

# Find and process all rule files
find ~/.cursor/rules -type f -name "*.mdc" | while read -r file; do
  # Get just the filename without path or extension
  filename=$(basename "$file" .mdc)

  # Replace hyphens with spaces and capitalize for title
  title=$(echo "$filename" | sed 's/-/ /g' | awk '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) substr($i,2)} 1')

  # Add section header with formatted title
  echo -e "\n## $title\n" >> $OUTPUT_FILE

  # Extract content between YAML markers, strip markdown
  sed -n '/^---$/,/^---$/!p' "$file" | \
    sed 's/^#\+ //g' | \
    sed 's/\*\*\([^*]*\)\*\*/\1/g' | \
    sed 's/\*\([^*]*\)\*/\1/g' | \
    sed "s|\`\([^\`]*\)\`|\1|g" | \
    sed 's/^\s*[0-9]\+\.\s*/  * /g' | \
    sed 's/^\s*-\s*/  * /g' >> $OUTPUT_FILE
done

echo "Rules combined into $OUTPUT_FILE"
