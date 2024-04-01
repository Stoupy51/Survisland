
# Move to the new position (remove the 'f' character before)
$data modify storage survisland:temp input set value {x:"$(x)",y:"$(y)",z:"$(z)"}
data modify storage survisland:temp input.x set string storage survisland:temp input.x 0 -1
data modify storage survisland:temp input.y set string storage survisland:temp input.y 0 -1
data modify storage survisland:temp input.z set string storage survisland:temp input.z 0 -1
function survisland:moving_structure/move_temp_marker with storage survisland:temp input

# Particles
execute at @s run particle glow ~ ~4 ~ 0.5 0.5 0.5 0 5

# Move the players
$execute at @s run tp @a[tag=survisland.linked_$(id)] ~ ~ ~

# Remove the tag if the cooldown is over
$execute if score #cooldown survisland.data matches 1 run tag @a[tag=survisland.linked_$(id)] remove survisland.linked_$(id)

