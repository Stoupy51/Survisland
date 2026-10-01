
#> survisland:modes/pr_stoupy/orbit/swallow
#
# @within	(public)
#

# Called on a player who fell into the black hole, from any command block
execute unless entity @s[tag=survisland.pr_orbit] run return fail
scoreboard players operation #pr_orbit_arena survisland.data = @s survisland.pr_orbit.arena
function survisland:modes/pr_stoupy/orbit/swallowed

