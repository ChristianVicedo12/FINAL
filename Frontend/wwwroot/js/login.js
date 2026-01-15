async function handleLogin(event) {
    event.preventDefault();
    
    const email = document.getElementById('emailInput').value;
    const password = document.getElementById('passwordInput').value;
    const errorMessage = document.getElementById('errorMessage');
    
    errorMessage.style.display = 'none';
    
    try {
        const response = await fetch('http://localhost:5012/api/auth/signin', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                email: email,
                password: password
            })
        });
        
        if (!response.ok) {
            const error = await response.json();
            errorMessage.textContent = error.message || 'Invalid email or password';
            errorMessage.style.display = 'block';
            return;
        }
        
        const data = await response.json();
        
        // ✅ Use localStorage instead
        localStorage.setItem('token', data.token);
        localStorage.setItem('userId', data.user.id.toString());
        localStorage.setItem('username', data.user.fullName);
        localStorage.setItem('email', data.user.email);
        
        // Also save to sessionStorage as backup
        sessionStorage.setItem('token', data.token);
        sessionStorage.setItem('userId', data.user.id.toString());
        sessionStorage.setItem('username', data.user.fullName);
        sessionStorage.setItem('email', data.user.email);
        
        console.log('Login successful, redirecting...');
        window.location.href = '/Dashboard';
        
    } catch (error) {
        console.error('Login error:', error);
        errorMessage.textContent = 'An error occurred. Please try again.';
        errorMessage.style.display = 'block';
    }
}
