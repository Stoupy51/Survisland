
#> survisland:modes/pr_stoupy/rats/hit
#
# @executed	as the player & at current position
#
# @within	advancement survisland:modes/pr_stoupy/rats_hit
#

advancement revoke @s only survisland:modes/pr_stoupy/rats_hit
execute if score @s survisland.pr_rats.carried matches 3.. run return run title @s actionbar {"text":"Tu portes déjà 3 rats, va les mettre en cage !","color":"red"}

# The rat just hit is the one whose last attacker is this player, never one already caged
tag @s add survisland.pr_rats.catching
execute as @e[type=minecraft:ocelot,tag=survisland.pr_rats.rat,tag=!survisland.pr_rats.caged,distance=..6] at @s on attacker if entity @s[tag=survisland.pr_rats.catching] run tag @n[type=minecraft:ocelot,tag=survisland.pr_rats.rat,distance=..0.01] add survisland.pr_rats.caught
tag @s remove survisland.pr_rats.catching
execute if entity @e[type=minecraft:ocelot,tag=survisland.pr_rats.caught] run function survisland:modes/pr_stoupy/rats/catch
tag @e[type=minecraft:ocelot,tag=survisland.pr_rats.caught] remove survisland.pr_rats.caught

