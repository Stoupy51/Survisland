
# Stop if the offhand and latest hotbar slot are not empty
scoreboard players set #is_empty survisland.data 1
execute if score #is_empty survisland.data matches 1 if items entity @s weapon.offhand * run scoreboard players set #is_empty survisland.data 0
execute if score #is_empty survisland.data matches 1 if items entity @s hotbar.8 * run scoreboard players set #is_empty survisland.data 0
execute if score #is_empty survisland.data matches 0 run tellraw @s ["",{"text":"[RatioGolf]","color":"gold"},{"text":" Veuillez libérer votre seconde main et le dernier emplacement de votre barre d'inventaire avant de commencer le parcours de minigolf.","color":"yellow"}]
execute if score #is_empty survisland.data matches 0 run playsound entity.villager.no
execute if score #is_empty survisland.data matches 0 run return 1

# Start parkour
scoreboard players set @s golf_ball.shots 0
function golf_ball:summon

