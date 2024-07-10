
## Fonction executée toutes les secondes lorsque le mode de jeu est activé

scoreboard players add #quake_seconds survisland.data 1
execute if score #remaining_time survisland.data matches 1.. run scoreboard players remove #remaining_time survisland.data 1
execute if score #remaining_time survisland.data matches 1.. run schedule function survisland:modes/quake/second 1s

