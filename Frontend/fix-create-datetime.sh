#!/bin/bash

FILE="Pages/Create.cshtml"

# Use perl to find and replace the formData object
perl -i -0pe 's/const formData = \{[^}]*userId: userId,[^}]*\};/const formData = {
            userId: userId,
            fromLocation: document.getElementById('\''fromLocation'\'').value,
            specifyOrigin: document.getElementById('\''specifyOrigin'\'').value || '\'''\'',
            toDestination: document.getElementById('\''destination'\'').value,
            dateOfWalk: document.getElementById('\''walkDate'\'').value + '\''T00:00:00'\'', \/\/ ✅ Fixed
            timeOfWalk: document.getElementById('\''walkTime'\'').value + '\'':00'\'', \/\/ ✅ Fixed
            attireDescription: document.getElementById('\''attire'\'').value,
            additionalNotes: document.getElementById('\''notes'\'').value || '\'''\'',
            contactNumber: null
        };/gs' "$FILE"

echo "✅ DateTime fields fixed in Create.cshtml"
