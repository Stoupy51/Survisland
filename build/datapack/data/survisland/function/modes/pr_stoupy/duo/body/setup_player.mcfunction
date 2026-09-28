
#> survisland:modes/pr_stoupy/duo/body/setup_player
#
# @executed	as @a[tag=survisland.pr_stoupy_duo.new]
#
# @within	survisland:modes/pr_stoupy/duo/body/setup_sensors [ as @a[tag=survisland.pr_stoupy_duo.new] ]
#

# Turn this player into an invisible sensor (scale is clamped to 0.0625 by vanilla, 0 is impossible)
effect give @s minecraft:invisibility infinite 255 true
# Resistance would still play the hurt flash and sound of a click holder in a wall, the immunity cancels the damage itself
item replace entity @s armor.body with minecraft:stone[equippable={slot:"body"},enchantments={"golf_ball:invulnerable":1}]
attribute @s minecraft:scale base set 0.0625
attribute @s minecraft:gravity base set 0
attribute @s minecraft:fall_damage_multiplier base set 0
attribute @s minecraft:camera_distance base set 32

tellraw @s ["\n",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Vous ne faites plus qu'un ! Chacun n'a qu'une partie des commandes."}]

