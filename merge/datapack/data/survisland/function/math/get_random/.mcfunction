
scoreboard players set #random survisland.data 0

execute if predicate survisland:chance/0.5 run scoreboard players add #random survisland.data 1
execute if predicate survisland:chance/0.5 run scoreboard players add #random survisland.data 2
execute if predicate survisland:chance/0.5 run scoreboard players add #random survisland.data 4
execute if predicate survisland:chance/0.5 run scoreboard players add #random survisland.data 8
execute if predicate survisland:chance/0.5 run scoreboard players add #random survisland.data 16
execute if predicate survisland:chance/0.5 run scoreboard players add #random survisland.data 32
execute if predicate survisland:chance/0.5 run scoreboard players add #random survisland.data 64

scoreboard players operation #random survisland.data %= #modulo_rand survisland.data

