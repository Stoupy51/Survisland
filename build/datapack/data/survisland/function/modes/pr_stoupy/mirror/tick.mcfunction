
#> survisland:modes/pr_stoupy/mirror/tick
#
# @within	survisland:modes/pr_stoupy/mirror/start 1t replace [ scheduled ]
#			survisland:modes/pr_stoupy/mirror/tick 1t replace [ scheduled ]
#

scoreboard players set #pr_mirror_alive survisland.data 0
execute as @a[tag=survisland.pr_mirror] at @s run function survisland:modes/pr_stoupy/mirror/player_tick
execute if score #pr_mirror_alive survisland.data matches 0 run return run function survisland:modes/pr_stoupy/mirror/stop
schedule function survisland:modes/pr_stoupy/mirror/tick 1t replace

