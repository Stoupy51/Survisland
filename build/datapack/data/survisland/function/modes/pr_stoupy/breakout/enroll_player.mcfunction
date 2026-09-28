
#> survisland:modes/pr_stoupy/breakout/enroll_player
#
# @executed	as @a[tag=survisland.pr_breakout.new,sort=nearest] & at @s
#
# @within	survisland:modes/pr_stoupy/breakout/start [ as @a[tag=survisland.pr_breakout.new,sort=nearest] & at @s ]
#

scoreboard players add #pr_breakout_slot_counter survisland.data 1
scoreboard players operation @s survisland.pr_breakout = #pr_breakout_slot_counter survisland.data
scoreboard players operation @s survisland.pr_breakout.arena = #pr_breakout_arena survisland.data
tag @s add survisland.pr_breakout
attribute @s minecraft:movement_speed modifier add survisland:pr_breakout_frozen -1 add_multiplied_total
scoreboard players set @s survisland.pr_breakout.color -1
execute if block ~ ~-1 ~ #survisland:pr_stoupy/breakout/white run scoreboard players set @s survisland.pr_breakout.color 0
execute if block ~ ~-1 ~ #survisland:pr_stoupy/breakout/orange run scoreboard players set @s survisland.pr_breakout.color 1
execute if block ~ ~-1 ~ #survisland:pr_stoupy/breakout/magenta run scoreboard players set @s survisland.pr_breakout.color 2
execute if block ~ ~-1 ~ #survisland:pr_stoupy/breakout/light_blue run scoreboard players set @s survisland.pr_breakout.color 3
execute if block ~ ~-1 ~ #survisland:pr_stoupy/breakout/yellow run scoreboard players set @s survisland.pr_breakout.color 4
execute if block ~ ~-1 ~ #survisland:pr_stoupy/breakout/lime run scoreboard players set @s survisland.pr_breakout.color 5
execute if block ~ ~-1 ~ #survisland:pr_stoupy/breakout/pink run scoreboard players set @s survisland.pr_breakout.color 6
execute if block ~ ~-1 ~ #survisland:pr_stoupy/breakout/gray run scoreboard players set @s survisland.pr_breakout.color 7
execute if block ~ ~-1 ~ #survisland:pr_stoupy/breakout/light_gray run scoreboard players set @s survisland.pr_breakout.color 8
execute if block ~ ~-1 ~ #survisland:pr_stoupy/breakout/cyan run scoreboard players set @s survisland.pr_breakout.color 9
execute if block ~ ~-1 ~ #survisland:pr_stoupy/breakout/purple run scoreboard players set @s survisland.pr_breakout.color 10
execute if block ~ ~-1 ~ #survisland:pr_stoupy/breakout/blue run scoreboard players set @s survisland.pr_breakout.color 11
execute if block ~ ~-1 ~ #survisland:pr_stoupy/breakout/brown run scoreboard players set @s survisland.pr_breakout.color 12
execute if block ~ ~-1 ~ #survisland:pr_stoupy/breakout/green run scoreboard players set @s survisland.pr_breakout.color 13
execute if block ~ ~-1 ~ #survisland:pr_stoupy/breakout/red run scoreboard players set @s survisland.pr_breakout.color 14
execute if block ~ ~-1 ~ #survisland:pr_stoupy/breakout/black run scoreboard players set @s survisland.pr_breakout.color 15

