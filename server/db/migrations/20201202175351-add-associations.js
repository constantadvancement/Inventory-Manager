'use strict'

module.exports = {
  up: async (queryInterface, Sequelize) => {
    // Creates the relation between Holders and Devices
    await queryInterface.addColumn(
      'Holders',
      'deviceSerialNumber',
      {
        type: Sequelize.STRING(32),
        references: {
          model: 'Devices',
          key: 'serialNumber',
        },
        allowNull: false,
        onUpdate: 'CASCADE',
        onDelete: 'CASCADE',
      }
    )

    // Creates the relation between Locations and Devices
    await queryInterface.addColumn(
      'Locations',
      'deviceSerialNumber',
      {
        type: Sequelize.STRING(32),
        references: {
          model: 'Devices',
          key: 'serialNumber',
        },
        allowNull: false,
        onUpdate: 'CASCADE',
        onDelete: 'CASCADE',
      }
    )
  },

  down: async (queryInterface, Sequelize) => {
    // Removes the relation between Holders and Devices
    await queryInterface.removeColumn(
      'Holders',
      'deviceSerialNumber'
    )

    // Removes the relation between Locations and Devices
    await queryInterface.removeColumn(
      'Locations',
      'deviceSerialNumber'
    )
  }
}
