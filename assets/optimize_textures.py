
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

			# Fully transparent pixels become (0, 0, 0, 0), the others are kept as they are
			image = Image.open(filepath).convert("RGBA")
			visible = image.getchannel("A").point(lambda alpha: 255 if alpha else 0)
			Image.composite(image, Image.new("RGBA", image.size), visible).save(filepath)
			stp.info(f"Optimized '{file}'")

