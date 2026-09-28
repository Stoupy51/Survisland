
#> survisland:modes/all_together/body/find_seat
#
# @executed	at @s
#
# @within	survisland:modes/all_together/body/tick
#

# A teleport carries the mannequin and its passengers but never its seat, so the seat is brought back by hand
execute store success score #all_together_seat survisland.data as @e[type=item_display,tag=survisland.all_together.seat,predicate=survisland:modes/all_together/same_group] run function survisland:modes/all_together/body/seat_tick
execute if score #all_together_seat survisland.data matches 0 summon minecraft:item_display run function survisland:modes/all_together/body/new_seat

