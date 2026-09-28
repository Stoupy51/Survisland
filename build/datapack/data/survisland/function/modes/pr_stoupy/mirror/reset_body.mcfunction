
#> survisland:modes/pr_stoupy/mirror/reset_body
#
# @executed	as @e[type=mannequin,tag=survisland.pr_mirror.body,predicate=survisland:modes/pr_stoupy/mirror/same_pair]
#
# @within	survisland:modes/pr_stoupy/mirror/reset_player [ as @e[type=mannequin,tag=survisland.pr_mirror.body,predicate=survisland:modes/pr_stoupy/mirror/same_pair] ]
#

execute if score @s survisland.pr_mirror.frozen matches 1 run function survisland:modes/pr_stoupy/mirror/unfreeze
function survisland:modes/pr_stoupy/mirror/place_body

