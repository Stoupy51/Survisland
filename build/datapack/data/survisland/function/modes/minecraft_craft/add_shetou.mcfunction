
#> survisland:modes/minecraft_craft/add_shetou
#
# @within	???
#

scoreboard players add #mShetou survisland.data 1
execute if score #mShetou survisland.data matches ..9 as @a at @s run function survisland:sounds/player.level_up
tellraw @a ["\n",{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"translate": "survisland.progrs_de_lquipe"},{"translate": "survisland.shetou","color":"light_purple"},{"text":" : "},{"text":"[","color":"aqua"},{"score":{"name":"#mShetou","objective":"survisland.data"},"color":"yellow"},{"text":"/"},{"text":"10","color":"yellow"},{"text":"]","color":"aqua"}]

execute if score #mShetou survisland.data matches 10 as @a at @s run function survisland:sounds/toast.challenge_complete
execute if score #mShetou survisland.data matches 10 at @a run summon firework_rocket ~ ~1 ~ {LifeTime:30,FireworksItem:{id:"firework_rocket",Count:1,tag:{Fireworks:{Flight:2,Explosions:[{Type:1,Flicker:1,Trail:1,Colors:[I;16711859]}]}}}}
execute if score #mShetou survisland.data matches 10 run tellraw @a ["\n",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"translate": "survisland.lquipe"},{"translate": "survisland.shetou","color":"light_purple"},{"translate": "survisland.vient_de_gagner_lpreuve_dimmunit"}]

