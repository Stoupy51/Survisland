
##Fonction executée tous les ticks lorsque le mode de jeu est activé
schedule function survisland:modes/find_that_button/tick 1t replace

scoreboard players add #find_that_button_ticks survisland.data 1

execute as @a[team=mKembali,nbt={Inventory:[{tag:{survisland:{button:1b}}}]}] positioned 0 0 0 run function survisland:modes/find_that_button/button_kembali
execute as @a[team=mTuarua,nbt={Inventory:[{tag:{survisland:{button:1b}}}]}] positioned 0 0 0 run function survisland:modes/find_that_button/button_tuarua
execute as @a[team=mPeluang,nbt={Inventory:[{tag:{survisland:{button:1b}}}]}] positioned 0 0 0 run function survisland:modes/find_that_button/button_peluang

execute if score #detect_end survisland.data matches 0 if score #mKembali_buttons survisland.data matches 20 if block -1265 117 -2828 redstone_lamp[lit=true] run scoreboard players set #detect_end survisland.data 1
execute if score #detect_end survisland.data matches 0 if score #mTuarua_buttons survisland.data matches 20 if block -1265 117 -2798 redstone_lamp[lit=true] run scoreboard players set #detect_end survisland.data 2
execute if score #detect_end survisland.data matches 0 if score #mPeluang_buttons survisland.data matches 20 if block -1265 117 -2768 redstone_lamp[lit=true] run scoreboard players set #detect_end survisland.data 3
execute if score #detect_end survisland.data matches 1.. run function survisland:modes/find_that_button/process_end

