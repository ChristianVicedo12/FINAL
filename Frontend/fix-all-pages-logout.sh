#!/bin/bash

pages=("MyRequestsActive" "MyRequestsAccepted" "MyRequestsHistory" "Profile" "Create")

for page in "${pages[@]}"; do
  FILE="Pages/${page}.cshtml"
  
  if [ ! -f "$FILE" ]; then
    echo "⚠️  ${FILE} not found, skipping..."
    continue
  fi
  
  echo "Processing ${page}.cshtml..."
  
  # Backup
  cp "$FILE" "${FILE}.backup_$(date +%s)"
  
  # Remove any existing handleLogout functions and duplicate body/html tags
  sed -i '' '/function handleLogout/,/<\/script>/d' "$FILE"
  sed -i '' '/<\/body>/d' "$FILE"
  sed -i '' '/<\/html>/d' "$FILE"
  
  # Update logout link to be clickable
  sed -i '' 's|<a[^>]*><i class="fa-solid fa-right-from-bracket"></i> Log out</a>|<a id="logoutBtn" onclick="handleLogout()" style="cursor: pointer;"><i class="fa-solid fa-right-from-bracket"></i> Log out</a>|g' "$FILE"
  
  # Add handleLogout function at the end
  cat >> "$FILE" << 'EOFJS'
<script>
    function handleLogout() {
        sessionStorage.clear();
        localStorage.clear();
        window.location.href = '/Index';
    }
</script>
EOFJS
  
  echo "✅ ${page}.cshtml updated"
done

echo ""
echo "=== Verification ==="
for page in "${pages[@]}"; do
  if grep -q "function handleLogout" "Pages/${page}.cshtml" 2>/dev/null; then
    echo "✓ ${page}.cshtml has handleLogout function"
  fi
  if grep -q 'onclick="handleLogout()"' "Pages/${page}.cshtml" 2>/dev/null; then
    echo "✓ ${page}.cshtml has clickable logout"
  fi
done
