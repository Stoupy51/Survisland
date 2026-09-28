
#> survisland:modes/pr_stoupy/mirror/reflect_yaw_z
#
# @executed	as @a[tag=survisland.pr_mirror] & at @s
#
# @within	survisland:modes/pr_stoupy/mirror/player_tick
#

scoreboard players operation #pr_mirror_yaw survisland.data *= #-1 survisland.data
scoreboard players operation #pr_mirror_yaw survisland.data += #18000 survisland.data

