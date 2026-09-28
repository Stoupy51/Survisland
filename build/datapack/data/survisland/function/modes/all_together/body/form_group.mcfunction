
#> survisland:modes/all_together/body/form_group
#
# @within	survisland:modes/all_together/start
#

# The closest one becomes the Joueur 1 of this new group
scoreboard players add #all_together_group_counter survisland.data 1
scoreboard players set #all_together_slot survisland.data 0
execute as @a[tag=!survisland.all_together,distance=..3,gamemode=!creative,gamemode=!spectator,limit=4,sort=nearest] run function survisland:modes/all_together/body/enroll_player

# Their body is summoned on the Joueur 1, never on the caller which may be a command block inside a wall
execute at @a[tag=survisland.all_together.new,scores={survisland.all_together=1},limit=1] summon minecraft:mannequin run function survisland:modes/all_together/body/new
tag @a[tag=survisland.all_together.new] remove survisland.all_together.new

