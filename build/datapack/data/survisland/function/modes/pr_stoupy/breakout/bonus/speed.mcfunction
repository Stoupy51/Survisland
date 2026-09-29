
#> survisland:modes/pr_stoupy/breakout/bonus/speed
#
# @executed	positioned ^ ^0.2 ^0.5
#
# @within	survisland:modes/pr_stoupy/breakout/bonus/count
#

# Half again as fast until the ball is lost, on top of its previous speed bonuses
scoreboard players operation @s survisland.pr_breakout.speed *= #3 survisland.data
scoreboard players operation @s survisland.pr_breakout.speed /= #2 survisland.data
execute if score #pr_breakout_axis survisland.data matches 0 store result entity @s Motion[0] double 0.0015 run scoreboard players get #pr_breakout_mu survisland.data
execute if score #pr_breakout_axis survisland.data matches 1 store result entity @s Motion[2] double 0.0015 run scoreboard players get #pr_breakout_mu survisland.data
execute store result entity @s Motion[1] double 0.0015 run scoreboard players get #pr_breakout_mv survisland.data

title @a[tag=survisland.pr_breakout,predicate=survisland:modes/pr_stoupy/breakout/same_arena] actionbar {"text": "Bonus : vitesse x1.5 !", "color": "#01FE41"}
execute as @a[tag=survisland.pr_breakout,predicate=survisland:modes/pr_stoupy/breakout/same_arena] at @s run playsound minecraft:entity.experience_orb.pickup ambient @s ~ ~ ~ 1 1.2

