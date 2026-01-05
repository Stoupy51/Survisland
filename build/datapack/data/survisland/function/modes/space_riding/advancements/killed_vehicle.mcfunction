
#> survisland:modes/space_riding/advancements/killed_vehicle
#
# @within	???
#

# Revoke advancement
advancement revoke @s only survisland:space_riding/killed_vehicle

# Check if
execute if score #game survisland.data matches 70 run function survisland:modes/space_riding/advancements/killed_vehicle_confirm

