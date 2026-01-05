
#> survisland:modes/shiren_trials/golf/win
#
# @within	survisland:modes/shiren_trials/golf/stop
#

# Finish trial
setblock ~ ~ ~ minecraft:glowstone
tellraw @a[distance=..100] ["",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Minigolf "},{"text":"terminé !","color":"red"}]
execute as @a[distance=..100] at @s run playsound entity.experience_orb.pickup ambient @s

# Give reward
loot spawn ~5 ~0 ~-2 loot survisland:i/blue_star

