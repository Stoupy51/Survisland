
#> survisland:modes/pr_stoupy/orbit/place_collector
#
# @executed	align xyz & positioned ~0.5 ~ ~0.5
#
# @within	survisland:modes/pr_stoupy/orbit/here/set_collector [ align xyz & positioned ~0.5 ~ ~0.5 ]
#

summon minecraft:marker ~ ~ ~ {Tags:["survisland.pr_orbit.collector","survisland.pr_orbit.new"]}
summon minecraft:item_display ~ ~1.5 ~ {Tags:["survisland.pr_orbit.collector","survisland.pr_orbit.new"],item:{id:"minecraft:nether_star",count:1},billboard:"center",glow_color_override:5636095,brightness:{sky:15,block:15},transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[1.5f,1.5f,1.5f]}}
summon minecraft:text_display ~ ~2.6 ~ {Tags:["survisland.pr_orbit.collector","survisland.pr_orbit.new"],text:{"text": "Dépôt des fragments", "color": "#01FE41"},billboard:"center",background:0,brightness:{sky:15,block:15}}
scoreboard players operation @e[tag=survisland.pr_orbit.new] survisland.pr_orbit.arena = #pr_orbit_arena survisland.data
tag @e[tag=survisland.pr_orbit.new] remove survisland.pr_orbit.new

