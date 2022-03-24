---
title: | 
  ![](./src/img/sf2i.png ){width=3in}

  Formation Kubernetes

  Les objets

author: Popa Ionut
date: 22/03/2022
classoption: table
documentclass: extarticle
urlcolor: blue
fontsize: 12pt
lang: fr
header-includes: |
    \rowcolors{2}{gray!10}{gray!25}
    \usepackage{graphicx}
    \usepackage{fancyhdr}
    \usepackage{listings}
    \pagestyle{fancy}
    \fancyfoot[CO,CE]{Kubernetes - SF2i}
    \fancyfoot[LE,RO]{\thepage}

output: pdf_document

mainfont: inconsolata.ttf
sansfont: DejaVuSans.ttf
monofont: DejaVuSansMono.ttf 
mathfont: texgyredejavu-math.otf 
---
\newpage

\tableofcontents

\newpage

# Déploiement des applications
Dans cette partie nous allons aborder les différentes objets qu'on peut utiliser pour déployer des applications
dans notre cluster Kubernetes.  
Parmis ces objets certains ont des avantages par rapport aux autres.  
Le but de cette partie c'est d'identifier dans quel contexte il faut utiliser quel objet.

## CRE
Le CRE ou (Container Runtime Engine) représente le moteur de conteneurisation qui a était choisi pour le management des conteneurs
sur les Noeuds de notre cluster.  

Pour qu'un moteur de conteneurisation soit utilise par Kubernetes, celui-ci doit exposer des interfaces qui permettent le management des conteneurs.  
Kubernetes défini un standard d'interfaces qui doivent être exposées par le CRE pour que les deux puissent communiquer.   
Ce standard est défini via le CRI (Container Runtime Interface).  
Tant qu'un moteur de conteneurisation est compatible avec le CRI Kubernetes, celui-ci pourra l'utiliser dans les cluster crée 
pour manager les conteneurs.

### Rôle
Le CRE est responsable du management des conteneurs sur les Nœuds qui font partie d'un cluster Kubernetes.

Pour la suite nous allons utiliser l'exemple de Docker, un des premier CRE utilisées dans les cluster Kubernetes.

### Commandes
Les commandes suivantes pourront être utilisées seulement sur les Nœuds qui dont partie du cluster pour interagir avec les conteneurs.
Seulement les commandes les plus importantes seront mentionnes.
Pour une liste complete avec les commandes : [liste de commandes Docker](https://phoenixnap.com/kb/list-of-docker-commands-cheat-sheet)


```{bash}
# Construire une image Docker a partir d'un Dockerfile.
$ docker build . -f Dockerfile

# Executer un conteneur à partir d'une image.
# Les parametres -it vont connecter le terminal de l'utilisateur
# à celui du conteneur. 
$ docker run -it --name mon_conteneur busybox:latest

# Inspecter les options d'un conteneur.
$ docker inspect mon_conteneur

# Afficher tous les conteneurs sur la machien courante
$ docker ps -a 

# Afficher tous les conteneurs en cours
# d'execution sur la machien courante
$ docker ps 

# Enlever tous les images Docker qui ne sont pas utilisées
# sur le Noeud
docker image prune
```

### Configuration
La configuration du Daemon Docker se fait a partir du fichier ``/etc/docker/daemon.json``  
Ce fichier de configuration vous permet de changer les paramètres du CRE (adresses IP à distribuer aux conteneurs, logs etc..)   

N'oubliez pas que chaque CRE à son fichier de configuration particulier.   

## Pods
Les pods représentent l'unité atomique de déploiement dans les clusters Kubernetes.  
Le pod peut contenir un ou plusieurs conteneurs.

### Rôle
Le Pod doit représenter un réplique de notre application. Les applications peuvent avoir plusieurs services qui sont packages dans celle-ci (service d'authentification, 
service pour la communication avec la base de données etc..).
Les différents services d'une même application pourront être mises ensemble dans un seul Pod pour faciliter la communication.

![Les Pods Kubernetes](./src/img/pods.png ){width=3in}

Dans le cas ou deux conteneurs se trouver dans le même Pod ceux-ci partagent le même espace réseau et peuvent interagir au niveau des processus.   
Conteneur A peut communiquer avec le conteneur B qui expose un service sur le port 80 en tapant sur localhost:80 .

Le seul moment ou deux service doivent être mit dans le même Pod c'est quand ils doivent partager des ressources locales (appeler des processus Linux ou
interagir avec le système de fichiers). 

### Commandes

```{bash}
# Recuperer l'ensemble de Pods dans le namespace courant.
$ kubectl get pods 

# Recuperer l'ensemble de Pods dans tous le cluster.
$ kubectl get pods --all-namespaces

# Decrire les options d'un Pod
$ kubectl inspect pod/mon_pod

# Obtenir le fichier de deployment d'un Pod sous format YAML
$ kubectl get pod/mon_pod -o yaml 
```

### Configuration
Nous allons expliquer les paramètres le plus importants d'un fichier de deployment type Pod.
```yaml
apiVersion: v1 # Version de l'API ou les Pods sont definis.
kind: Pod # Type d'objet qui est defini dans le fichier.
metadata:
  name: nginx # Nom du Pod
spec:
  containers:
  - name: nginx # Nom du conteneur.
    image: nginx:1.14.2 # Image utilisee par le conteneur.
    ports:
    - containerPort: 80 # Ports exposes par le conteneur au sein du Pod.
```

## ReplicaSets

### Rôle
### Commandes
### Configuration

## Déploiements

### Rôle
### Commandes
### Configuration

# La configuration d'applications déployées

### Rôle
### Commandes
### Configuration

# L'exécution des taches via Jobs et CronJobs

### Rôle
### Commandes
### Configuration

# Interconnexion des applications

### Rôle
### Commandes
### Configuration

# Stockage 

### Rôle
### Commandes
### Configuration
