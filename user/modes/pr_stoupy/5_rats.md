
# 5. Rats de labo (1 à 8 joueurs)

À construire : une salle fermée d'où les rats ne peuvent pas sortir, et une cage entourée de blocs invisibles (barrières) pour que les rats relâchés dedans y restent.
À poser dans cet ordre.

1. Le collecteur, à côté de la cage. C'est une hitbox invisible d'un bloc, sous le texte "Déposer les rats", que les joueurs cliquent (gauche ou droit).
	Un bloc plein peut être construit au même endroit, la hitbox dépasse un peu pour être cliquée avant lui.
	Un seul collecteur par salle : en reposer un à moins de 48 blocs remplace l'ancien.
	```
	function survisland:modes/pr_stoupy/rats/here/place_collector
	```
2. La cage, au sol à l'intérieur : les rats déposés y apparaissent et courent dedans. En reposer une remplace l'ancienne.
	```
	function survisland:modes/pr_stoupy/rats/here/place_cage
	```
3. Les rats, au lancement de l'épreuve : `count` rats de variantes au hasard, posés au sol dans le rayon, dont `goal` à mettre en cage pour l'étoile (0 pour tous) :
	```
	function survisland:modes/pr_stoupy/rats/here/spawn_rats {count:25,radius:10,goal:20}
	```
	Ou un rat précis ici (`grey`, `white`, `brown` ou `mutant`) :
	```
	function survisland:modes/pr_stoupy/rats/here/place_rat {variant:"grey"}
	```

Chaque rat porte un mini-chapeau tiré au hasard : haut-de-forme, chapeau de fête, couronne, toque ou chapeau de sorcier.
En jeu, frapper un rat l'attrape (3 au plus par joueur), cliquer le collecteur relâche dans la cage tous les rats portés.
Le rat qui atteint `goal` en cage donne l'étoile, les rats encore libres ou portés disparaissent alors.
Un joueur qui entre dans un autre trial avec des rats sur la tête les repose au sol, libres, avant d'être téléporté.

Retirer tous les rats de la salle, en liberté, portés ou en cage :

```
function survisland:modes/pr_stoupy/rats/here/stop
```

