
#> survisland:utils/snuffer
#
# @within			survisland:right_click/all
# @executed			as & at player to change flambeau state
#
# @description		Change flambeau state, playsound, and particles
#

# Flambeau state
item modify entity @s weapon.mainhand survisland:switch_flambeau_state

# Play sound fire extinguish
playsound block.fire.extinguish master @a ~ ~ ~ 1 1 1

# Particles
particle smoke ^-0.3 ^1.3 ^0.4 0.1 0.1 0.1 0 25 force @a

