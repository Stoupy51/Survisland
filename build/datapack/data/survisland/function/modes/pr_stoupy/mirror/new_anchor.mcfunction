
#> survisland:modes/pr_stoupy/mirror/new_anchor
#
# @executed	align xyz & positioned ~0.5 ~ ~0.5
#
# @within	survisland:modes/pr_stoupy/mirror/start [ align xyz & positioned ~0.5 ~ ~0.5 ]
#

tag @s add survisland.pr_mirror.anchor
scoreboard players operation @s survisland.pr_mirror.session = #pr_mirror_session survisland.data
function #bs.position:get_pos {scale:1000}
scoreboard players operation #pr_mirror_plane_x survisland.data = @s bs.pos.x
scoreboard players operation #pr_mirror_plane_z survisland.data = @s bs.pos.z

