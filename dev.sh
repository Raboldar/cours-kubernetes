#!/bin/sh

# Utiliser entr pour rebuilder les fichiers après un changement.
find src/ -name "*.md" | entr -s 'make'

