
##Fonction executée toutes les secondes lorsque le mode de jeu est activé

schedule function survisland:modes/cache_cache/second 20t replace
scoreboard players add #cache_cache_seconds survisland.data 1
scoreboard players remove #remaining_time survisland.data 1
function survisland:modes/cache_cache/update_sidebar_timer

scoreboard players add #glowing survisland.data 1
execute if score #glowing survisland.data matches 90.. run effect give @a[tag=survisland.alive] glowing 2 0 true
execute if score #glowing survisland.data matches 90.. as @a at @s run playsound entity.creeper.primed ambient @s
execute if score #glowing survisland.data matches 90.. run scoreboard players set #glowing survisland.data 0

execute if score #cache_cache_seconds survisland.data matches 300 run tellraw @a ["",{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"text":" Lancement de l'effet glowing periodique (1m30) !"}]

