
#> survisland:modes/shiren_trials/race/win
#
# @within	survisland:modes/shiren_trials/race/stop
#

# Finish trial
setblock ~ ~ ~ minecraft:glowstone
tellraw @a[distance=..100] ["",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"translate": "survisland.shopping_kart"},{"translate": "survisland.termin","color":"red"}]
execute as @a[distance=..100] at @s run playsound entity.experience_orb.pickup ambient @s

# Give reward
loot spawn ~2 ~-1 ~9 loot survisland:i/blue_star

