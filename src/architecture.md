---
title: | 
  ![](./src/img/sf2i.png ){width=3in}

  Formation Kubernetes

author: Popa Ionut
date: 07/03/2022
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
---
\newpage

# Architecture Kubernetes

Ce document fourni des informations sur les différentes composantes d'infrastructure qu'on peut 
retrouver dans un cluster Kubernetes. Le document n'a pas l'ambition d'être un guide exhaustif de tous
les briques d'un cluster mais seulement un document facilitant la compréhension du rôle de chaque 
composante dans un cluster.  

Au cours de ce documents nous allons resumer les notions suivantes :   
- Description d'un cluster Kubernetes  
- Les différents types de Noeuds  
- Les composantes applicatives d'un cluster.  
- Les objets Kubernetes  

Chaque notion abordée sera accompagne des exemples et commandes *kubectl*. 


# Description d'un cluster Kubernetes  
Un cluster Kubernetes est un ensemble de machines virtuelles ou physiques (servers) permettant d'exécuter des applications conteneurisées.  
Si vous exécutez Kubernetes, vous exécutez un cluster. Au minimum, un cluster contient un Noeud (server) de type `control-plane` (connu également sous le nom de Master) et une ou plusieurs machines `worker`.  

![Les neouds d'un cluster Kubernetes](./src/img/cluster_nodes_types.png ){width=3in}

Le Control-Plane est responsable du maintien de l'état souhaité du cluster, par exemple les applications en cours d'exécution et les images de conteneur qu'elles utilisent.  
Les nœuds Worker exécutent les applications et les charges applicatives (scripts, cronjobs etc..).  

Le cluster est au cœur de l'avantage clé de Kubernetes : la possibilité de planifier et d'exécuter des conteneurs sur un groupe de machines, qu'elles soient physiques ou virtuelles, sur site ou dans le cloud.  
Les conteneurs Kubernetes ne sont pas liés à des machines individuelles. Au contraire, ils sont abstraits à travers le cluster.

```sh
            # Obtenir l'ensemble de Noeuds dans mon cluster.
            $ kubectl get nodes -o wide
```

\newpage

## Configuration du cluster 
Un cluster Kubernetes a un état souhaité, qui définit quelles applications (scripts, jobs, services etc..) doivent être exécutées, ainsi que les images de conteneur
qu'elles doivent utilisent, les ressources qui doivent être mises à leur disposition et d'autres détails de configuration.

Un état souhaité est défini par des fichiers de configuration, qui sont des fichiers en format JSON ou YAML déclarant le type d'application à exécuter et le nombre de 
répliques nécessaires pour faire fonctionner un stack applicatif.


![Fichier de configuration type en format YAML](./src/img/fichier_configuration_kubernetes.png ){width=3in}

L'état souhaité du cluster est communique via les fichiers de configuration à l'API Kubernetes.  
La configuration peut être envoyée via la ligne de commande (en utilisant kubectl) ou en utilisant l'API (via des applications web, Kubernetes Dashboard) pour interagir
avec le cluster afin de définir ou et comment modifier l'état souhaité.

Kubernetes gérera automatiquement votre cluster en fonction de l'état souhaité.
À titre d'exemple, supposons que vous déployez une application avec un état souhaité de 3 replicas, ce qui signifie que 3 répliques de l'application doivent
être en cours d'exécution.  
Si l'un de ces répliques tombe en panne, Kubernetes constatera que seules deux répliques sont en cours d'exécution et en ajoutera une autre pour satisfaire l'état souhaité.

# Les composantes applicatives de Nœuds Master  



# Les objets Kubernetes  

