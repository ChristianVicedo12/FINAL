#!/bin/bash
for file in Pages/*.cshtml; do
  if grep -q "Log out" "$file"; then
    # Add id and onclick to logout link
    sed -i '' 's|<a><i class="fa-solid fa-right-from-bracket"></i> Log out</a>|<a id="logoutBtn" style="cursor: pointer;" onclick="handleLogout()"><i class="fa-solid fa-right-from-bracket"></i> Log out</a>|g' "$file"
    
    # Add logout function if not exists
    if ! grep -q "handleLogout" "$file"; then
      sed -i '' '/<\/body>/i\
    <script>\
        function handleLogout() {\
            sessionStorage.clear();\
            localStorage.clear();\
            window.location.href = "/Index";\
        }\
    </script>' "$file"
    fi
  fi
done
