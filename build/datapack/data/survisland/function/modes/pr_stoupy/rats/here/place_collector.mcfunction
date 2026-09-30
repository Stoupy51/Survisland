
#> survisland:modes/pr_stoupy/rats/here/place_collector
#
# @within	???
#

# Replaces the collector of an arena within 48 blocks, or opens a new arena
scoreboard objectives add survisland.pr_rats.arena dummy
scoreboard objectives add survisland.pr_rats.goal dummy
scoreboard players set #pr_rats_arena survisland.data 0
scoreboard players operation #pr_rats_arena survisland.data = @n[type=minecraft:interaction,tag=survisland.pr_rats.collector,distance=..48] survisland.pr_rats.arena
execute if score #pr_rats_arena survisland.data matches 0 store result score #pr_rats_arena survisland.data run scoreboard players add #pr_rats_arena_counter survisland.data 1
kill @e[tag=survisland.pr_rats.collector,predicate=survisland:modes/pr_stoupy/rats/same_arena]
execute align xyz positioned ~0.5 ~ ~0.5 run function survisland:modes/pr_stoupy/rats/new_collector
tellraw @a[distance=..16] {"text":"Rats : collecteur placé (clic gauche ou droit pour déposer les rats portés).","color":"green"}

