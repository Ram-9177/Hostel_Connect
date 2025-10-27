const express = require('express');
const cors = require('cors');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');

const app = express();
const PORT = 3007;

// Middleware
app.use(cors({
  origin: ['http://localhost:5500', 'http://localhost:3000', 'http://localhost:3006', 'http://localhost:5173'],
  credentials: true
}));
app.use(express.json());

// Mock database
const users = [];

// JWT Secret
const JWT_SECRET = 'your-super-secret-jwt-key';

// Helper functions
const generateTokens = (user) => {
  const payload = {
    sub: user.id,
    email: user.email,
    role: user.role,
    hostelId: user.hostelId
  };

  const accessToken = jwt.sign(payload, JWT_SECRET, { expiresIn: '15m' });
  const refreshToken = jwt.sign(payload, JWT_SECRET, { expiresIn: '7d' });

  return { accessToken, refreshToken, expiresIn: 900 };
};

// Routes
app.get('/api/v1/health', (req, res) => {
  res.json({ 
    status: 'healthy', 
    timestamp: new Date().toISOString(),
    message: 'HostelConnect API is running'
  });
});

app.post('/api/v1/auth/register', async (req, res) => {
  try {
    const { email, password, firstName, lastName, role, studentId, phone } = req.body;

    // Check if user already exists
    const existingUser = users.find(u => u.email === email);
    if (existingUser) {
      return res.status(400).json({
        success: false,
        message: 'Email already registered',
        error: 'BadRequest'
      });
    }

    // Check if student ID already exists (for students)
    if (role === 'STUDENT') {
      const existingStudentId = users.find(u => u.studentId === studentId);
      if (existingStudentId) {
        return res.status(400).json({
          success: false,
          message: 'Student ID already registered',
          error: 'BadRequest'
        });
      }
    }

    // Hash password
    const hashedPassword = await bcrypt.hash(password, 12);

    // Create user
    const user = {
      id: Date.now().toString(),
      email,
      password: hashedPassword,
      firstName,
      lastName,
      role,
      studentId: role === 'STUDENT' ? studentId : undefined,
      phone: phone || undefined,
      isActive: true,
      createdAt: new Date().toISOString(),
      updatedAt: new Date().toISOString()
    };

    users.push(user);

    // Generate tokens
    const tokens = generateTokens(user);

    res.json({
      success: true,
      user: {
        id: user.id,
        email: user.email,
        firstName: user.firstName,
        lastName: user.lastName,
        role: user.role,
        studentId: user.studentId,
        phone: user.phone,
        isActive: user.isActive,
        createdAt: user.createdAt
      },
      ...tokens,
      message: 'Registration successful'
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: 'Registration failed',
      error: error.message
    });
  }
});

app.post('/api/v1/auth/login', async (req, res) => {
  try {
    const { email, password } = req.body;

    // Find user
    const user = users.find(u => u.email === email);
    if (!user) {
      return res.status(401).json({
        success: false,
        message: 'Invalid credentials',
        error: 'Unauthorized'
      });
    }

    // Check if user is active
    if (!user.isActive) {
      return res.status(401).json({
        success: false,
        message: 'Account is deactivated',
        error: 'Unauthorized'
      });
    }

    // Verify password
    const isPasswordValid = await bcrypt.compare(password, user.password);
    if (!isPasswordValid) {
      return res.status(401).json({
        success: false,
        message: 'Invalid credentials',
        error: 'Unauthorized'
      });
    }

    // Update last login
    user.lastLogin = new Date().toISOString();
    user.updatedAt = new Date().toISOString();

    // Generate tokens
    const tokens = generateTokens(user);

    res.json({
      success: true,
      user: {
        id: user.id,
        email: user.email,
        firstName: user.firstName,
        lastName: user.lastName,
        role: user.role,
        studentId: user.studentId,
        phone: user.phone,
        isActive: user.isActive,
        lastLogin: user.lastLogin,
        createdAt: user.createdAt
      },
      ...tokens,
      message: 'Login successful'
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: 'Login failed',
      error: error.message
    });
  }
});

app.get('/api/v1/auth/profile', (req, res) => {
  const authHeader = req.headers.authorization;
  if (!authHeader || !authHeader.startsWith('Bearer ')) {
    return res.status(401).json({
      success: false,
      message: 'No token provided',
      error: 'Unauthorized'
    });
  }

  const token = authHeader.substring(7);
  try {
    const payload = jwt.verify(token, JWT_SECRET);
    const user = users.find(u => u.id === payload.sub);
    
    if (!user) {
      return res.status(401).json({
        success: false,
        message: 'User not found',
        error: 'Unauthorized'
      });
    }

    res.json({
      success: true,
      user: {
        id: user.id,
        email: user.email,
        firstName: user.firstName,
        lastName: user.lastName,
        role: user.role,
        studentId: user.studentId,
        phone: user.phone,
        isActive: user.isActive,
        lastLogin: user.lastLogin,
        createdAt: user.createdAt
      }
    });
  } catch (error) {
    res.status(401).json({
      success: false,
      message: 'Invalid token',
      error: 'Unauthorized'
    });
  }
});

app.post('/api/v1/auth/refresh', (req, res) => {
  try {
    const { refreshToken } = req.body;
    
    if (!refreshToken) {
      return res.status(401).json({
        success: false,
        message: 'No refresh token provided',
        error: 'Unauthorized'
      });
    }

    const payload = jwt.verify(refreshToken, JWT_SECRET);
    const user = users.find(u => u.id === payload.sub);
    
    if (!user || !user.isActive) {
      return res.status(401).json({
        success: false,
        message: 'Invalid refresh token',
        error: 'Unauthorized'
      });
    }

    const tokens = generateTokens(user);
    
    res.json({
      success: true,
      accessToken: tokens.accessToken
    });
  } catch (error) {
    res.status(401).json({
      success: false,
      message: 'Invalid refresh token',
      error: 'Unauthorized'
    });
  }
});

// Start server
app.listen(PORT, () => {
  console.log(`🚀 HostelConnect Mock API running on port ${PORT}`);
  console.log(`📚 Health check: http://localhost:${PORT}/api/v1/health`);
  console.log(`🔐 Auth endpoints: http://localhost:${PORT}/api/v1/auth/*`);
});
