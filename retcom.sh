# for each line in day notes apple notes/2025-04-14, parse the date and create an empty git commit with that date

#!/bin/bash
# Check if the file exists
if [ ! -f "day notes" ]; then
  echo "File day_notes.txt not found!"
  exit 1
fi
# Read the file line by line
while IFS= read -r line; do
  # Skip empty lines
  [ -z "$line" ] && continue
  # Extract date and trim whitespace
  date="$(echo "${line#*/}" | xargs)"
  # Skip if date is empty or not in YYYY-MM-DD format
  if [[ ! "$date" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
    echo "Skipping invalid date: $date"
    continue
  fi
  GIT_AUTHOR_DATE="${date}T12:00:00" GIT_COMMITTER_DATE="${date}T12:00:00" \
    git commit --allow-empty -m "[$date] day note created in apple notes." --date="${date}T12:00:00"
done < "day notes"