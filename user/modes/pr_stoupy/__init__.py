""" Épreuve "Laboratoire du professeur Stoupy" : cinq trials indépendants, chacun rapportant une étoile bleue.
Les cinq étoiles sont à ramener ensemble au villageois Maarcouscous, qui valide l'épreuve.

Toutes les fonctions sont sous survisland:modes/pr_stoupy/. Celles marquées (répétitif) peuvent être posées dans
un command block répétitif, elles ne font rien tant que les conditions ne sont pas réunies.
Celles marquées (une fois) sont à déclencher une seule fois (command block impulsion, redstone).

# Villageois
	villager/here/place                         pose le villageois ici (execute rotated <yaw> 0 pour l'orienter)

# 1. Les duos (4 joueurs, 2 paires de mannequins All Together)
	duo/start                                   (répétitif) 4 joueurs à 3 blocs, coupés en 2 paires par distance
	duo/here/stop                               (répétitif) rend son corps au duo dont le mannequin passe ici
	duo/here/reward                             (une fois) étoile au joueur le plus proche, après le puzzle redstone

# 2. Les miroirs (2 joueurs)
	mirror/start {axis:"x"}                     (répétitif) plan du miroir passant par ce bloc, axis "x" ou "z" = axe inversé
	mirror/reset                                renvoie chaque reflet en face de son joueur
	mirror/here/reward                          (une fois) étoile au joueur le plus proche, puis fin des reflets
	mirror/stop

# 3. Le casse-briques (4 joueurs, chacun sur un bloc de couleur)
	execute positioned <coin bas gauche> run function survisland:modes/pr_stoupy/breakout/here/setup {width:24,height:16,axis:"x",invert:0}
		(une fois) Le coin est la première case de la rangée des bumpers, le terrain s'étend vers +axis et vers le haut.
		Mettre invert:1 si gauche et droite sont inversées pour les joueurs.
	breakout/start                             (répétitif) 4 joueurs à 8 blocs, lancement du niveau 1
	breakout/next_level                         après avoir cloné le niveau suivant : balles remises, "Prochain niveau : 2/3"
	breakout/stop

# 4. L'orbite (2 à 4 joueurs)
	orbit/here/place_black_hole {scale:100}     cube inversé géant rendu par le shader du trou noir
	orbit/here/set_hole                         cible de l'attraction, là où le trou noir apparaît
	orbit/here/set_orbit                        centre des anneaux de fragments
	orbit/here/set_collector                    où les fragments sont déposés
	orbit/here/set_spawn                        départ des joueurs, et retour de ceux qui sont avalés
	orbit/start                                 (répétitif) 2 à 4 joueurs à 6 blocs, enchaîne les 3 rounds tout seul
	orbit/stop

# 5. Les rats de labo (1 à 8 joueurs, n'importe qui peut aider)
	rats/here/place_rat {variant:"grey"}        un rat ici : grey, white, brown ou mutant
	rats/here/spawn_rats {count:16,radius:10}   des rats au hasard, posés au sol dans le rayon
	rats/here/place_cage                        une cage, il peut y en avoir plusieurs
	rats/stop                                   retire tous les rats, en liberté, portés ou en cage

# Textes CRT
Tout texte de couleur #01FE41 (tellraw, title, text display) est dessiné comme un vieil écran cathodique par le shader.
"""
# ruff: noqa: E501
# Imports
from .breakout import main as generate_breakout
from .duo import main as generate_duo
from .mirror import main as generate_mirror
from .orbit import main as generate_orbit
from .rats import main as generate_rats
from .shared import generate_give_star
from .villager import main as generate_villager


# Functions
def main() -> None:
	""" Generate every file of the lab. """
	generate_give_star()
	generate_villager()
	generate_duo()
	generate_mirror()
	generate_breakout()
	generate_orbit()
	generate_rats()

