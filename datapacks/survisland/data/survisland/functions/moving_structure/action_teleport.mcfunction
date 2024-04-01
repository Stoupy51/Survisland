
# Move to the new position
$tp @s ~$(x) ~$(y) ~$(z)

# Particles
execute at @s run particle glow ~ ~5 ~ 0.75 0.5 0.75 0 5

# Move the players
$execute at @s run tp @a[tag=survisland.linked_$(id)] ~.5 ~ ~.5
$effect give @a[tag=survisland.linked_$(id)] levitation 1 255 true

# Remove the tag if the cooldown is over
$execute if score #cooldown survisland.data matches 1 run tag @a[tag=survisland.linked_$(id)] remove survisland.linked_$(id)

# Kill temporary marker
kill @s

