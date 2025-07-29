
#> survisland:utils/print_relative
#
# @within	survisland:utils/relative with storage survisland:main positioned
#

tellraw @s {"translate": "survisland.deuxime_position_enregistre_cliquez_pour_copier","color":"yellow"}
$tellraw @s {"text":"positioned ~$(x) ~$(y) ~$(z)","color":"aqua","clickEvent":{"action":"copy_to_clipboard","value":"positioned ~$(x) ~$(y) ~$(z)"},"hoverEvent":{"action":"show_text","value": {"translate": "survisland.cliquez_pour_copier"}}}

