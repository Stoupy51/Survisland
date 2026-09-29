
#> survisland:modes/pr_stoupy/orbit/pick_up
#
# @executed	at @s & as @p[tag=survisland.pr_orbit,predicate=survisland:modes/pr_stoupy/orbit/same_arena,distance=..1.6]
#
# @within	survisland:modes/pr_stoupy/orbit/play_tick [ at @s & as @p[tag=survisland.pr_orbit,predicate=survisland:modes/pr_stoupy/orbit/same_arena,distance=..1.6] ]
#

# @s is the player touching the fragment, which disappears from the orbit
scoreboard players add @s survisland.pr_orbit.carried 1
execute as @e[type=minecraft:item_display,tag=survisland.pr_orbit.fragment,tag=!survisland.pr_orbit.stolen,predicate=survisland:modes/pr_stoupy/orbit/same_arena,distance=..1.6,limit=1,sort=nearest] run kill @s
playsound minecraft:entity.experience_orb.pickup ambient @s ~ ~ ~ 1 1.2

