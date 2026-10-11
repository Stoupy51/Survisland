
# Imports
import os

import stouputils as stp


# Functions
def main() -> None:
    for root, _dirs, files in os.walk(stp.get_root_path(__file__)):
        for file in files:
            if file.endswith(".json"):
                path: str = f"{root}/{file}"
                stp.json_dump(stp.json_load(path), file=path, max_level=2)

if __name__ == "__main__":
    main()

