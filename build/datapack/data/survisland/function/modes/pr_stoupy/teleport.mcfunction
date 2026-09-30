
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
execute if data storage survisland:pr_stoupy {tp:""} run return 0
function survisland:modes/pr_stoupy/teleport_by with storage survisland:pr_stoupy

