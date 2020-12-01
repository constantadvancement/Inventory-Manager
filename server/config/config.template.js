/**
 * Server configuration file
 */

module.exports = {
    port: 3000,
    mysqlInfo : {
        host: 'localhost',
        username: 'root',
        password: '*****',
        database: 'CAInventoryManager',
        options : {
          host : 'localhost',
          dialect : 'mysql',
          logging: false,
        }
      }
}