'use strict'

const location = require('../controllers/location.server.controller')

module.exports = (app) => {
    // TODO get will probably require an admin key to GET (but anyone can post)
    
    app.post('/register/device/location', location.registerLocationInfo)
}