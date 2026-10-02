
#> survisland:modes/pr_stoupy/mirror/stop
#
# @within	survisland:modes/pr_stoupy/mirror/tick
#

# Every session, everywhere, won rooms staying locked
kill @e[type=mannequin,tag=survisland.pr_mirror.body]
kill @e[type=minecraft:marker,tag=survisland.pr_mirror.anchor,tag=!survisland.pr_mirror.done]
clear @a[tag=survisland.pr_mirror] *[custom_data~{survisland:{mirror_freeze:true}}]
execute as @a[tag=survisland.pr_mirror] run function survisland:modes/pr_stoupy/send_back
tag @a remove survisland.pr_mirror
schedule clear survisland:modes/pr_stoupy/mirror/tick

