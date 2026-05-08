
# Imports
import csv
import datetime
import io
import os
import zoneinfo

import requests
import stouputils as stp
from stouputils.typing import JsonDict


# Main function
def main() -> None:
    # 1. Get the current date in Paris timezone
    paris_tz = zoneinfo.ZoneInfo("Europe/Paris")
    current_date: str = datetime.datetime.now(paris_tz).strftime("%m-%d")  # Format: MM-DD

    # 2. Retrieve the google sheet data (CSV export URL)
    sheet_url: str = os.environ["GOOGLE_SHEET_URL"]
    response: requests.Response = requests.get(sheet_url, timeout=10)
    response.raise_for_status()

    # 3. Get all lines that match the current date (3 columns: name, date, discord_id (optional))
    reader = csv.reader(io.StringIO(response.text))
    matches: list[JsonDict] = []
    for row in reader:
        if len(row) < 2:
            continue
        name: str = row[0].strip()
        date: str = row[1].strip()
        discord_id: str = row[2].strip() if len(row) >= 3 else ""
        # Normalize date to MM-DD (supports MM-DD or DD/MM/YYYY or MM/DD/YYYY patterns)
        for fmt in ("%m-%d", "%d/%m/%Y", "%m/%d/%Y"):
            try:
                parsed = datetime.datetime.strptime(date, fmt)
                normalized = parsed.strftime("%m-%d")
                break
            except ValueError:
                normalized = date
        if normalized == current_date:
            matches.append({"name": name, "discord_id": discord_id})

    if not matches:
        stp.info(f"No anniversaries today ({current_date}).")
        return

    # 4. Prepare the message
    lines: list[str] = ["🎂 **Joyeux anniversaire aujourd'hui !**"]
    for entry in matches:
        if entry["discord_id"]:
            lines.append(f"- <@{entry['discord_id']}> ({entry['name']})")
        else:
            lines.append(f"- {entry['name']}")
    message: str = "\n".join(lines)

    # 5. Send the message to the channel using discord webhooks
    webhook_url: str = os.environ["DISCORD_WEBHOOK_URL"]
    payload: JsonDict = {"content": message}
    webhook_response: requests.Response = requests.post(webhook_url, json=payload, timeout=10)
    webhook_response.raise_for_status()
    stp.info(f"Anniversary message sent for {len(matches)} person(s).")

# Entry point
if __name__ == "__main__":
    main()

