
#> survisland:modes/pr_stoupy/rats/cage_one
#
# @executed	as @e[type=minecraft:item_display,tag=survisland.pr_rats.carried,predicate=survisland:modes/pr_stoupy/rats/same_carrier]
#
# @within	survisland:modes/pr_stoupy/rats/drop_in_cage [ as @e[type=minecraft:item_display,tag=survisland.pr_rats.carried,predicate=survisland:modes/pr_stoupy/rats/same_carrier] ]
#

tag @s remove survisland.pr_rats.carried
tag @s add survisland.pr_rats.caged
scoreboard players operation @s survisland.pr_rats.arena = #pr_rats_arena survisland.data
scoreboard players operation #pr_rats_slot survisland.data = #pr_rats_caged survisland.data
scoreboard players operation #pr_rats_slot survisland.data %= #16 survisland.data
scoreboard players add #pr_rats_caged survisland.data 1
execute if score #pr_rats_slot survisland.data matches 0 run tp @s ~-0.68 ~ ~-0.68 0 0
execute if score #pr_rats_slot survisland.data matches 1 run tp @s ~-0.23 ~ ~-0.68 137 0
execute if score #pr_rats_slot survisland.data matches 2 run tp @s ~0.23 ~ ~-0.68 274 0
execute if score #pr_rats_slot survisland.data matches 3 run tp @s ~0.68 ~ ~-0.68 51 0
execute if score #pr_rats_slot survisland.data matches 4 run tp @s ~-0.68 ~ ~-0.23 188 0
execute if score #pr_rats_slot survisland.data matches 5 run tp @s ~-0.23 ~ ~-0.23 325 0
execute if score #pr_rats_slot survisland.data matches 6 run tp @s ~0.23 ~ ~-0.23 102 0
execute if score #pr_rats_slot survisland.data matches 7 run tp @s ~0.68 ~ ~-0.23 239 0
execute if score #pr_rats_slot survisland.data matches 8 run tp @s ~-0.68 ~ ~0.23 16 0
execute if score #pr_rats_slot survisland.data matches 9 run tp @s ~-0.23 ~ ~0.23 153 0
execute if score #pr_rats_slot survisland.data matches 10 run tp @s ~0.23 ~ ~0.23 290 0
execute if score #pr_rats_slot survisland.data matches 11 run tp @s ~0.68 ~ ~0.23 67 0
execute if score #pr_rats_slot survisland.data matches 12 run tp @s ~-0.68 ~ ~0.68 204 0
execute if score #pr_rats_slot survisland.data matches 13 run tp @s ~-0.23 ~ ~0.68 341 0
execute if score #pr_rats_slot survisland.data matches 14 run tp @s ~0.23 ~ ~0.68 118 0
execute if score #pr_rats_slot survisland.data matches 15 run tp @s ~0.68 ~ ~0.68 255 0

