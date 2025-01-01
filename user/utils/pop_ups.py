
# Imports
from python_datapack.constants import *
from python_datapack.utils.print import *
from python_datapack.utils.io import *

# Constants
LABELS: list[str] = ["Confort", "Immunité", "Conseil"]
TIMES: list[str] = ["dans 30 minutes", "dans 10 minutes", "dans 5 minutes", "maintenant"]

# Generates pop-ups
def main(config: dict) -> None:
	namespace: str = config["namespace"]
	advancements: str = f"{config['build_datapack']}/data/{namespace}/advancement"
	all_paths: list[str] = []

	# Define the pop-ups
	from itertools import product
	for label, remaining_time in product(LABELS, TIMES):
		cleaned: str = label.replace("é", "e") + "_" + remaining_time
		cleaned = cleaned.lower().replace(" ", "_")
		advancement_path: str = f"{advancements}/pop_ups/{cleaned}.json"
		all_paths.append(f"{namespace}:pop_ups/{cleaned}")

		adv: dict = {
	"display": {
		"icon": {
			"id": "minecraft:stone",
			"components": {
				"minecraft:item_model": "survisland:icon"
			}
		},
		"title": {"text":f"{label} {remaining_time}","color":"aqua"},
		"description": "",
		"frame": "task",
		"show_toast": True,
		"announce_to_chat": False,
		"hidden": True,
	},
	"criteria": {
		"requirement": {
			"trigger": "minecraft:impossible"
		}
	},
	"rewards": {
		"function": "survisland:advancements/pop_ups"
	}
}
		# Write the advancement
		write_to_file(advancement_path, super_json_dump(adv))

	# Write the rewards function that
	tellraws: str = '\n'.join([
		f'tellraw @s[advancements={{{cleaned}=true}}] [{{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true}},{{"text":" {label} {remaining_time} !","color":"aqua"}}]'
		for cleaned, (label, remaining_time) in zip(all_paths, product(LABELS, TIMES))
	])
	write_to_function(config, f"{namespace}:advancements/pop_ups", f"""
# Revoke all pop-ups
schedule function {namespace}:advancements/pop_ups_revoke 1s replace

# Tellraw
{tellraws}

# Playsound
playsound ui.toast.in
playsound ui.toast.in
playsound ui.toast.in
playsound ui.toast.in
""")
	revokes: str = '\n'.join([f"advancement revoke @a only {path}" for path in all_paths])
	write_to_function(config, f"{namespace}:advancements/pop_ups_revoke", revokes)
	


