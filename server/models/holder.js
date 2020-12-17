module.exports = (sequelize, DataTypes) => {
    const Holder = sequelize.define('Holder', {
        id: { type: DataTypes.INTEGER, autoIncrement: true, primaryKey: true },

        name: { type: DataTypes.STRING, allowNull: false },
        email: { type: DataTypes.STRING, allowNull: false },
        phone: { type: DataTypes.STRING, allowNull: false },

        createdAt: { type: DataTypes.DATE, defaultValue: DataTypes.NOW },
        updatedAt: { type: DataTypes.DATE, defaultValue: DataTypes.NOW }
    }, {
        tableName: 'Holders'
    })

    return Holder
};