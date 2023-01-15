
scoreboard players set #newPercentage survisland.data 0
execute store result score #newPercentage survisland.data run data get entity @s Pos[2] 100
scoreboard players remove #newPercentage survisland.data 1600

scoreboard players operation #newPercentage survisland.data *= #100 survisland.data
scoreboard players operation #newPercentage survisland.data /= #6200 survisland.data

execute if entity @s[team=mBekou] if score #newPercentage survisland.data > #mBekou_percentage survisland.data run scoreboard players operation #mBekou_percentage survisland.data = #newPercentage survisland.data
execute if entity @s[team=mGalia] if score #newPercentage survisland.data > #mGalia_percentage survisland.data run scoreboard players operation #mGalia_percentage survisland.data = #newPercentage survisland.data
execute if entity @s[team=mIjo] if score #newPercentage survisland.data > #mIjo_percentage survisland.data run scoreboard players operation #mIjo_percentage survisland.data = #newPercentage survisland.data
execute if score #mBekou_percentage survisland.data matches 100 run scoreboard players set #mBekou_percentage survisland.data 99
execute if score #mGalia_percentage survisland.data matches 100 run scoreboard players set #mGalia_percentage survisland.data 99
execute if score #mIjo_percentage survisland.data matches 100 run scoreboard players set #mIjo_percentage survisland.data 99

