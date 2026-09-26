
#> survisland:modes/pr_stoupy/orbit/here/place_black_hole
#
# @within	???
#
# @args		scale (unknown)
#

# A huge inverted cube rendered by the black hole shader, seen from inside
kill @e[type=minecraft:item_display,tag=survisland.pr_orbit.sky,distance=..8]
$summon minecraft:item_display ~ ~ ~ {Tags:["survisland.pr_orbit.sky"],item:{id:"minecraft:stone",count:1,components:{"minecraft:item_model":"survisland:black_hole"}},view_range:10f,transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[-$(scale)f,-$(scale)f,-$(scale)f]}}

