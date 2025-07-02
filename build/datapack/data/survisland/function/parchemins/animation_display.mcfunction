
#> survisland:parchemins/animation_display
#
# @within	survisland:parchemins/deploy_open
#			survisland:parchemins/deploy_open 4t replace
#
# @executed			default context
# 
# @description		Function scheduled 4 ticks after the deploy_open function is called.
#

execute as @e[tag=survisland.scroll_animation] run function survisland:parchemins/animation_display_selected

