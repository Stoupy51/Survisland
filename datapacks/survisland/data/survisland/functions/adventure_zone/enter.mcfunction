
#> survisland:adventure_zone/enter
#
# @within			survisland:adventure_zone/second
# @executed			as the player who entered the zone
#
# @description		Switches the player to adventure mode and tags them
#

# Survival -> Adventure
gamemode adventure @s[gamemode=survival]

# Tag player
tag @s add survisland.in_adv_zone

