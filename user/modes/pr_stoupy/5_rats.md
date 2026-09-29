
# 5. Rats de labo (1 à 8 joueurs)

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
