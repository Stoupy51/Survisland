
#> survisland:modes/pr_stoupy/orbit/check_round
#
# @executed	at @s
#
# @within	survisland:modes/pr_stoupy/orbit/play_tick
#

# Won once every fragment is banked and every phantom is dead
execute if score #pr_orbit_banked survisland.data < #pr_orbit_required survisland.data run return 0
execute if entity @e[type=minecraft:phantom,tag=survisland.pr_orbit.phantom,predicate=survisland:modes/pr_stoupy/orbit/same_arena] run return 0
scoreboard players set #pr_orbit_state survisland.data 2
scoreboard players set #pr_orbit_timer survisland.data 100
title @a[tag=survisland.pr_orbit,predicate=survisland:modes/pr_stoupy/orbit/same_arena] times 10 40 10
title @a[tag=survisland.pr_orbit,predicate=survisland:modes/pr_stoupy/orbit/same_arena] subtitle {"text": "Préparez-vous au suivant", "color": "#01FE41"}
title @a[tag=survisland.pr_orbit,predicate=survisland:modes/pr_stoupy/orbit/same_arena] title {"text": "Round terminé !", "color": "#01FE41"}
execute as @a[tag=survisland.pr_orbit,predicate=survisland:modes/pr_stoupy/orbit/same_arena] at @s run playsound minecraft:entity.player.levelup ambient @s

