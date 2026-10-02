
# 2. Miroirs (2 joueurs)

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
Quand un joueur grimpe (échelle, lianes, échafaudage), son reflet monte et descend avec lui, même sans rien à grimper de son côté.

Sortie, command block impulsion. L'étoile va au joueur le plus proche, à 5 blocs au plus, puis ses reflets disparaissent et les deux joueurs retournent sur leur bloc de départ.
Ce départ ne peut plus être relancé, `here/clear` le réarme :

```
function survisland:modes/pr_stoupy/mirror/here/reward
```

Dépannage, sur un bouton. Renvoie les reflets du joueur le plus proche en face de leurs joueurs :

```
function survisland:modes/pr_stoupy/mirror/here/reset
```

Fin de la session du joueur le plus proche, qui renvoie aussi les deux joueurs sur leur bloc de départ.
Ils ne peuvent relancer qu'après en être descendus :

```
function survisland:modes/pr_stoupy/mirror/here/stop
```
