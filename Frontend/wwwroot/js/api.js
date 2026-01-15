const API_BASE_URL = 'http://localhost:5012/api';

async function apiCall(endpoint, method = 'GET', body = null) {
    const options = {
        method,
        headers: {
            'Content-Type': 'application/json'
        }
    };
    
    const token = localStorage.getItem('authToken');
    if (token) {
        options.headers['Authorization'] = `Bearer ${token}`;
    }
    
    if (body) {
        options.body = JSON.stringify(body);
    }
    
    try {
        const response = await fetch(`${API_BASE_URL}${endpoint}`, options);
        const data = await response.json();
        
        if (!response.ok) {
            throw new Error(data.message || 'Something went wrong');
        }
        
        return data;
    } catch (error) {
        console.error('API Error:', error);
        throw error;
    }
}

const api = {
    // Auth methods
    signUp: (fullName, email, contactNumber, password) => 
        apiCall('/Auth/signup', 'POST', { fullName, email, contactNumber, password }),
    
    signIn: (email, password) => 
        apiCall('/Auth/signin', 'POST', { email, password }),
    
    logout: () => 
        apiCall('/Auth/logout', 'POST'),
    
    // Walk Request methods
    getWalkRequests: () => 
        apiCall('/WalkRequest/active'),
    
    createWalkRequest: (requestData) => 
        apiCall('/WalkRequest/create', 'POST', requestData),
    
    acceptRequest: (id) => 
        apiCall(`/WalkRequest/accept/${id}`, 'POST'),
    
    getMyRequests: () => 
        apiCall('/WalkRequest/my-requests'),
    
    cancelRequest: (id) => 
        apiCall(`/WalkRequest/cancel/${id}`, 'POST')
};
