
#> survisland:modes/space_riding/advancements/killed_vehicle_confirm
#
# @within	survisland:modes/space_riding/advancements/killed_vehicle
#

# Add 3 points to self
scoreboard players add @s survisland.temp.sidebar 3

# Message to show player killed
tellraw @a ["",{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"translate": "survisland.3_points_pour"},{"selector":"@s"},{"translate": "survisland.pour_avoir_tu_la_monture_dun_joueur"}]

