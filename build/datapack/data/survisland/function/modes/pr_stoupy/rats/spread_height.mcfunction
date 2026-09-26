
#> survisland:modes/pr_stoupy/rats/spread_height
#
# @within	survisland:modes/pr_stoupy/rats/here/spawn_rats
#

function #bs.position:get_pos {scale:1}
execute store result storage survisland:pr_rats spread.max_y int 1 run scoreboard players add @s bs.pos.y 3
kill @s

