
# Tellraw and Playsound to announce the King
tellraw @a [{"selector":"@s","color":"dark_purple"},{"text":" est le King of The Ladder !","color":"light_purple"}]
execute as @a[x=47,y=77,z=45,distance=..200] at @s run playsound entity.player.levelup ambient @s ~ ~ ~ 0.25

# Set scoreboard to prevent the function from being executed again
scoreboard players set #kotl jn_lobby.data 1

