const express = require('express');
const cors = require('cors');

const app = express();
const PORT = 3000;
const HOST = '0.0.0.0';

// Middleware
app.use(cors({
  origin: true,
  credentials: true,
}));
app.use(express.json());

// Test endpoint
app.get('/api/v1/', (req, res) => {
  res.json({ 
    status: 'ok', 
    message: 'HostelConnect API is running!',
    timestamp: new Date().toISOString()
  });
});

// Health check
app.get('/api/v1/health', (req, res) => {
  res.json({ status: 'ok' });
});

// Test login endpoint - normalized response format
app.post('/api/v1/auth/login', (req, res) => {
  const { email, password } = req.body;
  
  // Demo credentials
  const demoUsers = {
    'student@demo.com': { password: 'password123', role: 'student', name: 'John Student' },
    'warden@demo.com': { password: 'password123', role: 'warden', name: 'Jane Warden' },
    'wardenhead@demo.com': { password: 'password123', role: 'warden_head', name: 'Mike Head' },
    'chef@demo.com': { password: 'password123', role: 'chef', name: 'Sarah Chef' },
    'admin@demo.com': { password: 'password123', role: 'super_admin', name: 'Admin User' }
  };
  
  if (demoUsers[email] && demoUsers[email].password === password) {
    // Success response - normalized format
    res.status(200).json({
      accessToken: 'demo-access-token-' + Date.now(),
      refreshToken: 'demo-refresh-token-' + Date.now(),
      user: {
        id: 'demo-user-' + Date.now(),
        role: demoUsers[email].role,
        name: demoUsers[email].name,
        email: email
      }
    });
  } else {
    // Failure response - clean 401
    res.status(401).json({
      error: 'INVALID_CREDENTIALS'
    });
  }
});

app.listen(PORT, HOST, () => {
  console.log(`🚀 HostelConnect API running on ${HOST}:${PORT}`);
  console.log(`📚 API Documentation: http://localhost:${PORT}/api/v1/`);
  console.log(`🔗 Test Login: POST http://localhost:${PORT}/api/v1/auth/login`);
});
