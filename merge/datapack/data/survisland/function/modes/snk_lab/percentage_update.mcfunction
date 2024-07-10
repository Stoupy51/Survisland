

scoreboard players set #newPercentage survisland.data 0
execute store result score #newPercentage survisland.data run data get entity @s Pos[0] -100
scoreboard players remove #newPercentage survisland.data 120600

scoreboard players operation #newPercentage survisland.data *= #100 survisland.data
scoreboard players operation #newPercentage survisland.data /= #7800 survisland.data

execute if entity @s[team=mAkijan] if score #newPercentage survisland.data > #mAkijan_percentage survisland.data run scoreboard players operation #mAkijan_percentage survisland.data = #newPercentage survisland.data
execute if entity @s[team=mHainy] if score #newPercentage survisland.data > #mHainy_percentage survisland.data run scoreboard players operation #mHainy_percentage survisland.data = #newPercentage survisland.data

