
#> survisland:modes/pr_stoupy/orbit/push_tick
#
# @executed	at @s
#
# @within	survisland:modes/pr_stoupy/orbit/arena_tick
#

# The hole pushes during the rounds and the breaks between them alike
scoreboard players operation #pr_orbit_step survisland.data = #pr_orbit_clock survisland.data
scoreboard players operation #pr_orbit_step survisland.data %= #4 survisland.data
execute unless score #pr_orbit_step survisland.data matches 0 run return 0
execute as @a[tag=survisland.pr_orbit,predicate=survisland:modes/pr_stoupy/orbit/same_arena] at @s run function survisland:modes/pr_stoupy/orbit/pull
execute as @a[tag=survisland.pr_orbit,predicate=survisland:modes/pr_stoupy/orbit/same_arena] run title @s actionbar [{"text":"Portés : ","color":"#01FE41"},{"score":{"name":"@s","objective":"survisland.pr_orbit.carried"},"color":"#01FE41"},{"text":"   Déposés : ","color":"#01FE41"},{"score":{"name":"#pr_orbit_banked","objective":"survisland.data"},"color":"#01FE41"},{"text":"/","color":"#01FE41"},{"score":{"name":"#pr_orbit_required","objective":"survisland.data"},"color":"#01FE41"}]

