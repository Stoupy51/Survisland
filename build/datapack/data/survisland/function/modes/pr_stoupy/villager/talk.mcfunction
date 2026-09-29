
#> survisland:modes/pr_stoupy/villager/talk
#
# @executed	as the player & at current position
#
# @within	advancement survisland:modes/pr_stoupy/villager_click
#

advancement revoke @s only survisland:modes/pr_stoupy/villager_click

execute store result score #pr_stoupy_stars survisland.data run clear @s *[custom_data~{survisland:{blue_star:true}}] 0
execute if score #pr_stoupy_stars survisland.data matches 5.. run return run function survisland:modes/pr_stoupy/villager/deliver

scoreboard players set #pr_stoupy_missing survisland.data 5
scoreboard players operation #pr_stoupy_missing survisland.data -= #pr_stoupy_stars survisland.data
tellraw @s ["",{"text":"<Maarcouscous> ","color":"yellow"},{"text":"Rapporte-moi les 5 étoiles bleues du laboratoire, toutes ensemble ! Il t'en manque encore "},{"score":{"name":"#pr_stoupy_missing","objective":"survisland.data"},"color":"aqua"},{"text":"."}]
playsound minecraft:entity.villager.no neutral @s

