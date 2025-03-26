
##Fonction executée lors du lancement de la partie

gamemode adventure @a[gamemode=survival]
effect give @a[gamemode=adventure] blindness 5 255 true
effect give @a[gamemode=adventure] weakness 5 255 true
effect give @a[gamemode=adventure] resistance 5 255 true
effect give @a[gamemode=adventure] regeneration 5 255 true
effect give @a[gamemode=adventure] speed 5 5 true
effect give @a[gamemode=adventure] jump_boost 5 5 true

scoreboard objectives add sidebar dummy {"text":" Scores ","color":"gold"}
scoreboard objectives setdisplay sidebar sidebar
scoreboard players set #marcus_truc_s9 sidebar 1
scoreboard players add @a[gamemode=adventure] sidebar 0

tp @a[gamemode=adventure] 10036 103 70

# Définition du résultat de la fonction survisland:_compteur
# Dans l'objet "sounds", les sons à 0b ne s'éxécuteront pas
# Le title, y'a juste à modifier le chiffre et l'intitulé si besoin
data modify storage survisland:main compteur set value {decompte:5,sounds:{xp:1b,goat_horn:1b,wither:0b},title:[{"text":"Epreuve de Confort ","color":"aqua"},{"text":"#4","color":"light_purple"}]}

# Lancer le compteur
function survisland:_compteur

