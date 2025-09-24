const mongoose = require('mongoose');

// =====================================
// USER SCHEMA DEFINITION
// =====================================
const userSchema = new mongoose.Schema({
  // Basic user information (from your users table)
  username: {
    type: String,
    required: [true, 'Username is required'],
    unique: true,
    trim: true,
    minlength: [3, 'Username must be at least 3 characters'],
    maxlength: [30, 'Username cannot exceed 30 characters']
  },

  // User status (embedded instead of separate user_status table)
  status: {
    type: String,
    required: true,
    enum: {
      values: ['active', 'inactive', 'suspended', 'pending'],
      message: 'Status must be: active, inactive, suspended, or pending'
    },
    default: 'pending'
  },

  // User role (embedded instead of separate role table)
  role: {
    type: String,
    required: true,
    enum: {
      values: ['admin', 'owner', 'guard', 'resident', 'maintenance'],
      message: 'Role must be: admin, owner, guard, resident, or maintenance'
    },
    default: 'resident'
  },

  // EMBEDDED PROFILE (replaces separate profile table)
  profile: {
    fullName: {
      type: String,
      required: [true, 'Full name is required'],
      trim: true,
      maxlength: [100, 'Full name cannot exceed 100 characters']
    },
    
    documentType: {
      type: String,
      required: [true, 'Document type is required'],
      enum: {
        values: ['CC', 'CE', 'TI', 'PP', 'NIT'],
        message: 'Document type must be: CC, CE, TI, PP, or NIT'
      }
    },
    
    documentNumber: {
      type: String,
      required: [true, 'Document number is required'],
      unique: true,
      trim: true,
      maxlength: [30, 'Document number cannot exceed 30 characters']
    },
    
    telephoneNumber: {
      type: String,
      required: [true, 'Phone number is required'],
      trim: true,
      maxlength: [12, 'Phone number cannot exceed 12 characters'],
      match: [/^[0-9+\-\s()]+$/, 'Please enter a valid phone number']
    },
    
    photo: {
      type: String,
      default: null
    }
  },

  // EMBEDDED OWNER INFO (only if user is owner - replaces owner table)
  ownerInfo: {
    isActive: {
      type: Boolean,
      default: true
    },
    
    isTenant: {
      type: Boolean,
      default: false
    },
    
    birthDate: {
      type: Date,
      validate: {
        validator: function(date) {
          return date < new Date();
        },
        message: 'Birth date must be in the past'
      }
    },

    // EMBEDDED PETS (replaces separate pet table)
    pets: [{
      name: {
        type: String,
        required: true,
        trim: true,
        maxlength: [30, 'Pet name cannot exceed 30 characters']
      },
      
      species: {
        type: String,
        required: true,
        trim: true,
        maxlength: [30, 'Species cannot exceed 30 characters']
      },
      
      breed: {
        type: String,
        trim: true,
        maxlength: [30, 'Breed cannot exceed 30 characters']
      },
      
      vaccinationCard: {
        type: String,
        default: null
      },
      
      photo: {
        type: String,
        default: null
      },
      
      isActive: {
        type: Boolean,
        default: true
      },
      
      registeredAt: {
        type: Date,
        default: Date.now
      }
    }],

    // Apartment associations (reference to apartments)
    apartments: [{
      apartmentId: Number,
      apartmentNumber: String,
      towerName: String,
      isOwner: { type: Boolean, default: true },
      isTenant: { type: Boolean, default: false },
      moveInDate: Date,
      moveOutDate: Date
    }]
  },

  // EMBEDDED GUARD INFO (only if user is guard - replaces guard table)
  guardInfo: {
    arl: {
      type: String,
      trim: true,
      maxlength: [30, 'ARL cannot exceed 30 characters']
    },
    
    eps: {
      type: String,
      trim: true,
      maxlength: [30, 'EPS cannot exceed 30 characters']
    },
    
    shift: {
      type: String,
      enum: {
        values: ['morning', 'afternoon', 'night', 'rotating'],
        message: 'Shift must be: morning, afternoon, night, or rotating'
      }
    },
    
    isActive: {
      type: Boolean,
      default: true
    },
    
    startDate: {
      type: Date,
      default: Date.now
    }
  },

  // Authentication fields (for login)
  email: {
    type: String,
    unique: true,
    sparse: true, // Allows null values while maintaining uniqueness
    lowercase: true,
    trim: true,
    match: [/^\w+([.-]?\w+)*@\w+([.-]?\w+)*(\.\w{2,3})+$/, 'Please enter a valid email']
  },

  password: {
    type: String,
    minlength: [6, 'Password must be at least 6 characters']
  },

  // Last login tracking
  lastLogin: {
    type: Date,
    default: null
  },

  // Account verification
  isVerified: {
    type: Boolean,
    default: false
  }

}, {
  // Automatic timestamps
  timestamps: true,
  
  // Transform output (remove sensitive data)
  toJSON: {
    transform: function(doc, ret) {
      delete ret.password;
      delete ret.__v;
      return ret;
    }
  }
});

// =====================================
// INDEXES FOR PERFORMANCE
// =====================================
userSchema.index({ username: 1 }, { unique: true });
userSchema.index({ 'profile.documentNumber': 1 }, { unique: true });
userSchema.index({ email: 1 }, { unique: true, sparse: true });
userSchema.index({ role: 1, status: 1 });
userSchema.index({ 'ownerInfo.isActive': 1 });
userSchema.index({ createdAt: -1 });

// =====================================
// VIRTUAL FIELDS (computed properties)
// =====================================
userSchema.virtual('fullProfile').get(function() {
  return {
    id: this._id,
    username: this.username,
    fullName: this.profile.fullName,
    role: this.role,
    status: this.status
  };
});

// =====================================
// INSTANCE METHODS
// =====================================
userSchema.methods.addPet = function(petData) {
  if (!this.ownerInfo) {
    this.ownerInfo = { pets: [] };
  }
  this.ownerInfo.pets.push(petData);
  return this.save();
};

userSchema.methods.removePet = function(petId) {
  if (this.ownerInfo && this.ownerInfo.pets) {
    this.ownerInfo.pets.id(petId).remove();
    return this.save();
  }
};

// =====================================
// STATIC METHODS (class methods)
// =====================================
userSchema.statics.findByRole = function(role) {
  return this.find({ role: role, status: 'active' });
};

userSchema.statics.findOwners = function() {
  return this.find({ 
    role: 'owner', 
    status: 'active',
    'ownerInfo.isActive': true 
  });
};

userSchema.statics.findGuards = function() {
  return this.find({ 
    role: 'guard', 
    status: 'active',
    'guardInfo.isActive': true 
  });
};

// =====================================
// PRE-SAVE MIDDLEWARE
// =====================================
userSchema.pre('save', function(next) {
  // Set default ownerInfo for owners
  if (this.role === 'owner' && !this.ownerInfo) {
    this.ownerInfo = {
      isActive: true,
      isTenant: false,
      pets: [],
      apartments: []
    };
  }
  
  // Set default guardInfo for guards
  if (this.role === 'guard' && !this.guardInfo) {
    this.guardInfo = {
      isActive: true
    };
  }
  
  next();
});

module.exports = mongoose.model('User', userSchema);