
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
data modify block ~ ~-2 ~ front_text.messages[0] set value '[{"text":"Auteur : ","color":"gold","italic":false},{"nbt":"Item.tag.author","storage":"survisland:main","interpret":false,"color":"yellow"}]'
data modify block ~ ~-2 ~ front_text.messages[1] set value '[{"nbt":"Item.tag.pages[0]","storage":"survisland:main","interpret":true,"color":"red","italic":false}]'

# Copy the author in the lore and the page content in the name
data modify storage survisland:main Item.tag.display.Lore append from block ~ ~-2 ~ front_text.messages[0]
data modify storage survisland:main Item.tag.display.Name set from block ~ ~-2 ~ front_text.messages[1]

# Replace the book by a scroll
data modify storage survisland:main Item.id set value "minecraft:warped_fungus_on_a_stick"
data modify storage survisland:main Item.tag.CustomModelData set value 2010001

# Remove unused data
data remove storage survisland:main Item.tag.author
data remove storage survisland:main Item.tag.pages
data remove storage survisland:main Item.tag.title

