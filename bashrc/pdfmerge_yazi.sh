#!/bin/bash

function pathpicker() {
	local tmp="$(mktemp -t "yazi-file.XXXXXX")" cpath
	yazi "$@" --chooser-file="$tmp"
	if cpath="$(command cat -- "$tmp")" && [ -n "$cpath" ] ; then
		echo "$cpath"
  else
    # if cpath is blank, i.e. none is selected
    # this happens when the program is exited
    echo "None"
	fi
	rm -f -- "$tmp"
}

selected_pdfs=()
while true; do

  selected_pdf=$(pathpicker)

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
