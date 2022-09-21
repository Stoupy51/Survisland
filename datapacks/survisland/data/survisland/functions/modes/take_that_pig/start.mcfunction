
##Fonction executée lors du lancement de la partie

tellraw @a ["\n",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Zééééééé parti !!!! Ramenez-moi un maximum d'animaux !"}]

gamemode adventure @a[gamemode=survival]

scoreboard objectives add survisland.temp.sidebar dummy {"text":"Classement des scores","color":"yellow"}
scoreboard objectives setdisplay sidebar survisland.temp.sidebar

scoreboard players set #take_that_pig_seconds survisland.data 0
scoreboard players set #take_that_pig_ticks survisland.data 0
scoreboard players set #remaining_time survisland.data 150
scoreboard players set #process_end survisland.data 0
scoreboard players set @a[gamemode=!creative,gamemode=!spectator] survisland.temp.sidebar 0


##Définition des couleurs selon la concrete sous le pied des joueurs
execute as @a[gamemode=!creative,gamemode=!spectator] run function survisland:modes/take_that_pig/define_color


schedule function survisland:modes/take_that_pig/tick 1t replace
schedule function survisland:modes/take_that_pig/second 1s replace

