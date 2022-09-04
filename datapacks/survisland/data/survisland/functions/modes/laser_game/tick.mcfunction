
##Fonction executée tous les ticks lorsque le mode de jeu est activé

scoreboard players add #laser_game_ticks survisland.data 1

scoreboard players add @a[team=!zStaff,team=!zSpec,team=!zOut,team=!aMJ] survisland.temp.cooldown 0
scoreboard players add @a[team=!zStaff,team=!zSpec,team=!zOut,team=!aMJ] survisland.temp.dead_cooldown 0
scoreboard players add @a[scores={survisland.temp.cooldown=..-1}] survisland.temp.cooldown 1
execute as @a[scores={survisland.temp.dead_cooldown=..-1}] at @s run function survisland:modes/laser_game/death_animation
execute as @a[scores={survisland.right_click=1..},sort=random] at @s run function survisland:modes/laser_game/right_click
execute as @a[team=!zStaff,team=!zSpec,team=!zOut,team=!aMJ] run function survisland:modes/laser_game/give_items
kill @e[type=item]

scoreboard players reset @a survisland.right_click

schedule function survisland:modes/laser_game/tick 1t replace
execute if score #remaining_time survisland.data matches ..0 run function survisland:modes/laser_game/process_end

