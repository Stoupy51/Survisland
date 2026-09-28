""" Épreuve "Laboratoire du professeur Stoupy" : cinq trials indépendants, chacun rapportant une étoile bleue.
Les cinq étoiles sont à ramener ensemble au villageois Maarcouscous, qui valide l'épreuve.

Toutes les fonctions sont sous survisland:modes/pr_stoupy/. Celles marquées (répétitif) peuvent être posées dans
un command block répétitif, elles ne font rien tant que les conditions ne sont pas réunies.
Celles marquées (une fois) sont à déclencher une seule fois (command block impulsion, redstone).

# Départs, portes et mode solo
Un start prend les joueurs debout sur un bloc d'émeraude (START_PAD_BLOCKS) à 16 blocs au plus, en survie ou aventure.
	solo {enabled:1}                            chaque trial démarre avec un seul joueur, {enabled:0} pour revenir à la normale
	<trial>/here/place_door {block:"minecraft:iron_bars",radius:24}
		Un bloc de porte, rempli tant qu'un joueur de ce trial est à moins de radius blocs (duo, mirror, breakout, orbit).

# Plusieurs copies de l'épreuve
Chaque copie d'une salle est une arène indépendante, repérée par ses propres marqueurs : tout se fait en relatif.
Les fonctions here/ et start agissent sur la salle la plus proche du point d'exécution.
Les fonctions sans here/ (stop) agissent sur toutes les copies à la fois, elles sont réservées au dépannage.
Il suffit d'éloigner les copies de plus de 48 blocs (regroupement des cages de rats) pour qu'elles ne se voient jamais.

# Villageois
	villager/here/place                         pose le villageois ici (execute rotated <yaw> 0 pour l'orienter)

# 1. Les duos (4 joueurs, 2 paires de mannequins All Together)
	duo/start                                   (répétitif) 4 joueurs sur les blocs de départ, coupés en 2 paires par distance
	duo/here/stop                               (répétitif) rend son corps au duo dont le mannequin passe ici
	duo/here/reward                             (une fois) étoile au joueur le plus proche, après le puzzle redstone

# 2. Les miroirs (2 joueurs)
	mirror/start {axis:"x",tp:""}               (répétitif) plan du miroir passant par ce bloc, axis "x" ou "z" = axe inversé
		tp déplace chaque joueur depuis sa position au départ (ex: "~ ~ ~10"), "" pour les laisser en place.
	mirror/here/reset                           renvoie les reflets du joueur le plus proche en face de leurs joueurs
	mirror/here/reward                          (une fois) étoile au joueur le plus proche, puis fin de ses reflets
	mirror/here/stop                            fin de la session du joueur le plus proche

# 3. Le casse-briques (4 joueurs, chacun sur un bloc de couleur)
	execute positioned <coin bas gauche> run function survisland:modes/pr_stoupy/breakout/here/setup {width:24,height:16,axis:"x",invert:0}
		(une fois) Le coin est la première case de la rangée des bumpers, le terrain s'étend vers +axis et vers le haut.
		Mettre invert:1 si gauche et droite sont inversées pour les joueurs.
	breakout/start                              (répétitif) 4 joueurs sur un bloc de couleur, lancement du niveau 1 du terrain le plus proche
	breakout/here/next_level                    après avoir cloné le niveau suivant : balles remises, "Prochain niveau : 2/3"
	breakout/here/stop
	execute positioned <coin bas gauche> run function survisland:modes/pr_stoupy/breakout/here/example {width:13,height:20,axis:"z"}
		Terrain d'exemple construit et configuré : cadre, vitre, briques, cabines des joueurs et command block de départ.
	breakout/here/example_level                 remet les briques d'exemple dans le terrain le plus proche

# 4. L'orbite (1 à 4 joueurs), à placer dans cet ordre, le trou noir d'abord
	orbit/here/place_black_hole {scale:100}     cube inversé géant rendu par le shader du trou noir
	orbit/here/set_hole                         ancre de la salle au centre du trou noir : arrivée 1 bloc au-dessus, poussée vers son yaw (+z depuis un command block)
	orbit/here/set_orbit                        centre des anneaux de fragments
	orbit/here/set_collector                    où les fragments sont déposés
	orbit/start                                 (répétitif) chaque joueur sur un bloc de départ rejoint la partie, le bloc disparaît jusqu'à la fin
	orbit/swallow                               à exécuter en tant que le joueur tombé dans le trou noir
	orbit/here/stop

# 5. Les rats de labo (1 à 8 joueurs, n'importe qui peut aider), les cages d'abord
	rats/here/place_cage                        une cage, il peut y en avoir plusieurs par salle
	rats/here/place_rat {variant:"grey"}        un rat ici : grey, white, brown ou mutant
	rats/here/spawn_rats {count:16,radius:10}   des rats au hasard, posés au sol dans le rayon
	rats/here/stop                              retire les rats de la salle, en liberté, portés ou en cage

# Remise à zéro pendant le développement
	here/clear {radius:100}                     arrête tout dans le rayon, ouvre les portes, puis supprime toutes les entités du labo, setup compris

# Textes CRT
Tout texte de couleur #01FE41 (tellraw, title, text display) est dessiné comme un vieil écran cathodique par le shader.
"""
# ruff: noqa: E501
# Imports
from stewbeet import Mem, write_function

from .breakout import main as generate_breakout
from .breakout.physics import MODE as BREAKOUT_MODE
from .doors import DOOR_TAG, main as generate_doors
from .duo import DUO, main as generate_duo
from .mirror import MODE as MIRROR_MODE, main as generate_mirror
from .orbit import MARKERS as ORBIT_MARKERS, MODE as ORBIT_MODE, main as generate_orbit
from .rats import MODE as RATS_MODE, main as generate_rats
from .shared import LAB, generate_give_star, generate_lobby
from .villager import main as generate_villager


# Functions
def main() -> None:
	""" Generate every file of the lab. """
	generate_give_star()
	generate_lobby()
	generate_villager()
	generate_duo()
	generate_mirror()
	generate_breakout()
	generate_orbit()
	generate_rats()
	generate_doors()
	generate_clear()


def generate_clear() -> None:
	""" Write the reset of everything the lab put within $(radius) blocks, players released first. """
	ns: str = Mem.ctx.project_id
	root: str = f"{ns}:{LAB}"
	duo, mirror, breakout, orbit, rats = (f"{ns}.{mode}" for mode in (DUO.id, MIRROR_MODE, BREAKOUT_MODE, ORBIT_MODE, RATS_MODE))
	entity_tags: list[str] = [
		f"{duo}.body", f"{duo}.seat",
		f"{mirror}.body", f"{mirror}.anchor",
		f"{breakout}.corner", f"{breakout}.screen", f"{breakout}.bumper", f"{breakout}.ball",
		f"{orbit}.hole", *(f"{orbit}.{name}" for name in ORBIT_MARKERS), f"{orbit}.sky", f"{orbit}.fragment", f"{orbit}.phantom", f"{orbit}.pad",
		f"{rats}.rat", f"{rats}.model", f"{rats}.cage", f"{rats}.carried", f"{rats}.caged",
		f"{ns}.pr_stoupy.villager", DOOR_TAG,
	]
	kills: str = "\n".join(f"$kill @e[tag={entity_tag},distance=..$(radius)]" for entity_tag in entity_tags)

	write_function(f"{root}/here/clear", f"""
# The stops of each trial give the players their state back, the kills then take everything else, setup included
$execute as @e[type=minecraft:mannequin,tag={duo}.body,distance=..$(radius)] at @s run function {root}/duo/body/stop
$execute as @a[tag={mirror},distance=..$(radius)] at @s run function {root}/mirror/here/stop
$execute as @e[type=minecraft:marker,tag={breakout}.corner,distance=..$(radius)] run function {root}/breakout/stop_corner
$execute as @e[type=minecraft:marker,tag={orbit}.hole,distance=..$(radius)] run function {root}/orbit/stop_hole
$execute as @e[type=minecraft:marker,tag={rats}.cage,distance=..$(radius)] at @s run function {root}/rats/here/stop
$execute as @e[type=minecraft:marker,tag={DOOR_TAG},distance=..$(radius)] at @s run function {root}/door/open with entity @s data

{kills}
$tellraw @a[distance=..16] {{"text":"Laboratoire : tout est supprimé à $(radius) blocs.","color":"green"}}
""")


