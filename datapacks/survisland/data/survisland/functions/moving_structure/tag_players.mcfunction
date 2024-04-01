
$execute if score #state survisland.data matches 0 run tag @a[distance=..1,tag=!survisland.moving_structure_immune] add survisland.linked_$(id)
$execute if score #state survisland.data matches 1 positioned ~$(offset_x) ~$(offset_y) ~$(offset_z) run tag @a[distance=..1,tag=!survisland.moving_structure_immune] add survisland.linked_$(id)

