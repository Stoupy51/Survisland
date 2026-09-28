
#> survisland:modes/pr_stoupy/mirror/enroll_player
#
# @executed	at @s
#
# @within	survisland:modes/pr_stoupy/mirror/start [ at @s ]
#

scoreboard players add #pr_mirror_slot_counter survisland.data 1
scoreboard players operation @s survisland.pr_mirror = #pr_mirror_slot_counter survisland.data
scoreboard players operation @s survisland.pr_mirror.session = #pr_mirror_session survisland.data
scoreboard players operation @s survisland.pr_mirror.plane_x = #pr_mirror_plane_x survisland.data
scoreboard players operation @s survisland.pr_mirror.plane_z = #pr_mirror_plane_z survisland.data
scoreboard players operation @s survisland.pr_mirror.flip_x = #pr_mirror_flip_x survisland.data
scoreboard players operation @s survisland.pr_mirror.flip_z = #pr_mirror_flip_z survisland.data
tag @s add survisland.pr_mirror
give @s minecraft:warped_fungus_on_a_stick[custom_data={survisland:{mirror_freeze:true}},item_model="minecraft:blue_ice",item_name={"text":"Figer le reflet","color":"aqua"},lore=[{"text":"Clic droit : fige ou libère ton reflet","color":"gray","italic":false}]]

# The first displacement is measured from here
function #bs.position:get_pos {scale:1000}
scoreboard players operation @s survisland.pr_mirror.x = @s bs.pos.x
scoreboard players operation @s survisland.pr_mirror.y = @s bs.pos.y
scoreboard players operation @s survisland.pr_mirror.z = @s bs.pos.z

tag @s add survisland.pr_mirror.new
execute summon minecraft:mannequin run function survisland:modes/pr_stoupy/mirror/new_body
tag @s remove survisland.pr_mirror.new

