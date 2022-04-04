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
Unité utilisée pour le contrôle de multiple répliquas d'une application.  

### Rôle
Le ReplicaSet est un objet Kubernetes permettant de cibler plusieurs Pods/Replicas d'une application pour faciliter 
le management de celle-ci.   
Lors de la création d'un ReplicaSet nous devons définir le template (matrice) qui sera utilisée
pour la création des futurs Pods et le selector qui défini les champs à utiliser pour cibler les Pods.  
Dans le cas ou des Pods possèdent tous les paramètres mentionnés dans le selecteur du ReplicaSet ceux-ci seront assimilées dans le 
ReplicaSet lors de la création. Le ReplicaSet cherchera toujours à attendre l'état désiré (nombre de répliquas) défini par l'administrateur.

**Attention :** Dans le cas où on a plus de Pods que ce qui est défini dans le paramètre "replicas" du ReplicaSet, les pods
supplémentaires seront supprimés pour attendre l'état souhaité. 

Pour enlever le pod d'un ReplicaSet Vous pouvez modifier ses labels pour qu'il match plus avec les selecteurs du ReplicaSet. 

### Commandes
```sh
# Pour changer le nombre de replicas :
# Editer le fichier source de l'objet .yml 
# Changez le nombre de replicas dans le fichier en question
# Executez la commande suivante : 
$ kubectl replace -f replicaset-app.yaml

# Vous pouvez également scaler l'application de maniére imperative
$kubectl scale - -replicas=5 -f replicaset-app.yaml   ## Monter à 5
$kubectl scale - -replicas=1 -f replicaset-app.yaml  ## Descendre à 5

# Obtenir les labels d'un ReplicaSet :
$ kubectl describe replicaset/replicaset-app

```

### Configuration
```yaml
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  # Nom du ReplicaSet
  name: frontend
  # Labels utilisés pour identifier le RS.
  labels:
    app: guestbook
    tier: frontend
spec:
  # Nombre de replicas cible.
  replicas: 3
  # Idéntifiants utilisés pour 
  # cibler les Pods par le RS.
  selector:
    matchLabels:
      tier: frontend
  # Template utilisé pour la creation
  # des nouveaux Pods.
  template:
    metadata:
      labels:
        tier: frontend
    spec:
      containers:
      - name: php-redis
        image: gcr.io/google_samples/gb-frontend:v3
```

\newpage

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
