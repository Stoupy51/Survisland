
execute unless predicate bs.id:has_suid run return fail

scoreboard players operation $link.to bs.in = @s bs.id
execute at @s run kill @n[predicate=bs.link:link_equal,sort=furthest]

