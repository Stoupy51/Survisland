
#> survisland:modes/1v1v1v1_cache_cache/heart_beat
#
# @executed	as @a[tag=survisland.alive] & at @s
#
# @within	survisland:modes/1v1v1v1_cache_cache/macro_tick [ as @a[tag=survisland.alive] & at @s ]
#

scoreboard players add @s survisland.temp.heart_beat 0
execute unless score @s survisland.temp.heart_beat matches 0 run scoreboard players add @s survisland.temp.heart_beat 1

#If there is a player between 10 & 24 blocks away, 2 heart beat per second
execute if score @s survisland.temp.heart_beat matches 0 if entity @a[distance=10..24,tag=survisland.seeker] run scoreboard players set @s survisland.temp.heart_beat 10
execute if score @s survisland.temp.heart_beat matches 10 run playsound entity.warden.heartbeat ambient @s
execute if score @s survisland.temp.heart_beat matches 30 run scoreboard players set @s survisland.temp.heart_beat 0

#If there is a player below 10 blocks away, 4 heart beats per second
execute if score @s survisland.temp.heart_beat matches 0 if entity @a[distance=0.001..10,tag=survisland.seeker] run scoreboard players set @s survisland.temp.heart_beat 40
execute if score @s survisland.temp.heart_beat matches 40 run playsound entity.warden.heartbeat ambient @s
execute if score @s survisland.temp.heart_beat matches 50 run playsound entity.warden.heartbeat ambient @s
execute if score @s survisland.temp.heart_beat matches 60 run scoreboard players set @s survisland.temp.heart_beat 0

