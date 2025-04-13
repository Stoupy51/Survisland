
# Search for a player on the top of the ladder
execute unless score #kotl jn_lobby.data matches 1 as @p[x=47,y=77,z=45,dx=0,dy=0,dz=0] run function jn_lobby:controller/king_of_the_ladder/message

# If there is no player on the top of the ladder, reset the score
execute if score #kotl jn_lobby.data matches 1 unless entity @p[x=47,y=77,z=45,distance=..5] run scoreboard players reset #kotl jn_lobby.data

