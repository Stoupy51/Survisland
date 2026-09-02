
#> survisland:modes/all_together/body/look_tick
#
# @executed	as @a[tag=survisland.all_together.look]
#
# @within	survisland:modes/all_together/body/tick [ as @a[tag=survisland.all_together.look] ]
#

# Put the mouse controller at the mannequin head without changing its rotation
tp @s ~ ~1.519 ~

# Copy the controller rotation into the mannequin
data modify entity @n[type=mannequin,tag=survisland.all_together.body] Rotation set from entity @s Rotation

# Teleport every players to the mouse controller
tp @a[tag=survisland.all_together,distance=..5,tag=!survisland.all_together.look] @s

# Put the click holder just in front of the mannequin for block and entity interaction
execute at @s as @a[tag=survisland.all_together.click,distance=..5] run tp @s ^ ^ ^1.0

