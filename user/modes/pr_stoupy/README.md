
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

- Casse-briques : jouable jusqu'au bout, ta balle casse les briques rouges, bleu clair, vert clair et jaunes (`SOLO_COLORS`, `colors.py`). Ton bumper est seul, au milieu de la rangée.
- Orbite : déjà jouable seul, de 1 à 4 joueurs sans mode solo.
- Miroirs : un seul reflet. La mécanique se teste, un puzzle pensé pour 2 ne sera peut-être pas faisable.
- Duos : un mannequin pour toi seul, avec toutes les commandes (regard, déplacements, clic, saut).

## Setup d'une copie depuis zéro

Dans l'ordre, pour une copie de 100x100 :

1. Construire la maison de Stoupy, l'entrée du labo, les 5 salles et la salle du villageois. Ce qu'il faut dans chaque salle est détaillé dans le fichier de son trial (voir [Les trials](#les-trials)).
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
Deux copies de 100x100 séparées d'environ 200 blocs ne se voient jamais : le plus grand rayon de recherche est de 48 blocs (regroupement des collecteurs de rats).

Pour la deuxième copie, cloner **les blocs seulement** : `/clone`, ou des structure blocks avec "Inclure les entités" désactivé.
Les marqueurs portent l'identifiant de leur arène, une copie de marqueurs ferait jouer les deux copies sur la même arène.
Refaire ensuite le setup dans la copie. Les command blocks clonés sont déjà en place, et le sont aussi les boutons de setup s'ils sont en relatif.
`/clone` est limité à 32768 blocs par commande, il en faut donc plusieurs pour 100x100.

## Villageois

Pose le villageois à ta position, orienté vers le yaw donné (0 sud, 90 ouest, 180 nord, -90 est) :

```
execute rotated 180 0 run function survisland:modes/pr_stoupy/villager/here/place
```

Il garde son IA et se promène : le retrouver fait partie de l'épreuve.
Un clic droit dessus avec les 5 étoiles les retire toutes et pose un bloc de redstone 2 blocs sous l'endroit où il a été posé.
Les messages de fin sont à brancher sur ce bloc.

## Les trials

- [1. Duos (4 joueurs)](1_duos.md)
- [2. Miroirs (2 joueurs)](2_miroirs.md)
- [3. Casse-briques (4 joueurs)](3_casse_briques.md)
- [4. Orbite (1 à 4 joueurs)](4_orbite.md)
- [5. Rats de labo (1 à 8 joueurs)](5_rats.md)

## Remise à zéro (développement)

Arrête tous les trials dans le rayon et rend leur état aux joueurs (corps, attributs, items, tags).
Supprime ensuite toutes les entités du labo dans ce rayon, setup compris : villageois, marqueurs, collecteurs et cages, rats, écran, trou noir.
Les blocs ne sont pas touchés. Rien ne sort du rayon, donc la deuxième copie n'est pas touchée si elle est plus loin :

```
function survisland:modes/pr_stoupy/here/clear {radius:100}
```

Les salles sont ensuite à refaire avec les commandes de setup du villageois et de chaque trial.

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
