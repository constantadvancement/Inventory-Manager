'use strict';

module.exports = {
  up: async (queryInterface, Sequelize) => {
    await queryInterface.createTable('Users', {
      id: { type: Sequelize.INTEGER, primaryKey: true, autoIncrement: true, allowNull: false },

      email: { type: Sequelize.STRING, allowNull: false },
      password: { type: Sequelize.STRING, allowNull: false },

      name: { type: Sequelize.STRING, allowNull: false  }, 
      phone: { type: Sequelize.STRING, allowNull: false  },

      imageSource: { type: Sequelize.STRING, allowNull: true },

      // User role: 0 - standard, 1 - admin
      role: { type: Sequelize.INTEGER, allowNull: false },

      apiKey: { type: Sequelize.STRING, allowNull: false },

      createdAt: { allowNull: false, type: Sequelize.DATE, defaultValue: Sequelize.fn('now') },
      updatedAt: { allowNull: false, type: Sequelize.DATE, defaultValue: Sequelize.fn('now') }
    })
  },

  down: async (queryInterface, Sequelize) => {
    await queryInterface.dropTable('Users')
  }
};
