#!/bin/bash

FILE="Pages/Dashboard.cshtml"

# Backup
cp "$FILE" "${FILE}.backup_$(date +%s)"

# Read the file
CONTENT=$(cat "$FILE")

# Check if handleLogout function already exists
if echo "$CONTENT" | grep -q "function handleLogout"; then
    echo "handleLogout function already exists"
else
    # Add handleLogout function before </body>
    CONTENT=$(echo "$CONTENT" | sed '/<\/body>/i\
<script>\
    function handleLogout() {\
        alert("Logging out...");\
        sessionStorage.clear();\
        localStorage.clear();\
        window.location.href = "/Index";\
    }\
</script>')
fi

# Update all logout links
CONTENT=$(echo "$CONTENT" | sed 's|<a><i class="fa-solid fa-right-from-bracket"></i> Log out</a>|<a onclick="handleLogout()" style="cursor: pointer;"><i class="fa-solid fa-right-from-bracket"></i> Log out</a>|g')
CONTENT=$(echo "$CONTENT" | sed 's|<a ><i class="fa-solid fa-right-from-bracket"></i> Log out</a>|<a onclick="handleLogout()" style="cursor: pointer;"><i class="fa-solid fa-right-from-bracket"></i> Log out</a>|g')
CONTENT=$(echo "$CONTENT" | sed 's|<a href="#"><i class="fa-solid fa-right-from-bracket"></i> Log out</a>|<a onclick="handleLogout()" style="cursor: pointer;"><i class="fa-solid fa-right-from-bracket"></i> Log out</a>|g')

# Write back
echo "$CONTENT" > "$FILE"

echo "✅ Dashboard.cshtml updated!"
echo ""
echo "Checking logout link:"
grep "onclick=\"handleLogout\"" "$FILE" || echo "⚠️  onclick not found"
echo ""
echo "Checking function:"
tail -20 "$FILE" | grep -A5 "handleLogout" || echo "⚠️  function not found"
