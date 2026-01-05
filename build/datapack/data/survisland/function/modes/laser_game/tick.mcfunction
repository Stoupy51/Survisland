
#> survisland:modes/laser_game/tick
#
# @within	survisland:modes/laser_game/start 1t [ scheduled ]
#			survisland:modes/laser_game/tick 1t [ scheduled ]
#

## Fonction executée tous les ticks lorsque le mode de jeu est activé

scoreboard players add #laser_game_ticks survisland.data 1

execute as @a run function survisland:modes/laser_game/xp_bar
execute as @a[scores={survisland.right_click=1..},sort=random] at @s run function survisland:modes/laser_game/right_click
execute as @a run function survisland:modes/laser_game/give_items
kill @e[type=item]

execute if score #remaining_time survisland.data matches ..0 run function survisland:modes/laser_game/process_end
execute if score #remaining_time survisland.data matches 1.. run schedule function survisland:modes/laser_game/tick 1t

