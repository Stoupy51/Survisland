
#> survisland:modes/1v1v1v1_cache_cache/second
#
# @within	survisland:modes/1v1v1v1_cache_cache/macro_start 20t replace [ scheduled ]
#			survisland:modes/1v1v1v1_cache_cache/second 20t replace [ scheduled ]
#

##Fonction executée toutes les secondes lorsque le mode de jeu est activé

schedule function survisland:modes/1v1v1v1_cache_cache/second 20t replace
scoreboard players add #1v1v1v1_cache_cache_seconds survisland.data 1
scoreboard players remove #remaining_time survisland.data 1
function survisland:modes/1v1v1v1_cache_cache/update_sidebar_points with storage survisland:main cache_cache_config
function survisland:modes/1v1v1v1_cache_cache/update_sidebar_timer

scoreboard players add #glowing survisland.data 1
execute if score #glowing survisland.data matches 60.. run effect give @a[tag=survisland.alive,tag=!survisland.no_glowing] glowing 5 0 true
execute if score #glowing survisland.data matches 60.. run effect give @a[tag=survisland.seeker,tag=!survisland.no_glowing] glowing 5 0 true
execute if score #glowing survisland.data matches 60.. as @a at @s run playsound entity.creeper.primed ambient @s
execute if score #glowing survisland.data matches 60.. run scoreboard players set #glowing survisland.data 0

execute if score #1v1v1v1_cache_cache_seconds survisland.data matches 590 run tellraw @a ["",{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"text":" Lancement de l'effet glowing périodique dans 10 secondes (1m00s) !"}]

