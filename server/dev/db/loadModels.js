'use strict'

const db = require('../../models')

module.exports = async () => {
    console.log('----- Creating database models -----')
    await db.sequelize.sync({ alter: true })
    console.log('Sync\'d Sequelize DB\n')
}