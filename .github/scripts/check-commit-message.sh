#!/bin/bash

# Get the commit messages
commit_messages=$(git log --format=%B -n 1)

# Check each commit message
while IFS= read -r message; do
  if [[ ! "$message" =~ ^(#none|[0-9]+) ]]; then
    echo "Commit message must start with #none or a Pivotal Tracker ID."
    echo "Invalid commit message: $message"
    exit 1
  fi
done <<< "$commit_messages"

echo "All commit messages are valid."
