
#> survisland:v2.1.3/load/tick_verification
#
# @within	#minecraft:tick
#

execute if score #survisland.major load.status matches 2 if score #survisland.minor load.status matches 1 if score #survisland.patch load.status matches 3 run function survisland:v2.1.3/tick

