
#> survisland:modes/pr_stoupy/breakout/new_screen
#
# @executed	rotated as @s
#
# @within	survisland:modes/pr_stoupy/breakout/summon_screen
#

tag @s add survisland.pr_breakout.screen
scoreboard players operation @s survisland.pr_breakout.arena = #pr_breakout_arena survisland.data
data merge entity @s {billboard:"center",alignment:"center",background:0,shadow:0b,line_width:400,brightness:{sky:15,block:15},transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[3f,3f,3f]}}

