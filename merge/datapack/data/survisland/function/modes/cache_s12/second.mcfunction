
##Fonction executée toutes les secondes lorsque le mode de jeu est activé

schedule function survisland:modes/cache_s12/second 20t replace
scoreboard players add #cache_s12_seconds survisland.data 1
scoreboard players remove #remaining_time survisland.data 1
function survisland:modes/cache_s12/update_sidebar_points
function survisland:modes/cache_s12/update_sidebar_timer

scoreboard players add #glowing survisland.data 1
execute if score #glowing survisland.data matches 60.. run effect give @a[tag=survisland.alive,tag=!survisland.no_glowing] glowing 5 0 true
execute if score #glowing survisland.data matches 60.. as @a at @s run playsound entity.creeper.primed ambient @s
execute if score #glowing survisland.data matches 60.. run scoreboard players set #glowing survisland.data 0

execute if score #cache_s12_seconds survisland.data matches 590 run tellraw @a ["",{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"text":" Lancement de l'effet glowing périodique dans 10 secondes (1m00s) !"}]

