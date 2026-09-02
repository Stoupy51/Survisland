
#> survisland:modes/all_together/body/remount
#
# @executed	at @s
#
# @within	survisland:modes/all_together/body/tick
#			survisland:modes/all_together/body/enter_phase/clairiere
#			survisland:modes/all_together/body/enter_phase/riviere
#			survisland:modes/all_together/body/enter_phase/fort
#

# The only pass still scanning the players, and it only runs while someone is off its vehicle
execute as @a[tag=survisland.all_together,distance=..16] if score @s survisland.all_together.group = #all_together_group survisland.data run function survisland:modes/all_together/body/mount_player

