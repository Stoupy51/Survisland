
##Fonction executée tous les ticks lorsque le mode de jeu est activé

# Schedule + timer
schedule function survisland:modes/space_riding/tick 1t replace
scoreboard players add #space_riding_ticks survisland.data 1

# Detect if players are holding go up or down items
execute as @a[gamemode=adventure,predicate=survisland:has_vehicle,nbt={SelectedItem:{tag:{survisland:{detect:{}}}}},sort=random] run function survisland:modes/space_riding/detect

# Detect if a player in-game lost his vehicle
execute as @a[gamemode=adventure,tag=survisland.alive,predicate=!survisland:has_vehicle] run function survisland:modes/space_riding/lost_vehicle


