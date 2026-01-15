#!/bin/bash

for page in MyRequestsActive MyRequestsAccepted MyRequestsHistory Profile; do
  FILE="Pages/${page}.cshtml"
  
  if [ -f "$FILE" ] && ! grep -q "profileBtn.addEventListener" "$FILE"; then
    echo "Adding dropdown script to ${page}.cshtml..."
    
    # Add before the last </script>
    cat >> "$FILE" << 'EOFJS'
<script>
    // Dropdown toggle
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
    echo "✅ ${page}.cshtml updated"
  else
    echo "⚠️  ${page}.cshtml already has dropdown or not found"
  fi
done
