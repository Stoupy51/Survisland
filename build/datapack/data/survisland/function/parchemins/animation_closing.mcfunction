
#> survisland:parchemins/animation_closing
#
# @within	survisland:parchemins/deploy_close
#

# Scale down
data modify entity @s transformation.scale[0] set value 0.0f

# Interpolation and set dying score
data modify entity @s interpolation_duration set value 8
data modify entity @s start_interpolation set value 0
scoreboard players set @s survisland.cooldown 1

# Schedule kill animation
schedule function survisland:parchemins/kill_animation 1t replace

