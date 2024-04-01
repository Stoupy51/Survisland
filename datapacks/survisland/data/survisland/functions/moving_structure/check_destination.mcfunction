
# If there is a player at the destination, launch it
$execute positioned ~$(offset_x) ~$(offset_y) ~$(offset_z) if entity @a[distance=..1,tag=!survisland.moving_structure_immune,gamemode=!spectator] run function survisland:moving_structure/launch_timer

