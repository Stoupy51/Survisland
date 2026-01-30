
#> survisland:v2.4.3/load/resolve
#
# @within	#survisland:resolve
#

# If correct version, load the datapack
execute if score #survisland.major load.status matches 2 if score #survisland.minor load.status matches 4 if score #survisland.patch load.status matches 3 run function survisland:v2.4.3/load/main

