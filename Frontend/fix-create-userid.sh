#!/bin/bash

FILE="Pages/Create.cshtml"

# Replace the userId line to use username
perl -i -pe 's/const userId = user\.id;/const userId = user.username || "juan.dc"; \/\/ Use username, not ID/' "$FILE"

# Also update the formData userId line
perl -i -pe 's/userId: userId,/userId: userId.toString(),/' "$FILE"

echo "✅ UserId fixed to use username"
