
## Function used to get timestamp into a scoreboard
#define storage suso.str:io

# Get timestamp (get = 2)
data remove storage suso.str:io in
data modify storage suso.str:io in.get set value 2
execute as @p run function suso.str:call_head
execute as @p run function suso.str:call
execute as @p run function suso.str:call_head
execute as @p run function suso.str:call

# Schedule function that will update timestamp
schedule function jn_lobby:utils/update_timestamp 18t

