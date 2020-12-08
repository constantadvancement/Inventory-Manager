'use strict'

const express = require('express')
const bodyParser = require('body-parser');

// Server Configuration
module.exports = () => {
    const app = express()

    // Helps parse requests
    app.use(bodyParser.json())
    app.use(bodyParser.urlencoded({extended: true}))

    // Routes
    require('../routes/status.server.routes') (app)
    require('../routes/device.server.routes') (app)
    require('../routes/location.server.routes') (app)

    return app
}