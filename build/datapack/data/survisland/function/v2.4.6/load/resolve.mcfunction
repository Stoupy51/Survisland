
#> survisland:v2.4.6/load/resolve
#
# @within	#survisland:resolve
#

# If correct version, load the datapack
execute if score #survisland.major load.status matches 2 if score #survisland.minor load.status matches 4 if score #survisland.patch load.status matches 6 run function survisland:v2.4.6/load/main

