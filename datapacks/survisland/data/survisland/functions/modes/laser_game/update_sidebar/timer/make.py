
# Stop if the execution is not in the same folder as the script
import os
if os.getcwd() != os.path.dirname(os.path.realpath(__file__)):
	print("Please execute this script in the same folder as the script")
	exit()

# Import
import math

# Constantes
max = 1200
namespace = "survisland"
base_path = f"{namespace}:modes/laser_game/update_sidebar/timer/"
base_score = f"execute if score #remaining_time {namespace}.data matches "
files = int(math.sqrt(max))
split = max / files
sidebar_number = 3	# DON'T FORGET TO CHANGE THIS

# Variables (don't change)
temp = 0
min = 0

# Delete old files (ending with .mcfunction)
for file in os.listdir():
	if file.endswith(".mcfunction"):
		os.remove(file)

# Loop for each file
for i in range(1, files + 1):

	# Create the file and write the first line (replace the old file if it exists)
	f = open(str(i) + ".mcfunction", "w")
	f.write('\n')

	# While there are remaining lines to write
	temp = 0
	while temp <= split and min <= max:

		# Prepare minute string
		minute = str((min // 60) % 60)

		# Prepare second string
		second = str(min % 60)
		if len(second) == 1:
			second = '0' + second

		# Write the base path and the score
		f.write(base_score + str(min))

		# Write the command until the JSON part
		f.write(f" run team modify {namespace}.temp.sidebar.{sidebar_number} suffix ")

		# Write the JSON part
		f.write('[{"text":"Temps restant : "},{"text":"' + minute + '","color":"yellow"},{"text":"m"},{"text":"' + second + '","color":"yellow"},{"text":"s"}]\n')

		# Increment the variables
		min += 1
		temp += 1

	# Close the file
	f.write('\n')
	f.close()

# Create the .mcfunction file that links all the files
f = open(".mcfunction", "w")
f.write('\n')

# Reset the variables
temp = 0
i = 1

# While there are remaining lines to write
while temp <= max:

	# Write the base path and the score
	from_score = int(temp)
	to_score = int((temp + split))
	f.write(f"{base_score}{from_score}..{to_score}")

	# Write the command until the end of the line
	f.write(f" run function {base_path}{i}\n")

	# Increment the variables
	temp += split + 1
	i += 1

# Close the file
f.write('\n')
f.close()

