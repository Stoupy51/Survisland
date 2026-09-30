
#> survisland:modes/pr_stoupy/rats/release
#
# @executed	as @a[tag=survisland.pr_stoupy_duo.new] & at @s
#
# @within	survisland:modes/pr_stoupy/teleport
#			survisland:modes/pr_stoupy/orbit/enroll_player
#

# @s enters a trial: the rats on its head run free again where it stands
execute unless score @s survisland.pr_rats.carried matches 1.. run return 0
scoreboard players operation #pr_rats_id survisland.data = @s survisland.pr_rats.id
execute as @e[type=minecraft:item_display,tag=survisland.pr_rats.carried,predicate=survisland:modes/pr_stoupy/rats/same_carrier] run function survisland:modes/pr_stoupy/rats/release_one
tag @e[type=minecraft:ocelot,tag=survisland.pr_rats.released] remove survisland.pr_rats.released
scoreboard players set @s survisland.pr_rats.carried 0

