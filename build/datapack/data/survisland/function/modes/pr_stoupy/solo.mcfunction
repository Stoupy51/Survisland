
#> survisland:modes/pr_stoupy/solo
#
# @within	(public)
#
# @args		enabled (unknown)
#

# $(enabled) at 1 lets every trial start with one player, and a duo player then holds every command
$scoreboard players set #pr_stoupy_solo survisland.data $(enabled)
execute if score #pr_stoupy_solo survisland.data matches 1 run tellraw @s {"text":"Laboratoire : mode solo activé, chaque trial démarre avec un seul joueur.","color":"yellow"}
execute unless score #pr_stoupy_solo survisland.data matches 1 run tellraw @s {"text":"Laboratoire : mode solo désactivé.","color":"yellow"}

