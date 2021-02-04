#!/bin/bash
echo "==> Downloading Docuemnation..."
xargs -n 1 curl -O < LISTS.txt
echo "==> Converting from markdown into asciidoc..."
find ./ -name "*.md" -type f -exec sh -c \ 'kramdoc --format=GFM --wrap=ventilate --output={}.adoc {}' \;
for f in ./*; do mv "$f" "${f%.*.adoc}.adoc" ; done
sleep 1
echo "Compile Complete"

