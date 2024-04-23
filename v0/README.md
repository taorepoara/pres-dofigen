# v0 - Le Dockerfile à ne pas faire

Le build ultra rapide: 2s
Le temps de rebuild: équivalent
L'image est lourde: 427M.
Utilisateur: root

Problèmes:
- Téléchargement des dépendances au démarrage
- Image lourde
- Contient le JDK ce qui amène des failles de sécurité