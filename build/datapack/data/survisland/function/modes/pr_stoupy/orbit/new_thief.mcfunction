
#> survisland:modes/pr_stoupy/orbit/new_thief
#
# @executed	at @e[type=minecraft:marker,tag=survisland.pr_orbit.orbit,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1] & positioned ~ ~8 ~
#
# @within	survisland:modes/pr_stoupy/orbit/round/3 [ at @e[type=minecraft:marker,tag=survisland.pr_orbit.orbit,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1] & positioned ~ ~8 ~ ]
#

function survisland:modes/pr_stoupy/orbit/new_phantom
tag @s add survisland.pr_orbit.thief
data merge entity @s {Glowing:1b,CustomName:{"text":"Voleur d'étoiles","color":"red"}}

