
# 1. Duos (4 joueurs)

À construire : une zone de départ, un parcours pour 2 mannequins, une arrivée, puis un puzzle redstone dont la porte déclenche la récompense.

Départ, command block répétitif. Il prend les 4 joueurs sur les blocs de départ et forme 2 paires, par distance au command block.
Chaque mannequin apparaît sur le Joueur 1 de sa paire, après le `tp`. Sans `tp`, les blocs de départ sont la ligne de départ du parcours :

```
function survisland:modes/pr_stoupy/duo/start {tp:""}
```

Arrivée, command block répétitif là où le mannequin doit arriver. Il rend leur corps aux joueurs du mannequin à moins de 3 blocs et les renvoie sur leur bloc de départ.
Ils ne peuvent relancer qu'après en être descendus :

```
function survisland:modes/pr_stoupy/duo/here/stop
```

Récompense, command block impulsion déclenché par la porte du puzzle redstone. L'étoile va au joueur le plus proche, à 5 blocs au plus.
Le départ d'où ce joueur est parti ne peut plus être relancé, `here/clear` le réarme :

```
function survisland:modes/pr_stoupy/duo/here/reward
```

Redistribuer au hasard les commandes des deux joueurs du mannequin à moins de 3 blocs (piège ou dépannage) :

```
function survisland:modes/pr_stoupy/duo/here/shuffle_slots
```
