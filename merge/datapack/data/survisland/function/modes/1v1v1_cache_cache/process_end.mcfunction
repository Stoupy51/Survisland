
scoreboard players add #process_end survisland.data 1

execute if score #process_end survisland.data matches 1 if score #detect_end survisland.data matches 1 run tellraw @a ["\n",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Fin de l'épreuve, tous les joueurs ont été trouvés !"}]
execute if score #process_end survisland.data matches 1 if score #detect_end survisland.data matches 2 run tellraw @a ["\n",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Fin de l'épreuve, temps écoulé !"}]
$execute if score #process_end survisland.data matches 1 as @a[team=$(team1_id),tag=survisland.alive] run scoreboard players add #$(team1_id)_points survisland.data 20
$execute if score #process_end survisland.data matches 1 as @a[team=$(team2_id),tag=survisland.alive] run scoreboard players add #$(team2_id)_points survisland.data 20
execute if score #process_end survisland.data matches 1 run function survisland:modes/1v1v1_cache_cache/update_sidebar_points with storage survisland:main cache_cache_config
$execute if score #process_end survisland.data matches 1 if score #$(team1_id)_points survisland.data = #$(team2_id)_points survisland.data run scoreboard players set #detect_end survisland.data 5
$execute if score #process_end survisland.data matches 1 if score #$(team1_id)_points survisland.data > #$(team2_id)_points survisland.data run scoreboard players set #detect_end survisland.data 4
$execute if score #process_end survisland.data matches 1 if score #$(team1_id)_points survisland.data < #$(team2_id)_points survisland.data run scoreboard players set #detect_end survisland.data 3
execute if score #process_end survisland.data matches 1 if score #detect_end survisland.data matches 5 run tellraw @a ["",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Avec une victoire de....., wait....., égalité des points !"}]
$execute if score #process_end survisland.data matches 1 if score #detect_end survisland.data matches 4 run tellraw @a ["",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Avec une victoire de l'équipe Sambor : "},{"selector":"@a[team=$(team1_id),sort=random]"}]
$execute if score #process_end survisland.data matches 1 if score #detect_end survisland.data matches 3 run tellraw @a ["",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Avec une victoire de l'équipe Kanawa : "},{"selector":"@a[team=$(team2_id),sort=random]"}]

execute if score #process_end survisland.data matches 1 run schedule clear survisland:modes/1v1v1_cache_cache/second
execute if score #process_end survisland.data matches 1 as @a at @s run function survisland:sounds/toast.challenge_complete

execute if score #process_end survisland.data matches 1 run effect clear @a
execute if score #process_end survisland.data matches 1 run effect give @a slow_falling 20 1 true
execute if score #process_end survisland.data matches 1 run effect give @a saturation 20 255 true
$execute if score #process_end survisland.data matches 1 run gamemode spectator @a[team=!$(team1_id),team=!$(team2_id),team=!$(team3_id),gamemode=!creative]
$execute if score #process_end survisland.data matches 1 run gamemode adventure @a[team=$(team1_id)]
$execute if score #process_end survisland.data matches 1 run gamemode adventure @a[team=$(team2_id)]
$execute if score #process_end survisland.data matches 1 run gamemode adventure @a[team=$(team3_id)]

execute if score #process_end survisland.data matches 6000 run function survisland:modes/1v1v1_cache_cache/stop

