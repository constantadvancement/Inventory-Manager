module.exports = (sequelize, DataTypes) => {
    const Device = sequelize.define('Device', {
        serialNumber: { type: DataTypes.STRING, primaryKey: true },

        modelName: { type: DataTypes.STRING, allowNull: false },
        modelIdentifier: { type: DataTypes.STRING, allowNull: false },
        modelNumber: { type: DataTypes.STRING, allowNull: false },

        hardwareUUID: { type: DataTypes.STRING, allowNull: false },

        createdAt: { type: DataTypes.DATE, defaultValue: DataTypes.NOW },
        updatedAt: { type: DataTypes.DATE, defaultValue: DataTypes.NOW }
    }, {
        tableName: 'devices'
    })

    return Device
};