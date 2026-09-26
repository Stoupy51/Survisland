
#> survisland:modes/pr_stoupy/orbit/steal
#
# @executed	as @e[type=minecraft:phantom,tag=...,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1,sort=random]
#
# @within	survisland:modes/pr_stoupy/orbit/phantoms_tick [ as @e[type=minecraft:phantom,tag=...,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1,sort=random] ]
#

execute unless entity @e[type=minecraft:item_display,tag=survisland.pr_orbit.fragment,tag=!survisland.pr_orbit.stolen,predicate=survisland:modes/pr_stoupy/orbit/same_arena] run return fail
tag @s add survisland.pr_orbit.diving
data merge entity @s {NoAI:1b}
tag @e[type=minecraft:item_display,tag=survisland.pr_orbit.fragment,tag=!survisland.pr_orbit.stolen,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1,sort=random] add survisland.pr_orbit.stealing
ride @e[type=minecraft:item_display,tag=survisland.pr_orbit.stealing,limit=1] mount @s
tag @e[type=minecraft:item_display,tag=survisland.pr_orbit.stealing] add survisland.pr_orbit.stolen
tag @e[type=minecraft:item_display,tag=survisland.pr_orbit.stealing] remove survisland.pr_orbit.stealing
execute at @s run playsound minecraft:entity.phantom.swoop hostile @a[tag=survisland.pr_orbit,predicate=survisland:modes/pr_stoupy/orbit/same_arena] ~ ~ ~ 2 0.6
tellraw @a[tag=survisland.pr_orbit,predicate=survisland:modes/pr_stoupy/orbit/same_arena] {"text":"Un voleur d'étoiles emporte un fragment vers le trou noir !","color":"red"}

