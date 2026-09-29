
#> survisland:modes/pr_stoupy/orbit/click
#
# @executed	as the player & at current position
#
# @within	advancement survisland:modes/pr_stoupy/orbit_hit_fragment
#			advancement survisland:modes/pr_stoupy/orbit_use_fragment
#

# @s clicked a fragment, even one a thief is carrying away: it catches it like by touching it
advancement revoke @s only survisland:modes/pr_stoupy/orbit_hit_fragment
advancement revoke @s only survisland:modes/pr_stoupy/orbit_use_fragment
tag @s add survisland.pr_orbit.clicker
execute if entity @s[tag=survisland.pr_orbit] as @e[type=minecraft:interaction,tag=survisland.pr_orbit.hitbox,distance=..8] if function survisland:modes/pr_stoupy/orbit/clicked on vehicle run function survisland:modes/pr_stoupy/orbit/grab
tag @s remove survisland.pr_orbit.clicker

