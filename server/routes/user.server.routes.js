'use strict'

const path = require('path')
const passport = require('passport')

const userController = require('../controllers/user.server.controller')

// Security middleware 
const apiKeyAuth = require('../security/apiKeyAuth')
const adminAuth = require('../security/adminAuth')

// Multer middleware (image upload)
const multer = require('multer')
const storage = multer.diskStorage({
    destination: function (req, file, cb) {
        cb(null, path.join(__dirname, '../public/userImages'))
    },
    filename: function (req, file, cb) {
        cb(null, file.originalname)
    }
})
const upload = multer({ storage: storage })

module.exports = (app) => {
    // app.post('/register/user')
    // app.post('/user/apiKey/reset')

    // User account management
    app.post('/:apiKey/user/password/change', apiKeyAuth, userController.changePassword)
    app.post('/:apiKey/user/account/edit', apiKeyAuth, userController.editAccount)
    app.post('/:apiKey/user/image/set', apiKeyAuth, upload.single('userImage'), userController.setUserImage) 

    // Password reset (forgot password)
    // TODO

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