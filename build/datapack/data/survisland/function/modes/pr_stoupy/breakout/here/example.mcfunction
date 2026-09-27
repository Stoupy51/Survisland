
#> survisland:modes/pr_stoupy/breakout/here/example
#
# @within	???
#
# @args		width (unknown)
#			height (unknown)
#			axis (unknown)
#

# Sets up a field here like here/setup, then builds it: every block of the frame, the glass front and the booths is replaced
$function survisland:modes/pr_stoupy/breakout/here/setup {width:$(width),height:$(height),axis:"$(axis)",invert:0}
execute as @n[type=minecraft:marker,tag=survisland.pr_breakout.corner] at @s rotated as @s run function survisland:modes/pr_stoupy/breakout/example/build
execute as @n[type=minecraft:marker,tag=survisland.pr_breakout.corner] at @s rotated as @s run function survisland:modes/pr_stoupy/breakout/example/bricks
tellraw @a[distance=..32] {"text":"Casse-briques : terrain d'exemple construit, les joueurs se mettent dans les cabines de couleur.","color":"green"}

