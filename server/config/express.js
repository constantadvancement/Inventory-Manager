'use strict'

const express = require('express')
const bodyParser = require('body-parser')

// const multer = require('multer')
// const upload = multer()

const passport = require('passport')
const initializePassport = require('../security/passport')
initializePassport(passport)

// Server Configuration
module.exports = () => {
    const app = express()

    // Helps parse requests
    app.use(bodyParser.json({ limit: '50mb' }))
    app.use(bodyParser.urlencoded({ limit: '50mb', extended: false }))

    // for parsing multipart/form-data
    // app.use(upload.array())
    // app.use(express.static('public'));


    // Passport authentication
    app.use(passport.initialize())

    // Routes
    require('../routes/status.server.routes') (app)
    require('../routes/inventory.server.routes') (app)
    require('../routes/user.server.routes') (app)

    return app
}