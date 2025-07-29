
#> survisland:parchemins/animation_closing
#
# @executed	as the player & at current position
#
# @within	survisland:parchemins/deploy_close
#			survisland:parchemins/deploy_close [ positioned ^ ^ ^.5 & positioned ~ ~1 ~ & as @n[type=item_display,tag=survisland.deployed_scroll,scores={survisland.cooldown=0}] ]
#			survisland:parchemins/deploy_close [ positioned ^ ^ ^.501 & positioned ~ ~0.925 ~ & as @n[type=text_display,tag=survisland.deployed_scroll,scores={survisland.cooldown=0}] ]
#

# Scale down
data modify entity @s transformation.scale[0] set value 0.0f

# Interpolation and set dying score
data modify entity @s interpolation_duration set value 8
data modify entity @s start_interpolation set value 0
scoreboard players set @s survisland.cooldown 1

# Schedule kill animation
schedule function survisland:parchemins/kill_animation 1t replace

