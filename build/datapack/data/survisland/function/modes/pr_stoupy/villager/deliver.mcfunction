
#> survisland:modes/pr_stoupy/villager/deliver
#
# @executed	as the player & at current position
#
# @within	survisland:modes/pr_stoupy/villager/talk
#

# The end messages belong to command blocks powered by the redstone block, 2 blocks under the spawn of the villager
clear @s *[custom_data~{survisland:{blue_star:true}}]
execute at @n[type=marker,tag=survisland.pr_stoupy.villager.spawn] run setblock ~ ~-2 ~ minecraft:redstone_block

