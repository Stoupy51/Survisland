
#> survisland:adventure_zone/leave
#
# @within			survisland:adventure_zone/second
# @executed			as the player who left the zone
#
# @description		Switches the player to survival mode and removes the tag
#

# Adventure -> Survival
gamemode survival @s[gamemode=adventure]

# Tag player
tag @s remove survisland.in_adv_zone

