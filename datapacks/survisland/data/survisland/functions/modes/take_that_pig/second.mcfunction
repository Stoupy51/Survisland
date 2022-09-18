

scoreboard players remove #remaining_time survisland.data 1

title @a actionbar [{"text":"Temps restant : ","color":"aqua"},{"score":{"name":"#remaining_time","objective":"survisland.data"},"color":"yellow"},{"text":" secondes"}]

execute if score #remaining_time survisland.data matches 149 as @e[limit=8] run summon pig -2261 80 -1175 {InLove:2000,AbsorptionAmount:2048.0f}
execute if predicate survisland:chance/0.2 run summon pig -2261 80 -1175 {InLove:2000,AbsorptionAmount:2048.0f}
execute if predicate survisland:chance/0.1 run summon cow -2261 80 -1175 {InLove:2000,AbsorptionAmount:2048.0f}
execute if predicate survisland:chance/0.1 run summon horse -2261 80 -1175 {InLove:2000,AbsorptionAmount:2048.0f}
execute if predicate survisland:chance/0.1 run summon chicken -2261 80 -1175 {InLove:2000,AbsorptionAmount:2048.0f}

#Prank de spectateurs
execute if score #remaining_time survisland.data matches 60 as @a[gamemode=spectator,limit=2,sort=random,team=zSpec] run function survisland:modes/take_that_pig/summon_spectators
execute if score #remaining_time survisland.data matches 60 run tellraw @a ["\n",{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"text":" Incroyable ! Deux spectateurs sont apparus, combien de points peuvent-ils donner ?!!"}]
execute if score #remaining_time survisland.data matches 60 as @a at @s run playsound entity.wither.ambient ambient @s 


schedule function survisland:modes/take_that_pig/second 1s replace

