
#> survisland:modes/pr_stoupy/mirror/reset_player
#
# @executed	as @a[tag=survisland.pr_mirror] & at @s
#
# @within	survisland:modes/pr_stoupy/mirror/here/reset [ as @a[tag=survisland.pr_mirror] & at @s ]
#

function #bs.position:get_pos {scale:1000}
scoreboard players operation @s survisland.pr_mirror.x = @s bs.pos.x
scoreboard players operation @s survisland.pr_mirror.y = @s bs.pos.y
scoreboard players operation @s survisland.pr_mirror.z = @s bs.pos.z
scoreboard players operation #pr_mirror_slot survisland.data = @s survisland.pr_mirror
tag @s add survisland.pr_mirror.new
execute as @e[type=mannequin,tag=survisland.pr_mirror.body,predicate=survisland:modes/pr_stoupy/mirror/same_pair] run function survisland:modes/pr_stoupy/mirror/reset_body
tag @s remove survisland.pr_mirror.new

