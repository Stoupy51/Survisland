
#> survisland:modes/pr_stoupy/duo/body/find_seat
#
# @executed	at @s
#
# @within	survisland:modes/pr_stoupy/duo/body/tick
#

# A teleport carries the mannequin and its passengers but never its seat, so the seat is brought back by hand
execute store success score #pr_stoupy_duo_seat survisland.data as @e[type=item_display,tag=survisland.pr_stoupy_duo.seat,predicate=survisland:modes/pr_stoupy/duo/same_group] run function survisland:modes/pr_stoupy/duo/body/seat_tick
execute if score #pr_stoupy_duo_seat survisland.data matches 0 summon minecraft:item_display run function survisland:modes/pr_stoupy/duo/body/new_seat

