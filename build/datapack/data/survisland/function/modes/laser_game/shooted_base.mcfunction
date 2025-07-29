
#> survisland:modes/laser_game/shooted_base
#
# @executed	at @e[tag=iris.ray]
#
# @within	survisland:modes/laser_game/shoot [ at @e[tag=iris.ray] ]
#

scoreboard players set #color survisland.data 0
execute store success score #color survisland.data if entity @s[tag=survisland.laser_game.red]

execute if score #color survisland.data matches 0 run tellraw @a[tag=survisland.laser_game.red] [{"selector":"@s"},{"translate": "survisland.a_tir_sur_la_base_de_bonus","color":"green"}]
execute if score #color survisland.data matches 1 run tellraw @a[tag=survisland.laser_game.blue] [{"selector":"@s"},{"translate": "survisland.a_tir_sur_la_base_de_bonus","color":"green"}]
execute as @a at @s run playsound entity.player.levelup ambient @s

scoreboard players set #modulo_rand survisland.data 6
function survisland:math/get_random/

execute if score #color survisland.data matches 0 run tag @a[tag=!survisland.laser_game.red] add survisland.message
execute if score #color survisland.data matches 1 run tag @a[tag=!survisland.laser_game.blue] add survisland.message
execute if score #random survisland.data matches 0 run tellraw @a[tag=survisland.message] [{"selector":"@s"},{"translate": "survisland.a_tir_sur_la_base_de_bonus_et_obtient_un_bouclier_rsistant_5_tir","color":"green"}]
execute if score #random survisland.data matches 1 run tellraw @a[tag=survisland.message] [{"selector":"@s"},{"translate": "survisland.a_tir_sur_la_base_de_bonus_et_obtient_une_mitraillette_pendant_1","color":"green"}]
execute if score #random survisland.data matches 2 run tellraw @a[tag=survisland.message] [{"selector":"@s"},{"translate": "survisland.a_tir_sur_la_base_de_bonus_et_donne_un_effet_darkness_la_team_en","color":"green"}]
execute if score #random survisland.data matches 3 run tellraw @a[tag=survisland.message] [{"selector":"@s"},{"translate": "survisland.a_tir_sur_la_base_de_bonus_et_donne_un_effet_glowing_la_team_enn","color":"green"}]
execute if score #random survisland.data matches 4 run tellraw @a[tag=survisland.message] [{"selector":"@s"},{"translate": "survisland.a_tir_sur_la_base_de_bonus_et_obtient_un_changement_de_couleur_v","color":"green"}]
execute if score #random survisland.data matches 5 run tellraw @a[tag=survisland.message] [{"selector":"@s"},{"translate": "survisland.a_tir_sur_la_base_de_bonus_et_donne_un_effet_speed_votre_quipe_p","color":"green"}]
tag @a remove survisland.message

execute if score #random survisland.data matches 0 run scoreboard players set @s survisland.temp.shield 5
execute if score #random survisland.data matches 1 run scoreboard players set #mitraillette survisland.data 15
execute if score #random survisland.data matches 1 run tag @s add survisland.bonus.fast
execute if score #random survisland.data matches 2 if score #color survisland.data matches 0 run effect give @a[tag=survisland.laser_game.red] darkness 5 255 true
execute if score #random survisland.data matches 2 if score #color survisland.data matches 1 run effect give @a[tag=survisland.laser_game.blue] darkness 5 255 true
execute if score #random survisland.data matches 3 if score #color survisland.data matches 0 run effect give @a[tag=survisland.laser_game.red] glowing 5 255 true
execute if score #random survisland.data matches 3 if score #color survisland.data matches 1 run effect give @a[tag=survisland.laser_game.blue] glowing 5 255 true
execute if score #random survisland.data matches 4 run scoreboard players set #change_color survisland.data 30
execute if score #random survisland.data matches 4 run team join survisland.laser_game.blue @s[tag=survisland.laser_game.red]
execute if score #random survisland.data matches 4 run team join survisland.laser_game.red @s[tag=survisland.laser_game.blue]
execute if score #random survisland.data matches 4 run tag @s add survisland.bonus.color
execute if score #random survisland.data matches 5 if score #color survisland.data matches 0 run effect give @a[tag=survisland.laser_game.blue] speed 15 1 true
execute if score #random survisland.data matches 5 if score #color survisland.data matches 1 run effect give @a[tag=survisland.laser_game.red] speed 15 1 true

execute if score #color survisland.data matches 0 run scoreboard players add #blue_points survisland.data 20
execute if score #color survisland.data matches 0 run function survisland:modes/laser_game/update_sidebar/blue_points/
execute if score #color survisland.data matches 1 run scoreboard players add #red_points survisland.data 20
execute if score #color survisland.data matches 1 run function survisland:modes/laser_game/update_sidebar/red_points/
scoreboard players add @s survisland.temp.individual_points 20

scoreboard players set #base_reload survisland.data 47
setblock 136 73 116 dark_oak_trapdoor[powered=true,open=true]
execute as @e[tag=survisland.laser_game.base] run data modify entity @s Item set value {id:""}

