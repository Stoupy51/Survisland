
#> survisland:player/check_id
#
# @executed	as @a
#
# @within	survisland:v2.4.3/second [ as @a ]
#

# If ID not >= 1, launch first join
execute unless score @s survisland.id matches 1.. run function survisland:player/first_join

