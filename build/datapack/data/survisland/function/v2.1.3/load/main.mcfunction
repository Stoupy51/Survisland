
#> survisland:v2.1.3/load/main
#
# @within	survisland:v2.1.3/load/resolve
#

# Avoiding multiple executions of the same load function
execute unless score #survisland.loaded load.status matches 1 run function survisland:v2.1.3/load/secondary
