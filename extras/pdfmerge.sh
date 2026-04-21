#!/bin/bash

# List all PDFs in the current directory
pdf_files=(*.pdf)

# Check if there are PDF files in the directory
if [ ${#pdf_files[@]} -eq 0 ]; then
  echo "No PDF files found in the directory."
  exit 1
fi

options=("None" "${pdf_files[@]}")
selected_pdfs=()
while true; do
  # gum time :D
  selected_pdf=$(gum choose "${options[@]}" --header "Select PDFs or choose 'None' to finish")

  # exit if None is selected
  if [ "$selected_pdf" == "None" ]; then
    break
  fi

  selected_pdfs+=("$selected_pdf")
done

# Check if user selected any PDFs
if [ -z "$selected_pdfs" ]; then
  echo "No PDFs selected. Exiting."
  exit 1
fi

# Merge the PDFs using pdftk
output_pdf=$(gum input --placeholder "PDF name (with .pdf)")

pdftk "${selected_pdfs[@]}" cat output "$output_pdf"

echo "PDFs merged successfully into $output_pdf"
