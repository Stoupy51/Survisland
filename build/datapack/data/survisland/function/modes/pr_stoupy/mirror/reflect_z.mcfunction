
#> survisland:modes/pr_stoupy/mirror/reflect_z
#
# @executed	as @a[tag=!survisland.pr_mirror,distance=..3,gamemode=!creative,limit=2,sort=nearest] & at @s
#
# @within	survisland:modes/pr_stoupy/mirror/place_body
#

# pos = 2 * plane - pos
scoreboard players operation @s bs.pos.z *= #-1 survisland.data
scoreboard players operation #pr_mirror_twice survisland.data = #pr_mirror_plane_z survisland.data
scoreboard players operation #pr_mirror_twice survisland.data *= #2 survisland.data
scoreboard players operation @s bs.pos.z += #pr_mirror_twice survisland.data

