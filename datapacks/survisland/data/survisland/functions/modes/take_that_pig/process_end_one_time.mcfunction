
##Add tag survisland.winner to the top players
tag @a remove survisland.winner
tag @a[gamemode=adventure] add survisland.to_check

scoreboard players set #best_score survisland.temp.sidebar 0
scoreboard players set #winners survisland.data 0
execute as @a[tag=survisland.to_check] if score @s survisland.temp.sidebar > #best_score survisland.temp.sidebar run scoreboard players operation #best_score survisland.temp.sidebar = @s survisland.temp.sidebar
execute as @a[tag=survisland.to_check] if score @s survisland.temp.sidebar = #best_score survisland.temp.sidebar run tag @s add survisland.winner
execute store result score #winners survisland.data if entity @a[tag=survisland.winner]


##End visual 
execute if score #winners survisland.data matches 1 run tellraw @a ["\n",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Fin de l'épreuve avec une victoire du grand joueur : "},{"selector":"@a[tag=survisland.winner]"}]
execute if score #winners survisland.data matches 2.. run tellraw @a ["\n",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Fin de l'épreuve avec une victoire de... Ah merde, y'a égalité entre ces grands joueurs : "},{"selector":"@a[tag=survisland.winner,sort=random]"}]
execute at @a run summon firework_rocket ~ ~1 ~ {LifeTime:30,FireworksItem:{id:"firework_rocket",Count:1,tag:{Fireworks:{Flight:2,Explosions:[{Type:1,Flicker:1,Trail:1,Colors:[I;1638655]}]}}}}
execute as @a at @s run playsound entity.wither.death ambient @s
gamemode survival @a[gamemode=adventure]


##Clear tags
tag @a remove survisland.winner
tag @a remove survisland.to_check




