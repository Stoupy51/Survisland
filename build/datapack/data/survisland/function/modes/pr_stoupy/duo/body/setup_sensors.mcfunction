
#> survisland:modes/pr_stoupy/duo/body/setup_sensors
#
# @executed	at @s
#
# @within	survisland:modes/pr_stoupy/duo/body/new [ at @s ]
#

# The freshly enrolled players are still scattered around the start block, so they are taken by tag
scoreboard players operation @a[tag=survisland.pr_stoupy_duo.new] survisland.pr_stoupy_duo.group = @s survisland.pr_stoupy_duo.group
execute as @a[tag=survisland.pr_stoupy_duo.new] run function survisland:modes/pr_stoupy/duo/body/setup_player

# Deals the first command set, then puts everyone on its vehicle
function survisland:modes/pr_stoupy/duo/body/enter_phase/laboratoire

