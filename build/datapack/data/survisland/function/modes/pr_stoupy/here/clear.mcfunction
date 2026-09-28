
#> survisland:modes/pr_stoupy/here/clear
#
# @within	???
#
# @args		radius (unknown)
#

# The stops of each trial give the players their state back, the kills then take everything else, setup included
$execute as @e[type=minecraft:mannequin,tag=survisland.pr_stoupy_duo.body,distance=..$(radius)] at @s run function survisland:modes/pr_stoupy/duo/body/stop
$execute as @a[tag=survisland.pr_mirror,distance=..$(radius)] at @s run function survisland:modes/pr_stoupy/mirror/here/stop
$execute as @e[type=minecraft:marker,tag=survisland.pr_breakout.corner,distance=..$(radius)] run function survisland:modes/pr_stoupy/breakout/stop_corner
$execute as @e[type=minecraft:marker,tag=survisland.pr_orbit.hole,distance=..$(radius)] run function survisland:modes/pr_stoupy/orbit/stop_hole
$execute as @e[type=minecraft:marker,tag=survisland.pr_rats.cage,distance=..$(radius)] at @s run function survisland:modes/pr_stoupy/rats/here/stop
$execute as @e[type=minecraft:marker,tag=survisland.pr_stoupy.door,distance=..$(radius)] at @s run function survisland:modes/pr_stoupy/door/open with entity @s data

$kill @e[tag=survisland.pr_stoupy_duo.body,distance=..$(radius)]
$kill @e[tag=survisland.pr_stoupy_duo.seat,distance=..$(radius)]
$kill @e[tag=survisland.pr_mirror.body,distance=..$(radius)]
$kill @e[tag=survisland.pr_mirror.anchor,distance=..$(radius)]
$kill @e[tag=survisland.pr_breakout.corner,distance=..$(radius)]
$kill @e[tag=survisland.pr_breakout.screen,distance=..$(radius)]
$kill @e[tag=survisland.pr_breakout.bumper,distance=..$(radius)]
$kill @e[tag=survisland.pr_breakout.ball,distance=..$(radius)]
$kill @e[tag=survisland.pr_orbit.hole,distance=..$(radius)]
$kill @e[tag=survisland.pr_orbit.orbit,distance=..$(radius)]
$kill @e[tag=survisland.pr_orbit.collector,distance=..$(radius)]
$kill @e[tag=survisland.pr_orbit.sky,distance=..$(radius)]
$kill @e[tag=survisland.pr_orbit.fragment,distance=..$(radius)]
$kill @e[tag=survisland.pr_orbit.phantom,distance=..$(radius)]
$kill @e[tag=survisland.pr_orbit.pad,distance=..$(radius)]
$kill @e[tag=survisland.pr_rats.rat,distance=..$(radius)]
$kill @e[tag=survisland.pr_rats.model,distance=..$(radius)]
$kill @e[tag=survisland.pr_rats.cage,distance=..$(radius)]
$kill @e[tag=survisland.pr_rats.carried,distance=..$(radius)]
$kill @e[tag=survisland.pr_rats.caged,distance=..$(radius)]
$kill @e[tag=survisland.pr_stoupy.villager,distance=..$(radius)]
$kill @e[tag=survisland.pr_stoupy.door,distance=..$(radius)]
$tellraw @a[distance=..16] {"text":"Laboratoire : tout est supprimé à $(radius) blocs.","color":"green"}

