'use strict'

const userService = require('../services/user.server.service')

/**
 * Updates the specified user (by API Key) indicating that they have a user image.
 */
exports.addUserImage = async function(req, res) {
    const apiKey = req.params.apiKey
    const opts = {
        apiKey: apiKey,
        hasImage: true
    }
    userService.addUserImage(opts, (err, result) => {
        if(err) return res.status(500).send(err)
        res.status(200).send(result)
    })
}

/**
 * Called on local login success. Returns the authenticated user.
 */
exports.localLoginSuccess = async function(req, res) {
    const email = req.params.email
    const opts = {
        email: email
    }
    userService.loginSuccess(opts, (err, user) => {
        if(err) return res.status(500).send(err)
        res.status(200).send(user)
    })
}

/**
 * Called on local login failure. Returns false.
 */
exports.localLoginFailure = async function(req, res) {
    res.status(200).send(false)
}