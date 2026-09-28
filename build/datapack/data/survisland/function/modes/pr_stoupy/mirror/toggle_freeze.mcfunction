
#> survisland:modes/pr_stoupy/mirror/toggle_freeze
#
# @executed	as the player & at current position
#
# @within	survisland:utils/right_click
#

# @s is the player who right clicked, only its own reflection answers
execute unless entity @s[tag=survisland.pr_mirror] run return fail
scoreboard players operation #pr_mirror_session survisland.data = @s survisland.pr_mirror.session
scoreboard players operation #pr_mirror_slot survisland.data = @s survisland.pr_mirror
execute as @e[type=mannequin,tag=survisland.pr_mirror.body,predicate=survisland:modes/pr_stoupy/mirror/same_pair] run function survisland:modes/pr_stoupy/mirror/toggle_body

