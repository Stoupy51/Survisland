
#> survisland:parchemins/animation_display_selected
#
# @within			survisland:parchemins/animation_display
# @executed			as & at item_display or text_display
#
# @description		Function scheduled 4 ticks after the deploy_open function is called.
#					Used to display the selected item or text.
#

# Item display : Setup texture and scale
data modify entity @s[type=item_display] transformation.scale[0] set value 1.25f

# Text display : Setup text and scale
data modify entity @s[type=text_display] text set from storage survisland:main ScrollTexts[0]
execute if entity @s[type=text_display] run data remove storage survisland:main ScrollTexts[0]
data modify entity @s[type=text_display] transformation.scale[0] set value 0.5f

# Interpolation and remove tag
data modify entity @s interpolation_duration set value 8
data modify entity @s start_interpolation set value 0
tag @s remove survisland.scroll_animation

