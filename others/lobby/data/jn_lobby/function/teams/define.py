
# Define.py : Ce script génère les fichiers .mcfunction pour les équipes
# ainsi que pour les joueurs qui appartiennent à une équipe

# Vérification de l'emplacement du script
import os
import sys

if os.getcwd() != os.path.dirname(os.path.realpath(__file__)):
	print("Please execute this script in the same folder as the script")
	sys.exit()

# Définition des fonctions
def create_teams_file(teams: list[tuple[str, str, int, str]]) -> None:
	""" Créer le fichier .mcfunction pour les équipes

	Args:
		teams: Liste des équipes, chacune sous la forme (nom, couleur, nb_joueurs, vanilla_color)
	"""
	with open("create_teams.mcfunction", "w", encoding="utf-8") as f:
		f.write("\n")
		f.write("## Création des équipes\n")
		f.write("\n")

		# Création des équipes
		for nom, couleur, _nb_joueurs, vanilla_color in teams:

			# Création d'une équipe "???" pour placement inconnu
			f.write(f'team add {nom}_x\n')
			f.write(f'team modify {nom}_x displayName {{"text":"{nom} - ???","color":"{couleur}"}}\n')
			f.write(f'team modify {nom}_x suffix {{"text":" [{nom} - ???]","color":"{couleur}"}}\n')
			f.write(f'team modify {nom}_x color {vanilla_color}\n')
			f.write("\n")

# Définition des équipes
create_teams_file([
	("S01", "#FA67FB", 18, "light_purple"),
	("S02", "#fd7839", 20, "gold"),
	("S03", "#5ee9f1", 18, "aqua"),
	("S04", "#209e26", 18, "dark_green"),
	("S05", "#f9e024", 21, "yellow"),
	("S06", "#fa2f2f", 18, "dark_red"),
	("S07", "#be6eee", 20, "dark_purple"),
	("S08", "#4ef158", 18, "green"),
	("S09", "#57c7c7", 18, "dark_aqua"),
	("S10", "#ff6868", 18, "red"),
	("S11", "#ee24a4", 21, "light_purple"),
	("S12", "#0240d1", 18, "dark_blue"),
	("S13", "#696969", 20, "gray"),
	("S14", "#ffb8cc", 20, "light_purple"),
	("S15", "#006910", 21, "dark_green"),
	("S16", "#dab10e", 21, "gold"),
	("S17", "#c31a0b", 18, "dark_red"),
	("S18", "#00ff9b", 18, "aqua"),
	("S19", "#d26d27", 20, "gold"),
	("S20", "#f6e9e9", 20, "white"),
	("S21", "#7d0606", 18, "dark_red"),
	("S22", "#d2c85f", 18, "yellow"),
	("S23", "#cbff6f", 21, "green"),
	("S24", "#712b99", 20, "dark_purple"),
	("S25", "#f5b47e", 20, "gold"),
	("S26", "#7d85ee", 18, "blue"),
	("S27", "#a7fff5", 21, "aqua"),
	("S28", "#f9ec8b", 21, "yellow"),
	("S29", "#ea1ae2", 18, "light_purple"),
	("S30", "#d21a41", 20, "red"),
	("S31", "#32dc2d", 21, "green"),
	("S32", "#ffc857", 20, "yellow"),
])

