
#> survisland:modes/pr_stoupy/orbit/new_star
#
# @executed	at @e[type=minecraft:marker,tag=survisland.pr_orbit.hole,predicate=survisland:modes/pr_stoupy/orbit/same_arena,limit=1]
#
# @within	survisland:modes/pr_stoupy/orbit/new_fragment
#

tag @s add survisland.pr_orbit.fragment
data merge entity @s {item:{id:"minecraft:nether_star",count:1},billboard:"vertical",Glowing:1b,glow_color_override:5636095,teleport_duration:1,brightness:{sky:15,block:15},transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,-0.5f,0f],scale:[0.8f,0.8f,0.8f]}}
ride @s mount @e[type=minecraft:interaction,tag=survisland.pr_orbit.new,limit=1]

