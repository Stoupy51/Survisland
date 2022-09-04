
scoreboard players reset @s survisland.right_click
execute if score @s[tag=!global.ignore] survisland.temp.cooldown matches 0 run function survisland:modes/laser_game/shoot
title @s[tag=global.ignore] actionbar [{"text":"[Laser Game] ","color":"red"},{"text":"Vous ne pouvez pas tirer pour le moment.","color":"white"}]
playsound block.note_block.snare ambient @s[tag=global.ignore] ~ ~ ~ 1 0.5

