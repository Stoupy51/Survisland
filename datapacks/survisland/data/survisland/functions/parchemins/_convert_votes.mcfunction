
#> survisland:parchemins/_convert_votes
#
# @within			Nothing
# @executed			default context
#
# @description		Convertit les votes (livres) en parchemins
#					- Entrée = bloc au dessus
#					- Sortie = bloc en dessous
#

# Copy the input to the output and count the number of books
data modify block ~ ~-1 ~ Items set from block ~ ~1 ~ Items
execute store result score #parchemin_count survisland.data run data get block ~ ~1 ~ Items

## Transform the books into parchemins (Could be done with a loop but I'm busy)
# Slot 0
execute if score #parchemin_count survisland.data matches 1.. run data modify storage survisland:main Item set from block ~ ~-1 ~ Items[0]
execute if score #parchemin_count survisland.data matches 1.. run function survisland:parchemins/_convert_to_scroll
execute if score #parchemin_count survisland.data matches 1.. run data modify block ~ ~-1 ~ Items[0] set from storage survisland:main Item
scoreboard players remove #parchemin_count survisland.data 1
# Slot 1
execute if score #parchemin_count survisland.data matches 1.. run data modify storage survisland:main Item set from block ~ ~-1 ~ Items[1]
execute if score #parchemin_count survisland.data matches 1.. run function survisland:parchemins/_convert_to_scroll
execute if score #parchemin_count survisland.data matches 1.. run data modify block ~ ~-1 ~ Items[1] set from storage survisland:main Item
scoreboard players remove #parchemin_count survisland.data 1
# Slot 2
execute if score #parchemin_count survisland.data matches 1.. run data modify storage survisland:main Item set from block ~ ~-1 ~ Items[2]
execute if score #parchemin_count survisland.data matches 1.. run function survisland:parchemins/_convert_to_scroll
execute if score #parchemin_count survisland.data matches 1.. run data modify block ~ ~-1 ~ Items[2] set from storage survisland:main Item
scoreboard players remove #parchemin_count survisland.data 1
# Slot 3
execute if score #parchemin_count survisland.data matches 1.. run data modify storage survisland:main Item set from block ~ ~-1 ~ Items[3]
execute if score #parchemin_count survisland.data matches 1.. run function survisland:parchemins/_convert_to_scroll
execute if score #parchemin_count survisland.data matches 1.. run data modify block ~ ~-1 ~ Items[3] set from storage survisland:main Item
scoreboard players remove #parchemin_count survisland.data 1
# Slot 4
execute if score #parchemin_count survisland.data matches 1.. run data modify storage survisland:main Item set from block ~ ~-1 ~ Items[4]
execute if score #parchemin_count survisland.data matches 1.. run function survisland:parchemins/_convert_to_scroll
execute if score #parchemin_count survisland.data matches 1.. run data modify block ~ ~-1 ~ Items[4] set from storage survisland:main Item
scoreboard players remove #parchemin_count survisland.data 1
# Slot 5
execute if score #parchemin_count survisland.data matches 1.. run data modify storage survisland:main Item set from block ~ ~-1 ~ Items[5]
execute if score #parchemin_count survisland.data matches 1.. run function survisland:parchemins/_convert_to_scroll
execute if score #parchemin_count survisland.data matches 1.. run data modify block ~ ~-1 ~ Items[5] set from storage survisland:main Item
scoreboard players remove #parchemin_count survisland.data 1
# Slot 6
execute if score #parchemin_count survisland.data matches 1.. run data modify storage survisland:main Item set from block ~ ~-1 ~ Items[6]
execute if score #parchemin_count survisland.data matches 1.. run function survisland:parchemins/_convert_to_scroll
execute if score #parchemin_count survisland.data matches 1.. run data modify block ~ ~-1 ~ Items[6] set from storage survisland:main Item
scoreboard players remove #parchemin_count survisland.data 1
# Slot 7
execute if score #parchemin_count survisland.data matches 1.. run data modify storage survisland:main Item set from block ~ ~-1 ~ Items[7]
execute if score #parchemin_count survisland.data matches 1.. run function survisland:parchemins/_convert_to_scroll
execute if score #parchemin_count survisland.data matches 1.. run data modify block ~ ~-1 ~ Items[7] set from storage survisland:main Item
scoreboard players remove #parchemin_count survisland.data 1
# Slot 8
execute if score #parchemin_count survisland.data matches 1.. run data modify storage survisland:main Item set from block ~ ~-1 ~ Items[8]
execute if score #parchemin_count survisland.data matches 1.. run function survisland:parchemins/_convert_to_scroll
execute if score #parchemin_count survisland.data matches 1.. run data modify block ~ ~-1 ~ Items[8] set from storage survisland:main Item
scoreboard players remove #parchemin_count survisland.data 1
# Slot 9
execute if score #parchemin_count survisland.data matches 1.. run data modify storage survisland:main Item set from block ~ ~-1 ~ Items[9]
execute if score #parchemin_count survisland.data matches 1.. run function survisland:parchemins/_convert_to_scroll
execute if score #parchemin_count survisland.data matches 1.. run data modify block ~ ~-1 ~ Items[9] set from storage survisland:main Item
scoreboard players remove #parchemin_count survisland.data 1
# Slot 10
execute if score #parchemin_count survisland.data matches 1.. run data modify storage survisland:main Item set from block ~ ~-1 ~ Items[10]
execute if score #parchemin_count survisland.data matches 1.. run function survisland:parchemins/_convert_to_scroll
execute if score #parchemin_count survisland.data matches 1.. run data modify block ~ ~-1 ~ Items[10] set from storage survisland:main Item
scoreboard players remove #parchemin_count survisland.data 1
# Slot 11
execute if score #parchemin_count survisland.data matches 1.. run data modify storage survisland:main Item set from block ~ ~-1 ~ Items[11]
execute if score #parchemin_count survisland.data matches 1.. run function survisland:parchemins/_convert_to_scroll
execute if score #parchemin_count survisland.data matches 1.. run data modify block ~ ~-1 ~ Items[11] set from storage survisland:main Item
scoreboard players remove #parchemin_count survisland.data 1
# Slot 12
execute if score #parchemin_count survisland.data matches 1.. run data modify storage survisland:main Item set from block ~ ~-1 ~ Items[12]
execute if score #parchemin_count survisland.data matches 1.. run function survisland:parchemins/_convert_to_scroll
execute if score #parchemin_count survisland.data matches 1.. run data modify block ~ ~-1 ~ Items[12] set from storage survisland:main Item
scoreboard players remove #parchemin_count survisland.data 1
# Slot 13
execute if score #parchemin_count survisland.data matches 1.. run data modify storage survisland:main Item set from block ~ ~-1 ~ Items[13]
execute if score #parchemin_count survisland.data matches 1.. run function survisland:parchemins/_convert_to_scroll
execute if score #parchemin_count survisland.data matches 1.. run data modify block ~ ~-1 ~ Items[13] set from storage survisland:main Item
scoreboard players remove #parchemin_count survisland.data 1
# Slot 14
execute if score #parchemin_count survisland.data matches 1.. run data modify storage survisland:main Item set from block ~ ~-1 ~ Items[14]
execute if score #parchemin_count survisland.data matches 1.. run function survisland:parchemins/_convert_to_scroll
execute if score #parchemin_count survisland.data matches 1.. run data modify block ~ ~-1 ~ Items[14] set from storage survisland:main Item
scoreboard players remove #parchemin_count survisland.data 1
# Slot 15
execute if score #parchemin_count survisland.data matches 1.. run data modify storage survisland:main Item set from block ~ ~-1 ~ Items[15]
execute if score #parchemin_count survisland.data matches 1.. run function survisland:parchemins/_convert_to_scroll
execute if score #parchemin_count survisland.data matches 1.. run data modify block ~ ~-1 ~ Items[15] set from storage survisland:main Item
scoreboard players remove #parchemin_count survisland.data 1
# Slot 16
execute if score #parchemin_count survisland.data matches 1.. run data modify storage survisland:main Item set from block ~ ~-1 ~ Items[16]
execute if score #parchemin_count survisland.data matches 1.. run function survisland:parchemins/_convert_to_scroll
execute if score #parchemin_count survisland.data matches 1.. run data modify block ~ ~-1 ~ Items[16] set from storage survisland:main Item
scoreboard players remove #parchemin_count survisland.data 1
# Slot 17
execute if score #parchemin_count survisland.data matches 1.. run data modify storage survisland:main Item set from block ~ ~-1 ~ Items[17]
execute if score #parchemin_count survisland.data matches 1.. run function survisland:parchemins/_convert_to_scroll
execute if score #parchemin_count survisland.data matches 1.. run data modify block ~ ~-1 ~ Items[17] set from storage survisland:main Item
scoreboard players remove #parchemin_count survisland.data 1
# Slot 18
execute if score #parchemin_count survisland.data matches 1.. run data modify storage survisland:main Item set from block ~ ~-1 ~ Items[18]
execute if score #parchemin_count survisland.data matches 1.. run function survisland:parchemins/_convert_to_scroll
execute if score #parchemin_count survisland.data matches 1.. run data modify block ~ ~-1 ~ Items[18] set from storage survisland:main Item
scoreboard players remove #parchemin_count survisland.data 1
# Slot 19
execute if score #parchemin_count survisland.data matches 1.. run data modify storage survisland:main Item set from block ~ ~-1 ~ Items[19]
execute if score #parchemin_count survisland.data matches 1.. run function survisland:parchemins/_convert_to_scroll
execute if score #parchemin_count survisland.data matches 1.. run data modify block ~ ~-1 ~ Items[19] set from storage survisland:main Item
scoreboard players remove #parchemin_count survisland.data 1
# Slot 20
execute if score #parchemin_count survisland.data matches 1.. run data modify storage survisland:main Item set from block ~ ~-1 ~ Items[20]
execute if score #parchemin_count survisland.data matches 1.. run function survisland:parchemins/_convert_to_scroll
execute if score #parchemin_count survisland.data matches 1.. run data modify block ~ ~-1 ~ Items[20] set from storage survisland:main Item
scoreboard players remove #parchemin_count survisland.data 1
# Slot 21
execute if score #parchemin_count survisland.data matches 1.. run data modify storage survisland:main Item set from block ~ ~-1 ~ Items[21]
execute if score #parchemin_count survisland.data matches 1.. run function survisland:parchemins/_convert_to_scroll
execute if score #parchemin_count survisland.data matches 1.. run data modify block ~ ~-1 ~ Items[21] set from storage survisland:main Item
scoreboard players remove #parchemin_count survisland.data 1
# Slot 22
execute if score #parchemin_count survisland.data matches 1.. run data modify storage survisland:main Item set from block ~ ~-1 ~ Items[22]
execute if score #parchemin_count survisland.data matches 1.. run function survisland:parchemins/_convert_to_scroll
execute if score #parchemin_count survisland.data matches 1.. run data modify block ~ ~-1 ~ Items[22] set from storage survisland:main Item
scoreboard players remove #parchemin_count survisland.data 1
# Slot 23
execute if score #parchemin_count survisland.data matches 1.. run data modify storage survisland:main Item set from block ~ ~-1 ~ Items[23]
execute if score #parchemin_count survisland.data matches 1.. run function survisland:parchemins/_convert_to_scroll
execute if score #parchemin_count survisland.data matches 1.. run data modify block ~ ~-1 ~ Items[23] set from storage survisland:main Item
scoreboard players remove #parchemin_count survisland.data 1
# Slot 24
execute if score #parchemin_count survisland.data matches 1.. run data modify storage survisland:main Item set from block ~ ~-1 ~ Items[24]
execute if score #parchemin_count survisland.data matches 1.. run function survisland:parchemins/_convert_to_scroll
execute if score #parchemin_count survisland.data matches 1.. run data modify block ~ ~-1 ~ Items[24] set from storage survisland:main Item
scoreboard players remove #parchemin_count survisland.data 1
# Slot 25
execute if score #parchemin_count survisland.data matches 1.. run data modify storage survisland:main Item set from block ~ ~-1 ~ Items[25]
execute if score #parchemin_count survisland.data matches 1.. run function survisland:parchemins/_convert_to_scroll
execute if score #parchemin_count survisland.data matches 1.. run data modify block ~ ~-1 ~ Items[25] set from storage survisland:main Item
scoreboard players remove #parchemin_count survisland.data 1
# Slot 26
execute if score #parchemin_count survisland.data matches 1.. run data modify storage survisland:main Item set from block ~ ~-1 ~ Items[26]
execute if score #parchemin_count survisland.data matches 1.. run function survisland:parchemins/_convert_to_scroll
execute if score #parchemin_count survisland.data matches 1.. run data modify block ~ ~-1 ~ Items[26] set from storage survisland:main Item
scoreboard players remove #parchemin_count survisland.data 1


# Clear storage & sign
data remove storage survisland:main Item
setblock ~ ~-2 ~ air

