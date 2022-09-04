
playsound entity.player.hurt player @s
execute as @a[tag=survisland.temp] at @s run playsound entity.arrow.hit_player player @s
function survisland:modes/laser_game/shooted_both

execute unless score @s survisland.temp.shield matches 1.. run scoreboard players add #red_points survisland.data 10
execute unless score @s survisland.temp.shield matches 1.. run function survisland:modes/laser_game/update_sidebar/red_points

