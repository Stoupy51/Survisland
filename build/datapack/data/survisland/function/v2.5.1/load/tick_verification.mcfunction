
#> survisland:v2.5.1/load/tick_verification
#
# @within	#minecraft:tick
#

execute if score #survisland.major load.status matches 2 if score #survisland.minor load.status matches 5 if score #survisland.patch load.status matches 1 run function survisland:v2.5.1/tick

