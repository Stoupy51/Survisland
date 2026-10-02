
# 3. Casse-briques (4 joueurs)

## Terrain d'exemple

Construit un terrain jouable complet et fait le setup, à lancer sur le coin bas gauche (la première case de la rangée des bumpers).
Tous les blocs du terrain, du cadre, de la plateforme et des cabines sont remplacés, donc à lancer dans un endroit vide :

```
execute positioned 100 64 200 run function survisland:modes/pr_stoupy/breakout/here/example {width:20,height:13,axis:"z"}
```

Avec ces valeurs, le terrain occupe x=100, de z=200 à 212 et de y=64 à 83 :
- Un cadre en pierre lisse autour, un fond en blackstone côté +x, une vitre côté -x.
- 6 rangées de briques en diagonales rouges, bleu clair, vert clair et jaunes, sous une rangée du haut laissée vide.
- Une plateforme à x=85 (15 blocs devant la vitre), sol à y=72 pour avoir les yeux au milieu du terrain.
- 4 cabines 1x1 ouvertes en haut, de sol rouge, bleu clair, vert clair et jaune, de z=201 à 211.
- Sous la plateforme, 5 blocs plus bas que les sols des cabines, une passerelle avec un bloc d'émeraude sous chaque cabine.
- Le command block répétitif de `breakout/start {tp:"~ ~5 ~",level_block:""}`, sous le milieu de la plateforme.
	Les joueurs se mettent sur les émeraudes et arrivent chacun dans la cabine au-dessus.

Avec `axis:"x"`, le terrain s'étend vers +x, le fond est côté -z et les joueurs côté +z.
La distance de la plateforme vaut 3/4 de la hauteur et le sol est à mi-hauteur moins 2, quelle que soit la taille choisie.

Remettre les briques d'exemple dans le terrain le plus proche, par exemple entre deux niveaux, avant `here/next_level` :

```
function survisland:modes/pr_stoupy/breakout/here/example_level
```

## Construire son propre terrain

Le terrain :
- Un mur vertical fermé par un cadre, avec un sol dessous. La rangée du bas reste vide, c'est la ligne des bumpers.
- Au-dessus, les briques en béton, laine, terre cuite ou verre teinté, dans les couleurs des joueurs. Le violet est réservé à la brique multiball, et le gris clair ne compte jamais comme une brique.
- Le cadre et le fond ne sont pas faits de ces blocs colorés : dans le plan du terrain, ils compteraient comme des briques. Le gris clair convient.

Les joueurs :
- 4 blocs d'émeraude dans un sas, à 16 blocs au plus du command block de départ.
- Pour chaque émeraude, une case 1x1 face au mur, avec au sol un bloc plein de couleur, au même décalage que le `tp` (5 blocs au-dessus avec `tp:"~ ~5 ~"`).
- Juste après le `tp`, la couleur est lue sur le premier bloc de couleur dans les 3 blocs sous les pieds.
	Si un joueur n'en trouve pas (ou tombe sur du violet), la partie ne démarre pas et il reste où le `tp` l'a mis.

Setup, une seule fois, positionné sur le coin bas gauche (la première case de la rangée des bumpers).
Le terrain s'étend vers +axis et vers le haut. `invert:1` si gauche et droite sont inversées pour les joueurs :

```
execute positioned 100 64 200 run function survisland:modes/pr_stoupy/breakout/here/setup {width:20,height:13,axis:"z",invert:0}
```

`width` et `height` ne placent l'écran que jusqu'au premier départ : chaque départ remesure le terrain jusqu'au cadre.
La largeur est prise le long de la rangée des bumpers (vide), la hauteur le long de la première colonne (air et briques), 64 cases au plus.

Départ, command block répétitif :

```
function survisland:modes/pr_stoupy/breakout/start {tp:"~ ~5 ~",level_block:"~ ~-2 ~"}
```

`level_block` pose un bloc au début de chaque niveau, relatif au command block : fer au niveau 1, or au 2, diamant au 3 (`LEVEL_BLOCKS`).
Des command blocks le détectent (`execute if block ... minecraft:gold_block run clone ...`) pour cloner les briques du bon niveau.
Il est retiré au lancement des balles, 7 secondes plus tard, et les briques sont comptées à ce moment-là. `level_block:""` pour aucun.
À la fin de chaque niveau, un bloc de redstone est posé au même endroit, et y reste jusqu'au bloc du niveau suivant (ou au départ suivant après le dernier).

## Pendant la partie

- Chaque joueur est assis au centre de sa case sur une monture invisible, et remis dessus s'il descend avec sneak. Sa vitesse baisse de 20 % pour un léger zoom.
- Gauche et droite déplacent son bumper : 2 blocs de large, 0.5 d'épaisseur. Les bumpers sont répartis sur la rangée selon le nombre de joueurs, le Joueur 1 (le plus proche du coin) en premier.
- Chaque balle casse les briques de toutes les couleurs. Le béton prend deux coups : il devient du verre teinté, puis casse.
- Tous les 15 blocs cassés, la balle qui casse le 15e reçoit un bonus, en alternance : vitesse x1.5, puis une deuxième balle à la même vitesse. Les bonus se cumulent.
- Une brique violette est cassée par n'importe quelle balle et multiplie par 5 toutes les balles en jeu, dans des directions au hasard, 40 au plus par terrain. Elle ne compte pas pour finir le niveau.
- Un joueur ne perd que quand sa dernière balle tombe : toutes les balles reviennent alors sur les bumpers, puis repartent après le compte à rebours.

Un niveau est fini quand il ne reste aucune brique des couleurs jouées. Lancer alors le suivant :

```
function survisland:modes/pr_stoupy/breakout/here/next_level
```

Le 3e niveau terminé donne l'étoile. Arrêter la partie du terrain le plus proche :

```
function survisland:modes/pr_stoupy/breakout/here/stop
```

