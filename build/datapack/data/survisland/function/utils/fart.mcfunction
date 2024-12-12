
#> survisland:utils/fart
#
# @within	survisland:v2.1.2/tick
#

#> survisland:utils/fart
#
# @within			survisland:tick
# @executed			as & at the player who farted
#
# @description		Manage fart sound, particles, farted tag
#

# Play fart sound
playsound survisland:fart master @a[distance=..10]

# Spawn fart particles behind the player
particle dust{color:[0,255,0],scale:2} ^ ^ ^-0.5 0.1 0.1 0.1 1 10 force @a[distance=..10]

# Add farted tag
tag @s add survisland.farted

