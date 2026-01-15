#!/bin/bash

FILE="Pages/MyRequestsActive.cshtml"

# Backup
cp "$FILE" "${FILE}.backup_final"

# Remove the old loadActiveRequests function
sed -i '' '/async function loadActiveRequests/,/}/d' "$FILE"
sed -i '' '/Load requests on page load/d' "$FILE"
sed -i '' '/document.addEventListener.*DOMContentLoaded.*loadActiveRequests/d' "$FILE"

# Add correct implementation BEFORE the closing </script>
sed -i '' '/<\/script>$/i\
\
    \/\/ ==================== LOAD ACTIVE REQUESTS ====================\
    async function loadActiveRequests() {\
        const loadingState = document.getElementById("loadingState");\
        const emptyState = document.getElementById("emptyState");\
        const requestGrid = document.getElementById("requestGrid");\
\
        try {\
            const response = await fetch("http://localhost:5012/api/walkrequests/active?userId=1");\
            \
            if (!response.ok) {\
                throw new Error(`API Error: ${response.status}`);\
            }\
            \
            const requests = await response.json();\
            console.log("Loaded requests:", requests);\
            \
            loadingState.style.display = "none";\
            \
            if (requests.length === 0) {\
                emptyState.style.display = "block";\
                requestGrid.style.display = "none";\
                return;\
            }\
            \
            emptyState.style.display = "none";\
            requestGrid.style.display = "grid";\
            \
            requestGrid.innerHTML = requests.map(req => `\
                <div class="request-card" style="border:1px solid #ddd; padding:15px; border-radius:8px; background:white;">\
                    <h3>${req.fromLocation} → ${req.toDestination}</h3>\
                    <p><i class="fa-regular fa-calendar"></i> ${new Date(req.dateOfWalk).toLocaleDateString()}</p>\
                    <p><i class="fa-regular fa-clock"></i> ${req.timeOfWalk}</p>\
                    <p><span class="badge">Status: ${req.status}</span></p>\
                </div>\
            `).join("");\
            \
        } catch (error) {\
            console.error("Error loading requests:", error);\
            loadingState.style.display = "none";\
            emptyState.style.display = "block";\
            document.querySelector(".empty-state .title").textContent = "Error loading requests";\
            document.querySelector(".empty-state .subtitle").textContent = error.message;\
        }\
    }\
\
    \/\/ Load on page ready\
    document.addEventListener("DOMContentLoaded", loadActiveRequests);' "$FILE"

echo "✅ Fixed!"
