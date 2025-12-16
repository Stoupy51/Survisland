
#> survisland:advancements/open_manual
#
# @executed	as the player & at current position
#
# @within	advancement survisland:technical/open_manual
#

# Revoke advancement and reset score
advancement revoke @s only survisland:technical/open_manual
scoreboard players set @s survisland.open_manual 0

# Show manual dialog if holding the manual
execute if items entity @s weapon.* *[custom_data~{survisland:{manual:true}}] run dialog show @s survisland:manual/page_1

