
tellraw @s {"text":"Deuxième position enregistrée, cliquez pour copier :","color":"yellow"}
$tellraw @s[tag=!no_positioned] {"text":"positioned ~$(x) ~$(y) ~$(z)","color":"aqua","click_event":{"action":"copy_to_clipboard","value":"positioned ~$(x) ~$(y) ~$(z)"},"hover_event":{"action":"show_text","value": {"text": "Cliquez pour copier"}}}
$tellraw @s[tag=no_positioned] {"text":"~$(x) ~$(y) ~$(z)","color":"aqua","click_event":{"action":"copy_to_clipboard","value":"~$(x) ~$(y) ~$(z)"},"hover_event":{"action":"show_text","value": {"text": "Cliquez pour copier"}}}

