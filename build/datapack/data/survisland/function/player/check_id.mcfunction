
#> survisland:player/check_id
#
# @within	survisland:v2.1.5/second
#

# If ID not >= 1, launch first join
execute unless score @s survisland.id matches 1.. run function survisland:player/first_join

