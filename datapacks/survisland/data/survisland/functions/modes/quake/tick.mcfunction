
## Fonction executée tous les ticks lorsque le mode de jeu est activé

scoreboard players add #quake_ticks survisland.data 1

execute as @a[scores={survisland.right_click=1..},sort=random] at @s run function survisland:modes/quake/right_click
scoreboard players add @a[scores={survisland.temp.cooldown=..-1}] survisland.temp.cooldown 1

execute if score #remaining_time survisland.data matches ..0 run function survisland:modes/quake/process_end
execute if score #remaining_time survisland.data matches 1.. run schedule function survisland:modes/quake/tick 1t

