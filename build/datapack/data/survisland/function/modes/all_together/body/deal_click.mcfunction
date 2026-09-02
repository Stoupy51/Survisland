
#> survisland:modes/all_together/body/deal_click
#
# @executed	as @a[tag=survisland.all_together,distance=..16]
#
# @within	survisland:modes/all_together/body/deal/clairiere
#			survisland:modes/all_together/body/deal/riviere
#			survisland:modes/all_together/body/deal/fort
#

# Adventure breaks nothing, and riding counts as being in the air which divides the mining speed by five
gamemode survival @s
attribute @s minecraft:block_break_speed base set 5
attribute @s minecraft:entity_interaction_range base reset
attribute @s minecraft:block_interaction_range base reset

