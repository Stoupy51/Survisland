
#> survisland:modes/pr_stoupy/breakout/example/frame
#
# @executed	at @s & rotated as @s
#
# @within	survisland:modes/pr_stoupy/breakout/example/build with storage survisland:pr_breakout example
#
# @args		height (unknown)
#			width (unknown)
#			front (unknown)
#			floor (unknown)
#			middle (unknown)
#

$fill ^ ^ ^ ^ ^$(height) ^$(width) minecraft:air
$fill ^1 ^-1 ^-1 ^1 ^$(height) ^$(width) minecraft:polished_blackstone
$fill ^ ^-1 ^-1 ^ ^-1 ^$(width) minecraft:smooth_stone
$fill ^ ^$(height) ^-1 ^ ^$(height) ^$(width) minecraft:smooth_stone
$fill ^ ^ ^-1 ^ ^$(height) ^-1 minecraft:smooth_stone
$fill ^ ^ ^$(width) ^ ^$(height) ^$(width) minecraft:smooth_stone
$fill ^-1 ^-1 ^-1 ^-1 ^$(height) ^$(width) minecraft:glass

# Platform of the players, with the start command block under its middle and the walkway of the start pads 5 blocks lower
$execute positioned ^$(front) ^$(floor) ^ run fill ^1 ^ ^-1 ^-1 ^ ^$(width) minecraft:smooth_stone
$execute positioned ^$(front) ^$(floor) ^ run fill ^1 ^-5 ^-1 ^-1 ^-5 ^$(width) minecraft:smooth_stone
$execute positioned ^$(front) ^$(floor) ^$(middle) run setblock ~ ~-1 ~ minecraft:repeating_command_block{auto:1b,Command:'function survisland:modes/pr_stoupy/breakout/start {tp:"~ ~5 ~",redstone:""}'}

