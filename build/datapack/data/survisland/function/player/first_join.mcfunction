
#> survisland:player/first_join
#
# @executed	as the player & at current position
#
# @within	advancement survisland:id_system
#			survisland:player/check_id
#

# ID System
scoreboard players add #next_id survisland.id 1
scoreboard players operation @s survisland.id = #next_id survisland.id

