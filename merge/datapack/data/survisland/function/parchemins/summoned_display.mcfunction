
#> survisland:parchemins/summoned_item_display
#
# @within			survisland:parchemins/deploy_open
# @executed			as & at current item_display or text_display
#
# @description		Setup additional data for summoned item_display or text_display
#

# Copy rotation
data modify entity @s Rotation[0] set from storage survisland:main Rotation[0]

# Add animation tag, add deployed_scroll tag, and remove tag 'new'
scoreboard players set @s survisland.cooldown 0
tag @s add survisland.scroll_animation
tag @s add survisland.deployed_scroll
tag @s remove survisland.new

