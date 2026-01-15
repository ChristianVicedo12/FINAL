#!/bin/bash

FILE="Pages/Dashboard.cshtml"

# Find and replace the acceptRequest function
perl -i -pe 's/async function acceptRequest\(requestId\).*?catch \(error\) \{.*?alert\(.*?\);.*?\}.*?\}/async function acceptRequest(requestId) {
        if (!confirm("Accept this walk request?")) return;

        try {
            const currentUser = "juan.dc"; \/\/ TODO: Get from session
            
            const response = await fetch("http:\/\/localhost:5012\/api\/walkrequest\/accept", {
                method: "POST",
                headers: { "Content-Type": "application\/json" },
                body: JSON.stringify({
                    requestId: requestId,
                    companionId: currentUser,
                    companionName: "Juan Dela Cruz" \/\/ TODO: Get real name
                })
            });

            if (response.ok) {
                const result = await response.json();
                alert("✅ " + result.message);
                window.location.reload(); \/\/ Refresh to update list
            } else {
                const error = await response.json();
                alert("❌ " + (error.message || "Failed to accept request"));
            }
        } catch (error) {
            console.error("Error:", error);
            alert("❌ Network error: " + error.message);
        }
    }/gs' "$FILE"

echo "✅ Dashboard acceptRequest function updated!"
