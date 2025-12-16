
#> survisland:utils/compteur_schedule
#
# @within	survisland:_compteur 5t [ scheduled ]
#			survisland:utils/compteur_schedule 1s [ scheduled ]
#

# Remove score
scoreboard players remove #compteur survisland.data 1

# Titles
execute if score #compteur survisland.data matches 0.. run title @a title {"nbt":"compteur.title","storage":"survisland:main","interpret": true}
execute if score #compteur survisland.data matches 4.. run title @a subtitle [{"score":{"name":"#compteur","objective":"survisland.data"}},{"text":"..."}]
execute if score #compteur survisland.data matches 3 run title @a subtitle {"text":"3...","color":"yellow"}
execute if score #compteur survisland.data matches 2 run title @a subtitle {"text":"2...","color":"gold"}
execute if score #compteur survisland.data matches 1 run title @a subtitle {"text":"1...","color":"red"}
execute if score #compteur survisland.data matches 0 run title @a subtitle {"text":"GO !","color":"dark_red"}
execute if score #compteur survisland.data matches 0.. if score #compteur survisland.data >= #max_compteur survisland.data run title @a times 10 40 10
execute if score #compteur survisland.data matches 0.. if score #compteur survisland.data < #max_compteur survisland.data run title @a times 0 60 10
execute if score #compteur survisland.data matches -5 run title @a times 10 40 10

# Playsounds
execute if score #compteur survisland.data matches 1.. if score #xp_sound survisland.data matches 1 as @a at @s run function survisland:sounds/experience_orb.pickup
execute if score #compteur survisland.data matches 0 if score #goat_horn_sound survisland.data matches 1 as @a at @s run function survisland:sounds/item.goat_horn
execute if score #compteur survisland.data matches 0 if score #wither_sound survisland.data matches 1 as @a at @s run function survisland:sounds/wither.spawn

# Schedule
execute if score #compteur survisland.data matches -5.. run schedule function survisland:utils/compteur_schedule 1s

