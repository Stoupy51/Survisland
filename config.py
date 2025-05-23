
# Imports
import os

ROOT: str = os.path.dirname(os.path.realpath(__file__)).replace("\\", "/")
IGNORE_UNSET: bool = True

# Folders
MERGE_FOLDER: str = f"{ROOT}/merge"					# If a file exists in both merge and build folder, they will be merged. Otherwise, it's just copied.
BUILD_FOLDER: str = f"{ROOT}/build"					# Folder where the final datapack and resource pack are built
ASSETS_FOLDER: str = f"{ROOT}/assets"				# Folder containing the all assets (textures, sounds, ...) for the datapack
TEXTURES_FOLDER: str = f"{ASSETS_FOLDER}/textures"	# Folder containing the textures for the datapack
LIBS_FOLDER: str = f"{ROOT}/libs"					# The libraries are copied to the build destination, and merged with the datapack using Weld
BUILD_COPY_DESTINATIONS: tuple[list, list] = (["D:/latest_snapshot/world/datapacks"], ["D:/minecraft/snapshot/resourcepacks"])	# Can be empty lists if you don't want to copy the generated files to other folders.

# Dev constants
HAS_MANUAL: bool = True                             # Do the program generate a manual/guide? (WARNING: if an item is malformed in the database, the server log will be flooded on load by the manual hiding the malformed item)
DATABASE_DEBUG: str = f"{ROOT}/database_debug.json"	# Dump of the database for debugging purposes
MERGE_LIBS: bool = True								# Make new zip of merged libraries with the datapack and resource pack using Smithed Weld


# Datapack related constants
AUTHOR: str = "Stoupy51"				# Author(s) name(s) displayed in pack.mcmeta, also used to add convention.debug tag to the players of the same name(s) <-- showing additionnal displays like datapack loading
PROJECT_NAME: str = "Survisland"		# Name of the datapack, used for messages and items lore
VERSION: str = "2.1.5"					# Datapack version in the following mandatory format: major.minor.patch, ex: 1.0.0 or 1.21.615
NAMESPACE: str = "survisland"			# Should be the same you use in the merge folder. Used to namespace functions, tags, etc.
DESCRIPTION = f"{PROJECT_NAME} [{VERSION}] by {AUTHOR}"	# Pack description displayed in pack.mcmeta

# Technical constants
SOURCE_LORE: list[dict] = [{"text":"ICON"},{"text": f" {PROJECT_NAME}","italic":True,"color":"blue"}]	# Appended lore to any custom item, can be an empty string


# Manual configuration
DEBUG_MODE: bool = False                            # Shows up grids in manual
MANUAL_PATH: str = f"{ROOT}/manual"                 # Cached manual assets
MANUAL_OVERRIDES: str = f"{ASSETS_FOLDER}/manual_overrides" # Path to a folder containing manual overrides to replace the default manual assets
MANUAL_HIGH_RESOLUTION: bool = True                 # Enable the high resolution for the manual to increase the craft resolutions
CACHE_MANUAL_ASSETS: bool = True                    # Caches the MC assets and the items renders for the manual (manual/items/*.png)
CACHE_MANUAL_PAGES: bool = False                    # Caches the content of the manual and the images (manual/pages/*.png)
MANUAL_DEBUG: str = f"{ROOT}/debug_manual.json"     # Dump of the manual for debugging purposes
MANUAL_NAME: str = f"{PROJECT_NAME} Manual"         # Name of the manual, used for the title of the book and first page
MAX_ITEMS_PER_ROW: int = 5                          # Max number of items per row in the manual, should not exceed 6
MAX_ROWS_PER_PAGE: int = 5                          # Max number of rows per page in the manual, should not exceed 6
OPENGL_RESOLUTION: int = 256                        # Resolution of the OpenGL renders used in the manual, best value is 256 <--- 256x256
MANUAL_FIRST_PAGE_TEXT: list[dict] = [{"text":"Ratio gold", "color":"#505050"}] # Text for the first page of the manual


# Configuration dictionnary
configuration = {
	"ignore_unset": IGNORE_UNSET,

	"merge_folder": MERGE_FOLDER,
	"build_folder": BUILD_FOLDER,
	"assets_folder": ASSETS_FOLDER,
	"textures_folder": TEXTURES_FOLDER,
	"libs_folder": LIBS_FOLDER,
	"build_copy_destinations": BUILD_COPY_DESTINATIONS,
    "has_manual": HAS_MANUAL,
	"database_debug": DATABASE_DEBUG,
	"merge_libs": MERGE_LIBS,
	"author": AUTHOR,
	"project_name": PROJECT_NAME,
	"version": VERSION,
	"namespace": NAMESPACE,
	"description": DESCRIPTION,
	"source_lore": SOURCE_LORE,

	"debug_mode": DEBUG_MODE,
	"manual_path": MANUAL_PATH,
	"manual_overrides": MANUAL_OVERRIDES,
	"manual_high_resolution": MANUAL_HIGH_RESOLUTION,
	"cache_manual_assets": CACHE_MANUAL_ASSETS,
	"cache_manual_pages": CACHE_MANUAL_PAGES,
	"manual_debug": MANUAL_DEBUG,
	"manual_name": MANUAL_NAME,
	"max_items_per_row": MAX_ITEMS_PER_ROW,
	"max_rows_per_page": MAX_ROWS_PER_PAGE,
	"opengl_resolution": OPENGL_RESOLUTION,
	"manual_first_page_text": MANUAL_FIRST_PAGE_TEXT,
}

