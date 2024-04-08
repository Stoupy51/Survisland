
#> survisland:utils/snuffer
#
# @within			survisland:right_click/all
# @executed			as & at player to change flambeau state
#
# @description		Change flambeau state, playsound, and particles
#

# Flambeau state
scoreboard players set #count survisland.data 0
execute store result score #count survisland.data run item modify entity @s weapon.mainhand survisland:switch_flambeau_state
execute if score #count survisland.data matches 0 store result score #count survisland.data run item modify entity @s weapon.mainhand survisland:switch_flambeau_state_offhand

# Play sound fire extinguish
execute unless score #count survisland.data matches 0 run playsound block.fire.extinguish master @a

# Particles
execute unless score #count survisland.data matches 0 run particle smoke ^-0.3 ^1.3 ^0.4 0.1 0.1 0.1 0 25 force @a
return 1

