
#> survisland:modes/take_that_pig/advancements/killed_by_player
#
# @within	???
#

advancement revoke @s only survisland:take_that_pig/killed_by_player
execute if score #game survisland.data matches 69 run gamemode spectator @s
execute if score #game survisland.data matches 69 run tag @s remove survisland.to_take_spec

