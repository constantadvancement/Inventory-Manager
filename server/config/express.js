'use strict'

const express = require('express')
const bodyParser = require('body-parser')

const passport = require('passport')
const initializePassport = require('../security/passport')
initializePassport(passport)

// Server Configuration
module.exports = () => {
    const app = express()

    // Helps parse requests
    app.use(bodyParser.json())
    app.use(bodyParser.urlencoded({extended: true}))

    // Passport authentication
    app.use(passport.initialize())
    // app.use(passport.session())

    // Routes
    require('../routes/status.server.routes') (app)
    require('../routes/inventory.server.routes') (app)
    require('../routes/user.server.routes') (app)

    return app
}