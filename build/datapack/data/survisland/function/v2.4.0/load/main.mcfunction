
#> survisland:v2.4.0/load/main
#
# @within	survisland:v2.4.0/load/resolve
#

# Avoiding multiple executions of the same load function
execute unless score #survisland.loaded load.status matches 1 run function survisland:v2.4.0/load/secondary

