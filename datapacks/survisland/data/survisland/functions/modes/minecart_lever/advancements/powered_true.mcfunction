
advancement revoke @s only survisland:minecart_lever/powered_true
scoreboard players add @s survisland.temp.sidebar 1
playsound entity.player.levelup ambient @s

execute if score @s survisland.temp.sidebar matches 11 if entity @s[tag=!survisland.11] run tellraw @a ["",{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"text":" Le joueur "},{"selector":"@s"},{"text":" a activé la moitié des leviers !"}]
execute if score @s survisland.temp.sidebar matches 11 if entity @s[tag=!survisland.11] as @a at @s run playsound entity.allay.hurt ambient @s
execute if score @s survisland.temp.sidebar matches 11 run tag @s add survisland.11
execute if score @s survisland.temp.sidebar matches 22 if entity @s[tag=!survisland.22] run tellraw @a ["",{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"text":" IL NE RESTE PLUS QU'UN LEVIER à "},{"selector":"@s"},{"text":" !!!"}]
execute if score @s survisland.temp.sidebar matches 22 if entity @s[tag=!survisland.22] as @a at @s run playsound entity.allay.death ambient @s
execute if score @s survisland.temp.sidebar matches 22 run tag @s add survisland.22
execute if score @s survisland.temp.sidebar matches 23 run scoreboard players set #detect_end survisland.data 1

