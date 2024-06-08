
#> survisland:parchemins/deploy_open
#
# @within			survisland:right_click/all
# @executed			as & at current player
#
# @description		Open the scroll by summoning an item_display and a text_display
#

# Copy player's rotation and text in a storage
data modify storage survisland:main Rotation set from entity @s Rotation
data modify storage survisland:main ScrollTexts append from entity @s SelectedItem.tag.display.Name

# Summon the item_display
execute positioned ^ ^ ^.5 positioned ~ ~1 ~ run summon item_display ~ ~ ~ {Tags:["survisland.new"],brightness:{block:15,sky:15},transformation:{left_rotation:[0.0f,0.0f,0.0f,1.0f],translation:[0.0f,0.0f,0.0f],right_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[0.0f, 1.0f, 1.0f]},interpolation_duration:0,start_interpolation:0}
execute as @e[tag=survisland.new,limit=1] at @s run function survisland:parchemins/summoned_display

# Summon the text_display
execute positioned ^ ^ ^.501 positioned ~ ~0.925 ~ run summon text_display ~ ~ ~ {Tags:["survisland.new"],brightness:{block:15,sky:15},background:0,shadow:1b,line_width:60,transformation:{left_rotation:[0.0f,0.0f,0.0f,1.0f],translation:[0.0f,0.0f,0.0f],right_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[0.0f, 0.5f, 0.5f]},interpolation_duration:0,start_interpolation:0}
execute as @e[tag=survisland.new,limit=1] at @s run function survisland:parchemins/summoned_display

# Replace hand item Custom Model Data
item modify entity @s weapon.mainhand survisland:switch_scroll_state

# Animation
schedule function survisland:parchemins/animation_display 4t replace
return 1

