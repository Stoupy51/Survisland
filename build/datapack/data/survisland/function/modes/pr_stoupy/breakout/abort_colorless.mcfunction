
#> survisland:modes/pr_stoupy/breakout/abort_colorless
#
# @within	survisland:modes/pr_stoupy/breakout/start
#

tellraw @a[tag=survisland.pr_breakout,predicate=survisland:modes/pr_stoupy/breakout/same_arena] {"text":"Casse-briques : chaque joueur doit se tenir sur un bloc de couleur (béton, laine, terre cuite ou verre teinté).","color":"red"}
tag @a[tag=survisland.pr_breakout,predicate=survisland:modes/pr_stoupy/breakout/same_arena] remove survisland.pr_breakout

