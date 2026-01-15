#!/bin/bash

FILE="Pages/MyRequestsActive.cshtml"

# Create clean version - remove all handleLogout and dropdown scripts
sed -i '' '/function handleLogout/,/<\/script>/d' "$FILE"
sed -i '' '/profileBtn.addEventListener/,/<\/script>/d' "$FILE"

# Add both scripts properly at the end
cat >> "$FILE" << 'EOFJS'
<script>
    function handleLogout() {
        sessionStorage.clear();
        localStorage.clear();
        window.location.href = '/Index';
    }
</script>
<script>
    const profileBtn = document.getElementById('profileBtn');
    const dropdownMenu = document.getElementById('dropdownMenu');
    if (profileBtn && dropdownMenu) {
        profileBtn.addEventListener('click', function(e) {
            e.stopPropagation();
            dropdownMenu.classList.toggle('show');
        });
        document.addEventListener('click', function() {
            dropdownMenu.classList.remove('show');
        });
    }
</script>
EOFJS

echo "✅ Fixed!"
