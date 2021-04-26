module.exports = (sequelize, DataTypes) => {
    const Location = sequelize.define('Location', {
        id: { type: DataTypes.INTEGER, autoIncrement: true, primaryKey: true },

        timestamp: { type: DataTypes.DATE, allowNull: false, defaultValue: DataTypes.NOW },

        street: { type: DataTypes.STRING, allowNull: true },
        city: { type: DataTypes.STRING, allowNull: true },
        state: { type: DataTypes.STRING, allowNull: true },
        zip: { type: DataTypes.STRING, allowNull: true },
        country: { type: DataTypes.STRING, allowNull: true },

        latitude: { type: DataTypes.STRING, allowNull: true },
        longitude: { type: DataTypes.STRING, allowNull: true },

        status: { type: DataTypes.STRING, allowNull: true },

        createdAt: { type: DataTypes.DATE, defaultValue: DataTypes.NOW },
        updatedAt: { type: DataTypes.DATE, defaultValue: DataTypes.NOW }
    }, {
        tableName: 'Locations'
    })

    return Location
}