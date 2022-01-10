# Image a partir de la quelle on construit notre container.
FROM ubuntu:16.04

# Personne responsable du maintien de l'image.
MAINTAINER "ipopa@sf2i.nc"

# Etiquette pour identifier plus facilement les images
LABEL environment="dev"
LABEL stack="flask"
LABEL app_name="Hello World Flask"

# Installer Python dans le container.
RUN apt-get update -y && \
    apt-get install -y python-pip python-dev

# Copyer les fichiers applicatifs locaux dans le conteneur ( chemin localhost -> chemin container ) 
COPY ./src /app

# Definir le directory principal dans le quel nous allons executer les commandes a suivre.
WORKDIR /app

# Installer les packages necessaires pour executer l'application.
RUN pip install -r requirements.txt

ENTRYPOINT [ "python" ]

CMD [ "flask flask_app.py" ]
