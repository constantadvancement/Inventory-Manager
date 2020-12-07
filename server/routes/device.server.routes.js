'use strict'

const device = require('../controllers/device.server.controller')

module.exports = (app) => {
    app.post('/register/device', device.registerDevice)
}