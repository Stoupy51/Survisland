
#> survisland:modes/pr_stoupy/rats/here/place_cage
#
# @within	???
#

# Joins the arena of a cage within 48 blocks, or opens a new one
scoreboard objectives add survisland.pr_rats.arena dummy
scoreboard objectives add survisland.pr_rats.caged dummy
scoreboard players set #pr_rats_arena survisland.data 0
scoreboard players operation #pr_rats_arena survisland.data = @n[type=minecraft:marker,tag=survisland.pr_rats.cage,distance=..48] survisland.pr_rats.arena
execute if score #pr_rats_arena survisland.data matches 0 store result score #pr_rats_arena survisland.data run scoreboard players add #pr_rats_arena_counter survisland.data 1
execute align xyz positioned ~0.5 ~ ~0.5 summon minecraft:marker run function survisland:modes/pr_stoupy/rats/new_cage
tellraw @a[distance=..16] {"text":"Rats : cage placée.","color":"green"}

