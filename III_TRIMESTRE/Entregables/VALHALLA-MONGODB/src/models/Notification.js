const mongoose = require('mongoose');

const notificationSchema = new mongoose.Schema({
  // Notification type (embedded instead of notification_type table)
  type: {
    type: String,
    required: [true, 'Notification type is required'],
    enum: {
      values: ['general', 'payment', 'maintenance', 'security', 'community', 'emergency'],
      message: 'Type must be: general, payment, maintenance, security, community, or emergency'
    }
  },

  // Notification content
  title: {
    type: String,
    required: [true, 'Notification title is required'],
    trim: true,
    maxlength: [100, 'Title cannot exceed 100 characters']
  },

  description: {
    type: String,
    required: [true, 'Notification description is required'],
    trim: true,
    maxlength: [1000, 'Description cannot exceed 1000 characters']
  },

  // Target audience
  targetUserId: {
    type: Number, // Reference to User._id from MySQL
    default: null // null means broadcast to all users
  },

  targetRole: {
    type: String,
    enum: ['admin', 'owner', 'guard', 'resident', 'maintenance', 'all'],
    default: 'all'
  },

  // Notification status
  isRead: {
    type: Boolean,
    default: false
  },

  priority: {
    type: String,
    enum: {
      values: ['low', 'medium', 'high', 'urgent'],
      message: 'Priority must be: low, medium, high, or urgent'
    },
    default: 'medium'
  },

  // Additional metadata
  metadata: {
    sourceModule: {
      type: String,
      enum: ['payments', 'reservations', 'pqrs', 'maintenance', 'security', 'admin'],
      default: 'admin'
    },
    relatedEntityId: Number,
    actionUrl: String,
    imageUrl: String
  },

  // Scheduling
  scheduledFor: {
    type: Date,
    default: null // null means send immediately
  },

  expiresAt: {
    type: Date,
    default: null // null means never expires
  },

  // Delivery tracking
  sentAt: {
    type: Date,
    default: null
  },

  readAt: {
    type: Date,
    default: null
  }

}, {
  timestamps: true
});

// =====================================
// INDEXES
// =====================================
notificationSchema.index({ targetUserId: 1, createdAt: -1 });
notificationSchema.index({ isRead: 1, createdAt: -1 });
notificationSchema.index({ type: 1, priority: 1 });
notificationSchema.index({ scheduledFor: 1 });
notificationSchema.index({ expiresAt: 1 });

// =====================================
// VIRTUAL FIELDS
// =====================================
notificationSchema.virtual('isExpired').get(function() {
  return this.expiresAt && this.expiresAt < new Date();
});

notificationSchema.virtual('isBroadcast').get(function() {
  return this.targetUserId === null;
});

// =====================================
// INSTANCE METHODS
// =====================================
notificationSchema.methods.markAsRead = function() {
  this.isRead = true;
  this.readAt = new Date();
  return this.save();
};

// =====================================
// STATIC METHODS
// =====================================
notificationSchema.statics.findUnreadForUser = function(userId) {
  return this.find({
    $or: [
      { targetUserId: userId },
      { targetUserId: null } // Broadcast notifications
    ],
    isRead: false,
    $or: [
      { expiresAt: null },
      { expiresAt: { $gt: new Date() } }
    ]
  }).sort({ createdAt: -1 });
};

notificationSchema.statics.findByPriority = function(priority) {
  return this.find({ 
    priority: priority,
    $or: [
      { expiresAt: null },
      { expiresAt: { $gt: new Date() } }
    ]
  }).sort({ createdAt: -1 });
};

module.exports = mongoose.model('Notification', notificationSchema);