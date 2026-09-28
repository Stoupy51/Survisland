
#> survisland:modes/pr_stoupy/breakout/bonus/split
#
# @executed	positioned ^ ^0.2 ^0.5
#
# @within	survisland:modes/pr_stoupy/breakout/bonus/count
#

# A second ball of the same player, launched upward from here at the speed of this one
scoreboard players operation #pr_breakout_slot survisland.data = @s survisland.pr_breakout
scoreboard players operation #pr_breakout_color survisland.data = @s survisland.pr_breakout.color
scoreboard players operation #pr_breakout_speed survisland.data = @s survisland.pr_breakout.speed
execute at @s summon minecraft:sulfur_cube run function survisland:modes/pr_stoupy/breakout/new_ball

title @a[tag=survisland.pr_breakout,predicate=survisland:modes/pr_stoupy/breakout/same_arena] actionbar {"text": "Bonus : balles x2 !", "color": "#01FE41"}
execute as @a[tag=survisland.pr_breakout,predicate=survisland:modes/pr_stoupy/breakout/same_arena] at @s run playsound minecraft:entity.experience_orb.pickup master @s ~ ~ ~ 1 1.2

