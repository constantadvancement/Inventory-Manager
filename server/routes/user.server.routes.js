'use strict'

const path = require('path')
const passport = require('passport')

const userController = require('../controllers/user.server.controller')

// Security middleware 
const apiKeyAuth = require('../security/apiKeyAuth')
const adminAuth = require('../security/adminAuth')
const faceIDAuth = require('../security/faceIDAuth')

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

    // Authentication
    app.post('/local/user/login', (req, res, next) => {
        const email = req.body.email
        const deviceUuid = req.body.deviceUuid
        passport.authenticate('local', { 
            successRedirect: deviceUuid == null ? '/local/user/login/' + email + '/success/' : '/local/user/login/' + email + '/success/' + deviceUuid,
            failureRedirect: '/local/user/login/failure'
        }) (req, res, next)
    })
    app.post('/local/user/login/faceId', faceIDAuth, (req, res, next) => {
        const email = res.locals.email
        res.status(200).redirect('/local/user/login/' + email + '/success')
    })
    app.get('/local/user/login/:email/success', userController.localLoginSuccess)
    app.get('/local/user/login/:email/success/:deviceUuid', userController.newDeviceLocalLoginSuccess)
    app.get('/local/user/login/failure', userController.localLoginFailure) 
}