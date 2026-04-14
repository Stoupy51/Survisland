
tellraw @s {"text":"Deuxième position enregistrée, cliquez pour copier :","color":"yellow"}
$tellraw @s {"text":"positioned ~$(x) ~$(y) ~$(z)","color":"aqua","click_event":{"action":"copy_to_clipboard","value":"positioned ~$(x) ~$(y) ~$(z)"},"hover_event":{"action":"show_text","value": {"text": "Cliquez pour copier"}}}

