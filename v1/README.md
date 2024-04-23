# v1 - Le Dockerfile de base

Le build est rapide: 13s
Le temps de rebuild: équivalent
L'image est lourde: 541M.
Utilisateur: root

Problèmes:
- Image lourde
- Contient le JDK ce qui amène des failles de sécurité
- A chaque fois qu'on build, on télécharge les dépendances

Du mieux:
- Amélioration du temps de démarrage