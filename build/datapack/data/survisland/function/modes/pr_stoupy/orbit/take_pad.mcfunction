
#> survisland:modes/pr_stoupy/orbit/take_pad
#
# @executed	positioned ~ ~-1 ~
#
# @within	survisland:modes/pr_stoupy/orbit/find_pad [ positioned ~ ~-1 ~ ]
#			survisland:modes/pr_stoupy/orbit/find_pad [ positioned ~0.3 ~-1 ~0.3 ]
#			survisland:modes/pr_stoupy/orbit/find_pad [ positioned ~-0.3 ~-1 ~0.3 ]
#			survisland:modes/pr_stoupy/orbit/find_pad [ positioned ~0.3 ~-1 ~-0.3 ]
#			survisland:modes/pr_stoupy/orbit/find_pad [ positioned ~-0.3 ~-1 ~-0.3 ]
#

# The pad under the player is emptied until the game ends, a marker remembers where to put it back
setblock ~ ~ ~ minecraft:air
execute align xyz positioned ~0.5 ~ ~0.5 summon minecraft:marker run function survisland:modes/pr_stoupy/orbit/new_pad

