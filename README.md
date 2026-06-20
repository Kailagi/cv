# CV as Code — Automatisation DevOps & Ingénierie CSS Print

Ce projet implémente une approche moderne de **CV as Code**, combinant la flexibilité du Markdown pour la rédaction du contenu, la puissance du CSS pour le design orienté impression (Print), et la rigueur de l'automatisation DevOps (Docker, GitHub Actions, Make) pour générer un CV au format PDF de qualité professionnelle.

---

## Identité & Informations
* **Nom :** TAFONO
* **Prénom :** Anaïs
* **Cursus :** B2 en Informatique
* **Livrable :** Dépôt GitHub Public avec Pipeline CI/CD automatisé
* **Artéfact attendu :** PDF généré disponible via les GitHub Actions Artifacts

---

## 🚀 Guide d'Utilisation & Compilation (En-tête)

### Prérequis
* [Docker](https://www.docker.com/) installé et démarré sur votre machine.
* L'utilitaire standard `make` (disponible nativement sur macOS/Linux).

### Commandes à taper pour compiler localement
Pour simplifier l'utilisation sans avoir à retenir les commandes Docker complexes, un fichier `Makefile` orchestre les opérations. Ouvrez votre terminal à la racine du projet et exécutez :

1. **Compiler le CV au format PDF :**
   ```bash
   make build
   ```
   *Cette commande construit l'image Docker contenant toutes les dépendances (Pandoc et WeasyPrint) et lance le conteneur pour compiler le fichier `cv.pdf` à la racine de votre projet.*

2. **Nettoyer les fichiers locaux générés :**
   ```bash
   make clean
   ```
   *Cette commande supprime proprement le fichier `cv.pdf` généré localement pour éviter tout encombrement.*

### Explication technique du processus
La commande `make build` automatise la création d'un environnement isolé et reproductible. Elle construit une image Docker temporaire, y installe Pandoc (pour transformer le Markdown en HTML structuré) et WeasyPrint (pour transformer le HTML en PDF vectoriel pixel-perfect via CSS). Lors de l'exécution, le répertoire courant de votre machine est monté dans le conteneur (`/workspace`), assurant la compilation directe et l'écriture du PDF final à la racine de votre espace de travail.

---

## 📁 Architecture du Projet & Séparation des Préoccupations (SRP)

Le projet respecte scrupuleusement la séparation des responsabilités (**SRP - Single Responsibility Principle**), garantissant une maintenance aisée et une modularité maximale.

```text
.
├── .github/
│   └── workflows/
│       └── compile.yml      # Pipeline CI/CD de génération automatique du PDF
├── assets/
│   ├── icons/               # Icônes vectorielles SVG (DRY & performance)
│   │   ├── code-solid-full.svg
│   │   ├── docker-brands-solid-full.svg
│   │   └── ...
│   ├── RecursiveSans*.ttf   # Polices de caractères typographiques embarquées
│   └── style.css            # Feuille de style dédiée au rendu CSS Print
├── src/
│   ├── cv.md                # Contenu brut du CV (Markdown)
│   └── template.html        # Squelette structurel HTML
├── Dockerfile               # Image de compilation isolée et reproductible
├── Makefile                 # Automatisation des tâches de build locales
├── .gitignore               # Exclusion des fichiers générés temporaires et locaux
└── README.md                # Documentation de compétition (ce fichier)
```

### Principes de Conception Appliqués
* **SRP (Single Responsibility Principle) :** 
  * Le **fond** (le texte, l'expérience) est rédigé uniquement dans [cv.md](file:/cv/src/cv.md).
  * La **forme** (la charte graphique et mise en page) est isolée dans [style.css](file:/cv/assets/style.css).
  * La **structure** HTML est assurée par le template [template.html](file:/cv/src/template.html).
  * L'**infrastructure** et le cycle de vie sont gérés par le `Dockerfile`, le `Makefile` et la GitHub Action.
* **DRY (Don't Repeat Yourself) :**
  * Utilisation de variables CSS (`:root`) pour centraliser la palette chromatique (`--accent-purple`, `--accent-pink`, etc.).
  * Les styles répétitifs de la barre latérale gauche (polices, marges, puces) sont factorisés grâce à des sélecteurs CSS combinés (ex: `.cv-body h2:nth-of-type(2)+ul li`).
* **KISS (Keep It Simple, Stupid) :**
  * Aucun framework JavaScript ni préprocesseur CSS (Sass/Less) n'est employé. Pandoc et WeasyPrint effectuent la compilation de bout en bout sans dépendances superflues.

---

## 🛠️ Arsenal IA
Pour concevoir, optimiser et déboguer ce projet, les outils et LLMs suivants ont été sollicités :
* **Cursor (IDE) :** Environnement d'intégration pour piloter l'agent de codage.
* **Gemini :** Utilisé pour l'audit d'architecture, le débogage CSS Print, la résolution des incompatibilités WeasyPrint, et la rédaction structurée du rapport final.
* **GitHub Copilot :** Assistant d'écriture rapide pour les sélecteurs CSS complexes et l'arborescence du Dockerfile.

---

## 🎯 Ingénierie de Prompt (Architecture & Print)

Pour forcer l'IA à abandonner les réflexes classiques du développement web d'affichage sur écran et concevoir une interface robuste dédiée exclusivement à l'impression via WeasyPrint, j'ai formulé mes directives selon les étapes clés de la conception :

### 1. Initialisation de l'Infrastructure DevOps (Docker, Makefile, .gitignore)
Pour garantir une reproductibilité totale du projet sur n'importe quel ordinateur, le prompt suivant a été conçu :
> **Prompt d'architecture :**
> *« Agis en tant qu'expert DevOps et Ingénieur Logiciel senior. Je dois mettre en place l'infrastructure de build pour un projet de génération de CV "As Code" basé sur Pandoc et WeasyPrint. L'objectif est de garantir une reproductibilité parfaite et de respecter la Séparation des Préoccupations (SRP) ainsi que les principes KISS et DRY.*
> 
> *Génère les composants suivants :*
> *1. Un Dockerfile basé sur 'debian:bookworm-slim' qui installe de manière non-interactive Pandoc, WeasyPrint, les dépendances graphiques nécessaires et un pack de polices de base (comme fonts-liberation). L'environnement doit être configuré pour éviter les conflits d'architecture locale (notamment ARM/Mac M1/M2 vs x86).*
> *2. Un Makefile clair (KISS) définissant une règle `build` qui construit l'image Docker localement, lance le conteneur en montant le volume de travail, et exécute la commande Pandoc pour compiler un fichier source 'src/cv.md' en utilisant un template 'src/template.html' et un fichier de style 'assets/style.css' pour générer un 'cv.pdf'. Inclut une règle `clean` pour supprimer le PDF généré localement.*
> *3. Un fichier .gitignore strict pour s'assurer que les fichiers PDF locaux ne soient jamais poussés sur le dépôt Git, respectant ainsi la contrainte de génération exclusive par CI/CD. »*

### 2. Séparation du Contenu et de la Structure (cv.md & template.html)
Afin d'appliquer le principe de responsabilité unique (SRP) entre le fond sémantique et le squelette structurel :
> **Prompt de contenu :**
> *« Agis en tant qu'expert en ingénierie logicielle. Je souhaite concevoir la partie "Contenu" et "Structure" de mon projet CV As Code en appliquant strictement le principe de Séparation des Préoccupations (SRP).*
> 
> *Génère deux fichiers distincts :*
> *1. Un template HTML minimaliste ('src/template.html') destiné à Pandoc, utilisant des variables dynamiques pour le titre, le CSS et le corps du document, le tout enveloppé dans un conteneur principal sémantique.*
> *2. Un fichier source en Markdown ('src/cv.md') contenant un CV complet et professionnel. Ce fichier doit être purement sémantique, structuré rigoureusement avec des balises de titres (H1, H2, H3) et des listes à puces, sans aucune intrusion de code HTML ou de styles en ligne, afin de garantir que le fond reste totalement indépendant de la forme. »*

### 3. Design Orienté Impression et Factorisation (style.css)
Pour la feuille de style, l'accent a été mis sur le principe DRY et les règles propres au standard CSS Paged Media :
> **Prompt de design :**
> *« Agis en tant que Designer d'Interface et Intégrateur CSS senior. Je souhaite concevoir une feuille de style CSS ('assets/style.css') moderne, épurée et optimisée pour l'impression via WeasyPrint. L'objectif visuel est d'allier professionnalisme et élégance à travers un thème doux et des touches graphiques minimalistes.*
> 
> *Contraintes techniques et méthodologiques strictes :*
> *1. Respect du principe DRY : Utilisation obligatoire de variables CSS en tête de fichier pour centraliser la palette chromatique.*
> *2. Typographie : Configure une pile de polices élégante débutant par la police variable 'Recursive', avec des replis (fallbacks) système robustes ('Georgia', 'Segoe UI') pour parer à toute absence de police sur la machine de compilation.*
> *3. Personnalisation sémantique : Remplace les puces circulaires par défaut des listes (`ul`) par un caractère fin et graphique comme un rond plein discret.*
> *4. Règles de Print (@page) : Configure les marges et dimensions adaptées au format A4 physique et mets en place des contrôles de sauts de page pour éviter les contenus orphelins. »*

### 4. Automatisation du Pipeline CI/CD (.github/workflows/compile.yml)
Pour automatiser la compilation à chaque modification et s'affranchir de toute intervention humaine sur la branche de production :
> **Prompt de configuration CI/CD :**
> *« Crée un fichier de workflow GitHub Actions nommé `.github/workflows/compile.yml` qui écoute les événements de `push` sur la branche principale `main`. Ce script doit utiliser l'environnement d'exécution standard d'Ubuntu, instancier notre image Docker, exécuter la commande de build et téléverser le document final `cv.pdf` en tant qu'artéfact d'action sécurisé sous le nom `CV_Anais_TAFONO` afin qu'il soit directement accessible en téléchargement public. »*

---

## 🐳 Analyse de la Conteneurisation (Dockerfile)

Le [Dockerfile](file:///Users/kailagi/cv/Dockerfile) a été configuré de manière optimale pour réduire le poids de l'image finale et assurer la reproductibilité de la compilation :

```dockerfile
FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    pandoc \
    weasyprint \
    fonts-liberation \
    fontconfig \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace

ENTRYPOINT ["pandoc"]
```

* **Optimisation de la taille de l'image (KISS/DevOps) :** Utilisation de l'image de base ultra-légère `debian:bookworm-slim`.
* **Précautions de build :** L'option `--no-install-recommends` empêche l'installation de dépendances système superflues. Le nettoyage immédiat du cache apt (`rm -rf /var/lib/apt/lists/*`) garantit une image minimale.
* **Configuration d'exécution :** L'utilisation de `pandoc` en `ENTRYPOINT` permet de traiter le conteneur comme une simple commande CLI, facilitant son intégration dans le Makefile et le pipeline de CI/CD.

---

## 🔄 Pipeline CI/CD (GitHub Actions)

La génération du CV est entièrement automatisée grâce à un pipeline de livraison continue (CI/CD) défini dans [.github/workflows/compile.yml](file:///Users/kailagi/cv/.github/workflows/compile.yml).

### Déclenchement
Le pipeline s'exécute automatiquement à chaque action de `push` sur la branche principale `main`.

### Description des étapes (Steps)
1. **Checkout Repository :** Récupération sécurisée du code source sur le runner GitHub Actions.
2. **Build PDF via Docker Container :**
   * Build de l'image Docker locale `cv-builder`.
   * Lancement du conteneur en montant le répertoire de travail dans `/workspace` pour générer le fichier `cv.pdf` de manière isolée.
3. **Upload PDF Artifact :** Téléversement du document PDF produit sous le nom d'artefact `CV_Anais_TAFONO`, disponible directement en téléchargement sur l'interface GitHub.

> [!IMPORTANT]
> **Résolution DevOps Critique :** 
> Le dossier d'automatisation initial était nommé `.github/workflow` (au singulier). Les spécifications de GitHub Actions imposent le dossier `.github/workflows` (au pluriel). Sans cette correction cruciale apportée lors de notre audit, le pipeline CI/CD était totalement ignoré par GitHub. Le dossier a été renommé en `.github/workflows/` et le fonctionnement est désormais 100 % opérationnel.

---

## 🔍 Analyse Critique & Débogage (Échecs de l'IA & Spécificités CSS Print)

Piloter l'IA en approche *Vibe Coding* exige une analyse critique poussée des retours des compilateurs et des moteurs de rendu. Face aux limitations inhérentes de WeasyPrint par rapport aux navigateurs web traditionnels, plusieurs ajustements fondamentaux ont été nécessaires :

### 1. Hallucination sur le masquage web (`mask-image` / `-webkit-mask`)
* **Le problème :** L'IA a initialement tenté d'intégrer et de colorer dynamiquement des fichiers SVG locaux pour la barre latérale en utilisant des propriétés de masque web modernes (`mask: url(...)`, `-webkit-mask`). Lors du build, WeasyPrint a levé des alertes critiques (`WARNING: Ignored mask, unknown property`) et a rendu de simples carrés de couleur opaques et noirs.
* **La résolution :** Le moteur de rendu de WeasyPrint appliquant strictement les spécifications CSS Paged Media, il fait abstraction des masques web. Nous avons contourné cette anomalie en intégrant les icônes vectorielles pré-colorées avec leur code hexadécimal figé de façon statique directement dans le dossier `assets/icons/` et en les important via la propriété standard `background-image` :
  ```css
  background-image: url('icons/code-solid-full.svg');
  background-size: contain;
  background-repeat: no-repeat;
  ```
  Cette approche garantit un affichage vectoriel parfait et ultra-léger sans surcharger le moteur d'affichage.

### 2. Incompatibilité de la propriété d'ombrage (`box-shadow`)
* **Le problème :** Lors des compilations de test, le terminal affichait :
  `WARNING: Ignored box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05) at 44:5, unknown property.`
* **La résolution :** L'ombrage de boîte n'a aucun sens sémantique ou graphique sur un support physique imprimé. Pour conserver le contour élégant du design écran (style macOS) tout en supprimant l'alerte du compilateur, la propriété a été remplacée par une bordure unitaire fine (`border: 1px solid #E5E5E5;`).

### 3. Rejet des variables CSS dynamiques dans les raccourcis (`border`)
* **Le problème :** Le compilateur a retourné une alerte de valeur invalide :
  `WARNING: Ignored border: 2px solid var(--accent-purple) at 122:5, invalid value.`
  Le parseur de WeasyPrint n'interprète pas correctement l'imbrication d'une fonction `var()` au sein d'une déclaration de propriété raccourcie complexe.
* **La résolution :** Application stricte du principe KISS en éclatant la règle en trois instructions élémentaires simples et explicites :
  ```css
  border-width: 2px;
  border-style: solid;
  border-color: var(--accent-purple);
  ```

### 4. Gestion rigoureuse des hauteurs absolues en millimètres (A4 Page Break)
* **Le problème :** Lors de la conception d'un CV sur une seule page (Single-Page CV), si le contenu ou les dimensions des conteneurs dépassent ne serait-ce que d'un pixel la hauteur physique de la page A4 (`297mm`), WeasyPrint génère automatiquement une deuxième page vierge ou tronquée, ce qui est éliminatoire lors d'un rendu académique.
* **La résolution :** Application d'une grille de hauteurs absolues rigoureuse en millimètres :
  * Dimensions physiques A4 de la page : `210mm` x `297mm`.
  * Nous avons défini les marges de la page `@page` à `0`.
  * Le `body` possède un `padding` uniforme de `10mm` de chaque côté (soit `20mm` de perte sur la hauteur).
  * Le conteneur principal du CV `.cv-window` est dimensionné pour occuper précisément l'espace restant sans dépasser :
    * Largeur : `210mm - 20mm = 190mm`
    * Hauteur : `297mm - 20mm = 277mm`
  * De plus, le conteneur utilise `box-sizing: border-box` pour s'assurer que ses paddings internes n'augmentent pas ses dimensions physiques externes.
  * Grâce à cette gestion mathématique des contraintes de hauteur absolue, le PDF généré fait **exactement une seule page**, sans aucun débordement.

### 5. Sauts de page orphelins & marges rognées
* **Le problème :** L'utilisation de hauteurs relatives (`vh`, `%`) ou de marges automatiques pour positionner des blocs a entraîné, lors du premier rendu, des textes coupés en bas de page et des marges intérieures asymétriques selon le lecteur PDF utilisé.
* **La résolution :** Remplacement systématique de toutes les hauteurs relatives par des valeurs absolues fixes en millimètres (`mm`). Ajout de la règle de saut de page `page-break-inside: avoid` sur les éléments importants et structurants afin d'interdire au compilateur de découper une section d'expérience professionnelle au milieu de sa description.

### 6. Conflit de versions Pandoc (Moteur de Template)
* **Le problème :** Selon que Pandoc soit installé en version 2.x ou 3.x sur la machine hôte, les paramètres d'inclusion de feuilles de style et la gestion des variables de templates HTML diffèrent (les variables de template comme `$body$` ou `$title$` ne sont pas interprétées de la même manière).
* **La résolution :** L'usage de Docker fige définitivement la version de Pandoc à celle installée dans l'image Debian stable, garantissant le même comportement de compilation en local (sous macOS ARM) et sur le runner d'intégration continue de GitHub Actions (Ubuntu x86).
