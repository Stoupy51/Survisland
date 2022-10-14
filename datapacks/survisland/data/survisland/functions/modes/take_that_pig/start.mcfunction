
##Fonction executée lors du lancement de la partie

tellraw @a ["\n",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Zééééééé parti !!!! Ramenez-moi un maximum d'animaux !"}]

gamemode adventure @a[gamemode=survival]
time set 6000

scoreboard objectives add survisland.temp.color dummy
scoreboard objectives add survisland.temp.sidebar dummy {"text":"Classement des scores","color":"yellow"}
scoreboard objectives setdisplay sidebar survisland.temp.sidebar

scoreboard players set #take_that_pig_seconds survisland.data 0
scoreboard players set #take_that_pig_ticks survisland.data 0
scoreboard players set #remaining_time survisland.data 150
scoreboard players set #process_end survisland.data 0
scoreboard players set #detect_end survisland.data 0
scoreboard players set @a[gamemode=!creative,gamemode=!spectator] survisland.temp.sidebar 0


##Définition des couleurs selon la concrete sous le pied des joueurs
execute as @a[gamemode=!creative,gamemode=!spectator] run function survisland:modes/take_that_pig/define_color

#Start
fill -1219 58 -2805 -1221 61 -2807 birch_planks replace structure_void
fill -1268 52 -2793 -1268 55 -2798 emerald_block replace air
fill -1221 55 -2805 -1219 55 -2807 glass
execute as @e[limit=8] run summon pig -1220 64 -2806 {Tags:["survisland.to_take"],AbsorptionAmount:2048.0f}
team modify mMerge friendlyFire false


schedule function survisland:modes/take_that_pig/tick 1t replace
schedule function survisland:modes/take_that_pig/second 1s replace

