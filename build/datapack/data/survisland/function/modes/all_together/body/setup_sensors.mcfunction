
#> survisland:modes/all_together/body/setup_sensors
#
# @executed	at @s
#
# @within	survisland:modes/all_together/body/new [ at @s ]
#

# The freshly enrolled players are still scattered around the start block, so they are taken by tag
execute as @a[tag=survisland.all_together.new] run function survisland:modes/all_together/body/setup_player

function survisland:modes/all_together/body/enter_phase/clairiere

