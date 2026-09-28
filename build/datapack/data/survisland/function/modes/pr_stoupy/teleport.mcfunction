
#> survisland:modes/pr_stoupy/teleport
#
# @executed	as @a[tag=survisland.pr_stoupy_duo.new] & at @s
#
# @within	survisland:modes/pr_stoupy/duo/body/form_group [ as @a[tag=survisland.pr_stoupy_duo.new] & at @s ]
#			survisland:modes/pr_stoupy/mirror/start [ at @s ]
#			survisland:modes/pr_stoupy/breakout/start [ as @a[tag=survisland.pr_breakout.new] & at @s ]
#

execute if data storage survisland:pr_stoupy {tp:""} run return 0
function survisland:modes/pr_stoupy/teleport_by with storage survisland:pr_stoupy

