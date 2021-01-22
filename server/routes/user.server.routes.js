'use strict'

const passport = require('passport')

const userController = require('../controllers/user.server.controller')

// Security middleware 
const apiKeyAuth = require('../security/apiKeyAuth')
const adminAuth = require('../security/adminAuth')

module.exports = (app) => {
    // app.post('/register/user')
    // app.post('/user/apiKey/reset')

    app.post('/:apiKey/user/image/add', apiKeyAuth, userController.addUserImage)
    // TODO remove user/image

    // Local authentication
    app.post('/local/user/login', (req, res, next) => {
        const email = req.body.email
        passport.authenticate('local', { 
            successRedirect: '/local/user/login/' + email + '/success',
            failureRedirect: '/local/user/login/failure'
        }) (req, res, next)
    })
    app.get('/local/user/login/:email/success', userController.localLoginSuccess)
    app.get('/local/user/login/failure', userController.localLoginFailure) 
}