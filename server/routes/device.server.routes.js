'use strict'

const device = require('../controllers/device.server.controller')

module.exports = (app) => {
    // app.post() TODO

    // TODO get will probably require an admin key (but anyone can post)
    app.post('/device/:deviceId/info', device.getDeviceInfo)
}