
#> survisland:cushion/compare_attacker
#
# @executed	as @e[type=interaction,tag=survisland.cushion,distance=..50]
#
# @within	survisland:cushion/punch_adv [ as @e[type=interaction,tag=survisland.cushion,distance=..50] ]
#

# Stop if this cushion's last attacker is not the player
scoreboard players set #is_attacker survisland.data 0
execute on attacker if entity @s[tag=survisland.temp] run scoreboard players set #is_attacker survisland.data 1
execute if score #is_attacker survisland.data matches 0 run return fail

# If it's the attacker, kill the cushion display and the interaction
execute at @s run playsound block.wool.break block @a[distance=..20]
execute at @s run particle poof ~ ~.1 ~ 0.2 0.05 0.2 0.01 20
execute at @s run kill @e[type=item_display,tag=survisland.cushion,distance=..0.1]
kill @s

