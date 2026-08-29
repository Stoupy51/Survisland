
#> survisland:modes/all_together/body/read_player
#
# @executed	at @s & as @a[tag=survisland.all_together,distance=..3]
#
# @within	survisland:modes/all_together/body/tick [ at @s & as @a[tag=survisland.all_together,distance=..3] ]
#

# Stick this sensor on the mannequin eyes, and lock its view on the mannequin aim
tp @s ~ ~1.519 ~ ~ ~

# Report the keys it is holding down (crawl has no vanilla key, it is read on CRAWL_KEY)
execute if entity @s[tag=survisland.all_together.forward,predicate=survisland:input/forward] run scoreboard players add #all_together_in_forward survisland.data 1
execute if entity @s[tag=survisland.all_together.backward,predicate=survisland:input/backward] run scoreboard players add #all_together_in_backward survisland.data 1
execute if entity @s[tag=survisland.all_together.left,predicate=survisland:input/left] run scoreboard players add #all_together_in_left survisland.data 1
execute if entity @s[tag=survisland.all_together.right,predicate=survisland:input/right] run scoreboard players add #all_together_in_right survisland.data 1
execute if entity @s[tag=survisland.all_together.jump,predicate=survisland:input/jump] run scoreboard players add #all_together_in_jump survisland.data 1
execute if entity @s[tag=survisland.all_together.sneak,predicate=survisland:input/sneak] run scoreboard players add #all_together_in_sneak survisland.data 1
execute if entity @s[tag=survisland.all_together.sprint,predicate=survisland:input/sprint] run scoreboard players add #all_together_in_sprint survisland.data 1
execute if entity @s[tag=survisland.all_together.crawl,predicate=survisland:input/sprint] run scoreboard players add #all_together_in_crawl survisland.data 1
execute if entity @s[tag=survisland.all_together.forward] run scoreboard players add #all_together_in_holders survisland.data 1

