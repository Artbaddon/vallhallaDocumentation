import { connect, connection } from 'mongoose';
import { createConnection } from 'mysql2/promise';
import dotenv from 'dotenv';
dotenv.config(); 

class DatabaseManager {
  constructor() {
    this.mongoConnection = null;
    this.mysqlConnection = null;
  }

  // =====================================
  // MONGODB CONNECTION
  // =====================================
  async connectMongoDB() {
    try {
      console.log('🔄 Connecting to MongoDB...');
      
      // Connection options for better performance and reliability
      const options = {
        useNewUrlParser: true,
        useUnifiedTopology: true,
        maxPoolSize: 10, // Maximum number of connections
        serverSelectionTimeoutMS: 5000, // Keep trying to send operations for 5 seconds
        socketTimeoutMS: 45000, // Close sockets after 45 seconds of inactivity
        bufferMaxEntries: 0 // Disable mongoose buffering
      };

      this.mongoConnection = await connect(process.env.MONGODB_URI, options);
      
      console.log('✅ MongoDB Connected Successfully!');
      console.log(`📊 Database: ${connection.name}`);
      console.log(`🌐 Host: ${connection.host}:${connection.port}`);

      // Set up event listeners for connection monitoring
      connection.on('error', (error) => {
        console.error('❌ MongoDB Error:', error.message);
      });

      connection.on('disconnected', () => {
        console.log('📡 MongoDB Disconnected');
      });

      connection.on('reconnected', () => {
        console.log('🔄 MongoDB Reconnected');
      });

      return this.mongoConnection;

    } catch (error) {
      console.error('💥 MongoDB Connection Failed:', error.message);
      console.error('🔧 Check your connection string in .env file');
      process.exit(1);
    }
  }

  // =====================================
  // MYSQL CONNECTION (for migration)
  // =====================================
  async connectMySQL() {
    try {
      console.log('🔄 Connecting to MySQL...');
      
      this.mysqlConnection = await createConnection({
        host: process.env.MYSQL_HOST,
        user: process.env.MYSQL_USER,
        password: process.env.MYSQL_PASSWORD,
        database: process.env.MYSQL_DATABASE,
        port: process.env.MYSQL_PORT,
        
        // Connection pool settings
        acquireTimeout: 60000,
        timeout: 60000,
        reconnect: true
      });

      console.log('✅ MySQL Connected Successfully!');
      console.log(`📊 Database: ${process.env.MYSQL_DATABASE}`);
      
      return this.mysqlConnection;

    } catch (error) {
      console.error('💥 MySQL Connection Failed:', error.message);
      console.error('🔧 Check your MySQL credentials in .env file');
      throw error;
    }
  }

  // =====================================
  // CONNECTION HEALTH CHECK
  // =====================================
  async checkConnections() {
    const status = {
      mongodb: 'disconnected',
      mysql: 'disconnected',
      timestamp: new Date().toISOString()
    };

    // Check MongoDB
    try {
      if (connection.readyState === 1) {
        status.mongodb = 'connected';
      }
    } catch (error) {
      status.mongodb = 'error';
    }

    // Check MySQL
    try {
      if (this.mysqlConnection) {
        await this.mysqlConnection.ping();
        status.mysql = 'connected';
      }
    } catch (error) {
      status.mysql = 'error';
    }

    return status;
  }

  // =====================================
  // GRACEFUL SHUTDOWN
  // =====================================
  async disconnect() {
    console.log('🛑 Closing database connections...');
    
    try {
      // Close MongoDB
      if (this.mongoConnection) {
        await connection.close();
        console.log('👋 MongoDB connection closed');
      }

      // Close MySQL
      if (this.mysqlConnection) {
        await this.mysqlConnection.end();
        console.log('👋 MySQL connection closed');
      }

    } catch (error) {
      console.error('❌ Error closing connections:', error.message);
    }
  }
}

// Export a single instance (Singleton pattern)
export default new DatabaseManager();