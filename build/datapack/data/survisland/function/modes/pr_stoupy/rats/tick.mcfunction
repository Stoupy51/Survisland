
#> survisland:modes/pr_stoupy/rats/tick
#
# @within	survisland:modes/pr_stoupy/rats/summon/grey 1t replace [ scheduled ]
#			survisland:modes/pr_stoupy/rats/summon/white 1t replace [ scheduled ]
#			survisland:modes/pr_stoupy/rats/summon/brown 1t replace [ scheduled ]
#			survisland:modes/pr_stoupy/rats/summon/mutant 1t replace [ scheduled ]
#			survisland:modes/pr_stoupy/rats/tick 1t replace [ scheduled ]
#

execute as @e[type=minecraft:ocelot,tag=survisland.pr_rats.rat] at @s on passengers run rotate @s ~ 0
execute as @a[scores={survisland.pr_rats.carried=1..}] at @s run function survisland:modes/pr_stoupy/rats/carry

# Alive while a rat runs or rides a head, any new rat brings the tick back
execute if entity @e[type=minecraft:ocelot,tag=survisland.pr_rats.rat] run return run schedule function survisland:modes/pr_stoupy/rats/tick 1t replace
execute if entity @e[type=minecraft:item_display,tag=survisland.pr_rats.carried] run schedule function survisland:modes/pr_stoupy/rats/tick 1t replace

