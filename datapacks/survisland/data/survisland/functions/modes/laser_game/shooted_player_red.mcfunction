
function survisland:modes/laser_game/shooted_both

execute unless score @s survisland.temp.shield matches 1.. run scoreboard players add #blue_points survisland.data 10
execute unless score @s survisland.temp.shield matches 1.. run function survisland:modes/laser_game/update_sidebar/blue_points/

