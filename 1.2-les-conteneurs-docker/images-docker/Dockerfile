# Image a partir de la quelle on construit notre container.
FROM ubuntu:latest

# Personne responsable du maintien de l'image.
MAINTAINER "ipopa@sf2i.nc"

# Etiquette pour identifier plus facilement les images
LABEL environment="dev"
LABEL stack="flask"
LABEL app_name="Hello World Flask"

# Installer Python dans le container.
RUN apt-get update -y && \
    apt-get install -y python3-pip python3-dev

# Changement
RUN echo "Hello"

# Copyer les fichiers applicatifs locaux dans le conteneur ( chemin localhost -> chemin container ) 
COPY ./src /app

# Definir le directory principal dans le quel nous allons executer les commandes a suivre.
WORKDIR /app

# Installer les packages necessaires pour executer l'application.
RUN pip3 install -r requirements.txt

# Exposer le port 8080 pour l'access depuis l'exterieur.
EXPOSE 8080

# Commande qui sera executee par defaut.
ENTRYPOINT [ "python3" ]

# Arguments par defauts passes au entrypoint.
CMD [ "app.py" ]
