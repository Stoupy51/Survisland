
#> survisland:modes/pr_stoupy/mirror/stop_session
#
# @within	survisland:modes/pr_stoupy/mirror/here/stop
#			survisland:modes/pr_stoupy/mirror/here/reward
#

# The session held in #pr_mirror_session: reflections, freeze items, player tags and its anchor, unless won
kill @e[type=mannequin,tag=survisland.pr_mirror.body,predicate=survisland:modes/pr_stoupy/mirror/same_session]
kill @e[type=minecraft:marker,tag=survisland.pr_mirror.anchor,tag=!survisland.pr_mirror.done,predicate=survisland:modes/pr_stoupy/mirror/same_session]
clear @a[tag=survisland.pr_mirror,predicate=survisland:modes/pr_stoupy/mirror/same_session] *[custom_data~{survisland:{mirror_freeze:true}}]
execute as @a[tag=survisland.pr_mirror,predicate=survisland:modes/pr_stoupy/mirror/same_session] run function survisland:modes/pr_stoupy/send_back
tag @a[tag=survisland.pr_mirror,predicate=survisland:modes/pr_stoupy/mirror/same_session] remove survisland.pr_mirror

