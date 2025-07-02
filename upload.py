
# Imports
from stewbeet.continuous_delivery import load_credentials, upload_to_github

from continuous_delivery.github_config import github_config

# Get credentials
credentials: dict[str, str] = load_credentials("~/stewbeet/credentials.yml")

## Uploads
# Upload to GitHub
changelog: str = upload_to_github(credentials, github_config)

