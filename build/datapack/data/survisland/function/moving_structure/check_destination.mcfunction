
#> survisland:moving_structure/check_destination
#
# @executed	at @s
#
# @within	survisland:moving_structure/tick with entity @s data
#
# @args		offset_x (unknown)
#			offset_y (unknown)
#			offset_z (unknown)
#

# If there is a player at the destination, launch it
$execute positioned ~$(offset_x) ~$(offset_y) ~$(offset_z) if entity @a[distance=..2,tag=!survisland.moving_structure_immune,gamemode=!spectator] run function survisland:moving_structure/launch_timer

