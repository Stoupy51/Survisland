
#> survisland:modes/shiren_trials/race/start
#
# @within	???
#

# Start race (Shopping Kart model, force rotation, summon new kart)
scoreboard players set @s shopping_kart.current_model 0
data modify storage shopping_kart:main ForcedRotation set value [180.0f, 0.0f]
function shopping_kart:kart/switch_model/summon_new_kart

# Register start time
scoreboard players set @s survisland.temp.race_start 0

