
# Imports
from stewbeet import Item


# Main function should return a database
def main() -> None:

	obj = Item(
		id="pendent",
		components={
			"lore": [{"text":"[Seconde main pour l'équiper]","italic":False,"color":"gray"}],
			"max_stack_size": 64
		},
		override_model={
			"parent": "item/handheld",
			"display": {
				"thirdperson_righthand": { "translation": [-1.75, 2, 1.5], "scale": [0.5, 0.5, 0.5] },
				"thirdperson_lefthand": { "scale": [0, 0, 0] },
				"firstperson_righthand": { "translation": [0, 3, 0], "scale": [0.75, 0.75, 0.75] },
				"firstperson_lefthand": { "translation": [0, 3, 0], "scale": [0, 0, 0] },
				"gui": { "translation": [0, 0.5, 0] },
				"fixed": { "translation": [0, 0.75, 0], "scale": [1.25, 1.25, 1.25] }
			}
		}
	)

	Item(
		id="pendent_held",
		components=obj.components.copy(),
		override_model={
			"parent": "item/handheld",
			"display": {
				"thirdperson_righthand": { "scale": [0, 0, 0] },
				"thirdperson_lefthand": { "rotation": [68, 0, 0], "translation": [-5.75, 0.5, 6.5], "scale": [0.66, 0.66, 0.66] },
				"firstperson_righthand": { "translation": [0, 3, 0], "scale": [0, 0, 0] },
				"firstperson_lefthand": { "translation": [0, 3, 0], "scale": [0, 0, 0] },
				"head": { "translation": [0, -14.25, -5], "scale": [1.1, 1.1, 1.1] },
				"fixed": { "translation": [0, 0.75, 0], "scale": [1.25, 1.25, 1.25] }
			}
		}
	)

