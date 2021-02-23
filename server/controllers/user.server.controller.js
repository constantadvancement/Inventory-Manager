'use strict'

const userService = require('../services/user.server.service')

// Local Authentication

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

// User Account Management

/**
 * Changes the specified user's (by API key) password. The provided current password
 * must match this user's existing password in order to exit successfully.
 */
exports.changePassword = async function(req, res) {
    const apiKey = req.params.apiKey
    const currentPassword = req.body.currentPassword
    const newPassword = req.body.newPassword
    const opts = {
        apiKey: apiKey,
        currentPassword: currentPassword,
        newPassword: newPassword
    } 
    userService.changePassword(opts, (err, result) => {
        if(err) return res.status(500).send(err)
        res.status(200).send(result)
    })
}

/**
 * Edits the specified user's (by API key) account information. This can include their
 * name, email, and/or phone number. 
 */
exports.editAccount = async function(req, res) {
    const apiKey = req.params.apiKey
    const edit = req.body
    const opts = {
        apiKey: apiKey,
        edit: edit
    } 
    userService.editAccount(opts, (err, result) => {
        if(err) return res.status(500).send(err)
        res.status(200).send(result)
    }) 
}

/**
 * Sets the specified user's (by API key) profile image.
 */
exports.setUserImage = async function(req, res) {
    const apiKey = req.params.apiKey
    const file = req.file
    const opts = {
        apiKey: apiKey,
        file: file
    }
    userService.setUserImage(opts, (err, result) => {
        if(err) return res.status(500).send(err)
        res.status(200).send(result)
    })
}

// User Account Security

// TODO -- submitEmailVerification / processEmailVerification, submitPhoneVerification / processPhoneVerification



// Forgot Password

/**
 * Sends a password reset token (OTP) to the provided media source (email or phone). The provided media
 * source must belong to a user AND must be a verified source.
 */
exports.sendPasswordResetToken = async function(req, res) {
    const media = req.params.media
    const opts = {
        media: media
    }
    userService.sendPasswordResetToken(opts, (err, result) => {
        if(err) return res.status(500).send(err)
        res.status(200).send(result)
    })
}
