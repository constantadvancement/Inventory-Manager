'use strict';

module.exports = {
  up: async (queryInterface, Sequelize) => {
    await queryInterface.createTable('Devices', {
      serialNumber: { type: Sequelize.STRING(32), primaryKey: true, allowNull: false },

      modelName: { type: Sequelize.STRING, allowNull: false },
      modelIdentifier: { type: Sequelize.STRING, allowNull: false },
      modelNumber: { type: Sequelize.STRING, allowNull: false },

      hardwareUUID: { type: Sequelize.STRING, allowNull: false },

      createdAt: { allowNull: false, type: Sequelize.DATE },
      updatedAt: { allowNull: false, type: Sequelize.DATE }
    });
  },

  down: async (queryInterface, Sequelize) => {
    await queryInterface.dropTable('Devices');
  }
};
