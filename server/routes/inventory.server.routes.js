'use strict'

const controller = require('../controllers/inventory.server.controller')

// Security middleware 
const apiKeyAuth = require('../security/apiKeyAuth')
const adminAuth = require('../security/adminAuth')

module.exports = (app) => {
    // iOS app routes
    app.get('/:apiKey/inventory', apiKeyAuth, controller.getInventory)
    app.post('/:apiKey/unregister/device/:serialNumber', apiKeyAuth, adminAuth, controller.unregisterDevice)

    // macOS app routes
    app.get('/:apiKey/verification', apiKeyAuth, controller.verifyApiKey)
    app.post('/:apiKey/register/device', apiKeyAuth, controller.registerDevice)
    app.post('/update/:serialNumber/location', controller.updateLocation)
}