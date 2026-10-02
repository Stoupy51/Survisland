
# 4. Orbite (1 à 4 joueurs)

À construire : une grande salle vide (40x40x40 par exemple), avec des rochers flottants pour sauter de l'un à l'autre.
Le trou noir est dessiné à l'infini dans le ciel par le shader, vers +z : les joueurs sont poussés vers lui en permanence pendant la partie, rounds et pauses compris.
Un voleur d'étoiles plonge dans la même direction et disparaît en touchant le premier bloc sur son chemin.
À poser dans cet ordre, le trou noir d'abord.

1. Le trou noir, au centre de la salle : le cube du ciel rendu par le shader, et l'ancre de la salle.
	Les joueurs arrivent 1 bloc au-dessus, et la poussée suit son yaw.
	Les fragments tournent autour sur 6 anneaux inclinés chacun dans un sens différent, de 6 à 16 blocs du centre.
	Un joueur attrape un fragment en le touchant, ou en cliquant dessus (gauche ou droit), même un fragment emporté par un voleur.
	Depuis un command block, c'est +z, la direction du trou noir dans le ciel. Depuis le chat, forcer ce yaw :
	```
	function survisland:modes/pr_stoupy/orbit/here/place_black_hole {scale:100}
	execute rotated 0 0 run function survisland:modes/pr_stoupy/orbit/here/place_black_hole {scale:100}
	```
2. Le dépôt des fragments, du côté -z, pour que les joueurs remontent contre la poussée.
	Une étoile lumineuse et le texte "Dépôt des fragments" le signalent au-dessus :
	```
	function survisland:modes/pr_stoupy/orbit/here/set_collector
	```
3. Des rochers flottants, centrés à ta position. Cinq tailles (rayon 1 à 5 blocs), le bord de chacun est tiré au hasard :
	```
	function survisland:modes/pr_stoupy/orbit/here/rock/tiny
	function survisland:modes/pr_stoupy/orbit/here/rock/small
	function survisland:modes/pr_stoupy/orbit/here/rock/medium
	function survisland:modes/pr_stoupy/orbit/here/rock/large
	function survisland:modes/pr_stoupy/orbit/here/rock/huge
	```
4. 4 blocs d'émeraude dans le sas, espacés d'au moins un bloc, et un command block répétitif à 16 blocs au plus :
	```
	function survisland:modes/pr_stoupy/orbit/start
	```
	Chaque joueur qui monte sur un bloc est téléporté 1 bloc au-dessus de l'ancre et reçoit l'épée.
	Le premier lance le round 1, les suivants rejoignent la partie en cours.
	Le bloc d'émeraude disparaît, donc 4 joueurs au plus. À la fin de la partie (victoire ou stop), tous les blocs reviennent et chaque joueur est renvoyé sur l'un d'eux.
	Il ne peut rejoindre une partie qu'après en être descendu.
	Une fois l'épreuve réussie, elle ne peut plus être relancée : replacer le trou noir la réarme.

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

