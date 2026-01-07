
#> survisland:v2.4.1/load/enumerate
#
# @within	#survisland:enumerate
#

# If current major is too low, set it to the current major
execute unless score #survisland.major load.status matches 2.. run scoreboard players set #survisland.major load.status 2

# If current minor is too low, set it to the current minor (only if major is correct)
execute if score #survisland.major load.status matches 2 unless score #survisland.minor load.status matches 4.. run scoreboard players set #survisland.minor load.status 4

# If current patch is too low, set it to the current patch (only if major and minor are correct)
execute if score #survisland.major load.status matches 2 if score #survisland.minor load.status matches 4 unless score #survisland.patch load.status matches 1.. run scoreboard players set #survisland.patch load.status 1

