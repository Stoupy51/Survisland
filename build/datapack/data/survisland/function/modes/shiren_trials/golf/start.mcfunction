
#> survisland:modes/shiren_trials/golf/start
#
# @within	???
#

# Stop if the offhand and latest hotbar slot are not empty
scoreboard players set #is_empty survisland.data 1
execute if score #is_empty survisland.data matches 1 if items entity @s weapon.offhand * run scoreboard players set #is_empty survisland.data 0
execute if score #is_empty survisland.data matches 1 if items entity @s hotbar.8 * run scoreboard players set #is_empty survisland.data 0
execute if score #is_empty survisland.data matches 0 run tellraw @s ["",{"translate": "survisland.ratiogolf","color":"gold"},{"translate": "survisland.veuillez_librer_votre_seconde_main_et_le_dernier_emplacement_de_","color":"yellow"}]
execute if score #is_empty survisland.data matches 0 run playsound entity.villager.no
execute if score #is_empty survisland.data matches 0 run return 1

# Start parkour
scoreboard players set @s golf_ball.shots 0
function golf_ball:summon

