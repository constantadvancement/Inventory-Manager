module.exports = (sequelize, DataTypes) => {
    const User = sequelize.define('User', {
        id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },

        email: { type: DataTypes.STRING, allowNull: false  },
        password: { type: DataTypes.STRING, allowNull: false  },

        name: { type: DataTypes.STRING, allowNull: false  },
        phone: { type: DataTypes.STRING, allowNull: false  },

        imageSource: { type: DataTypes.STRING, allowNull: true },
        
        // User role: 1 - admin, 2 - standard
        role: { type: DataTypes.INTEGER, allowNull: false }, 

        apiKey: { type: DataTypes.STRING, allowNull: false },
        
        createdAt: { type: DataTypes.DATE, defaultValue: DataTypes.NOW },
        updatedAt: { type: DataTypes.DATE, defaultValue: DataTypes.NOW }
    }, {
        tableName: 'Users'
    })

    return User
}