
#> survisland:modes/pr_stoupy/mirror/here/reset
#
# @within	(public)
#

# The session of the nearest player of the trial: every reflection goes back in front of its player, released
scoreboard players operation #pr_mirror_session survisland.data = @p[tag=survisland.pr_mirror] survisland.pr_mirror.session
execute as @a[tag=survisland.pr_mirror] if score @s survisland.pr_mirror.session = #pr_mirror_session survisland.data at @s run function survisland:modes/pr_stoupy/mirror/reset_player

