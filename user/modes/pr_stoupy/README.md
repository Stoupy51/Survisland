
# Laboratoire du professeur Stoupy

Cinq trials indépendants, chacun rapporte une étoile bleue. Les cinq étoiles sont à ramener au villageois Maarcouscous.

Les commandes sont écrites pour un command block (sans `/`). Dans le chat, ajouter `/` devant.
Les fonctions `here/` et `start` agissent sur la salle la plus proche du point d'exécution.
Les `stop` sans `here/` agissent sur toutes les copies à la fois, ils servent au dépannage.

## Deux copies

Chaque copie d'une salle est une arène indépendante, tout est relatif à ses marqueurs.
Deux copies de 100x100 séparées d'environ 200 blocs ne se voient jamais : le plus grand rayon de recherche est de 48 blocs (regroupement des cages de rats).
Pour la deuxième copie, refaire exactement le même setup dans ses salles.

## Villageois

Pose le villageois à ta position, orienté vers le yaw donné (0 sud, 90 ouest, 180 nord, -90 est) :

```
execute rotated 180 0 run function survisland:modes/pr_stoupy/villager/here/place
```

Un clic droit dessus avec les 5 étoiles termine l'épreuve.

## 1. Duos (4 joueurs)

Départ, command block répétitif. Il prend les 4 joueurs à moins de 3 blocs et forme 2 paires par distance :

```
function survisland:modes/pr_stoupy/duo/start
```

Arrivée, command block répétitif là où le mannequin doit arriver. Il rend leur corps aux joueurs du mannequin à moins de 3 blocs :

```
function survisland:modes/pr_stoupy/duo/here/stop
```

Récompense, command block impulsion déclenché par la porte du puzzle redstone. L'étoile va au joueur le plus proche :

```
function survisland:modes/pr_stoupy/duo/here/reward
```

Redistribuer au hasard les commandes des deux joueurs du mannequin à moins de 3 blocs (piège ou dépannage) :

```
function survisland:modes/pr_stoupy/duo/here/shuffle_slots
```

## 2. Miroirs (2 joueurs)

Départ, command block répétitif posé sur le plan du miroir. `axis:"x"` inverse la coordonnée X (miroir perpendiculaire à X), `axis:"z"` pour l'autre sens :

```
function survisland:modes/pr_stoupy/mirror/start {axis:"x"}
```

Les joueurs reçoivent l'item "Figer le reflet" : clic droit pour figer ou libérer leur mannequin.
Le mannequin subit murs, escaliers et plaques de pression, le puzzle repose sur le décalage accumulé pendant qu'il est figé.

Sortie, command block impulsion. L'étoile va au joueur le plus proche, puis ses reflets disparaissent :

```
function survisland:modes/pr_stoupy/mirror/here/reward
```

Dépannage, sur un bouton. Renvoie les reflets du joueur le plus proche en face de leurs joueurs :

```
function survisland:modes/pr_stoupy/mirror/here/reset
```

Fin de la session du joueur le plus proche :

```
function survisland:modes/pr_stoupy/mirror/here/stop
```

## 3. Casse-briques (4 joueurs)

Construction :
- Un mur vertical. La rangée du bas reste vide, c'est la ligne des bumpers.
- Au-dessus, les briques en concrete, laine, terracotta ou verre teinté, dans les couleurs des joueurs.
- Chaque joueur se tient sur un bloc de sa couleur, face au mur, enfermé dans une case 1x1.
	Le datapack ne les bloque pas, et les touches gauche/droite qui dirigent le bumper déplaceraient aussi le joueur.

Setup, une seule fois, positionné sur le coin bas gauche (la première case de la rangée des bumpers).
Le terrain s'étend vers +axis et vers le haut. Relancer avec `invert:1` si gauche et droite sont inversées pour les joueurs :

```
execute positioned 100 64 200 run function survisland:modes/pr_stoupy/breakout/here/setup {width:13,height:20,axis:"z",invert:0}
```

Départ, command block répétitif à 8 blocs ou moins des joueurs :

```
function survisland:modes/pr_stoupy/breakout/start
```

Un niveau est fini quand il ne reste aucune brique des couleurs jouées.
Cloner alors le niveau suivant dans le mur (structure block ou `clone`), puis lancer :

```
function survisland:modes/pr_stoupy/breakout/here/next_level
```

Le 3e niveau terminé donne l'étoile. Arrêter la partie du terrain le plus proche :

```
function survisland:modes/pr_stoupy/breakout/here/stop
```

## 4. Orbite (2 à 4 joueurs)

À poser dans cet ordre, le trou noir d'abord.

1. Le trou noir, un cube inversé géant rendu par le shader :
	```
	function survisland:modes/pr_stoupy/orbit/here/place_black_hole {scale:100}
	```
2. Au même endroit, l'ancre de la salle. Un joueur à moins de 3 blocs est avalé, l'attraction est plus forte sous 12 blocs :
	```
	function survisland:modes/pr_stoupy/orbit/here/set_hole
	```
3. Le centre des anneaux de fragments :
	```
	function survisland:modes/pr_stoupy/orbit/here/set_orbit
	```
4. Le dépôt des fragments, de l'autre côté de la salle par rapport au trou :
	```
	function survisland:modes/pr_stoupy/orbit/here/set_collector
	```
5. Le départ des joueurs, et le retour de ceux qui sont avalés :
	```
	function survisland:modes/pr_stoupy/orbit/here/set_spawn
	```
6. Command block répétitif, 2 à 4 joueurs à moins de 6 blocs. Les 3 rounds s'enchaînent seuls, l'épée est donnée puis reprise :
	```
	function survisland:modes/pr_stoupy/orbit/start
	```

Prévoir un plafond assez haut pour les phantoms des rounds 2 et 3. Arrêter la partie de la salle la plus proche :

```
function survisland:modes/pr_stoupy/orbit/here/stop
```

## 5. Rats de labo (1 à 8 joueurs)

1. Une cage, au centre de chaque cage construite, avant les rats. Les rats y sont posés en carré.
	Toutes les cages d'une même salle doivent être à moins de 48 blocs les unes des autres.
	```
	function survisland:modes/pr_stoupy/rats/here/place_cage
	```
2. Des rats de variantes au hasard, posés au sol dans le rayon :
	```
	function survisland:modes/pr_stoupy/rats/here/spawn_rats {count:16,radius:10}
	```
	Ou un rat précis ici (`grey`, `white`, `brown` ou `mutant`) :
	```
	function survisland:modes/pr_stoupy/rats/here/place_rat {variant:"grey"}
	```

Chaque rat porte un mini-chapeau tiré au hasard : haut-de-forme, chapeau de fête, couronne, toque ou chapeau de sorcier.
En jeu, frapper un rat l'attrape (3 au plus par joueur), s'approcher à moins de 2,5 blocs du centre d'une cage l'y dépose.
Le dernier rat mis en cage donne l'étoile.

Retirer tous les rats de la salle, en liberté, portés ou en cage :

```
function survisland:modes/pr_stoupy/rats/here/stop
```

## Dépannage global

Chaque ligne arrête le trial partout, dans les deux copies :

```
function survisland:modes/pr_stoupy/duo/stop
function survisland:modes/pr_stoupy/mirror/stop
function survisland:modes/pr_stoupy/breakout/stop
function survisland:modes/pr_stoupy/orbit/stop
function survisland:modes/pr_stoupy/rats/stop
```

Se donner une étoile bleue :

```
loot give @s loot survisland:i/blue_star
```

## Remise à zéro (développement)

Arrête tous les trials dans le rayon et rend leur état aux joueurs (corps, attributs, items, tags).
Supprime ensuite toutes les entités du labo dans ce rayon, setup compris : villageois, marqueurs, cages, rats, écran, trou noir.
Rien ne sort du rayon, donc la deuxième copie n'est pas touchée si elle est plus loin :

```
function survisland:modes/pr_stoupy/here/clear {radius:100}
```

Les salles sont ensuite à refaire avec les commandes de setup ci-dessus.

## Textes CRT

Tout texte de couleur `#01FE41` (tellraw, title, text display) est dessiné comme un vieil écran cathodique par le shader :

```
tellraw @a {"text":"Bienvenue au laboratoire","color":"#01FE41"}
```

## Tester en solo

1. Rats : entièrement testable seul.
2. Orbite : baisser temporairement `MIN_PLAYERS` à 1 dans `orbit.py`.
3. Villageois : avec 5 étoiles données par le `loot give` ci-dessus.
4. Casse-briques, miroirs, duos : seul le setup se vérifie (marqueurs, écran CRT, bumpers). Le gameplay demande de vrais joueurs ou des comptes alts.

