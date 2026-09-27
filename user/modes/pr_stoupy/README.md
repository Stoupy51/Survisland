# Laboratoire du professeur Stoupy

Cinq trials indépendants, chacun rapporte une étoile bleue. Les cinq étoiles sont à ramener au villageois Maarcouscous.

Toutes les fonctions sont sous `survisland:modes/pr_stoupy/`.
Les fonctions `here/` et `start` agissent sur la salle la plus proche du point d'exécution.
Les fonctions sans `here/` (`stop`) agissent sur toutes les copies à la fois, elles servent au dépannage.

## Plusieurs copies

Chaque copie d'une salle est une arène indépendante, tout est relatif à ses marqueurs.
Pour une deuxième copie, refaire exactement le même setup à plus de 48 blocs de la première.

## Villageois

- `execute rotated <yaw> 0 run function survisland:modes/pr_stoupy/villager/here/place` pose le villageois, orienté.
- Test : clic droit dessus sans étoile, puis avec 5 étoiles (`loot give @s loot survisland:i/blue_star` cinq fois).

## 1. Duos (4 joueurs)

- **Départ** : command block répétitif `duo/start`. Il prend les 4 joueurs à moins de 3 blocs et forme 2 paires par distance.
- **Arrivée** : command block répétitif `duo/here/stop` là où le mannequin doit arriver. Il rend leur corps aux joueurs de la paire.
- **Récompense** : la porte du puzzle redstone déclenche un command block impulsion `duo/here/reward`. L'étoile va au joueur le plus proche.

## 2. Miroirs (2 joueurs)

- **Départ** : command block répétitif posé sur le plan du miroir, `mirror/start {axis:"x"}`.
	`axis:"x"` inverse la coordonnée X (miroir perpendiculaire à X), `"z"` pour l'autre sens.
- Les joueurs reçoivent l'item "Figer le reflet" : clic droit pour figer ou libérer leur mannequin.
- **Sortie** : impulsion `mirror/here/reward`.
- **Dépannage** : bouton `mirror/here/reset`, qui renvoie les reflets en face de leurs joueurs. `mirror/here/stop` termine la session.
- Construction : le mannequin subit murs, escaliers et plaques de pression. Le puzzle repose sur le décalage accumulé pendant qu'il est figé.

## 3. Casse-briques (4 joueurs)

- **Mur** : vertical. La rangée du bas reste vide (ligne des bumpers).
	Au-dessus, les briques en concrete, laine, terracotta ou verre teinté, dans les couleurs des joueurs.
- **Joueurs** : chacun sur un bloc de sa couleur, face au mur, enfermé dans une case 1x1.
	Le datapack ne les bloque pas, et les touches gauche/droite qui dirigent le bumper déplaceraient aussi le joueur.
- **Setup** (une fois) : `execute positioned <coin bas gauche> run function survisland:modes/pr_stoupy/breakout/here/setup {width:24,height:16,axis:"x",invert:0}`.
	Le coin est la première case de la rangée des bumpers, le terrain s'étend vers +axis et vers le haut.
	Relancer avec `invert:1` si gauche et droite sont inversées pour les joueurs.
- **Départ** : command block répétitif `breakout/start` à 8 blocs ou moins des joueurs.
- **Niveaux** : un niveau est fini quand il ne reste aucune brique des couleurs jouées.
	Cloner le niveau suivant dans le mur (structure block ou `/clone`), puis lancer `breakout/here/next_level`.
	Le 3e niveau terminé donne l'étoile.
- `breakout/here/stop` arrête la partie.

## 4. Orbite (2 à 4 joueurs)

À placer dans cet ordre :

1. `orbit/here/place_black_hole {scale:100}` au centre du trou noir.
2. `orbit/here/set_hole` au même endroit : c'est l'ancre de la salle.
	Un joueur à moins de 3 blocs est avalé, l'attraction est plus forte sous 12 blocs.
3. `orbit/here/set_orbit` : centre des anneaux de fragments.
4. `orbit/here/set_collector` : dépôt des fragments, de l'autre côté de la salle par rapport au trou.
5. `orbit/here/set_spawn` : départ des joueurs, et retour de ceux qui sont avalés.
6. Command block répétitif `orbit/start`, avec 2 à 4 joueurs à moins de 6 blocs. Les 3 rounds s'enchaînent seuls, l'épée est donnée puis reprise.

Prévoir un plafond assez haut pour les phantoms des rounds 2 et 3. `orbit/here/stop` arrête la partie.

## 5. Rats de labo (1 à 8 joueurs)

1. `rats/here/place_cage` au centre de chaque cage, avant les rats. Construire la cage autour : les rats y sont posés en carré.
2. `rats/here/spawn_rats {count:16,radius:10}`, ou `rats/here/place_rat {variant:"grey"}` à la main (`grey`, `white`, `brown`, `mutant`).

En jeu : frapper un rat l'attrape, s'approcher à moins de 2,5 blocs du marqueur de la cage l'y dépose.
Le dernier rat mis en cage donne l'étoile. `rats/here/stop` retire tous les rats de la salle.

## Textes CRT

Tout texte de couleur `#01FE41` (tellraw, title, text display) est dessiné comme un vieil écran cathodique par le shader.

## Tester en solo

1. **Rats** : entièrement testable seul.
2. **Orbite** : baisser temporairement `MIN_PLAYERS` à 1 dans `orbit.py`.
3. **Villageois** : avec des étoiles données à la main.
4. **Casse-briques, miroirs, duos** : seul, seul le setup se vérifie (marqueurs, écran CRT, bumpers). Le gameplay demande de vrais joueurs ou des comptes alts.
