
# Debug tellraw
tellraw @a[tag=convention.debug] {"text":"[Loaded JustNoobLobby v1.0.0]","italic":false,"color":"green"}

# # Repeat this function every tick to check if the player is in the lobby
# execute unless entity @a run schedule function jn_lobby:post_load 1t
# execute if entity @a run function jn_lobby:utils/call_timestamp

