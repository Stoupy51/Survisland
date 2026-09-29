
#> survisland:modes/pr_stoupy/orbit/turn/2
#
# @executed	at @e[type=minecraft:marker,tag=survisland.pr_orbit.hole,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1]
#
# @within	survisland:modes/pr_stoupy/orbit/play_tick [ at @e[type=minecraft:marker,tag=survisland.pr_orbit.hole,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1] ]
#

# The pitch is clamped to 90 degrees, so each half of the circle is swept by pitch and the fragment turns over between them
execute if entity @s[tag=!survisland.pr_orbit.half1] run rotate @s ~ ~1
execute if entity @s[tag=survisland.pr_orbit.half1] run rotate @s ~ ~-1
execute if entity @s[tag=!survisland.pr_orbit.half1,x_rotation=90] run function survisland:modes/pr_stoupy/orbit/turn_over
execute if entity @s[tag=survisland.pr_orbit.half1,x_rotation=-90] run function survisland:modes/pr_stoupy/orbit/turn_over
execute rotated as @s positioned ~ ~0 ~ positioned ^ ^ ^14 run tp @s ~ ~ ~

