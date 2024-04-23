# v4 - Gestion du cache

Ajout du dockerignore pour ne charger que ce qui est nécessaire pour le build.
Cache des dépendances Maven pour ne pas les recharger à chaque build.
Cache du dossier target pour ne pas le recompiler ce qui n'est pas nécessaire (oblige à déplacer le jar et a définir le workspace, car le cache et une valeur absolue).


Le build est rapide: 13s
Le temps de rebuild: 6s
L'image plus légère: 185M.
Utilisateur: 1000

Du mieux:
- On ne télécharge les dépandances Maven qu'une fois
- Le temps de buidl est divisé par deux