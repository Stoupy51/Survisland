
#> survisland:parchemins/deploy_open
#
# @within			survisland:right_click/all
# @executed			as & at current player
#
# @description		Open the scroll by summoning an item_display and a text_display
#

# Copy player's rotation and text in a storage
data modify storage survisland:main Rotation set from entity @s Rotation
data modify storage survisland:main ScrollTexts append from entity @s SelectedItem.components."minecraft:custom_name"

# Replace hand item Custom Model Data and copy the item
item modify entity @s weapon.mainhand survisland:switch_scroll_state
data modify storage survisland:main Item set from entity @s SelectedItem

# Summon the item_display
execute positioned ^ ^ ^.7 positioned ~ ~1 ~ run summon item_display ~ ~ ~ {Tags:["survisland.new"],brightness:{block:15,sky:15},transformation:{left_rotation:[0.0f,0.0f,0.0f,1.0f],translation:[0.0f,0.0f,0.0f],right_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[0.0f, 1.0f, 1.0f]},interpolation_duration:0,start_interpolation:0}
execute as @n[tag=survisland.new] at @s run function survisland:parchemins/summoned_display

# Summon the text_display
execute positioned ^ ^ ^.701 positioned ~ ~0.925 ~ run summon text_display ~ ~ ~ {Tags:["survisland.new"],alignment:"center",brightness:{block:15,sky:15},background:0,shadow:1b,line_width:60,transformation:{left_rotation:[0.0f,0.0f,0.0f,1.0f],translation:[0.0f,0.0f,0.0f],right_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[0.0f, 0.5f, 0.5f]},interpolation_duration:0,start_interpolation:0}
execute as @n[tag=survisland.new] at @s run function survisland:parchemins/summoned_display

# Animation
schedule function survisland:parchemins/animation_display 4t replace
return 1

