
data modify storage survisland:main compteur set value {decompte:5,sounds:{xp:1b,goat_horn:1b,wither:0b},title:[{"text":"Epreuve d'Immunité ","color":"aqua"},{"text":"#4","color":"light_purple"}]}
execute as @a[gamemode=adventure] run gamemode survival @s
scoreboard objectives remove sidebar

