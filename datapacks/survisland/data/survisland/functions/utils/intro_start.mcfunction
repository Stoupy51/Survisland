
scoreboard players set #intro survisland.data 0
execute if entity @a[team=mBekou] run scoreboard players set #saison survisland.data 10
execute unless entity @a[team=mBekou] run scoreboard players set #saison survisland.data 9

summon marker ~ ~ ~ {Tags:["survisland.intro"]}
function survisland:utils/intro_entity

