---
title: "Introduction à la conteneurisation via Kubernetes"
author: "Popa Ionut"
institute: "SF2i"
topic: "Conteneurisation via Kubernets"
theme: "Copenhagen"
mainfont: "Hack Nerd Font"
fontsize: 10pt
urlcolor: red
linkstyle: bold
aspectratio: 169
date: 2022
lang: fr
section-titles: false
toc: false
---

# Introduction  

\center
![](src/img/kubernetes-logo.png){height=3in, width=3in}   


# Le Besoin   

::: columns

:::: column
Les problématiques ?   

* Uniformisation difficile à mettre en place   
* Éliminer les dépendance de la plateforme   
* Faciliter le cycle de développement ralenti     
::::

:::: column
![](src/img/uniformisation.png){height=3in, width=3in}
::::
:::

# Les conteneurs

::: columns
:::: column
Pourquoi les conteneurs ?   
* Uniformisation (via Dockerfile)   
* Éliminer la dépendance de la plateforme (tous les dépendances applicatives se trouveront dans le conteneur)   
* Faciliter le cycle de développement via les outils DevOps (CI/CD)   
::::

:::: column
![](src/img/docker.png){height=2in, width=2in}   
::::
:::

# C'est quoi un conteneur ?   

![](src/img/conteneur_architecture.png){height=2in, width=2in}     


