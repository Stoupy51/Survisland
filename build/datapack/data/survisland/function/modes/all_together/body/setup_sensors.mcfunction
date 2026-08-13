
#> survisland:modes/all_together/body/setup_sensors
#
# @executed	at @s
#
# @within	survisland:modes/all_together/body/new [ at @s ]
#

# Single scan of the group: every player becomes an invisible sensor
execute as @a[tag=survisland.all_together,distance=..50] run function survisland:modes/all_together/body/setup_player

function survisland:modes/all_together/body/set_phase/prologue

