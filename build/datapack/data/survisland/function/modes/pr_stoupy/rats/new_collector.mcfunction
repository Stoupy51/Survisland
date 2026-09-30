
#> survisland:modes/pr_stoupy/rats/new_collector
#
# @executed	align xyz & positioned ~0.5 ~ ~0.5
#
# @within	survisland:modes/pr_stoupy/rats/here/place_collector [ align xyz & positioned ~0.5 ~ ~0.5 ]
#

# A hitbox slightly larger than the block here, so it is clicked before a block built in the same place
summon minecraft:interaction ~ ~-0.05 ~ {Tags:["survisland.pr_rats.collector","survisland.pr_rats.new_collector"],width:1.1f,height:1.1f,response:1b}
summon minecraft:text_display ~ ~1.3 ~ {Tags:["survisland.pr_rats.collector","survisland.pr_rats.new_collector"],text:{"text": "Déposer les rats", "color": "#01FE41"},billboard:"center",background:0,brightness:{sky:15,block:15}}
scoreboard players operation @e[tag=survisland.pr_rats.new_collector] survisland.pr_rats.arena = #pr_rats_arena survisland.data
scoreboard players set @e[type=minecraft:interaction,tag=survisland.pr_rats.new_collector] survisland.pr_rats.goal 0
tag @e[tag=survisland.pr_rats.new_collector] remove survisland.pr_rats.new_collector

