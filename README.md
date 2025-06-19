# symfony-mariadb-apache2-devcontainer
Mon devcontainer pour démarrer un nouveau projet Symfony en utilisant l'IDE VScode.

## Contenu du conteneur

La configuration proposée est faite pour coller à mes besoins, tout en restant suffisamment générique pour convenir au plus grand nombre.
Elle comprend:

- l'installation de PHP, Symfony accompagné de Composer,
- l'ajout de NodeJS et NPM,
- un serveur web Apache2,
- une base de données MariaDB

## Démarrer

1. forkez le projet, puis clonez-le dans un répertoire de votre choix:

`git clone https://github.com/<votre-espace-github>/symfony-mariadb-apache2-devcontainer`

2. construisez le conteneur
   
### Méthode facile: VScode

   - Lancez votre IDE VScode, et installez, si ce n'est pas déjà fait, l'extension *ms-vscode-remote.remote-containers*

   - Ouvrez le projet dans l'éditeur *Fichier > Ouvrir le dossier*
  
   - VScode détecte automatiquement la présence d'un ***devcontainer.json*** et vous proposera de le lancer.
  
### Méthode alternative: [Devpod](https://devpod.sh/docs/getting-started/install)

Pour ma part, j'utilise la distribution [Bluefin](https://projectbluefin.io/), qui est une version customisée de Fedora. Devpod est installé de base après avoir activé le mode développeur.

Tout ce que j'ai à faire est de lancer Devpod, puis créer un *workspace*.

Les étapes sont alors:

- de sélectionner "Folder", et choisir le chemin vers le répertoire *symfony-mariadb-apache2-devcontainer* cloné précédemment ***OU*** sélectionner github et renseigner l'URL du répository *https://github.com/<votre-espace-github>/symfony-mariadb-apache2-devcontainer* 
  
- choisir son "Provider": vous pouvez laisser ***Docker***, qui fonctionne parfaitement,

- définir le nom de votre *workspace* (en minuscules, en séparant éventuellement les termes par des tirets),

- indiquer le chemin (relatif) vers le devcontainer. Ici: ***.devcontainer/devcontainer.json***
  
- lancer la création du *workspace*.

#### Quelle plus-value à utiliser cette méthode?

C'est davantage une question de goût. Vous pouvez lancez votre environnement depuis VScode ou, si vous avez plusieurs *devcontainer*, vous pouvez avec Devpod sélectionner celui de votre choix et le lancer...







