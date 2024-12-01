
#> survisland:parchemins/deploy_close
#
# @within			survisland:right_click/all
# @executed			as & at current player
#
# @description		Close the scroll by kill an item_display and a text_display (usually summoned by deploy_open)
#

# Kill the item_display and the text_display
execute positioned ^ ^ ^.5 positioned ~ ~1 ~ as @n[type=item_display,tag=survisland.deployed_scroll,scores={survisland.cooldown=0}] run function survisland:parchemins/animation_closing
execute positioned ^ ^ ^.501 positioned ~ ~0.925 ~ as @n[type=text_display,tag=survisland.deployed_scroll,scores={survisland.cooldown=0}] run function survisland:parchemins/animation_closing

# Replace hand item Custom Model Data
item modify entity @s weapon.mainhand survisland:switch_scroll_state
return 1

