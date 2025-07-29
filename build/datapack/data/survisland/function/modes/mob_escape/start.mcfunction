
#> survisland:modes/mob_escape/start
#
# @within	???
#

##Fonction executée lors du lancement de la partie

tellraw @a ["\n",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"translate": "survisland.z_parti"}]

gamemode adventure @a[gamemode=survival]
tag @a[gamemode=adventure] add survisland.alive

scoreboard objectives add survisland.temp.death_count deathCount

scoreboard players set #mob_escape_seconds survisland.data 0
scoreboard players set #mob_escape_ticks survisland.data 0
scoreboard players set #process_end survisland.data 0

schedule function survisland:modes/mob_escape/tick 1t replace
schedule function survisland:modes/mob_escape/second 1s replace

