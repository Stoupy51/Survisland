
# Imports
import os

import stouputils as stp
from PIL import Image

# For each texture in the textures folder, optimize it without loosing any quality
with stp.MeasureTime(message="Textures optimized"):
	for root, _, files in os.walk("./"):
		for file in files:
			if not file.endswith(".png"):
				continue
			filepath = f"{root}/{file}"

			# Load image
			image = Image.open(filepath)
			image = image.convert("RGBA")
			pixels = image.load()
			width, height = image.size

			# Optimize image
			for x in range(width):
				for y in range(height):
					r, g, b, a = pixels[x, y]
					if a == 0:
						pixels[x, y] = (0, 0, 0, 0)

			# Save image
			image.save(filepath)
			stp.info(f"Optimized '{file}'")

