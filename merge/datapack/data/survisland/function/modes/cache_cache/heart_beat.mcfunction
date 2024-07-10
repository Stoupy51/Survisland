
scoreboard players add @s survisland.temp.heart_beat 0
execute unless score @s survisland.temp.heart_beat matches 0 run scoreboard players add @s survisland.temp.heart_beat 1

#If there is a player between 16 and 32 blocks away, 2 heart beat per second
execute if score @s survisland.temp.heart_beat matches 0 if entity @a[distance=16..32,tag=survisland.seeker] run scoreboard players set @s survisland.temp.heart_beat 10
execute if score @s survisland.temp.heart_beat matches 10 run playsound block.note_block.bass ambient @s ~ ~ ~ 2 0.5
execute if score @s survisland.temp.heart_beat matches 16 run playsound block.note_block.bass ambient @s ~ ~ ~ 2 0.5
execute if score @s survisland.temp.heart_beat matches 30 run scoreboard players set @s survisland.temp.heart_beat 0

#If there is a player between 8 and 16 blocks away, 4 heart beats per second
execute if score @s survisland.temp.heart_beat matches 0 if entity @a[distance=8..16,tag=survisland.seeker] run scoreboard players set @s survisland.temp.heart_beat 40
execute if score @s survisland.temp.heart_beat matches 40 run playsound block.note_block.bass ambient @s ~ ~ ~ 2 0.5
execute if score @s survisland.temp.heart_beat matches 43 run playsound block.note_block.bass ambient @s ~ ~ ~ 2 0.5
execute if score @s survisland.temp.heart_beat matches 49 run playsound block.note_block.bass ambient @s ~ ~ ~ 2 0.5
execute if score @s survisland.temp.heart_beat matches 52 run playsound block.note_block.bass ambient @s ~ ~ ~ 2 0.5
execute if score @s survisland.temp.heart_beat matches 60 run scoreboard players set @s survisland.temp.heart_beat 0

#If there is a player between 0 and 8 blocks away, 6 heart beats per second
execute if score @s survisland.temp.heart_beat matches 0 if entity @a[distance=0.001..8,tag=survisland.seeker] run scoreboard players set @s survisland.temp.heart_beat 70
execute if score @s survisland.temp.heart_beat matches 70 run playsound block.note_block.bass ambient @s ~ ~ ~ 2 0.5
execute if score @s survisland.temp.heart_beat matches 73 run playsound block.note_block.bass ambient @s ~ ~ ~ 2 0.5
execute if score @s survisland.temp.heart_beat matches 77 run playsound block.note_block.bass ambient @s ~ ~ ~ 2 0.5
execute if score @s survisland.temp.heart_beat matches 80 run playsound block.note_block.bass ambient @s ~ ~ ~ 2 0.5
execute if score @s survisland.temp.heart_beat matches 84 run playsound block.note_block.bass ambient @s ~ ~ ~ 2 0.5
execute if score @s survisland.temp.heart_beat matches 87 run playsound block.note_block.bass ambient @s ~ ~ ~ 2 0.5
execute if score @s survisland.temp.heart_beat matches 70 run playsound block.note_block.bass ambient @s ~ ~ ~ 2 0.5
execute if score @s survisland.temp.heart_beat matches 73 run playsound block.note_block.bass ambient @s ~ ~ ~ 2 0.5
execute if score @s survisland.temp.heart_beat matches 77 run playsound block.note_block.bass ambient @s ~ ~ ~ 2 0.5
execute if score @s survisland.temp.heart_beat matches 80 run playsound block.note_block.bass ambient @s ~ ~ ~ 2 0.5
execute if score @s survisland.temp.heart_beat matches 84 run playsound block.note_block.bass ambient @s ~ ~ ~ 2 0.5
execute if score @s survisland.temp.heart_beat matches 87 run playsound block.note_block.bass ambient @s ~ ~ ~ 2 0.5
execute if score @s survisland.temp.heart_beat matches 90 run scoreboard players set @s survisland.temp.heart_beat 0

