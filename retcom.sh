while IFS= read -r line; do
  date="${line#*/}"
  fname="file_$date.txt"
  echo "$date" > "$fname"
  git add "$fname"
  GIT_AUTHOR_DATE="${date}T12:00:00" GIT_COMMITTER_DATE="${date}T12:00:00" \
    git commit -m "[$date] day note created in apple notes." --date="${date}T12:00:00"
done < "day notes"