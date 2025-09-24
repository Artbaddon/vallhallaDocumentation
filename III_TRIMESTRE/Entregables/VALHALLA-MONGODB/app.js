// =====================================
// MAIN APPLICATION FILE
// =====================================
const express = require('express');
const cors = require('cors');
const path = require('path');
require('dotenv').config();

// Import database manager
const databaseManager = require('./src/config/database');

// Import models (this registers them with Mongoose)
const User = require('./src/models/User');
const Notification = require('./src/models/Notification');

// =====================================
// EXPRESS APP SETUP
// =====================================
const app = express();

// =====================================
// MIDDLEWARE SETUP
// =====================================

// CORS configuration
app.use(cors({
  origin: process.env.CORS_ORIGIN || 'http://localhost:3000',
  credentials: true
}));

// Body parsing middleware
app.use(express.json({ limit: '10mb' }));
app.use(express.urlencoded({ extended: true, limit: '10mb' }));

// Static files (for uploaded images, etc.)
app.use('/uploads', express.static(path.join(__dirname, 'uploads')));

// Request logging middleware (simple version)
app.use((req, res, next) => {
  console.log(`${new Date().toISOString()} - ${req.method} ${req.path}`);
  next();
});

// =====================================
// BASIC ROUTES
// =====================================

// Health check route
app.get('/health', async (req, res) => {
  try {
    const connectionStatus = await databaseManager.checkConnections();
    
    res.json({
      status: 'OK',
      timestamp: new Date().toISOString(),
      environment: process.env.NODE_ENV,
      databases: connectionStatus,
      uptime: process.uptime()
    });
  } catch (error) {
    res.status(500).json({
      status: 'ERROR',
      message: error.message
    });
  }
});

// Root route
app.get('/', (req, res) => {
  res.json({
    message: '🏢 Welcome to Valhalla Apartment Management System!',
    version: '1.0.0',
    database: 'MongoDB',
    endpoints: {
      health: '/health',
      users: '/api/users',
      notifications: '/api/notifications',
      test: '/api/test'
    }
  });
});

// =====================================
// TEST ROUTES (for learning MongoDB)
// =====================================

// CREATE USER (Test creating documents)
app.post('/api/test/user', async (req, res) => {
  try {
    console.log('📝 Creating test user...');
    
    const userData = {
      username: `testuser_${Date.now()}`,
      status: 'active',
      role: 'owner',
      profile: {
        fullName: 'Test User Example',
        documentType: 'CC',
        documentNumber: `12345${Date.now()}`,
        telephoneNumber: '3001234567'
      },
      ownerInfo: {
        isActive: true,
        isTenant: false,
        birthDate: new Date('1990-01-01'),
        pets: [
          {
            name: 'Rex',
            species: 'Dog',
            breed: 'Golden Retriever'
          },
          {
            name: 'Fluffy',
            species: 'Cat',
            breed: 'Persian'
          }
        ]
      }
    };

    const user = new User(userData);
    const savedUser = await user.save();

    res.status(201).json({
      success: true,
      message: 'User created successfully',
      data: savedUser
    });

  } catch (error) {
    console.error('❌ Error creating user:', error);
    res.status(500).json({
      success: false,
      message: 'Error creating user',
      error: error.message
    });
  }
});

// GET ALL USERS (Test reading documents)
app.get('/api/test/users', async (req, res) => {
  try {
    console.log('📋 Fetching all users...');
    
    const users = await User.find({})
      .select('-password') // Exclude password field
      .sort({ createdAt: -1 }) // Newest first
      .limit(10); // Limit to 10 users

    res.json({
      success: true,
      count: users.length,
      data: users
    });

  } catch (error) {
    console.error('❌ Error fetching users:', error);
    res.status(500).json({
      success: false,
      message: 'Error fetching users',
      error: error.message
    });
  }
});

// GET USER BY ID (Test finding specific documents)
app.get('/api/test/user/:id', async (req, res) => {
  try {
    const { id } = req.params;
    console.log(`🔍 Finding user with ID: ${id}`);
    
    const user = await User.findById(id);
    
    if (!user) {
      return res.status(404).json({
        success: false,
        message: 'User not found'
      });
    }

    res.json({
      success: true,
      data: user
    });

  } catch (error) {
    console.error('❌ Error finding user:', error);
    res.status(500).json({
      success: false,
      message: 'Error finding user',
      error: error.message
    });
  }
});

// UPDATE USER (Test updating documents)
app.put('/api/test/user/:id', async (req, res) => {
  try {
    const { id } = req.params;
    const updates = req.body;
    
    console.log(`✏️ Updating user with ID: ${id}`);
    
    const user = await User.findByIdAndUpdate(
      id, 
      updates, 
      { 
        new: true, // Return the updated document
        runValidators: true // Run schema validation
      }
    );
    
    if (!user) {
      return res.status(404).json({
        success: false,
        message: 'User not found'
      });
    }

    res.json({
      success: true,
      message: 'User updated successfully',
      data: user
    });

  } catch (error) {
    console.error('❌ Error updating user:', error);
    res.status(500).json({
      success: false,
      message: 'Error updating user',
      error: error.message
    });
  }
});

// CREATE NOTIFICATION (Test embedded documents)
app.post('/api/test/notification', async (req, res) => {
  try {
    console.log('📢 Creating test notification...');
    
    const notificationData = {
      type: 'general',
      title: 'Welcome to Valhalla!',
      description: 'This is a test notification to demonstrate MongoDB functionality.',
      targetUserId: null, // Broadcast to all users
      priority: 'medium',
      metadata: {
        sourceModule: 'admin',
        actionUrl: '/dashboard'
      }
    };

    const notification = new Notification(notificationData);
    const savedNotification = await notification.save();

    res.status(201).json({
      success: true,
      message: 'Notification created successfully',
      data: savedNotification
    });

  } catch (error) {
    console.error('❌ Error creating notification:', error);
    res.status(500).json({
      success: false,
      message: 'Error creating notification',
      error: error.message
    });
  }
});

// SEARCH USERS (Test querying with filters)
app.get('/api/test/search/users', async (req, res) => {
  try {
    const { role, status, haspets } = req.query;
    
    console.log('🔍 Searching users with filters:', { role, status, haspets });
    
    // Build query dynamically
    let query = {};
    
    if (role) query.role = role;
    if (status) query.status = status;
    if (haspets === 'true') {
      query['ownerInfo.pets.0'] = { $exists: true }; // Has at least one pet
    }

    const users = await User.find(query)
      .select('username role status profile.fullName ownerInfo.pets')
      .sort({ createdAt: -1 });

    res.json({
      success: true,
      count: users.length,
      filters: { role, status, haspets },
      data: users
    });

  } catch (error) {
    console.error('❌ Error searching users:', error);
    res.status(500).json({
      success: false,
      message: 'Error searching users',
      error: error.message
    });
  }
});

// =====================================
// ERROR HANDLING MIDDLEWARE
// =====================================
app.use((err, req, res, next) => {
  console.error('💥 Unhandled error:', err);
  
  res.status(500).json({
    success: false,
    message: 'Internal server error',
    error: process.env.NODE_ENV === 'development' ? err.message : 'Something went wrong'
  });
});

// Handle 404 routes
app.use('*', (req, res) => {
  res.status(404).json({
    success: false,
    message: `Route ${req.method} ${req.originalUrl} not found`,
    availableRoutes: [
      'GET /',
      'GET /health',
      'POST /api/test/user',
      'GET /api/test/users',
      'GET /api/test/user/:id',
      'PUT /api/test/user/:id',
      'POST /api/test/notification',
      'GET /api/test/search/users'
    ]
  });
});

// =====================================
// SERVER STARTUP
// =====================================
const PORT = process.env.PORT || 3000;

const startServer = async () => {
  try {
    console.log('🚀 Starting Valhalla MongoDB Application...');
    
    // Connect to MongoDB first
    await databaseManager.connectMongoDB();
    
    // Start the Express server
    app.listen(PORT, () => {
      console.log('');
      console.log('='.repeat(50));
      console.log('🎉 SERVER STARTED SUCCESSFULLY!');
      console.log('='.repeat(50));
      console.log(`🌐 Server URL: http://localhost:${PORT}`);
      console.log(`📊 Database: MongoDB`);
      console.log(`🔧 Environment: ${process.env.NODE_ENV}`);
      console.log('');
      console.log('📋 Available endpoints:');
      console.log(`   • GET  http://localhost:${PORT}/`);
      console.log(`   • GET  http://localhost:${PORT}/health`);
      console.log(`   • POST http://localhost:${PORT}/api/test/user`);
      console.log(`   • GET  http://localhost:${PORT}/api/test/users`);
      console.log('');
      console.log('🎯 Try creating a test user:');
      console.log(`   curl -X POST http://localhost:${PORT}/api/test/user`);
      console.log('='.repeat(50));
    });

  } catch (error) {
    console.error('💥 Failed to start server:', error);
    process.exit(1);
  }
};

// =====================================
// GRACEFUL SHUTDOWN
// =====================================
process.on('SIGINT', async () => {
  console.log('\n🛑 Received SIGINT. Graceful shutdown...');
  await databaseManager.disconnect();
  process.exit(0);
});

process.on('SIGTERM', async () => {
  console.log('\n🛑 Received SIGTERM. Graceful shutdown...');
  await databaseManager.disconnect();
  process.exit(0);
});

// Start the server
startServer();