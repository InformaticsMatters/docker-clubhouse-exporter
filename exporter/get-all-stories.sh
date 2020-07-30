#!/bin/sh
#
# Relies on files produced by 'exporter.sh'
# Here we iterate through each story ID and get
# all its data, send each to the file 'data/stories.json'
#
# Alan Christie
# Informatics Matters Ltd.
# 30 Jul 2020

GET_STORY_URL=https://api.clubhouse.io/api/v3/stories

echo > data/stories.json

echo "Getting all bugs..."
cat data/stories.bugs.json | jq -c '.[].id' | while read id; do
  curl -X GET \
    -H "Content-Type: application/json" \
    -H "Clubhouse-Token: ${CLUBHOUSE_API_TOKEN}" \
    -L "${GET_STORY_URL}/${id}" >> data/stories.json 2>/dev/null
  echo >> data/stories.json
done

echo "Getting all chores..."
cat data/stories.chores.json | jq -c '.[].id' | while read id; do
  curl -X GET \
    -H "Content-Type: application/json" \
    -H "Clubhouse-Token: ${CLUBHOUSE_API_TOKEN}" \
    -L "${GET_STORY_URL}/${id}" >> data/stories.json 2>/dev/null
  echo >> data/stories.json
done

echo "Getting all features..."
cat data/stories.features.json | jq -c '.[].id' | while read id; do
  curl -X GET \
    -H "Content-Type: application/json" \
    -H "Clubhouse-Token: ${CLUBHOUSE_API_TOKEN}" \
    -L "${GET_STORY_URL}/${id}" >> data/stories.json 2>/dev/null
  echo >> data/stories.json
done

num=$(cat data/stories.json | wc -l)
echo "Got $num"

echo "Done!"
