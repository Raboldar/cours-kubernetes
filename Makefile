#  Répertoire contenant l'ensemble des documents MD.
source := src

#  Répertoire contenant l'ensemble des documents en format PDF.
output := print

# Tous les fichiers type .md sont considères comme sources.
# sources := $(wildcard $(source)/*/*.md)
sources := $(shell find ./src -maxdepth 10 -type f  | grep -E "*.md")

# Convertir tous les fichiers source du dossier src et les mettre dans le 
# dossier print.
objects := $(patsubst %.md,%.pdf,$(subst $(source),$(output),$(sources)))

# Générer tous les dossiers nécessaires pour l'arborescence print.
directories := $(dir $(objects))

%.swp:
	: ignore $@

# Instructions
all: $(objects) $(directories)

dirs:
	mkdir -p $(directories)
	
# Commande a executer pour convertir les fichiers.
$(output)/%.pdf: $(source)/%.md dirs
	pandoc \
		--variable fontsize=12pt \
		--variable geometry:"top=2.5cm, bottom=2.5cm, left=2.5cm, right=2.5cm" \
		--variable geometry:a4paper \
		--number-sections \
		--listings \
		-f markdown+smart  $< \
		--pdf-engine=xelatex \
		-o $@

.PHONY : clean

clean:
	rm -rf $(output)/*
