
#> survisland:utils/print_relative
#
# @executed	as the player & at current position
#
# @within	survisland:utils/relative with storage survisland:main positioned
#
# @args		x (int)
#			y (int)
#			z (int)
#

tellraw @s {"text":"Deuxième position enregistrée, cliquez pour copier :","color":"yellow"}
$tellraw @s {"text":"positioned ~$(x) ~$(y) ~$(z)","color":"aqua","click_event":{"action":"copy_to_clipboard","value":"positioned ~$(x) ~$(y) ~$(z)"},"hover_event":{"action":"show_text","value": {"text": "Cliquez pour copier"}}}

