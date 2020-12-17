'use strict'

const location = require('../controllers/location.server.controller')

module.exports = (app) => {
    app.post('/update/:serialNumber/location', location.updateLocation)

    // app.get('/location/history/:serialNumber', location.getLocationHistory)
}