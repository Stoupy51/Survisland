
#> survisland:v2.1.4/load/resolve
#
# @within	#survisland:resolve
#

# If correct version, load the datapack
execute if score #survisland.major load.status matches 2 if score #survisland.minor load.status matches 1 if score #survisland.patch load.status matches 4 run function survisland:v2.1.4/load/main

