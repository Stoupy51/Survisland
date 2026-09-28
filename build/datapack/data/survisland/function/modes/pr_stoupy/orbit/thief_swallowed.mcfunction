
#> survisland:modes/pr_stoupy/orbit/thief_swallowed
#
# @executed	positioned ^ ^ ^1
#
# @within	survisland:modes/pr_stoupy/orbit/dive [ positioned ^ ^ ^1 ]
#

# The stolen fragment goes back to its ring, and the thief is gone for good
execute on passengers run tag @s remove survisland.pr_orbit.stolen
execute on passengers run ride @s dismount
tp @s ~ -1000 ~
kill @s

