# v2 - Tranformation pour Dofigen

Le build est rapide: 13s
Le temps de rebuild: équivalent
L'image est lourde: 521M.
Utilisateur: 1000

Problèmes:
- Image lourde
- Contient le JDK ce qui amène des failles de sécurité
- A chaque fois qu'on build, on télécharge les dépendances

Du mieux:
- Utilisateur non-root
- On gagne 20M sur l'image