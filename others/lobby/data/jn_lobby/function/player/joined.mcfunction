
## Fonction permettant d'afficher le nombre de temps écoulé depuis la dernière connexion d'un joueur

# Get the current time in seconds
scoreboard players reset @s jn_lobby.leave
scoreboard players operation #time jn_lobby.data = seconds jn_lobby.timestamp
scoreboard players operation #time jn_lobby.data -= @s jn_lobby.timestamp



# Decode timestamp into years, months, days, hours, minutes and seconds
scoreboard players operation #year jn_lobby.data = #time jn_lobby.data
scoreboard players operation #year jn_lobby.data /= #31557600 jn_lobby.data
scoreboard players operation #time jn_lobby.data %= #31557600 jn_lobby.data

scoreboard players operation #month jn_lobby.data = #time jn_lobby.data
scoreboard players operation #month jn_lobby.data /= #2630016 jn_lobby.data
scoreboard players operation #time jn_lobby.data %= #2630016 jn_lobby.data

scoreboard players operation #day jn_lobby.data = #time jn_lobby.data
scoreboard players operation #day jn_lobby.data /= #86400 jn_lobby.data
scoreboard players operation #time jn_lobby.data %= #86400 jn_lobby.data

scoreboard players operation #hour jn_lobby.data = #time jn_lobby.data
scoreboard players operation #hour jn_lobby.data /= #3600 jn_lobby.data
scoreboard players operation #time jn_lobby.data %= #3600 jn_lobby.data

scoreboard players operation #minute jn_lobby.data = #time jn_lobby.data
scoreboard players operation #minute jn_lobby.data /= #60 jn_lobby.data
scoreboard players operation #time jn_lobby.data %= #60 jn_lobby.data

scoreboard players operation #second jn_lobby.data = #time jn_lobby.data
scoreboard players operation #time jn_lobby.data = seconds jn_lobby.timestamp
scoreboard players operation #time jn_lobby.data -= @s jn_lobby.timestamp



# Tellraw the proper message
scoreboard players set #success jn_lobby.data 0
# execute if score #success jn_lobby.data matches 0 store success score #success jn_lobby.data if score #year jn_lobby.data matches 2.. run tellraw @s ["",{"nbt":"JustNoob","storage":"jn_lobby:main","interpret":true},{"text":" Dernière connexion il y a "},{"score":{"name":"#year","objective":"jn_lobby.data"},"color":"aqua"},{"text":" ans, "},{"score":{"name":"#month","objective":"jn_lobby.data"},"color":"aqua"},{"text":" mois, "},{"score":{"name":"#day","objective":"jn_lobby.data"},"color":"aqua"},{"text":"j"},{"score":{"name":"#hour","objective":"jn_lobby.data"},"color":"aqua"},{"text":"h"},{"score":{"name":"#minute","objective":"jn_lobby.data"},"color":"aqua"},{"text":"m"},{"score":{"name":"#second","objective":"jn_lobby.data"},"color":"aqua"},{"text":"s !"}]
# execute if score #success jn_lobby.data matches 0 store success score #success jn_lobby.data if score #year jn_lobby.data matches 1.. run tellraw @s ["",{"nbt":"JustNoob","storage":"jn_lobby:main","interpret":true},{"text":" Dernière connexion il y a "},{"score":{"name":"#year","objective":"jn_lobby.data"},"color":"aqua"},{"text":" an, "},{"score":{"name":"#month","objective":"jn_lobby.data"},"color":"aqua"},{"text":" mois, "},{"score":{"name":"#day","objective":"jn_lobby.data"},"color":"aqua"},{"text":"j"},{"score":{"name":"#hour","objective":"jn_lobby.data"},"color":"aqua"},{"text":"h"},{"score":{"name":"#minute","objective":"jn_lobby.data"},"color":"aqua"},{"text":"m"},{"score":{"name":"#second","objective":"jn_lobby.data"},"color":"aqua"},{"text":"s !"}]
# execute if score #success jn_lobby.data matches 0 store success score #success jn_lobby.data if score #month jn_lobby.data matches 1.. run tellraw @s ["",{"nbt":"JustNoob","storage":"jn_lobby:main","interpret":true},{"text":" Dernière connexion il y a "},{"score":{"name":"#month","objective":"jn_lobby.data"},"color":"aqua"},{"text":" mois, "},{"score":{"name":"#day","objective":"jn_lobby.data"},"color":"aqua"},{"text":"j"},{"score":{"name":"#hour","objective":"jn_lobby.data"},"color":"aqua"},{"text":"h"},{"score":{"name":"#minute","objective":"jn_lobby.data"},"color":"aqua"},{"text":"m"},{"score":{"name":"#second","objective":"jn_lobby.data"},"color":"aqua"},{"text":"s !"}]
# execute if score #success jn_lobby.data matches 0 store success score #success jn_lobby.data if score #day jn_lobby.data matches 1.. run tellraw @s ["",{"nbt":"JustNoob","storage":"jn_lobby:main","interpret":true},{"text":" Dernière connexion il y a "},{"score":{"name":"#day","objective":"jn_lobby.data"},"color":"aqua"},{"text":"j"},{"score":{"name":"#hour","objective":"jn_lobby.data"},"color":"aqua"},{"text":"h"},{"score":{"name":"#minute","objective":"jn_lobby.data"},"color":"aqua"},{"text":"m"},{"score":{"name":"#second","objective":"jn_lobby.data"},"color":"aqua"},{"text":"s !"}]
# execute if score #success jn_lobby.data matches 0 store success score #success jn_lobby.data if score #hour jn_lobby.data matches 1.. run tellraw @s ["",{"nbt":"JustNoob","storage":"jn_lobby:main","interpret":true},{"text":" Dernière connexion il y a "},{"score":{"name":"#hour","objective":"jn_lobby.data"},"color":"aqua"},{"text":"h"},{"score":{"name":"#minute","objective":"jn_lobby.data"},"color":"aqua"},{"text":"m"},{"score":{"name":"#second","objective":"jn_lobby.data"},"color":"aqua"},{"text":"s !"}]
# execute if score #success jn_lobby.data matches 0 store success score #success jn_lobby.data if score #minute jn_lobby.data matches 1.. run tellraw @s ["",{"nbt":"JustNoob","storage":"jn_lobby:main","interpret":true},{"text":" Dernière connexion il y a "},{"score":{"name":"#minute","objective":"jn_lobby.data"},"color":"aqua"},{"text":"m"},{"score":{"name":"#second","objective":"jn_lobby.data"},"color":"aqua"},{"text":"s !"}]
# execute if score #success jn_lobby.data matches 0 store success score #success jn_lobby.data if score #second jn_lobby.data matches 1.. run tellraw @s ["",{"nbt":"JustNoob","storage":"jn_lobby:main","interpret":true},{"text":" Dernière connexion il y a "},{"score":{"name":"#second","objective":"jn_lobby.data"},"color":"aqua"},{"text":"s !"}]

