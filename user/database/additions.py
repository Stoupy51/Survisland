
# Imports
from python_datapack.utils.database_helper import *

# Main function should return a database
def main(config: dict) -> dict[str, dict]:

	# Setup database
	database: dict[str,dict] = {
		"laser_gun": {
			"id": "minecraft:warped_fungus_on_a_stick",
		},
		"parchemin": {
			"id": "minecraft:warped_fungus_on_a_stick",
			"item_name": '{"text":"Default vote","italic":false,"color":"red"}',
			"lore":['[{"text":"Auteur : ","italic":false,"color":"gold"},{"text":"Stoupy51","color":"yellow"}]'],
			OVERRIDE_MODEL: {
				"parent": "item/handheld",
				"display": {
					"thirdperson_righthand": { "scale": [0.5, 0.5, 0.5] },
					"thirdperson_lefthand": { "scale": [0.5, 0.5, 0.5] },
					"firstperson_righthand": { "scale": [0.5, 0.5, 0.5] },
					"firstperson_lefthand": { "scale": [0.5, 0.5, 0.5] },
					"ground": { "scale": [0.5, 0.5, 0.5] },
					"head": { "scale": [1.1, 1.1, 1.1] },
				},
			},
		},
		"deployed_parchemin": {
			"id": "minecraft:warped_fungus_on_a_stick",
			OVERRIDE_MODEL: {
				"textures": {
					"layer0": "survisland:item/parchemin"
				},
				"elements": [
					{
						"from": [1, 2, 7],
						"to": [3, 14, 9],
						"faces": {
							"north": {"uv": [9.96875, 1.3125, 11.96875, 14.65625], "texture": "#layer0"},
							"east": {"uv": [9.96875, 1.3125, 11.96875, 14.65625], "texture": "#layer0"},
							"south": {"uv": [9.96875, 1.3125, 11.96875, 14.65625], "texture": "#layer0"},
							"west": {"uv": [9.96875, 1.3125, 11.96875, 14.65625], "texture": "#layer0"},
							"up": {"uv": [8.875, 1.25, 9.375, 1.375], "texture": "#layer0"},
							"down": {"uv": [8.875, 1.25, 9.375, 1.375], "texture": "#layer0"}
						}
					},
					{
						"from": [13, 2, 7],
						"to": [15, 14, 9],
						"faces": {
							"north": {"uv": [9.96875, 1.3125, 11.96875, 14.65625], "texture": "#layer0"},
							"east": {"uv": [9.96875, 1.3125, 11.96875, 14.65625], "texture": "#layer0"},
							"south": {"uv": [9.96875, 1.3125, 11.96875, 14.65625], "texture": "#layer0"},
							"west": {"uv": [9.96875, 1.3125, 11.96875, 14.65625], "texture": "#layer0"},
							"up": {"uv": [8.875, 1.25, 9.375, 1.375], "texture": "#layer0"},
							"down": {"uv": [8.875, 1.25, 9.375, 1.375], "texture": "#layer0"}
						}
					},
					{
						"from": [0, 2, 8],
						"to": [16, 14, 8],
						"faces": {
							"north": {"uv": [0, 0, 16, 16], "texture": "#layer0"},
							"east": {"uv": [16, 16, 16, 16], "texture": "#layer0"},
							"south": {"uv": [0, 0, 16, 16], "texture": "#layer0"},
							"west": {"uv": [16, 16, 16, 16], "texture": "#layer0"},
							"up": {"uv": [16, 16, 16, 16], "texture": "#layer0"},
							"down": {"uv": [16, 16, 16, 16], "texture": "#layer0"}
						}
					}
				],
				"display": {
					"thirdperson_righthand": {
						"scale": [0.5, 0.5, 0.5]
					},
					"thirdperson_lefthand": {
						"scale": [0.5, 0.5, 0.5]
					},
					"firstperson_righthand": {
						"scale": [0.5, 0.5, 0.5]
					},
					"firstperson_lefthand": {
						"scale": [0.5, 0.5, 0.5]
					},
					"ground": {
						"scale": [0.5, 0.5, 0.5]
					},
					"head": {
						"scale": [1.1, 1.1, 1.1]
					}
				}
			}
		},
		"snuffer": {
			"id": "minecraft:warped_fungus_on_a_stick",
			"lore": [
				'[{"text":"Clic-droit pour éteindre la torche","italic":false,"color":"gray"}]',
				'[{"text":"du joueur le plus proche","italic":false,"color":"gray"}]'
			],
			OVERRIDE_MODEL: {
				"elements": [
					{
						"from":[7,0,7],
						"to":[9,7,9],
						"rotation":{"angle":0,"axis":"y","origin":[8,0,8]},
						"faces":{
							"north":{"uv":[8,9,10,16],"texture":"#layer0"},
							"east":{"uv":[10,9,12,16],"texture":"#layer0"},
							"south":{"uv":[14,9,16,16],"texture":"#layer0"},
							"west":{"uv":[12,9,14,16],"texture":"#layer0"},
							"up":{"uv":[6,12,8,14],"texture":"#layer0"},
							"down":{"uv":[6,14,8,16],"texture":"#layer0"}
						}
					},
					{
						"from":[6.5,6.75,6.5],
						"to":[14.5,8.75,9.5],
						"rotation":{"angle":0,"axis":"y","origin":[8,0,8]},
						"faces":{
							"north":{"uv":[0,14,8,16],"texture":"#layer0"},
							"east":{"uv":[7,12,11,14],"texture":"#layer0"},
							"south":{"uv":[8,14,16,16],"texture":"#layer0"},
							"west":{"uv":[7,12,11,14],"texture":"#layer0"},
							"up":{"uv":[0,4,9,8],"texture":"#layer0"},
							"down":{"uv":[0,0,9,4],"texture":"#layer0"}
						}
					},
					{
						"from":[6.75,8.75,6.75],
						"to":[14.25,9.5,9.25],
						"rotation":{"angle":0,"axis":"y","origin":[8,0,8]},
						"faces":{
							"north":{"uv":[0,15,8,16],"texture":"#layer0"},
							"east":{"uv":[0,14,8,15],"texture":"#layer0"},
							"south":{"uv":[8,15,16,16],"texture":"#layer0"},
							"west":{"uv":[8,14,16,15],"texture":"#layer0"},
							"up":{"uv":[0,0,9,4],"texture":"#layer0"},
							"down":{"uv":[0,4,9,8],"texture":"#layer0"}
						}
					},
					{
						"from":[9,5.75,7.25],
						"to":[9.5,7.5,8.75],
						"rotation":{"angle":0,"axis":"y","origin":[8,0,8]},
						"faces":{
							"north":{"uv":[6,13,7,16],"texture":"#layer0"},
							"east":{"uv":[9,13,12,16],"texture":"#layer0"},
							"south":{"uv":[7,13,8,16],"texture":"#layer0"},
							"west":{"uv":[13,13,16,16],"texture":"#layer0"},
							"up":{"uv":[10,8,11,5],"texture":"#layer0"},
							"down":{"uv":[9,8,10,5],"texture":"#layer0"}
						}
					},
					{
						"from":[12.25,5.75,8.75],
						"to":[14.25,7.5,9.25],
						"rotation":{"angle":0,"axis":"y","origin":[8,0,8]},
						"faces":{
							"north":{"uv":[8,13,12,16],"texture":"#layer0"},
							"east":{"uv":[7,13,8,16],"texture":"#layer0"},
							"south":{"uv":[12,13,16,16],"texture":"#layer0"},
							"west":{"uv":[4,13,5,16],"texture":"#layer0"},
							"up":{"uv":[10,12,13,13],"texture":"#layer0"},
							"down":{"uv":[13,12,16,13],"texture":"#layer0"}
						}
					},
					{
						"from":[12.25,5.75,6.75],
						"to":[14.25,7.5,7.25],
						"rotation":{"angle":0,"axis":"y","origin":[8,0,8]},
						"faces":{
							"north":{"uv":[8,13,12,16],"texture":"#layer0"},
							"east":{"uv":[7,13,8,16],"texture":"#layer0"},
							"south":{"uv":[12,13,16,16],"texture":"#layer0"},
							"west":{"uv":[4,13,5,16],"texture":"#layer0"},
							"up":{"uv":[10,12,13,13],"texture":"#layer0"},
							"down":{"uv":[13,12,16,13],"texture":"#layer0"}
						}
					},
					{
						"from":[11.75,5.75,6.75],
						"to":[12.25,7.5,9.25],
						"rotation":{"angle":0,"axis":"y","origin":[8,0,8]},
						"faces":{
							"north":{"uv":[4,13,5,16],"texture":"#layer0"},
							"east":{"uv":[6,13,11,16],"texture":"#layer0"},
							"south":{"uv":[5,13,6,16],"texture":"#layer0"},
							"west":{"uv":[11,13,16,16],"texture":"#layer0"},
							"up":{"uv":[10,8,11,5],"texture":"#layer0"},
							"down":{"uv":[9,8,10,5],"texture":"#layer0"}
						}
					},
					{
						"from":[13.75,5.75,7.25],
						"to":[14.25,7.5,8.75],
						"rotation":{"angle":0,"axis":"y","origin":[8,0,8]},
						"faces":{
							"north":{"uv":[6,13,7,16],"texture":"#layer0"},
							"east":{"uv":[9,13,12,16],"texture":"#layer0"},
							"south":{"uv":[7,13,8,16],"texture":"#layer0"},
							"west":{"uv":[13,13,16,16],"texture":"#layer0"},
							"up":{"uv":[10,8,11,5],"texture":"#layer0"},
							"down":{"uv":[9,8,10,5],"texture":"#layer0"}
						}
					}
				],
				"display":{
					"thirdperson_righthand":{"rotation":[0,90,25],"translation":[0,6.25,5]},
					"thirdperson_lefthand":{"rotation":[0,90,25],"translation":[0,6.25,5]},
					"firstperson_righthand":{"rotation":[0,90,0],"translation":[0,3.25,-1.25]},
					"firstperson_lefthand":{"rotation":[0,-90,0],"translation":[0,3.25,-1.25]},
					"ground":{"translation":[0,4,0]},
					"gui":{"rotation":[45,0,30],"translation":[-1.75,2.5,0],"scale":[1.5,1.5,1.5]},
					"head":{"translation":[0,14,0]},"fixed":{"translation":[0,4,0],"scale":[1.5,1.5,1.5]}
				},
				"groups":[0,1,2,3,{"name":"group","origin":[8,0,8],"color":0,"nbt":"{}","armAnimationEnabled":False,"children":[4,5,6,7]}]
			},
		},
		"flambeau": {
			"id": "minecraft:warped_fungus_on_a_stick",
			"lore": ['{"text":"Gardez cette torche précieusement","italic":false,"color":"gray"}'],
			OVERRIDE_MODEL: {
				"elements": [
					{
						"from": [7, 0, 7],
						"to": [9, 7, 9],
						"rotation": {"angle": 0, "axis": "y", "origin": [8, 0, 8]},
						"faces": {
							"north": {"uv": [7, 9, 9, 16], "texture": "#layer0"},
							"east": {"uv": [7, 9, 9, 16], "texture": "#layer0"},
							"south": {"uv": [7, 9, 9, 16], "texture": "#layer0"},
							"west": {"uv": [7, 9, 9, 16], "texture": "#layer0"},
							"up": {"uv": [7, 8, 9, 10], "texture": "#layer0"},
							"down": {"uv": [7, 8, 9, 10], "texture": "#layer0"}
						}
					},
					{
						"from": [6.5, 6.75, 6.5],
						"to": [9.5, 8.75, 9.5],
						"rotation": {"angle": 0, "axis": "y", "origin": [8, 0, 8]},
						"faces": {
							"north": {"uv": [7, 6, 9, 7], "rotation": 180, "texture": "#layer0"},
							"east": {"uv": [7, 6, 9, 7], "rotation": 180, "texture": "#layer0"},
							"south": {"uv": [7, 6, 9, 7], "rotation": 180, "texture": "#layer0"},
							"west": {"uv": [7, 6, 9, 7], "rotation": 180, "texture": "#layer0"},
							"up": {"uv": [7, 6, 9, 8], "texture": "#layer0"},
							"down": {"uv": [7, 6, 9, 8], "texture": "#layer0"}
						}
					},
					{
						"from": [6.75, 8.75, 6.75],
						"to": [9.25, 10.5, 9.25],
						"rotation": {"angle": 0, "axis": "y", "origin": [8, 0, 8]},
						"faces": {
							"north": {"uv": [7, 6, 9, 7], "texture": "#layer0"},
							"east": {"uv": [7, 6, 9, 7], "texture": "#layer0"},
							"south": {"uv": [7, 6, 9, 7], "texture": "#layer0"},
							"west": {"uv": [7, 6, 9, 7], "texture": "#layer0"},
							"up": {"uv": [7, 6, 9, 8], "texture": "#layer0"},
							"down": {"uv": [7, 6, 9, 7], "texture": "#layer0"}
						}
					},
					{
						"from": [6, 6.25, 7.19],
						"to": [7, 8.25, 7.94],
						"rotation": {"angle": 0, "axis": "y", "origin": [8, 0, 8]},
						"faces": {
							"north": {"uv": [1, 14, 2, 16], "texture": "#layer0"},
							"east": {"uv": [1, 14, 1.75, 16], "texture": "#layer0"},
							"south": {"uv": [1, 14, 2, 16], "texture": "#layer0"},
							"west": {"uv": [1, 14, 1.75, 16], "texture": "#layer0"},
							"up": {"uv": [1, 14, 2, 14.75], "texture": "#layer0"},
							"down": {"uv": [1, 14, 2, 14.75], "texture": "#layer0"}
						}
					},
					{
						"from": [6, 6.25, 8.135],
						"to": [7, 8.25, 8.885],
						"rotation": {"angle": 0, "axis": "y", "origin": [8, 0, 8]},
						"faces": {
							"north": {"uv": [1, 14, 2, 16], "texture": "#layer0"},
							"east": {"uv": [1, 14, 1.75, 16], "texture": "#layer0"},
							"south": {"uv": [1, 14, 2, 16], "texture": "#layer0"},
							"west": {"uv": [1, 14, 1.75, 16], "texture": "#layer0"},
							"up": {"uv": [1, 14, 2, 14.75], "texture": "#layer0"},
							"down": {"uv": [1, 14, 2, 14.75], "texture": "#layer0"}
						}
					},
					{
						"from": [9, 6.25, 7.19],
						"to": [10, 8.25, 7.94],
						"rotation": {"angle": 0, "axis": "y", "origin": [8, 0, 8]},
						"faces": {
							"north": {"uv": [1, 14, 2, 16], "texture": "#layer0"},
							"east": {"uv": [1, 14, 1.75, 16], "texture": "#layer0"},
							"south": {"uv": [1, 14, 2, 16], "texture": "#layer0"},
							"west": {"uv": [1, 14, 1.75, 16], "texture": "#layer0"},
							"up": {"uv": [1, 14, 2, 14.75], "texture": "#layer0"},
							"down": {"uv": [1, 14, 2, 14.75], "texture": "#layer0"}
						}
					},
					{
						"from": [9, 6.25, 8.135],
						"to": [10, 8.25, 8.885],
						"rotation": {"angle": 0, "axis": "y", "origin": [8, 0, 8]},
						"faces": {
							"north": {"uv": [1, 14, 2, 16], "texture": "#layer0"},
							"east": {"uv": [1, 14, 1.75, 16], "texture": "#layer0"},
							"south": {"uv": [1, 14, 2, 16], "texture": "#layer0"},
							"west": {"uv": [1, 14, 1.75, 16], "texture": "#layer0"},
							"up": {"uv": [1, 14, 2, 14.75], "texture": "#layer0"},
							"down": {"uv": [1, 14, 2, 14.75], "texture": "#layer0"}
						}
					},
					{
						"from": [8.06, 6.25, 6],
						"to": [8.81, 8.25, 7],
						"rotation": {"angle": 0, "axis": "y", "origin": [8, 0, 8]},
						"faces": {
							"north": {"uv": [1, 14, 1.75, 16], "texture": "#layer0"},
							"east": {"uv": [1, 14, 2, 16], "texture": "#layer0"},
							"south": {"uv": [1, 14, 1.75, 16], "texture": "#layer0"},
							"west": {"uv": [1, 14, 2, 16], "texture": "#layer0"},
							"up": {"uv": [1, 14, 2, 14.75], "rotation": 90, "texture": "#layer0"},
							"down": {"uv": [1, 14, 2, 14.75], "rotation": 270, "texture": "#layer0"}
						}
					},
					{
						"from": [7.115, 6.25, 6],
						"to": [7.865, 8.25, 7],
						"rotation": {"angle": 0, "axis": "y", "origin": [8, 0, 8]},
						"faces": {
							"north": {"uv": [1, 14, 1.75, 16], "texture": "#layer0"},
							"east": {"uv": [1, 14, 2, 16], "texture": "#layer0"},
							"south": {"uv": [1, 14, 1.75, 16], "texture": "#layer0"},
							"west": {"uv": [1, 14, 2, 16], "texture": "#layer0"},
							"up": {"uv": [1, 14, 2, 14.75], "rotation": 90, "texture": "#layer0"},
							"down": {"uv": [1, 14, 2, 14.75], "rotation": 270, "texture": "#layer0"}
						}
					},
					{
						"from": [8.06, 6.25, 9],
						"to": [8.81, 8.25, 10],
						"rotation": {"angle": 0, "axis": "y", "origin": [8, 0, 8]},
						"faces": {
							"north": {"uv": [1, 14, 1.75, 16], "texture": "#layer0"},
							"east": {"uv": [1, 14, 2, 16], "texture": "#layer0"},
							"south": {"uv": [1, 14, 1.75, 16], "texture": "#layer0"},
							"west": {"uv": [1, 14, 2, 16], "texture": "#layer0"},
							"up": {"uv": [1, 14, 2, 14.75], "rotation": 90, "texture": "#layer0"},
							"down": {"uv": [1, 14, 2, 14.75], "rotation": 270, "texture": "#layer0"}
						}
					},
					{
						"from": [7.115, 6.25, 9],
						"to": [7.865, 8.25, 10],
						"rotation": {"angle": 0, "axis": "y", "origin": [8, 0, 8]},
						"faces": {
							"north": {"uv": [1, 14, 1.75, 16], "texture": "#layer0"},
							"east": {"uv": [1, 14, 2, 16], "texture": "#layer0"},
							"south": {"uv": [1, 14, 1.75, 16], "texture": "#layer0"},
							"west": {"uv": [1, 14, 2, 16], "texture": "#layer0"},
							"up": {"uv": [1, 14, 2, 14.75], "rotation": 90, "texture": "#layer0"},
							"down": {"uv": [1, 14, 2, 14.75], "rotation": 270, "texture": "#layer0"}
						}
					}
				],
				"display": {
					"thirdperson_righthand": {
						"rotation": [0, 90, 25],
						"translation": [0, 6.25, 5]
					},
					"thirdperson_lefthand": {
						"rotation": [0, 90, 25],
						"translation": [0, 6.25, 5]
					},
					"firstperson_righthand": {
						"rotation": [0, 90, 0],
						"translation": [0, 3.25, -1.25]
					},
					"firstperson_lefthand": {
						"rotation": [0, -90, 0],
						"translation": [0, 3.25, -1.25]
					},
					"ground": {
						"translation": [0, 4, 0]
					},
					"gui": {
						"rotation": [45, 0, 30],
						"translation": [-1.75, 2.5, 0],
						"scale": [1.5, 1.5, 1.5]
					},
					"head": {
						"translation": [0, 14, 0]
					},
					"fixed": {
						"translation": [0, 4, 0],
						"scale": [1.5, 1.5, 1.5]
					}
				},
				"groups": [
					0,
					1,
					2,
					{
						"name": "side",
						"origin": [8, 0, 8],
						"color": 0,
						"nbt": "{}",
						"armAnimationEnabled": False,
						"children": [3, 4]
					},
					{
						"name": "side",
						"origin": [8, 0, 8],
						"color": 0,
						"nbt": "{}",
						"armAnimationEnabled": False,
						"children": [5, 6]
					},
					{
						"name": "side",
						"origin": [8, 0, 8],
						"color": 0,
						"nbt": "{}",
						"armAnimationEnabled": False,
						"children": [7, 8]
					},
					{
						"name": "side",
						"origin": [8, 0, 8],
						"color": 0,
						"nbt": "{}",
						"armAnimationEnabled": False,
						"children": [9, 10]
					}
				]
			}
		},
		"necklace": {
			"id": "minecraft:warped_fungus_on_a_stick",
			"lore": ['{"text":"[Seconde main pour l\'équiper]","italic":false,"color":"gray"}'],
			OVERRIDE_MODEL: {
				"parent": "item/handheld",
				"display": {
					"thirdperson_righthand": {
						"scale": [0.5, 0.5, 0.5]
					},
					"thirdperson_lefthand": {
						"rotation": [68, 0, 0],
						"translation": [-6, 0.25, 5.75],
						"scale": [0.66, 0.66, 0.66]
					},
					"firstperson_righthand": {
						"translation": [0, 3, 0],
						"scale": [0.5, 0.5, 0.5]
					},
					"firstperson_lefthand": {
						"translation": [0, 3, 0],
						"scale": [0.5, 0.5, 0.5]
					},
					"gui": {
						"translation": [0, 0.5, 0]
					},
					"head": {
						"translation": [0, -14.25, -5.75],
						"scale": [1.1, 1.1, 1.1]
					},
					"fixed": {
						"translation": [0, 0.75, 0],
						"scale": [1.25, 1.25, 1.25]
					}
				}
			}
		},
		"pendent": {
			"id": "minecraft:warped_fungus_on_a_stick",
			"lore": ['{"text":"[Seconde main pour l\'équiper]","italic":false,"color":"gray"}'],
			OVERRIDE_MODEL: {
				"parent": "item/handheld",
				"display": {
					"thirdperson_righthand": {
						"translation": [-1.75, 2, 1.5],
						"scale": [0.5, 0.5, 0.5]
					},
					"thirdperson_lefthand": {
						"scale": [0, 0, 0]
					},
					"firstperson_righthand": {
						"translation": [0, 3, 0],
						"scale": [0.75, 0.75, 0.75]
					},
					"firstperson_lefthand": {
						"translation": [0, 3, 0],
						"scale": [0, 0, 0]
					},
					"gui": {
						"translation": [0, 0.5, 0]
					},
					"fixed": {
						"translation": [0, 0.75, 0],
						"scale": [1.25, 1.25, 1.25]
					}
				}
			}
		},
		"pendent_held": {
			"id": "minecraft:warped_fungus_on_a_stick",
			"lore": ['{"text":"[Seconde main pour l\'équiper]","italic":false,"color":"gray"}'],
			OVERRIDE_MODEL: {
				"parent": "item/handheld",
				"display": {
					"thirdperson_righthand": {
						"scale": [0, 0, 0]
					},
					"thirdperson_lefthand": {
						"rotation": [68, 0, 0],
						"translation": [-5.75, 0.5, 6.5],
						"scale": [0.66, 0.66, 0.66]
					},
					"firstperson_righthand": {
						"translation": [0, 3, 0],
						"scale": [0, 0, 0]
					},
					"firstperson_lefthand": {
						"translation": [0, 3, 0],
						"scale": [0, 0, 0]
					},
					"head": {
						"translation": [0, -14.25, -5],
						"scale": [1.1, 1.1, 1.1]
					},
					"fixed": {
						"translation": [0, 0.75, 0],
						"scale": [1.25, 1.25, 1.25]
					}
				}
			}
		},
		"maple_leaf": {
			"id": CUSTOM_ITEM_VANILLA,
			"item_name": '{"text":"Feuille d\'érable","italic":false,"color":"gold"}',
		},
		"golden_leaf": {
			"id": CUSTOM_ITEM_VANILLA,
			"item_name": '{"text":"Feuille d\'or","italic":false,"color":"gold"}',
		},
		"temp_item": {
			"id": "minecraft:stone"
		},
	}

	# Add colored books
	books: list[str] = [x.replace('.png','') for x in config['textures_files'] if "book_" in x]
	for book in books:
		database[book] = {"id": "minecraft:written_book"}
	
	return database

