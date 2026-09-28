
#> survisland:modes/pr_stoupy/mirror/here/place_door
#
# @within	???
#
# @args		block (unknown)
#			radius (unknown)
#

# One block of a doorway, filled with $(block) while a player of the trial is within $(radius) blocks
execute align xyz positioned ~0.5 ~ ~0.5 run kill @e[type=minecraft:marker,tag=survisland.pr_stoupy.door,distance=..0.5]
$execute align xyz positioned ~0.5 ~ ~0.5 run summon minecraft:marker ~ ~ ~ {Tags:["survisland.pr_stoupy.door"],data:{block:"$(block)",player_tag:"survisland.pr_mirror",radius:$(radius)}}
tellraw @a[distance=..16] {"text":"Porte placée.","color":"green"}

