
#> survisland:modes/pr_stoupy/duo/body/form_group
#
# @within	survisland:modes/pr_stoupy/duo/start
#

# The closest one becomes the Joueur 1 of this new group
scoreboard players add #pr_stoupy_duo_group_counter survisland.data 1
scoreboard players set #pr_stoupy_duo_slot survisland.data 0
execute as @a[tag=!survisland.pr_stoupy_duo,tag=!survisland.pr_stoupy.back,distance=..16,predicate=survisland:modes/pr_stoupy/on_start_pad,gamemode=!creative,gamemode=!spectator,limit=2,sort=nearest] run function survisland:modes/pr_stoupy/duo/body/enroll_player
execute as @a[tag=survisland.pr_stoupy_duo.new] at @s run function survisland:modes/pr_stoupy/teleport

# Their body is summoned on the Joueur 1, never on the caller which may be a command block inside a wall
execute at @a[tag=survisland.pr_stoupy_duo.new,scores={survisland.pr_stoupy_duo=1},limit=1] summon minecraft:mannequin run function survisland:modes/pr_stoupy/duo/body/new
tag @a[tag=survisland.pr_stoupy_duo.new] remove survisland.pr_stoupy_duo.new

