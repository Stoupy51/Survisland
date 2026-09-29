
#> survisland:modes/pr_stoupy/orbit/grab
#
# @executed	as @e[type=minecraft:interaction,tag=survisland.pr_orbit.fragment,distance=..8]
#
# @within	survisland:modes/pr_stoupy/orbit/click [ as @e[type=minecraft:interaction,tag=survisland.pr_orbit.fragment,distance=..8] ]
#

scoreboard players add @a[tag=survisland.pr_orbit.clicker,limit=1] survisland.pr_orbit.carried 1
execute as @a[tag=survisland.pr_orbit.clicker,limit=1] at @s run playsound minecraft:entity.experience_orb.pickup ambient @s ~ ~ ~ 1 1.2
particle minecraft:end_rod ~ ~0.5 ~ 0.2 0.2 0.2 0.05 12
function survisland:modes/pr_stoupy/orbit/remove_fragment

