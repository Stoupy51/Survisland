
#> survisland:modes/pr_stoupy/orbit/turn/3
#
# @executed	at @e[type=minecraft:marker,tag=survisland.pr_orbit.hole,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1]
#
# @within	survisland:modes/pr_stoupy/orbit/play_tick [ at @e[type=minecraft:marker,tag=survisland.pr_orbit.hole,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1] ]
#

# The step of @s indexes the points of its ring, written in storage when the game begins
scoreboard players add @s survisland.pr_orbit.step 1
execute if score @s survisland.pr_orbit.step matches 240.. run scoreboard players set @s survisland.pr_orbit.step 0
execute store result storage survisland:pr_orbit turn.step int 1 run scoreboard players get @s survisland.pr_orbit.step
function survisland:modes/pr_stoupy/orbit/turn/3_point with storage survisland:pr_orbit turn

