
#> survisland:modes/space_riding/summon/3_chicken
#
# @within	???
#

# Configure the summons
scoreboard players set #is_vulnerable shopping_kart.data 1
scoreboard players set #can_fly shopping_kart.data 1

# Summon the entity
execute summon chicken at @s run function shopping_kart:kart/switch_model/init_functions
team join mMerge @e[type=!player,distance=..5]

# Reset summon configuration
scoreboard players reset #is_vulnerable shopping_kart.data
scoreboard players reset #can_fly shopping_kart.data

