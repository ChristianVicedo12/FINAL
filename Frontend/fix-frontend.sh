#!/bin/bash
FILE="Pages/MyRequestsActive.cshtml"
# Backup first
cp "$FILE" "$FILE.backup"

# Replace the loadActiveRequests function
sed -i.tmp '/async function loadActiveRequests()/,/^    }$/ {
    /const token = localStorage.getItem/s/^/        \/\/ /
    /if (!token)/s/^/        \/\/ /
    /window.location.href/s/^/            \/\/ /
    /return;$/s/^/            \/\/ /
    /'"'"'Authorization'"'"'/s/^/                \/\/ /
}' "$FILE"

echo "Frontend fixed! Backup saved as $FILE.backup"
