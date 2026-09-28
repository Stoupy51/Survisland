
#> survisland:modes/pr_stoupy/breakout/shatter
#
# @executed	positioned ^ ^0.2 ^0.5
#
# @within	survisland:modes/pr_stoupy/breakout/break_brick
#			survisland:modes/pr_stoupy/breakout/bonus/multiball
#

# Sounds are played on the players themselves, the bricks being too far from them to be heard
execute if block ~ ~ ~ #survisland:pr_stoupy/breakout/concrete as @a[tag=survisland.pr_breakout,predicate=survisland:modes/pr_stoupy/breakout/same_arena] at @s run playsound minecraft:block.stone.break ambient @s
execute if block ~ ~ ~ #survisland:pr_stoupy/breakout/wool as @a[tag=survisland.pr_breakout,predicate=survisland:modes/pr_stoupy/breakout/same_arena] at @s run playsound minecraft:block.wool.break ambient @s
execute if block ~ ~ ~ #survisland:pr_stoupy/breakout/terracotta as @a[tag=survisland.pr_breakout,predicate=survisland:modes/pr_stoupy/breakout/same_arena] at @s run playsound minecraft:block.stone.break ambient @s
execute if block ~ ~ ~ #survisland:pr_stoupy/breakout/stained_glass as @a[tag=survisland.pr_breakout,predicate=survisland:modes/pr_stoupy/breakout/same_arena] at @s run playsound minecraft:block.glass.break ambient @s
function survisland:modes/pr_stoupy/breakout/break_particles
setblock ~ ~ ~ minecraft:air

