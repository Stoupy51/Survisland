
#> survisland:modes/shiren_trials/golf/stop
#
# @within	???
#

# If record is beaten, stop golf
execute if score @s golf_ball.shots matches ..11 if block ~ ~ ~ minecraft:redstone_lamp run function survisland:modes/shiren_trials/golf/win

# If not beaten, print message
execute if score @s golf_ball.shots matches 12.. run tellraw @s ["",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Record non battu, vous avez fait "},{"score":{"name":"@s","objective":"golf_ball.shots"},"color":"red"},{"text":" coups"}]

# Leave golf
function golf_ball:ball/exit_player

