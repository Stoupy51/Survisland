
#> survisland:modes/pr_stoupy/duo/body/new_seat
#
# @executed	at @s
#
# @within	survisland:modes/pr_stoupy/duo/body/new [ at @s ]
#			survisland:modes/pr_stoupy/duo/body/find_seat
#

tag @s add survisland.pr_stoupy_duo.seat
scoreboard players operation @s survisland.pr_stoupy_duo.group = #pr_stoupy_duo_group survisland.data
data merge entity @s {teleport_duration:2}

