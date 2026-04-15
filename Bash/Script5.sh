#!/bin/bash

DIR=$1

images=0
pdf=0
text=0

for file in "$DIR"/*; do

    # Skip if it is a directory
    if [ -d "$file" ]; then
        continue
    fi

    # Get filename and extension
    filename=$(basename "$file")
    extension="${filename##*.}"

    # Convert extension to lowercase
    extension=$(echo "$extension" | tr 'A-Z' 'a-z')

    # Decide category based on extension
    case "$extension" in
        jpg|jpeg|png|gif)
            mv "$file" "$DIR/Images/"
            ((images++))
            ;;
        pdf|doc|docx)
            mv "$file" "$DIR/Pdf/"
            ((pdf++))
            ;;
        txt)
            mv "$file" "$DIR/Text/"
            ((text++))
            ;;
        *)
            ;;
    esac

done

echo "Images moved: $images"
echo "PDFs moved: $pdf"
echo "Text files moved: $text"
