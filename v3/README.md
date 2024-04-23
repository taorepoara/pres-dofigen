# v3 - Ajout d'un builder pour optimiser la taille de l'image

Séparation du build et de l'exécution, et utilisation d'images alpine pour optimiser la taille de l'image.

Le build est rapide: 13s
Le temps de rebuild: équivalent
L'image plus légère: 185M.
Utilisateur: 1000

Problèmes:
- A chaque fois qu'on build, on télécharge les dépendances

Du mieux:
- Taille de l'image divisée par 3,5
- Plus de JDK dans l'image finale