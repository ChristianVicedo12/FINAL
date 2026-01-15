document.getElementById('signupBtn').addEventListener('click', async function() {
    const fullName = document.getElementById('fullName').value.trim();
    const email = document.getElementById('email').value.trim();
    const contactNumber = document.getElementById('contactNumber').value.trim();
    const password = document.getElementById('password').value;
    const errorDiv = document.getElementById('errorMessage');
    const successDiv = document.getElementById('successMessage');
    
    errorDiv.style.display = 'none';
    successDiv.style.display = 'none';

    // Validation
    if (!fullName || !email || !contactNumber || !password) {
        errorDiv.textContent = 'Please fill in all fields';
        errorDiv.style.display = 'block';
        return;
    }

    // Email validation (PUP email)
    if (!email.endsWith('@iskolarngbayan.pup.edu.ph')) {
        errorDiv.textContent = 'Please use your PUP email (@iskolarngbayan.pup.edu.ph)';
        errorDiv.style.display = 'block';
        return;
    }

    // ✅ Contact number validation - numbers only, 11 digits (PH format)
    const phoneRegex = /^09\d{9}$/;
    if (!phoneRegex.test(contactNumber)) {
        errorDiv.textContent = 'Contact number must be 11 digits starting with 09 (e.g., 09123456789)';
        errorDiv.style.display = 'block';
        return;
    }

    // Password validation
    if (password.length < 6) {
        errorDiv.textContent = 'Password must be at least 6 characters long';
        errorDiv.style.display = 'block';
        return;
    }

    try {
        this.disabled = true;
        this.textContent = 'Signing up...';

        const result = await AuthAPI.signup({
            fullName: fullName,
            email: email,
            contactNumber: contactNumber,
            password: password
        });

        if (result.success) {
            successDiv.textContent = 'Account created successfully! Redirecting to login...';
            successDiv.style.display = 'block';
            
            // Clear form
            document.getElementById('fullName').value = '';
            document.getElementById('email').value = '';
            document.getElementById('contactNumber').value = '';
            document.getElementById('password').value = '';
            
            setTimeout(() => {
                window.location.href = '/';
            }, 2000);
        } else {
            throw new Error(result.message);
        }
    } catch (error) {
        console.error('Signup error:', error);
        errorDiv.textContent = error.message || 'Sign up failed. Please try again.';
        errorDiv.style.display = 'block';
        this.disabled = false;
        this.textContent = 'Sign Up';
    }
});
