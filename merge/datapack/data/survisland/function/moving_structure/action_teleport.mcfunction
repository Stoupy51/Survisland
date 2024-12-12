
# Move to the new position
$tp @s ~$(x) ~$(y) ~$(z)

# Particles
execute at @s run particle glow ~ ~5 ~ 0.75 0.5 0.75 0 5

# Move the players
$execute at @s run tp @a[tag=survisland.linked_$(id)] ~ ~ ~
$execute if score #cooldown survisland.data matches 0 at @s run tp @a[tag=survisland.linked_$(id)] ~ ~.25 ~
$execute as @a[tag=survisland.linked_$(id)] run attribute @s gravity base set 0

# Remove the tag if the cooldown is over and reset the gravity
$execute if score #cooldown survisland.data matches 0 as @a[tag=survisland.linked_$(id)] run attribute @s gravity base reset
$execute if score #cooldown survisland.data matches 0 run tag @a[tag=survisland.linked_$(id)] remove survisland.linked_$(id)

# Kill temporary marker
kill @s

