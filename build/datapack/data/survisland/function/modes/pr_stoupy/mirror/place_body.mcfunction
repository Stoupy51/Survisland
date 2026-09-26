
#> survisland:modes/pr_stoupy/mirror/place_body
#
# @executed	as @a[tag=!survisland.pr_mirror,distance=..3,gamemode=!creative,limit=2,sort=nearest] & at @s
#
# @within	survisland:modes/pr_stoupy/mirror/new_body
#			survisland:modes/pr_stoupy/mirror/reset_body
#

# @s is a mannequin, sent to the reflection of the player tagged survisland.pr_mirror.new across the plane of that player
scoreboard players operation @s bs.pos.x = @a[tag=survisland.pr_mirror.new,limit=1] survisland.pr_mirror.x
scoreboard players operation @s bs.pos.y = @a[tag=survisland.pr_mirror.new,limit=1] survisland.pr_mirror.y
scoreboard players operation @s bs.pos.z = @a[tag=survisland.pr_mirror.new,limit=1] survisland.pr_mirror.z
scoreboard players operation #pr_mirror_plane_x survisland.data = @a[tag=survisland.pr_mirror.new,limit=1] survisland.pr_mirror.plane_x
scoreboard players operation #pr_mirror_plane_z survisland.data = @a[tag=survisland.pr_mirror.new,limit=1] survisland.pr_mirror.plane_z
execute if entity @a[tag=survisland.pr_mirror.new,scores={survisland.pr_mirror.flip_x=-1}] run function survisland:modes/pr_stoupy/mirror/reflect_x
execute if entity @a[tag=survisland.pr_mirror.new,scores={survisland.pr_mirror.flip_z=-1}] run function survisland:modes/pr_stoupy/mirror/reflect_z
function #bs.position:set_pos {scale:0.001}
scoreboard players set @s survisland.pr_mirror.yaw 2147483647

