
##Fonction executée tous les ticks lorsque le mode de jeu est activé
schedule function survisland:modes/snk_lab/tick 1t replace

scoreboard players add #snk_lab_ticks survisland.data 1

execute as @a[gamemode=adventure,nbt={Inventory:[{tag:{ChuzData:{}}}]}] at @s if block ~ ~ ~ powder_snow run tp @s ~1.5 ~ ~
execute as @a[gamemode=adventure,nbt=!{Inventory:[{tag:{ChuzData:{}}}]}] at @s if block ~ ~-1 ~ note_block run tp @s ~1.5 ~ ~

execute if score #detect_end survisland.data matches 0 run function survisland:modes/snk_lab/update_sidebar

execute if score #detect_end survisland.data matches 0 if block -1283 68 -2822 redstone_lamp[lit=true] if block -1283 68 -2819 redstone_lamp[lit=true] run scoreboard players set #detect_end survisland.data 1
execute if score #detect_end survisland.data matches 0 if block -1283 68 -2780 redstone_lamp[lit=true] if block -1283 68 -2777 redstone_lamp[lit=true] run scoreboard players set #detect_end survisland.data 2
execute if score #detect_end survisland.data matches 1.. run function survisland:modes/snk_lab/process_end

