
# ruff: noqa: E501
# Imports
import os

from stewbeet import CUSTOM_ITEM_VANILLA, Ingr, Item, Mem, SmeltingRecipe, SmokingRecipe


# Main function should return a database
def main() -> None:
	ns: str = Mem.ctx.project_id

	# Setup database - Items now auto-register in Mem.definitions
	Item(id="icon", base_item=CUSTOM_ITEM_VANILLA)

	Item(
		id="laser_gun",
		components={"max_stack_size": 64}
	)

	Item(
		id="parchemin",
		base_item="minecraft:warped_fungus_on_a_stick",
		components={
			"custom_name": {"text":"Default vote","italic":False,"color":"red"},
			"lore":[{"text":"Auteur : ","italic":False,"color":"gold"},{"text":"Stoupypy","color":"yellow"}]
		},
		override_model={
			"parent": "item/handheld",
			"display": {
				"thirdperson_righthand": { "scale": [0.5, 0.5, 0.5] },
				"thirdperson_lefthand": { "scale": [0.5, 0.5, 0.5] },
				"firstperson_righthand": { "scale": [0.5, 0.5, 0.5] },
				"firstperson_lefthand": { "scale": [0.5, 0.5, 0.5] },
				"ground": { "scale": [0.5, 0.5, 0.5] },
				"head": { "scale": [1.1, 1.1, 1.1] },
			},
		}
	)

	Item(
		id="deployed_parchemin",
		base_item="minecraft:warped_fungus_on_a_stick",
		override_model={
			"textures": {
				"layer0": "survisland:item/parchemin"
			},
			"elements": [
				{
					"from": [1, 2, 7],
					"to": [3, 14, 9],
					"faces": {
						"north": {"uv": [9.96875, 1.3125, 11.96875, 14.65625], "texture": "#layer0", "tintindex": 0},
						"east": {"uv": [9.96875, 1.3125, 11.96875, 14.65625], "texture": "#layer0", "tintindex": 0},
						"south": {"uv": [9.96875, 1.3125, 11.96875, 14.65625], "texture": "#layer0", "tintindex": 0},
						"west": {"uv": [9.96875, 1.3125, 11.96875, 14.65625], "texture": "#layer0", "tintindex": 0},
						"up": {"uv": [8.875, 1.25, 9.375, 1.375], "texture": "#layer0", "tintindex": 0},
						"down": {"uv": [8.875, 1.25, 9.375, 1.375], "texture": "#layer0", "tintindex": 0}
					}
				},
				{
					"from": [13, 2, 7],
					"to": [15, 14, 9],
					"faces": {
						"north": {"uv": [9.96875, 1.3125, 11.96875, 14.65625], "texture": "#layer0", "tintindex": 0},
						"east": {"uv": [9.96875, 1.3125, 11.96875, 14.65625], "texture": "#layer0", "tintindex": 0},
						"south": {"uv": [9.96875, 1.3125, 11.96875, 14.65625], "texture": "#layer0", "tintindex": 0},
						"west": {"uv": [9.96875, 1.3125, 11.96875, 14.65625], "texture": "#layer0", "tintindex": 0},
						"up": {"uv": [8.875, 1.25, 9.375, 1.375], "texture": "#layer0", "tintindex": 0},
						"down": {"uv": [8.875, 1.25, 9.375, 1.375], "texture": "#layer0", "tintindex": 0}
					}
				},
				{
					"from": [0, 2, 8],
					"to": [16, 14, 8],
					"faces": {
						"north": {"uv": [0, 0, 16, 16], "texture": "#layer0", "tintindex": 0},
						"east": {"uv": [16, 16, 16, 16], "texture": "#layer0", "tintindex": 0},
						"south": {"uv": [0, 0, 16, 16], "texture": "#layer0", "tintindex": 0},
						"west": {"uv": [16, 16, 16, 16], "texture": "#layer0", "tintindex": 0},
						"up": {"uv": [16, 16, 16, 16], "texture": "#layer0", "tintindex": 0},
						"down": {"uv": [16, 16, 16, 16], "texture": "#layer0", "tintindex": 0}
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
	)

	Item(
		id="snuffer",
		base_item="minecraft:warped_fungus_on_a_stick",
		components={
			"lore": [
				{"text":"Clic-droit pour éteindre la torche","italic":False,"color":"gray"},
				{"text":"du joueur le plus proche","italic":False,"color":"gray"}
			]
		},
		override_model={
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
				"thirdperson_lefthand":{"rotation":[0,-90,-25],"translation":[0,6.25,5]},
				"firstperson_righthand":{"rotation":[0,90,0],"translation":[0,3.25,-1.25]},
				"firstperson_lefthand":{"rotation":[0,-90,0],"translation":[0,3.25,-1.25]},
				"ground":{"translation":[0,4,0]},
				"gui":{"rotation":[45,0,30],"translation":[-1.75,2.5,0],"scale":[1.5,1.5,1.5]},
				"head":{"translation":[0,14,0]},"fixed":{"translation":[0,4,0],"scale":[1.5,1.5,1.5]}
			},
			"groups":[0,1,2,3,{"name":"group","origin":[8,0,8],"color":0,"nbt":"{}","armAnimationEnabled":False,"children":[4,5,6,7]}]
		},
	)

	Item(
		id="flambeau",
		components={
			"lore": [{"text":"Gardez cette torche précieusement","italic":False,"color":"gray"}],
			"max_stack_size": 64
		},
		override_model={
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
	)

	Item(
		id="pendent",
		components={
			"lore": [{"text":"[Seconde main pour l'équiper]","italic":False,"color":"gray"}],
			"max_stack_size": 64
		},
		override_model={
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
	)

	Item(
		id="pendent_held",
		components={
			"lore": [{"text":"[Seconde main pour l'équiper]","italic":False,"color":"gray"}],
			"max_stack_size": 64
		},
		override_model={
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
	)

	Item(
		id="maple_leaf",
		components={
			"item_name": {"text":"Feuille d'érable","italic":False,"color":"gold"},
			"max_stack_size": 64
		}
	)

	Item(
		id="golden_leaf",
		components={
			"item_name": {"text":"Feuille d'or","italic":False,"color":"gold"},
			"max_stack_size": 64
		}
	)

	Item(
		id="temp_item",
		components={"item_model": "air"}
	)

	Item(
		id="black_letter",
		base_item="minecraft:written_book"
	)

	Item(
		id="maracas",
		base_item="minecraft:diamond_sword",
		components={
			"lore": [{"text":"Made by M4TOUW","color":"gold","italic":False}],
			"equippable":{"slot":"chest","equip_sound":{"sound_id":"survisland:maracas"}}
		},
		override_model={"credit":"Made with Blockbench","textures":{"0":"minecraft:block/oak_planks","1":"minecraft:block/red_concrete","2":"minecraft:block/green_concrete","3":"minecraft:block/white_concrete","particle":"minecraft:block/oak_planks"},"elements":[{"from":[7,0,7],"to":[9,6,9],"rotation":{"angle":0,"axis":"y","origin":[6,1,7]},"faces":{"north":{"uv":[0,0,2,6],"texture":"#0"},"east":{"uv":[0,0,2,6],"texture":"#0"},"south":{"uv":[0,0,2,6],"texture":"#0"},"west":{"uv":[0,0,2,6],"texture":"#0"},"up":{"uv":[0,0,2,2],"texture":"#missing"},"down":{"uv":[0,0,2,2],"texture":"#0"}}},{"from":[6,9,6],"to":[10,10,10],"rotation":{"angle":0,"axis":"y","origin":[7,9,7]},"faces":{"north":{"uv":[0,0,4,1],"texture":"#1"},"east":{"uv":[0,0,4,1],"texture":"#1"},"south":{"uv":[0,0,4,1],"texture":"#1"},"west":{"uv":[0,0,4,1],"texture":"#1"},"up":{"uv":[0,0,4,4],"texture":"#1"},"down":{"uv":[0,0,4,4],"texture":"#missing"}}},{"from":[6,8,6],"to":[10,9,10],"rotation":{"angle":0,"axis":"y","origin":[7,8,7]},"faces":{"north":{"uv":[0,0,4,1],"texture":"#3"},"east":{"uv":[0,0,4,1],"texture":"#3"},"south":{"uv":[0,0,4,1],"texture":"#3"},"west":{"uv":[0,0,4,1],"texture":"#3"},"up":{"uv":[0,0,4,4],"texture":"#missing"},"down":{"uv":[0,0,4,4],"texture":"#missing"}}},{"from":[6,7,6],"to":[10,8,10],"rotation":{"angle":0,"axis":"y","origin":[7,7,7]},"faces":{"north":{"uv":[0,0,4,1],"texture":"#2"},"east":{"uv":[0,0,4,1],"texture":"#2"},"south":{"uv":[0,0,4,1],"texture":"#2"},"west":{"uv":[0,0,4,1],"texture":"#2"},"up":{"uv":[0,0,4,4],"texture":"#missing"},"down":{"uv":[0,0,4,4],"texture":"#missing"}}},{"from":[6,6,6],"to":[10,7,10],"rotation":{"angle":0,"axis":"y","origin":[7,6,7]},"faces":{"north":{"uv":[0,0,4,1],"texture":"#1"},"east":{"uv":[0,0,4,1],"texture":"#1"},"south":{"uv":[0,0,4,1],"texture":"#1"},"west":{"uv":[0,0,4,1],"texture":"#1"},"up":{"uv":[0,0,4,4],"texture":"#missing"},"down":{"uv":[0,0,4,4],"texture":"#1"}}}],"display":{"thirdperson_righthand":{"translation":[0.25,5,1.25]},"thirdperson_lefthand":{"translation":[0.25,5,1.25]},"firstperson_righthand":{"translation":[0.25,5,1.25]},"firstperson_lefthand":{"translation":[0.25,5,1.25]},"gui":{"translation":[0,2.5,0]},"head":{"rotation":[-90,0,0],"translation":[0.75,3.5,-3.25]}}}
	)

	Item(
		id="sombrero",
		components={
			"lore": [{"text":"Made by Fhara","color":"gold","italic":False}],
			"equippable":{"slot":"head"}
		},
		override_model={"credit":"Made with Blockbench","textures":{"0":f"{ns}:item/sombrero","particle":f"{ns}:item/sombrero"},"elements":[{"from":[13,1,2],"to":[15,2,14],"faces":{"north":{"uv":[0,4,2,5],"texture":"#0"},"east":{"uv":[0,0,12,1],"texture":"#0"},"south":{"uv":[0,4,2,5],"texture":"#0"},"west":{"uv":[0,2,10,3],"texture":"#0"},"up":{"uv":[0.5,4,2.5,16],"texture":"#0"},"down":{"uv":[0,4.5,2,15.5],"texture":"#0"}}},{"from":[1,1,2],"to":[3,2,14],"faces":{"north":{"uv":[0,4,2,5],"texture":"#0"},"east":{"uv":[0,2,10,3],"texture":"#0"},"south":{"uv":[0,4,2,5],"texture":"#0"},"west":{"uv":[0,0,12,1],"texture":"#0"},"up":{"uv":[2.5,4,0.5,16],"texture":"#0"},"down":{"uv":[2,4.5,0,15.5],"texture":"#0"}}},{"from":[3,1,13],"to":[13,2,15],"faces":{"north":{"uv":[0,2,10,3],"texture":"#0"},"east":{"uv":[0,4,2,5],"texture":"#0"},"south":{"uv":[1,0,11,1],"texture":"#0"},"west":{"uv":[0,4,2,5],"texture":"#0"},"up":{"uv":[0,3,10,1],"texture":"#0"},"down":{"uv":[0.5,1.5,9.5,3.5],"texture":"#0"}}},{"from":[3,1,1],"to":[13,2,3],"faces":{"north":{"uv":[1,0,11,1],"texture":"#0"},"east":{"uv":[0,4,2,5],"texture":"#0"},"south":{"uv":[0,2,10,3],"texture":"#0"},"west":{"uv":[0,4,2,5],"texture":"#0"},"up":{"uv":[0,1,10,3],"texture":"#0"},"down":{"uv":[0.5,3.5,9.5,1.5],"texture":"#0"}}},{"from":[12,0,3],"to":[13,1,13],"rotation":{"angle":0,"axis":"y","origin":[8,0,8]},"faces":{"north":{"uv":[15,15,16,16],"texture":"#0","tintindex":0},"east":{"uv":[5,15,15,16],"texture":"#0","tintindex":0},"south":{"uv":[21,15,22,16],"texture":"#0","tintindex":0},"west":{"uv":[6,14,16,15],"texture":"#0","tintindex":0},"up":{"uv":[16,14,15,6],"texture":"#0","tintindex":0},"down":{"uv":[6,4,5,14],"texture":"#0","tintindex":0}}},{"from":[3,0,3],"to":[4,1,13],"rotation":{"angle":0,"axis":"y","origin":[8,0,8]},"faces":{"north":{"uv":[15,15,16,16],"texture":"#0","tintindex":0},"east":{"uv":[6,14,16,15],"texture":"#0","tintindex":0},"south":{"uv":[21,15,22,16],"texture":"#0","tintindex":0},"west":{"uv":[5,15,15,16],"texture":"#0","tintindex":0},"up":{"uv":[15,14,16,6],"texture":"#0","tintindex":0},"down":{"uv":[5,3.5,6,13.5],"texture":"#0","tintindex":0}}},{"from":[4,0,3],"to":[12,1,4],"rotation":{"angle":0,"axis":"y","origin":[4,0,3]},"faces":{"north":{"uv":[6,15,14,16],"texture":"#0"},"east":{"uv":[15,15,16,16],"texture":"#0"},"south":{"uv":[7,7,15,8],"texture":"#0"},"west":{"uv":[15,15,16,16],"texture":"#0"},"up":{"uv":[6,16,14,15],"texture":"#0"},"down":{"uv":[7,15,15,14],"texture":"#0"}}},{"from":[4,0,12],"to":[12,1,13],"rotation":{"angle":0,"axis":"y","origin":[4,0,12]},"faces":{"north":{"uv":[7,14,15,15],"texture":"#0"},"east":{"uv":[15,15,16,16],"texture":"#0"},"south":{"uv":[6,15,14,16],"texture":"#0"},"west":{"uv":[15,15,16,16],"texture":"#0"},"up":{"uv":[6,15,14,16],"texture":"#0"},"down":{"uv":[7,14,15,15],"texture":"#0"}}},{"from":[4,1,4],"to":[12,3,12],"faces":{"north":{"uv":[7,5,15,7],"texture":"#0"},"east":{"uv":[7,5,15,7],"texture":"#0"},"south":{"uv":[7,5,15,7],"texture":"#0"},"west":{"uv":[7,5,15,7],"texture":"#0"},"up":{"uv":[7,7,15,15],"texture":"#0"},"down":{"uv":[7,7,15,15],"texture":"#0"}}},{"from":[5,3,5],"to":[11,4,11],"faces":{"north":{"uv":[10,4,16,5],"texture":"#0"},"east":{"uv":[10,4,16,5],"texture":"#0"},"south":{"uv":[10,4,16,5],"texture":"#0"},"west":{"uv":[10,4,16,5],"texture":"#0"},"up":{"uv":[8,8,14,14],"texture":"#0"},"down":{"uv":[8,8,14,14],"texture":"#0"}}},{"from":[6,4,6],"to":[10,6,10],"faces":{"north":{"uv":[3,13,7,15],"texture":"#0"},"east":{"uv":[3,13,7,15],"texture":"#0"},"south":{"uv":[3,13,7,15],"texture":"#0"},"west":{"uv":[3,13,7,15],"texture":"#0"},"up":{"uv":[3,9,7,13],"texture":"#0"},"down":{"uv":[3,9,7,13],"texture":"#0"}}},{"from":[7,4,5],"to":[9,6,11],"faces":{"north":{"uv":[14,0,16,2],"texture":"#0"},"east":{"uv":[10,2,16,4],"texture":"#0"},"south":{"uv":[14,0,16,2],"texture":"#0"},"west":{"uv":[10,2,16,4],"texture":"#0"},"up":{"uv":[5,7,7,13],"texture":"#0"},"down":{"uv":[7,14,5,8],"texture":"#0"}}},{"from":[5,4,7],"to":[11,6,9],"faces":{"north":{"uv":[10,2,16,4],"texture":"#0"},"east":{"uv":[14,0,16,2],"texture":"#0"},"south":{"uv":[10,2,16,4],"texture":"#0"},"west":{"uv":[14,0,16,2],"texture":"#0"},"up":{"uv":[2.5,7,5,9],"texture":"#0"},"down":{"uv":[10,2,16,4],"texture":"#0"}}},{"from":[7,6,6],"to":[9,7,10],"faces":{"north":{"uv":[12,0,14,1],"texture":"#0"},"east":{"uv":[10,1,14,2],"texture":"#0"},"south":{"uv":[12,0,14,1],"texture":"#0"},"west":{"uv":[10,1,14,2],"texture":"#0"},"up":{"uv":[5,5,7,9],"texture":"#0"},"down":{"uv":[5,5,7,9],"texture":"#0"}}},{"from":[6,6,7],"to":[10,7,9],"faces":{"north":{"uv":[10,1,14,2],"texture":"#0"},"east":{"uv":[12,0,14,1],"texture":"#0"},"south":{"uv":[10,1,14,2],"texture":"#0"},"west":{"uv":[12,0,14,1],"texture":"#0"},"up":{"uv":[2.5,7,6.5,9],"texture":"#0"},"down":{"uv":[12,2,16,4],"texture":"#0"}}}],"display":{"thirdperson_righthand":{"rotation":[-48,-12,-67],"translation":[7.25,4.75,-2.5],"scale":[-1,1,1]},"thirdperson_lefthand":{"rotation":[-48,-12,-67],"translation":[7.25,4.75,-2.5]},"firstperson_righthand":{"translation":[0,2.5,0]},"firstperson_lefthand":{"translation":[0,2.5,0]},"ground":{"translation":[0,4,0]},"gui":{"rotation":[25,15,0],"translation":[0,4.5,0],"scale":[0.9,0.9,0.9]},"head":{"translation":[0,17.5,0],"scale":[2.0,2.0,2.0]},"fixed":{"rotation":[-90,0,0],"translation":[0,0,-7]}},"groups":[{"name":"group","origin":[14,1,8],"color":0,"children":[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14]}]}
	)

	Item(
		id="mask_re2",
		components={
			"lore": [{"text":"Made by Akwaden","color":"gold","italic":False}],
			"equippable": {"slot": "head"}
		},
		override_model={"credit":"Made with Blockbench","textures":{"2":f"{ns}:item/mask_re2","particle":f"{ns}:item/mask_re2"},"elements":[{"from":[2,0,14],"to":[14,2,16],"rotation":{"angle":0,"axis":"y","origin":[8,0,22]},"faces":{"north":{"uv":[2,12,3,13],"texture":"#2"},"east":{"uv":[2,12,3,13],"texture":"#2"},"south":{"uv":[2,12,3,13],"texture":"#2"},"west":{"uv":[2,12,3,13],"texture":"#2"},"up":{"uv":[2,12,3,13],"texture":"#2"},"down":{"uv":[2,12,3,13],"texture":"#2"}}},{"from":[0,0,0],"to":[16,2,2],"rotation":{"angle":0,"axis":"y","origin":[8,0,8]},"faces":{"north":{"uv":[2,12,3,13],"texture":"#2"},"east":{"uv":[2,12,3,13],"texture":"#2"},"south":{"uv":[2,12,3,13],"texture":"#2"},"west":{"uv":[2,12,3,13],"texture":"#2"},"up":{"uv":[2,12,3,13],"texture":"#2"},"down":{"uv":[2,12,3,13],"texture":"#2"}}},{"from":[0,0,2],"to":[2,2,16],"rotation":{"angle":0,"axis":"y","origin":[8,0,8]},"faces":{"north":{"uv":[2,12,3,13],"texture":"#2"},"east":{"uv":[2,12,3,13],"texture":"#2"},"south":{"uv":[2,12,3,13],"texture":"#2"},"west":{"uv":[2,12,3,13],"texture":"#2"},"up":{"uv":[2,12,3,13],"texture":"#2"},"down":{"uv":[2,12,3,13],"texture":"#2"}}},{"from":[14,0,2],"to":[16,2,16],"rotation":{"angle":0,"axis":"y","origin":[22,0,8]},"faces":{"north":{"uv":[2,12,3,13],"texture":"#2"},"east":{"uv":[2,12,3,13],"texture":"#2"},"south":{"uv":[2,12,3,13],"texture":"#2"},"west":{"uv":[2,12,3,13],"texture":"#2"},"up":{"uv":[2,12,3,13],"texture":"#2"},"down":{"uv":[2,12,3,13],"texture":"#2"}}},{"from":[5,0,-2],"to":[11,5,2],"rotation":{"angle":0,"axis":"y","origin":[8,0,8]},"faces":{"north":{"uv":[3,2,5,3],"texture":"#2"},"east":{"uv":[7,12,9,13],"texture":"#2"},"south":{"uv":[2,12,3,13],"texture":"#2"},"west":{"uv":[7,12,9,13],"texture":"#2"},"up":{"uv":[7,12,9,13],"texture":"#2"},"down":{"uv":[7,12,9,13],"texture":"#2"}}},{"from":[3,0,-1],"to":[13,4,2],"rotation":{"angle":0,"axis":"y","origin":[8,0,8]},"faces":{"north":{"uv":[6,9,10,11],"texture":"#2"},"east":{"uv":[6,9,10,11],"texture":"#2"},"south":{"uv":[2,12,3,13],"texture":"#2"},"west":{"uv":[6,9,10,11],"texture":"#2"},"up":{"uv":[6,9,10,11],"texture":"#2"},"down":{"uv":[6,9,10,11],"texture":"#2"}}}],"display":{"thirdperson_righthand":{"translation":[0,0.75,-1.75],"scale":[0.38,0.38,0.4]},"thirdperson_lefthand":{"translation":[0,0.5,-1.75],"scale":[0.38,0.37,0.38]},"firstperson_righthand":{"translation":[0,6,0]},"firstperson_lefthand":{"translation":[0,6,0]},"ground":{"translation":[0,2.25,0],"scale":[0.38,0.38,0.38]},"gui":{"rotation":[45,45,0],"translation":[0,3.5,0],"scale":[0.7,0.7,0.7]},"head":{"translation":[0,1.25,0]},"fixed":{"rotation":[-90,0,0],"translation":[0,0,-7]}}}
	)

	Item(
		id="iron_bowl",
		components={"lore": [{"text":"Made by Emilou","color":"gold","italic":False}]}
	)

	Item(
		id="rice",
		base_item="minecraft:apple",
		manual_category="food",
		components={
			"lore": [{"text":"Made by Emilou","color":"gold","italic":False}],
			"max_stack_size": 1,
			"consumable": {
				"on_consume_effects": [{
					"type": "minecraft:apply_effects",
					"effects": [{"duration": 100, "id": "minecraft:poison", "show_icon": True}],
					"probability": 0.6
				}]
			},
			"food": {"nutrition": 2,"saturation": 1.2}
		}
	)

	Item(
		id="cooked_rice",
		base_item="minecraft:apple",
		manual_category="food",
		recipes=[
			SmeltingRecipe(ingredient=Ingr("rice", ns), cookingtime=200, experience=1.0, group="riz", category="food"),
			SmokingRecipe(ingredient=Ingr("rice", ns), cookingtime=100, experience=1.0, group="riz", category="food")
		],
		components={
			"lore": [{"text":"Made by Emilou","color":"gold","italic":False}],
			"max_stack_size": 1,
			"consumable": {},
			"food": {"nutrition": 20,"saturation": 12}
		}
	)

	Item(
		id="croissant",
		base_item="minecraft:apple",
		manual_category="food",
		recipes=[
			SmeltingRecipe(ingredient=Ingr("minecraft:bread"), cookingtime=200, experience=1.0, group="croissant", category="food"),
			SmokingRecipe(ingredient=Ingr("minecraft:bread"), cookingtime=100, experience=1.0, group="croissant", category="food")
		],
		components={
			"lore": [{"text":"Made by M4TOUW","color":"gold","italic":False}],
			"consumable": {},
			"food": {"nutrition": 6,"saturation": 7}
		}
	)

	Item(
		id="chocolatine",
		base_item="minecraft:apple",
		manual_category="food",
		components={
			"lore": [{"text":"Made by Fhara","color":"gold","italic":False}],
			"consumable": {},
			"food": {"nutrition": 5,"saturation": 6}
		}
	)

	Item(
		id="donut",
		base_item="minecraft:apple",
		manual_category="food",
		components={
			"lore": [{"text":"Made by M4TOUW","color":"gold","italic":False}],
			"consumable": {},
			"food": {"nutrition": 5,"saturation": 6}
		}
	)

	Item(
		id="chocolate_eclair",
		base_item="minecraft:apple",
		manual_category="food",
		components={
			"lore": [{"text":"Made by M4TOUW","color":"gold","italic":False}],
			"consumable": {},
			"food": {"nutrition": 5,"saturation": 6}
		}
	)

	Item(
		id="strawberry_pie",
		base_item="minecraft:apple",
		manual_category="food",
		components={
			"lore": [{"text":"Made by M4TOUW","color":"gold","italic":False}],
			"consumable": {},
			"food": {"nutrition": 5,"saturation": 6}
		}
	)

	Item(
		id="scalbar",
		manual_category="misc",
		components={
			"lore": [{"text":"Made by EvoRay","color":"gold","italic":False}],
			"consumable": {}
		}
	)

	Item(id="monocoin", base_item=CUSTOM_ITEM_VANILLA, manual_category="misc")
	Item(id="super_star", base_item=CUSTOM_ITEM_VANILLA, manual_category="misc")
	Item(id="red_coin", base_item=CUSTOM_ITEM_VANILLA, manual_category="misc")

	# Cards 1 to 8
	for i in range(1, 9):
		Item(
			id=f"card_{i}",
			base_item=CUSTOM_ITEM_VANILLA,
			manual_category="misc",
			components={"lore": [{"text":"Made by Canfav","color":"gold","italic":False}]}
		)

	Item(id="gland", base_item=CUSTOM_ITEM_VANILLA, manual_category="misc")
	Item(id="ice_stone", base_item=CUSTOM_ITEM_VANILLA, manual_category="misc")
	Item(id="papillon", base_item=CUSTOM_ITEM_VANILLA, manual_category="misc")
	Item(id="water_gun", base_item=CUSTOM_ITEM_VANILLA, manual_category="misc")
	Item(id="pass_du_bureau_de_giovanni", base_item=CUSTOM_ITEM_VANILLA, manual_category="misc")

	# Get textures
	textures: list[str] = os.listdir(str(Mem.ctx.meta.get("stewbeet", {}).get("textures_folder", "")))

	# Add colored books
	books: list[str] = [x.replace(".png","") for x in textures if "book_" in x]
	for book in books:
		Item(id=book, base_item="minecraft:written_book", manual_category="book")

	# Add edible colored fishs
	fishs: list[str] = [x.replace(".png","") for x in textures if "poisson_" in x]
	for fish in fishs:
		Item(
			id=fish,
			base_item="minecraft:apple",
			manual_category="fish",
			components={
				"consumable": {},
				"food": {"nutrition": 4, "saturation": 2.4, "can_always_eat": True},
				"lore": [{"text":"Made by M4TOUW","color":"gold","italic":False}],
				"equippable": {"slot": "head", "camera_overlay":f"{ns}:item/{fish}"}
			}
		)

	# Add edible logos
	for logo in textures:
		if "logo_" in logo:
			Item(
				id=logo.replace(".png",""),
				base_item="minecraft:apple",
				manual_category="logo",
				components={
					"consumable": {},
					"food": {"nutrition": 4, "saturation": 2.4, "can_always_eat": True}
				}
			)

