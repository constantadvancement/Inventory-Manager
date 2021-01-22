'use strict';

module.exports = {
  up: async (queryInterface, Sequelize) => {
    await queryInterface.createTable('Locations', {
      id: { type: Sequelize.INTEGER, primaryKey: true, autoIncrement: true, allowNull: false },

      timestamp: { type: Sequelize.DATE, allowNull: false, defaultValue: Sequelize.fn('now') },

      street: { type: Sequelize.STRING, allowNull: true },
      city: { type: Sequelize.STRING, allowNull: true },
      state: { type: Sequelize.STRING, allowNull: true },
      zip: { type: Sequelize.STRING, allowNull: true },
      country: { type: Sequelize.STRING, allowNull: true },

      latitude: { type: Sequelize.STRING, allowNull: true },
      longitude: { type: Sequelize.STRING, allowNull: true },

      status: { type: Sequelize.STRING, allowNull: true },

      createdAt: { allowNull: false, type: Sequelize.DATE, defaultValue: Sequelize.fn('now') },
      updatedAt: { allowNull: false, type: Sequelize.DATE, defaultValue: Sequelize.fn('now') }
    });
  },

  down: async (queryInterface, Sequelize) => {
    await queryInterface.dropTable('Locations');
  }
};
