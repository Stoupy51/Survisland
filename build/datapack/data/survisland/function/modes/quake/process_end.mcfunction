
#> survisland:modes/quake/process_end
#
# @within	survisland:modes/quake/tick
#

# Get player with most points
tag @a remove survisland.winner
scoreboard players set #max survisland.data 0
scoreboard players operation #max survisland.data > @a[team=mMerge] survisland.temp.points
execute as @a[team=mMerge] if score #max survisland.data = @s survisland.temp.points run tag @s add survisland.winner
tellraw @a ["\n",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"translate": "survisland.fin_de_lpreuve_avec_une_victoire_de"},{"selector":"@a[tag=survisland.winner]"},{"text":" !\n"}]
execute as @a at @s run function survisland:sounds/toast.challenge_complete
tag @a[tag=survisland.winner] remove survisland.winner

# Clear item and schedule
clear @a warped_fungus_on_a_stick[minecraft:custom_data={quake:1b}]
schedule clear survisland:modes/quake/tick
schedule clear survisland:modes/quake/second

