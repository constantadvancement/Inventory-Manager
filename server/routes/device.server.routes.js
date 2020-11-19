'use strict'

const device = require('../controllers/device.server.controller')

module.exports = (app) => {
    // TODO get will probably require an admin key to GET (but anyone can post)
    
    app.post('/register/device/info', device.registerDeviceInfo)

    app.post('/ping', device.ping)
}