
#> survisland:utils/snuffer
#
# @executed	as @p[gamemode=!spectator,tag=!survisland.temp,distance=..3] & at @s
#
# @within	survisland:right_click/all
#			survisland:utils/right_click [ as @p[gamemode=!spectator,tag=!survisland.temp,distance=..3] & at @s ]
#			survisland:utils/right_click [ as @p[gamemode=!spectator,distance=..3] & at @s ]
#
# @executed			as & at player to change flambeau state
# 
# @description		Change flambeau state, playsound, and particles
#

# Flambeau state
scoreboard players set #count survisland.data 0
execute if data entity @s SelectedItem.components."minecraft:custom_data".survisland.flambeau store success score #count survisland.data run item modify entity @s weapon.mainhand survisland:switch_flambeau_state/mainhand
execute if score #count survisland.data matches 0 if data entity @s Inventory[-1].components."minecraft:custom_data".survisland.flambeau store success score #count survisland.data run item modify entity @s weapon.offhand survisland:switch_flambeau_state/offhand

# Play sound fire extinguish
execute unless score #count survisland.data matches 0 run playsound block.fire.extinguish master @a

# Particles
execute unless score #count survisland.data matches 0 run particle smoke ^-0.3 ^1.3 ^0.4 0.1 0.1 0.1 0 25 force @a
return 1

