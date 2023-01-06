
scoreboard players set #compteur survisland.data 4

# data modify storage survisland:main compteur set value {decompte:3,sounds:{xp:1b,goat_horn:1b,wither:0b},title:'[{"text":"Epreuve d\'Immunité ","color":"aqua"},{"text":"#1","color":"light_purple"}]'}

title @a times 10 60 10
title @a title {"nbt":"compteur.title","storage":"survisland:main","interpret": true}

execute store result score #compteur survisland.data run data get storage survisland:main compteur.decompte
execute store result score #xp_sound survisland.data run data get storage survisland:main compteur.sounds.xp
execute store result score #goat_horn_sound survisland.data run data get storage survisland:main compteur.sounds.goat_horn
execute store result score #wither_sound survisland.data run data get storage survisland:main compteur.sounds.wither
scoreboard players add #compteur survisland.data 1

function survisland:utils/compteur_schedule

