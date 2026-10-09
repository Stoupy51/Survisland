# Script that forces all .ogg files to use mono channel.
# Requires ffmpeg (and ffprobe) to be installed.

import os
import subprocess
from multiprocessing import Pool


def get_channels(path):
	result = subprocess.run(
		["ffprobe", "-v", "error", "-select_streams", "a:0", "-show_entries", "stream=channels", "-of", "csv=p=0", path],
		capture_output=True, text=True
	)
	try:
		return int(result.stdout.strip())
	except ValueError:
		return None

def convert_file(args):
	src, dst = args

	# Skip files already in mono to avoid a useless lossy re-encode
	if get_channels(src) == 1:
		return
	previous_size = os.path.getsize(src)
	result = subprocess.run(["ffmpeg", "-y", "-i", src, "-ac", "1", dst], stdin=subprocess.DEVNULL, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
	if result.returncode != 0 or not os.path.exists(dst):
		print(f"Failed to convert '{src}'")
		if os.path.exists(dst):
			os.remove(dst)
		return

	# Replace original by the mono file (even if bigger, mono is required for positional sounds)
	file_size = os.path.getsize(dst)
	os.replace(dst, src)
	print(f"Mono file '{src}' got from {previous_size} to {file_size} bytes")

if __name__ == "__main__":
	py_path = os.path.dirname(os.path.abspath(__file__))

	files_to_compress = []
	for root, _, files in os.walk(py_path):
		for file in files:
			if file.endswith(".ogg") and not file.endswith(".temp.ogg"):
				src = f"{root}/{file}"
				dst = f"{root}/{file[:-4]}.temp.ogg"
				files_to_compress.append((src, dst))

	# Compress
	cpu_count = (os.cpu_count() or 1) // 2 + 1
	with Pool(processes = cpu_count) as pool:
		pool.map(convert_file, files_to_compress)
	print("Compression finished!")
