
#> survisland:modes/pr_stoupy/orbit/clicked
#
# @executed	as @e[type=minecraft:interaction,tag=survisland.pr_orbit.fragment,distance=..8]
#
# @within	survisland:modes/pr_stoupy/orbit/click [ as @e[type=minecraft:interaction,tag=survisland.pr_orbit.fragment,distance=..8] ]
#

execute on attacker if entity @s[tag=survisland.pr_orbit.clicker] run return 1
execute on target if entity @s[tag=survisland.pr_orbit.clicker] run return 1
return 0

