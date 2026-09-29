
# 4. Orbite (1 à 4 joueurs)

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
