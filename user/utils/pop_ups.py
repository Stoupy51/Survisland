
# Imports
from stewbeet import Advancement, Mem, set_json_encoder, write_function

# Constants
LABELS: list[str] = ["Confort", "Immunité", "Conseil"]
TIMES: list[str] = [f"dans {x} minutes" for x in range(5, 61, 5)] + ["maintenant"]

# Generates pop-ups
def main() -> None:
	ns: str = Mem.ctx.project_id
	all_paths: list[str] = []

	# Define the pop-ups
	from itertools import product
	for label, remaining_time in product(LABELS, TIMES):
		cleaned: str = label.replace("é", "e") + "_" + remaining_time
		cleaned = cleaned.lower().replace(" ", "_")
		all_paths.append(f"{ns}:pop_ups/{cleaned}")

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
		Mem.ctx.data[ns].advancements[f"pop_ups/{cleaned}"] = set_json_encoder(Advancement(adv))

	# Write the rewards function that
	tellraws: str = '\n'.join([
		f'tellraw @s[advancements={{{cleaned}=true}}] [{{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true}},{{"text":" {label} {remaining_time} !","color":"aqua"}}]'
		for cleaned, (label, remaining_time) in zip(all_paths, product(LABELS, TIMES), strict=False)
	])
	write_function(f"{ns}:advancements/pop_ups", f"""
# Revoke all pop-ups
schedule function {ns}:advancements/pop_ups_revoke 1s replace

# Tellraw
{tellraws}

# Playsound
playsound ui.toast.in
playsound ui.toast.in
playsound ui.toast.in
playsound ui.toast.in
""")
	revokes: str = '\n'.join([f"advancement revoke @a only {path}" for path in all_paths])
	write_function(f"{ns}:advancements/pop_ups_revoke", revokes)

