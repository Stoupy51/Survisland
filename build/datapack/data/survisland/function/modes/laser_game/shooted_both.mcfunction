
#> survisland:modes/laser_game/shooted_both
#
# @within	survisland:modes/laser_game/shooted_player_blue
#			survisland:modes/laser_game/shooted_player_red
#

playsound entity.player.hurt player @s
execute as @a[tag=survisland.temp] at @s run playsound entity.arrow.hit_player player @s
scoreboard players add @a[tag=survisland.temp] survisland.temp.individual_points 10

execute if score @s survisland.temp.shield matches 1.. run scoreboard players remove @s survisland.temp.shield 1
execute if score @s survisland.temp.shield matches 1.. run tellraw @s [{"selector":"@a[tag=survisland.temp]"},{"text":" vous a tiré dessus ! Plus que ","color":"gray"},{"score":{"name":"@s","objective":"survisland.temp.shield"},"color":"green"},{"text":" points de bouclier.","color":"gray"}]
execute if score @s survisland.temp.shield matches 1.. run tellraw @a[tag=survisland.temp] [{"text":"Vous avez tiré sur ","color":"gray"},{"selector":"@s"},{"text":" ayant un bouclier, il lui reste "},{"score":{"name":"@s","objective":"survisland.temp.shield"},"color":"green"},{"text":" points de bouclier."}]

execute unless score @s survisland.temp.shield matches 1.. run tag @s add global.ignore
execute unless score @s survisland.temp.shield matches 1.. run tellraw @s [{"selector":"@a[tag=survisland.temp]"},{"text":" vous a tiré dessus ! Vous êtes désactivé pendant 5 secondes.","color":"gray"}]
execute unless score @s survisland.temp.shield matches 1.. run tellraw @a[tag=survisland.temp] [{"text":"Vous avez tué ","color":"gray"},{"selector":"@s"},{"text":" ! [+10 points]"}]
execute unless score @s survisland.temp.shield matches 1.. run scoreboard players set @s survisland.temp.dead_cooldown -100

