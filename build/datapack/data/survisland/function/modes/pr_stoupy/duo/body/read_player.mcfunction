
#> survisland:modes/pr_stoupy/duo/body/read_player
#
# @executed	at @s
#
# @within	survisland:modes/pr_stoupy/duo/body/tick
#			survisland:modes/pr_stoupy/duo/body/seat_tick
#			survisland:modes/pr_stoupy/duo/body/mount_player
#			survisland:modes/pr_stoupy/duo/body/mount_seat
#

scoreboard players add #pr_stoupy_duo_crew survisland.data 1

# Report the keys it is holding down (crawl has no vanilla key, it is read on CRAWL_KEY)
execute if entity @s[tag=survisland.pr_stoupy_duo.forward,predicate=survisland:input/forward] run scoreboard players add #pr_stoupy_duo_in_forward survisland.data 1
execute if entity @s[tag=survisland.pr_stoupy_duo.backward,predicate=survisland:input/backward] run scoreboard players add #pr_stoupy_duo_in_backward survisland.data 1
execute if entity @s[tag=survisland.pr_stoupy_duo.left,predicate=survisland:input/left] run scoreboard players add #pr_stoupy_duo_in_left survisland.data 1
execute if entity @s[tag=survisland.pr_stoupy_duo.right,predicate=survisland:input/right] run scoreboard players add #pr_stoupy_duo_in_right survisland.data 1
execute if entity @s[tag=survisland.pr_stoupy_duo.jump,predicate=survisland:input/jump] run scoreboard players add #pr_stoupy_duo_in_jump survisland.data 1
execute if entity @s[tag=survisland.pr_stoupy_duo.sneak,predicate=survisland:input/sneak] run scoreboard players add #pr_stoupy_duo_in_sneak survisland.data 1
execute if entity @s[tag=survisland.pr_stoupy_duo.sprint,predicate=survisland:input/sprint] run scoreboard players add #pr_stoupy_duo_in_sprint survisland.data 1
execute if entity @s[tag=survisland.pr_stoupy_duo.crawl,predicate=survisland:input/sprint] run scoreboard players add #pr_stoupy_duo_in_crawl survisland.data 1

