
#> survisland:utils/url
#
# @within	???
#
# @args		url (unknown)
#

# Playsound to everyone
execute as @a at @s run playsound entity.experience_orb.pickup ambient @s

# Tellraw with link
$tellraw @a ["\n",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Lien vers la vidéo d'explication [clique ici]","color":"yellow","click_event":{"action":"open_url","url":"$(url)"},"hover_event":{"action":"show_text","value":"Oui ici !"}}]

