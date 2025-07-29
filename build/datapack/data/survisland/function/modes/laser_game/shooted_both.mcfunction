
#> survisland:modes/laser_game/shooted_both
#
# @executed	as @e[tag=...] & at @s
#
# @within	survisland:modes/laser_game/shooted_player_blue
#			survisland:modes/laser_game/shooted_player_red
#

playsound entity.player.hurt player @s
execute as @a[tag=survisland.temp] at @s run playsound entity.arrow.hit_player player @s
scoreboard players add @a[tag=survisland.temp] survisland.temp.individual_points 10

execute if score @s survisland.temp.shield matches 1.. run scoreboard players remove @s survisland.temp.shield 1
execute if score @s survisland.temp.shield matches 1.. run tellraw @s [{"selector":"@a[tag=survisland.temp]"},{"translate": "survisland.vous_a_tir_dessus_plus_que","color":"gray"},{"score":{"name":"@s","objective":"survisland.temp.shield"},"color":"green"},{"translate": "survisland.points_de_bouclier","color":"gray"}]
execute if score @s survisland.temp.shield matches 1.. run tellraw @a[tag=survisland.temp] [{"translate": "survisland.vous_avez_tir_sur","color":"gray"},{"selector":"@s"},{"translate": "survisland.ayant_un_bouclier_il_lui_reste"},{"score":{"name":"@s","objective":"survisland.temp.shield"},"color":"green"},{"translate": "survisland.points_de_bouclier"}]

execute unless score @s survisland.temp.shield matches 1.. run tag @s add global.ignore
execute unless score @s survisland.temp.shield matches 1.. run tellraw @s [{"selector":"@a[tag=survisland.temp]"},{"translate": "survisland.vous_a_tir_dessus_vous_tes_dsactiv_pendant_5_secondes","color":"gray"}]
execute unless score @s survisland.temp.shield matches 1.. run tellraw @a[tag=survisland.temp] [{"translate": "survisland.vous_avez_tu","color":"gray"},{"selector":"@s"},{"translate": "survisland.10_points"}]
execute unless score @s survisland.temp.shield matches 1.. run scoreboard players set @s survisland.temp.dead_cooldown -100

