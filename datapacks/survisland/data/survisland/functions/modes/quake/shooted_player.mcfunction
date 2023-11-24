
function survisland:modes/quake/respawn

execute at @s run playsound entity.player.hurt player @s
execute as @a[tag=survisland.temp] at @s run playsound entity.arrow.hit_player player @s
scoreboard players add @a[tag=survisland.temp] survisland.temp.points 1

tellraw @s [{"selector":"@a[tag=survisland.temp]"},{"text":" vous a tiré dessus !","color":"gray"}]
tellraw @a[tag=survisland.temp] [{"text":"Vous avez tué ","color":"gray"},{"selector":"@s"},{"text":" !"}]
scoreboard players set @s survisland.temp.dead_cooldown -100

