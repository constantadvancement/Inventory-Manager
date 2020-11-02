'use strict'

const express = require('express')
const bodyParser = require('body-parser');

// server configuration
module.exports = () => {
    const app = express()

    // parses requests and puts them into a nice object
    app.use(bodyParser.json())
    app.use(bodyParser.urlencoded({extended: true}))

    // routes
    require('../routes/device.server.routes') (app)

    return app
}