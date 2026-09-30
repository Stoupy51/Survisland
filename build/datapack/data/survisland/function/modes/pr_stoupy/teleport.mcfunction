
#> survisland:modes/pr_stoupy/teleport
#
# @executed	as @a[tag=survisland.pr_stoupy_duo.new] & at @s
#
# @within	survisland:modes/pr_stoupy/duo/body/form_group [ as @a[tag=survisland.pr_stoupy_duo.new] & at @s ]
#			survisland:modes/pr_stoupy/mirror/start [ at @s ]
#			survisland:modes/pr_stoupy/breakout/start [ as @a[tag=survisland.pr_breakout.new] & at @s ]
#

# Every start runs it, so the rats carried into a trial are put back on the ground before anyone moves
function survisland:modes/pr_stoupy/rats/release
scoreboard objectives add survisland.pr_stoupy.x dummy
execute store result score @s survisland.pr_stoupy.x run data get entity @s Pos[0] 100
scoreboard objectives add survisland.pr_stoupy.y dummy
execute store result score @s survisland.pr_stoupy.y run data get entity @s Pos[1] 100
scoreboard objectives add survisland.pr_stoupy.z dummy
execute store result score @s survisland.pr_stoupy.z run data get entity @s Pos[2] 100
execute if data storage survisland:pr_stoupy {tp:""} run return 0
function survisland:modes/pr_stoupy/teleport_by with storage survisland:pr_stoupy

