'use strict'

const inventoryController = require('../controllers/inventory.server.controller')

module.exports = (app) => {
    // iOS app routes
    app.get('/inventory', inventoryController.getInventory) // TODO will use api key
    // app.post('/unregister/device/:serialNumber')

    // macOS app routes
    app.post('/register/device', inventoryController.registerDevice) // TODO will use api key
    app.post('/update/:serialNumber/location', inventoryController.updateLocation)
}