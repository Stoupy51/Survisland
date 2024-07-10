
#> survisland:parchemins/_convert_to_scroll
#
# @within			survisland:parchemins/_convert_votes
# @executed			default context
#
# @input			storage survisland:main Item
# @output			storage survisland:main Item
#
# @description		Convertit un vote (livre) en parchemin
#

# Setblock sign with the author and the page content
setblock ~ ~-2 ~ air
setblock ~ ~-2 ~ oak_sign
data modify block ~ ~-2 ~ front_text.messages[0] set value '[{"text":"Auteur : ","color":"gold","italic":false},{"nbt":"Item.components.\\"minecraft:written_book_content\\".author","storage":"survisland:main","interpret":false,"color":"yellow"}]'
data modify block ~ ~-2 ~ front_text.messages[1] set value '[{"nbt":"Item.components.\\"minecraft:written_book_content\\".pages[0].raw","storage":"survisland:main","interpret":true,"color":"red","italic":false}]'

# Copy the author in the lore and the page content in the name
data modify storage survisland:main Item.components."minecraft:lore" set value []
data modify storage survisland:main Item.components."minecraft:lore" append from block ~ ~-2 ~ front_text.messages[0]
data modify storage survisland:main Item.components."minecraft:item_name" set from block ~ ~-2 ~ front_text.messages[1]

