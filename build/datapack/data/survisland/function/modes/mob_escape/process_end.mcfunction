
#> survisland:modes/mob_escape/process_end
#
# @within	survisland:modes/mob_escape/tick
#

scoreboard players add #process_end survisland.data 1
scoreboard players set #mob_escape_seconds survisland.data -1000

execute if score #process_end survisland.data matches 1 run tp @e[tag=survisland.mob] 0 -10000 0
execute if score #process_end survisland.data matches 1 run tellraw @a ["\n",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Fin de l'épreuve de Mob Escape avec une victoire de "},{"selector":"@a[tag=survisland.alive]"}]
execute if score #process_end survisland.data matches 1 run gamemode survival @a[team=mAkijan]
execute if score #process_end survisland.data matches 1 run gamemode survival @a[team=mHainy]
execute if score #process_end survisland.data matches 1 run gamemode survival @a[gamemode=adventure]
execute if score #process_end survisland.data matches 1 run effect give @a[gamemode=survival] slow_falling 20 0 true
execute if score #process_end survisland.data matches 1 as @a at @s run playsound entity.wither.death ambient @s

#Fin
execute if score #process_end survisland.data matches 600 run function survisland:modes/mob_escape/stop

