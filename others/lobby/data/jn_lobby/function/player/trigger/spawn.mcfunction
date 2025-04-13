
# Reset trigger
scoreboard players set @s jn_lobby.trigger.spawn 0
scoreboard players enable @s jn_lobby.trigger.spawn

# Teleport to spawn
function jn_lobby:utils/teleport_spawn

# Playsound
execute at @s run playsound entity.ender_dragon.shoot master @s

