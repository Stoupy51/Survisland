
#> survisland:modes/pr_stoupy/mirror/new_body
#
# @executed	at @s
#
# @within	survisland:modes/pr_stoupy/mirror/enroll_player
#

tag @s add survisland.pr_mirror.body
tag @s add survisland.pr_mirror.fresh
data merge entity @s {immovable:0b,hide_description:1b,Invulnerable:1b}
scoreboard players operation @s survisland.pr_mirror = #pr_mirror_slot_counter survisland.data
scoreboard players operation @s survisland.pr_mirror.session = #pr_mirror_session survisland.data
scoreboard players set @s survisland.pr_mirror.frozen 0
scoreboard players set @s survisland.pr_mirror.moving 0
scoreboard players set @s survisland.pr_mirror.sneak 0

# Same skin as its player, borrowed through a player head
execute as @a[tag=survisland.pr_mirror.new,limit=1] run loot replace entity @n[type=mannequin,tag=survisland.pr_mirror.fresh] weapon.mainhand loot survisland:player_head
data modify entity @s profile set from entity @s equipment.mainhand.components."minecraft:profile"
item replace entity @s weapon.mainhand with minecraft:air
tag @s remove survisland.pr_mirror.fresh

function survisland:modes/pr_stoupy/mirror/place_body

