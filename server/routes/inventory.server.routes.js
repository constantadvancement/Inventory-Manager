'use strict'

const inventoryController = require('../controllers/inventory.server.controller')

// Security middleware 
const apiKeyAuth = require('../security/apiKeyAuth')
const adminAuth = require('../security/adminAuth')

module.exports = (app) => {
    // iOS app routes
    app.get('/:apiKey/inventory', apiKeyAuth, inventoryController.getInventory)
    app.post('/:apiKey/unregister/device/:serialNumber', apiKeyAuth, adminAuth, inventoryController.unregisterDevice)

    // macOS app routes
    app.post('/register/device', inventoryController.registerDevice) // TODO should require api key
    app.post('/update/:serialNumber/location', inventoryController.updateLocation)
}