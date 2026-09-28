
# Laboratoire du professeur Stoupy

Cinq trials indépendants, chacun rapporte une étoile bleue. Les cinq étoiles sont à ramener au villageois Maarcouscous.

Les commandes sont écrites pour un command block (sans `/`). Dans le chat, ajouter `/` devant.
Les fonctions `here/` et `start` agissent sur la salle la plus proche du point d'exécution.
Les `stop` sans `here/` agissent sur toutes les copies à la fois, ils servent au dépannage.

## Avant de commencer

1. Build depuis la racine du repo avec `stewbeet`. Le datapack est copié tout seul dans `saves/s31/datapacks`, puis `/reload` en jeu.
2. Le resource pack (`build/resource_pack`, copié dans `resource_pack_shortcut`) doit être actif chez tout le monde.
	Sans lui, pas d'écran CRT, pas de trou noir, et les rats sont des blocs de pierre.
3. Toi en créatif pour tout poser. Les joueurs en survie ou aventure : les `start` ignorent les joueurs en créatif et en spectateur.
4. Les command blocks doivent être activés (`enable-command-block=true` sur un serveur).

Deux réglages de command block reviennent partout :
- **Répétitif, toujours actif** pour les `start` et `duo/here/stop`. Ils ne font rien tant qu'il n'y a pas assez de joueurs.
- **Impulsion, redstone requise** pour les récompenses, branché sur une plaque de pression, un bouton ou la porte d'un puzzle.

## Départs, téléports et mode solo

### Blocs de départ

Un `start` prend les joueurs **debout sur un bloc d'émeraude**, à 16 blocs au plus de son command block.
Le rayon peut donc être large sans prendre les joueurs qui passent : il faut marcher sur un bloc de départ.
Pose un bloc d'émeraude par place (4 pour les duos, 2 pour les miroirs, 4 pour le casse-briques, 4 pour l'orbite), dans un sas devant la salle.
Les blocs acceptés sont dans `START_PAD_BLOCKS` (`shared.py`).

### Téléports

Les `start` des duos, des miroirs et du casse-briques prennent un argument `tp`.
Il déplace chaque joueur pris depuis sa propre position, avec une rotation en option, par exemple `tp:"~ ~ ~10 180 0"`.
Les joueurs arrivent donc dans la même disposition que sur leurs blocs de départ. `tp:""` les laisse en place.
Téléporter les joueurs dans une salle fermée suffit à ce que personne ne sorte ni n'entre pendant la partie.
L'orbite n'en a pas besoin : chaque joueur arrive au-dessus du trou noir.

### Mode solo

Chaque trial démarre avec un seul joueur, pour tester seul. Toujours en survie ou aventure :

```
function survisland:modes/pr_stoupy/solo {enabled:1}
function survisland:modes/pr_stoupy/solo {enabled:0}
```

- Casse-briques : jouable jusqu'au bout, ta balle casse les briques rouges, bleu clair, vert clair et jaunes (`SOLO_COLORS`, `colors.py`). Ton bumper est celui du Joueur 1, au début de la rangée.
- Orbite : déjà jouable seul, de 1 à 4 joueurs sans mode solo.
- Miroirs : un seul reflet. La mécanique se teste, un puzzle pensé pour 2 ne sera peut-être pas faisable.
- Duos : un mannequin pour toi seul, avec toutes les commandes (regard, déplacements, clic, saut).

## Setup d'une copie depuis zéro

Dans l'ordre, pour une copie de 100x100 :

1. Construire la maison de Stoupy, l'entrée du labo, les 5 salles et la salle du villageois. Ce qu'il faut dans chaque salle est détaillé dans sa section.
	Devant chaque salle à départ, un sas avec les blocs d'émeraude, d'où le `tp` du start envoie les joueurs dans la salle.
	- Duos : un parcours pour les mannequins, une arrivée, puis un puzzle redstone.
	- Miroirs : une salle symétrique autour d'un plan.
	- Casse-briques : un mur de jeu avec des cabines de joueurs, ou le terrain d'exemple.
	- Orbite : une grande salle avec un plafond haut.
	- Rats : une salle fermée avec des cages.
2. Poser le villageois.
3. Pour chaque trial, poser les marqueurs de setup, puis les command blocks de départ et de récompense.
4. Tester (voir [Tester en solo](#tester-en-solo)). Pour tout recommencer, `here/clear` supprime les entités du labo dans un rayon.
5. Faire la deuxième copie.

Conseil : mets chaque commande de setup dans un command block impulsion avec un bouton, en coordonnées relatives (`~`).
Refaire le setup, après un `here/clear` ou dans la deuxième copie, revient alors à appuyer sur les boutons.

## Deux copies

Chaque copie d'une salle est une arène indépendante, tout est relatif à ses marqueurs.
Deux copies de 100x100 séparées d'environ 200 blocs ne se voient jamais : le plus grand rayon de recherche est de 48 blocs (regroupement des cages de rats).

Pour la deuxième copie, cloner **les blocs seulement** : `/clone`, ou des structure blocks avec "Inclure les entités" désactivé.
Les marqueurs portent l'identifiant de leur arène, une copie de marqueurs ferait jouer les deux copies sur la même arène.
Refaire ensuite le setup dans la copie. Les command blocks clonés sont déjà en place, et le sont aussi les boutons de setup s'ils sont en relatif.
`/clone` est limité à 32768 blocs par commande, il en faut donc plusieurs pour 100x100.

## Villageois

Pose le villageois à ta position, orienté vers le yaw donné (0 sud, 90 ouest, 180 nord, -90 est) :

```
execute rotated 180 0 run function survisland:modes/pr_stoupy/villager/here/place
```

Un clic droit dessus avec les 5 étoiles termine l'épreuve.

## 1. Duos (4 joueurs)

À construire : une zone de départ, un parcours pour 2 mannequins, une arrivée, puis un puzzle redstone dont la porte déclenche la récompense.

Départ, command block répétitif. Il prend les 4 joueurs sur les blocs de départ et forme 2 paires, par distance au command block.
Chaque mannequin apparaît sur le Joueur 1 de sa paire, après le `tp`. Sans `tp`, les blocs de départ sont la ligne de départ du parcours :

```
function survisland:modes/pr_stoupy/duo/start {tp:""}
```

Arrivée, command block répétitif là où le mannequin doit arriver. Il rend leur corps aux joueurs du mannequin à moins de 3 blocs :

```
function survisland:modes/pr_stoupy/duo/here/stop
```

Récompense, command block impulsion déclenché par la porte du puzzle redstone. L'étoile va au joueur le plus proche, à 5 blocs au plus :

```
function survisland:modes/pr_stoupy/duo/here/reward
```

Redistribuer au hasard les commandes des deux joueurs du mannequin à moins de 3 blocs (piège ou dépannage) :

```
function survisland:modes/pr_stoupy/duo/here/shuffle_slots
```

## 2. Miroirs (2 joueurs)

À construire : une salle coupée en deux par un plan vertical. Les joueurs marchent d'un côté, leurs reflets de l'autre.
Le côté des reflets porte les murs, escaliers et plaques de pression du puzzle.

Départ, command block répétitif posé sur le plan du miroir, 2 joueurs sur les blocs de départ.
`axis:"x"` inverse la coordonnée X (miroir perpendiculaire à X), `axis:"z"` pour l'autre sens.
`tp` déplace chaque joueur depuis son bloc de départ au lancement, avec une rotation en option. `""` les laisse en place :

```
function survisland:modes/pr_stoupy/mirror/start {axis:"x",tp:"~ ~ ~10 180 0"}
```

Le déplacement est le même pour les deux, ils arrivent donc côte à côte comme sur leurs blocs de départ.
Leur reflet apparaît après le déplacement, en face de leur point d'arrivée.

Les joueurs reçoivent l'item "Figer le reflet" : clic droit pour figer ou libérer leur mannequin.
Le mannequin subit murs, escaliers et plaques de pression, le puzzle repose sur le décalage accumulé pendant qu'il est figé.

Sortie, command block impulsion. L'étoile va au joueur le plus proche, à 5 blocs au plus, puis ses reflets disparaissent :

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

### Terrain d'exemple

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
- Le command block répétitif de `breakout/start {tp:"~ ~5 ~",redstone:""}`, sous le milieu de la plateforme.
	Les joueurs se mettent sur les émeraudes et arrivent chacun dans la cabine au-dessus.

Avec `axis:"x"`, le terrain s'étend vers +x, le fond est côté -z et les joueurs côté +z.
La distance de la plateforme vaut 3/4 de la hauteur et le sol est à mi-hauteur moins 2, quelle que soit la taille choisie.

Remettre les briques d'exemple dans le terrain le plus proche, par exemple entre deux niveaux, avant `here/next_level` :

```
function survisland:modes/pr_stoupy/breakout/here/example_level
```

### Construire son propre terrain

- Un mur vertical. La rangée du bas reste vide, c'est la ligne des bumpers. Un sol dessous pour que la balle perdue s'arrête.
- Au-dessus, les briques en concrete, laine, terracotta ou verre teinté, dans les couleurs des joueurs.
	Le cadre et le fond ne doivent pas être de ces blocs colorés dans le plan du terrain, sinon ils comptent comme des briques.
- Chaque joueur arrive par le `tp` sur un bloc plein de sa couleur, face au mur, enfermé dans une case 1x1.
	Un tapis ou une dalle posé dessus cache la couleur : c'est le bloc juste sous les pieds qui est lu.
	Ils sont assis au centre de leur bloc sur une monture invisible pendant la partie, et remis dessus aussitôt s'ils descendent avec sneak. Leur vitesse baisse de 20 % pour un léger zoom.
- Le Joueur 1 est le plus proche du coin, son bumper est au début de la rangée.

Setup, une seule fois, positionné sur le coin bas gauche. Le terrain s'étend vers +axis et vers le haut.
Relancer avec `invert:1` si gauche et droite sont inversées pour les joueurs :

```
execute positioned 100 64 200 run function survisland:modes/pr_stoupy/breakout/here/setup {width:20,height:13,axis:"z",invert:0}
```

À chaque départ, la largeur et la hauteur sont remesurées jusqu'au cadre : la rangée des bumpers, vide, et la première colonne, faite d'air et de briques.
Le cadre doit donc fermer ces deux lignes, et ne pas être fait d'un bloc de couleur (64 cases au plus sinon).

Départ, command block répétitif à 16 blocs ou moins des 4 blocs d'émeraude.
Le `tp` est le même pour tous : chaque bloc de couleur doit être au même décalage de son émeraude (5 blocs au-dessus avec `tp:"~ ~5 ~"`).
La couleur est lue juste après le `tp`. Avec `tp:""`, le bloc lu est l'émeraude et la partie ne démarre pas.
Si un joueur n'arrive pas sur un bloc de couleur, la partie ne démarre pas et il reste où le `tp` l'a mis.
`redstone` pose un bloc de redstone à la victoire, relatif au command block, pour ouvrir la sortie par exemple.
Il est retiré au start suivant. `redstone:""` pour aucun :

```
function survisland:modes/pr_stoupy/breakout/start {tp:"~ ~5 ~",redstone:"~ ~-2 ~"}
```

### Pendant la partie

Les bumpers font 2 blocs de large et 0.5 d'épaisseur : des barrières sous un block display de la couleur du joueur.
Tous les 15 blocs cassés, la balle qui casse le 15e reçoit un bonus, en alternance : vitesse x1.5, puis une deuxième balle (à la même vitesse). Les bonus se cumulent.
Un joueur ne perd que quand sa dernière balle tombe.
Le béton prend deux coups : le premier le change en verre teinté de sa couleur, le second le casse. La laine, la terre cuite et le verre cassent en un coup.
Le joueur arrive par le `tp` au-dessus de sa case : sa couleur est lue sur le premier bloc de couleur dans les 3 blocs sous ses pieds.

Un niveau est fini quand il ne reste aucune brique des couleurs jouées.
Cloner alors le niveau suivant dans le mur (structure block, `clone` ou `here/example_level`), puis lancer :

```
function survisland:modes/pr_stoupy/breakout/here/next_level
```

Le 3e niveau terminé donne l'étoile. Arrêter la partie du terrain le plus proche :

```
function survisland:modes/pr_stoupy/breakout/here/stop
```

## 4. Orbite (1 à 4 joueurs)

À construire : une grande salle, avec un plafond assez haut pour les phantoms des rounds 2 et 3.
Le trou noir est peint sur un mur : les joueurs sont poussés vers lui en permanence pendant la partie, rounds et pauses compris.
Un voleur d'étoiles plonge dans la même direction et disparaît en touchant le premier bloc sur son chemin.
À poser dans cet ordre, le trou noir d'abord.

1. Le trou noir, un cube inversé géant rendu par le shader :
	```
	function survisland:modes/pr_stoupy/orbit/here/place_black_hole {scale:100}
	```
2. Au même endroit, l'ancre de la salle. Les joueurs arrivent 1 bloc au-dessus, et la poussée suit son yaw.
	Depuis un command block, c'est +z. Pour une autre direction, préciser le yaw (0 sud/+z, 90 ouest, 180 nord, -90 est) :
	```
	function survisland:modes/pr_stoupy/orbit/here/set_hole
	execute rotated 180 0 run function survisland:modes/pr_stoupy/orbit/here/set_hole
	```
3. Le centre des anneaux de fragments :
	```
	function survisland:modes/pr_stoupy/orbit/here/set_orbit
	```
4. Le dépôt des fragments, du côté opposé au mur du trou noir :
	```
	function survisland:modes/pr_stoupy/orbit/here/set_collector
	```
5. 4 blocs d'émeraude dans le sas, espacés d'au moins un bloc, et un command block répétitif à 16 blocs au plus :
	```
	function survisland:modes/pr_stoupy/orbit/start
	```
	Chaque joueur qui monte sur un bloc est téléporté 1 bloc au-dessus de l'ancre et reçoit l'épée.
	Le premier lance le round 1, les suivants rejoignent la partie en cours.
	Le bloc d'émeraude disparaît, donc 4 joueurs au plus. Tous les blocs reviennent à la fin de la partie (victoire ou stop).

La chute dans le trou noir est à détecter toi-même, avec un command block répétitif de la salle.
La fonction s'exécute en tant que le joueur tombé : elle le renvoie 1 bloc au-dessus de l'ancre et remet ses fragments en orbite.
Exemple avec une zone de détection devant le mur (à adapter) :

```
execute as @a[tag=survisland.pr_orbit,x=100,y=60,z=240,dx=40,dy=2,dz=3] run function survisland:modes/pr_stoupy/orbit/swallow
```

Arrêter la partie de la salle la plus proche :

```
function survisland:modes/pr_stoupy/orbit/here/stop
```

## 5. Rats de labo (1 à 8 joueurs)

À construire : une salle fermée d'où les rats ne peuvent pas sortir, avec une ou plusieurs cages.

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

## Remise à zéro (développement)

Arrête tous les trials dans le rayon et rend leur état aux joueurs (corps, attributs, items, tags).
Supprime ensuite toutes les entités du labo dans ce rayon, setup compris : villageois, marqueurs, cages, rats, écran, trou noir.
Les blocs ne sont pas touchés. Rien ne sort du rayon, donc la deuxième copie n'est pas touchée si elle est plus loin :

```
function survisland:modes/pr_stoupy/here/clear {radius:100}
```

Les salles sont ensuite à refaire avec les commandes de setup ci-dessus.

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

## Textes CRT

Tout texte de couleur `#01FE41` (tellraw, title, text display) est dessiné comme un vieil écran cathodique par le shader :

```
tellraw @a {"text":"Bienvenue au laboratoire","color":"#01FE41"}
```

## Tester en solo

Activer le [mode solo](#mode-solo), passer en survie ou aventure, puis monter sur un bloc de départ.
Les rats et le villageois (avec 5 étoiles du `loot give` ci-dessus) se testent seul sans mode solo.

Ce que le mode solo ne teste pas : deux joueurs sur un même mannequin, quatre balles en même temps, un puzzle de miroir à deux.
Pour ça, un serveur local avec `online-mode=false` et plusieurs clients en comptes hors-ligne (Prism Launcher) sur `localhost`.
