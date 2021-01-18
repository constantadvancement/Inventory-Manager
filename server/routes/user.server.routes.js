'use strict'

const passport = require('passport')

const userController = require('../controllers/user.server.controller')

module.exports = (app) => {
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