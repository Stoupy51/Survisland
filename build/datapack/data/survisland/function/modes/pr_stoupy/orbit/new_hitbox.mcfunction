
#> survisland:modes/pr_stoupy/orbit/new_hitbox
#
# @executed	at @e[type=minecraft:marker,tag=survisland.pr_orbit.hole,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1]
#
# @within	survisland:modes/pr_stoupy/orbit/new_fragment
#

# The negative height hangs the box below the star's origin, around the lowered star
tag @s add survisland.pr_orbit.hitbox
data merge entity @s {width:1f,height:-1f,response:1b}
ride @s mount @e[type=minecraft:item_display,tag=survisland.pr_orbit.new,limit=1]

