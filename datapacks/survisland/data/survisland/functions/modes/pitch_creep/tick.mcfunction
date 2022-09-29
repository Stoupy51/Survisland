
##Fonction executée tous les ticks lorsque le mode de jeu est activé

schedule function survisland:modes/pitch_creep/tick 1t replace
scoreboard players add #pitch_creep_ticks survisland.data 1

#On passe pas de l'autre côté !
execute as @a[team=mTuarua,tag=survisland.alive,predicate=survisland:in_water] at @s run tp @s ~5 ~1 ~
execute as @a[team=mPeluang,tag=survisland.alive,predicate=survisland:in_water] at @s run tp @s ~-5 ~1 ~

#Detection de mort
execute as @a[scores={survisland.temp.deathCount=1..}] run function survisland:modes/pitch_creep/death
execute as @e[type=player,tag=survisland.dead] run function survisland:modes/pitch_creep/death_teleport

#Comptage des entités restantes
execute store result score #creepers_restants survisland.data if entity @e[type=creeper,tag=survisland.creeper]
execute unless score #mTuarua_restants survisland.data matches 0 store result score #mTuarua_restants survisland.data if entity @a[team=mTuarua,gamemode=!spectator]
execute unless score #mPeluang_restants survisland.data matches 0 store result score #mPeluang_restants survisland.data if entity @a[team=mPeluang,gamemode=!spectator]

##Detection de fin
execute if score #detect_end survisland.data matches 0 if score #mTuarua_restants survisland.data matches 0 unless score #mPeluang_restants survisland.data matches 0 run scoreboard players set #detect_end survisland.data 1
execute if score #detect_end survisland.data matches 0 unless score #mTuarua_restants survisland.data matches 0 if score #mPeluang_restants survisland.data matches 0 run scoreboard players set #detect_end survisland.data 2
execute if score #detect_end survisland.data matches 0 if score #mTuarua_restants survisland.data matches 0 if score #mPeluang_restants survisland.data matches 0 run scoreboard players set #detect_end survisland.data 3
execute if score #detect_end survisland.data matches 0 run function survisland:modes/pitch_creep/update_sidebar
execute if score #detect_end survisland.data matches 1.. run function survisland:modes/pitch_creep/process_end


