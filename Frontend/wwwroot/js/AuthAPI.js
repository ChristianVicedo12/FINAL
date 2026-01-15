const AuthAPI = {
    baseUrl: 'http://localhost:5012/api',
    
    signup: async function(userData) {
        try {
            console.log('=== SIGNUP DEBUG ===');
            console.log('userData received:', userData);
            console.log('fullName:', userData.fullName);
            console.log('email:', userData.email);
            
            const requestBody = {
                fullName: userData.fullName,
                email: userData.email,
                contactNumber: userData.contactNumber,
                password: userData.password
            };
            
            console.log('Request body:', JSON.stringify(requestBody, null, 2));
            
            const response = await fetch(this.baseUrl + '/Auth/signup', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(requestBody)
            });

            const data = await response.json();
            console.log('Signup response:', data);

            if (!response.ok) {
                throw new Error(data.message || 'Signup failed');
            }

            return { success: true, data: data };
        } catch (error) {
            console.error('Signup error:', error);
            return { success: false, message: error.message };
        }
    },

    login: async function(email, password) {
        try {
            console.log('Sending login request');
            
            const response = await fetch(this.baseUrl + '/Auth/signin', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ email: email, password: password })
            });

            const data = await response.json();
            console.log('Login response:', data);

            if (!response.ok) {
                throw new Error(data.message || 'Login failed');
            }

            if (data.token) {
                sessionStorage.setItem('token', data.token);
                sessionStorage.setItem('userId', data.user.id);
                sessionStorage.setItem('username', data.user.fullName);
                sessionStorage.setItem('email', data.user.email);
            }

            return { success: true, data: data };
        } catch (error) {
            console.error('Login error:', error);
            return { success: false, message: error.message };
        }
    },

    logout: function() {
        sessionStorage.clear();
        localStorage.clear();
        window.location.href = '/';
    },

    isLoggedIn: function() {
        return sessionStorage.getItem('token') !== null;
    },

    getCurrentUser: function() {
        return {
            token: sessionStorage.getItem('token'),
            userId: sessionStorage.getItem('userId'),
            userName: sessionStorage.getItem('username')
        };
    }
};

window.AuthAPI = AuthAPI;
console.log('AuthAPI loaded - version 2.0');
