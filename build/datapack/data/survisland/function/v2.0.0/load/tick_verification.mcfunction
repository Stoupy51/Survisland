
#> survisland:v2.0.0/load/tick_verification
#
# @within	#minecraft:tick
#

execute if score #survisland.major load.status matches 2 if score #survisland.minor load.status matches 0 if score #survisland.patch load.status matches 0 run function survisland:v2.0.0/tick

