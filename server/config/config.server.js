require('dotenv').config()

/**
 * Server configuration file
 */

module.exports = {
  port: 3000,
  mysqlInfo : {
    host: process.env.DB_HOST,
    username: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
    options : {
      host : process.env.DB_HOST,
      dialect : 'mysql',
      logging: false,
    }
  }
}