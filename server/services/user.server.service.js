'use strict'

const fs = require('fs')
const path = require('path')
const bcrypt = require('bcryptjs')
const moment = require('moment')

// Models
const models = require('../models')

// Local Authentication

/**
 * Called on local login success. Returns the authenticated user.
 */
exports.loginSuccess = async function(opts, callback) {
    if(!opts.email) return callback('Requires \'email\' as an opts parameter')

    try {
        // Finds the authenticated user that this email belongs to
        const user = await models.User.findOne({
            where: { email: opts.email },
            attributes: { exclude: ['createdAt', 'updatedAt'] },
            nest: true, raw: true
        })

        if(user) {
            if(user.imageSource) {
                // Return user; include image
                user.imageData = fs.readFileSync(path.join(__dirname, '../public/userImages/', user.imageSource), 'base64')
                delete user.imageSource
                callback(null, user)
            } else {
                // Return user; exclude image (none exist)
                user.imageData = null
                delete user.imageSource
                callback(null, user)
            }
        } else {
            throw Error('No such user found.')
        }
    } catch (err) {
        console.log(err)
        callback(err, null)
    }
}

// User Account Management

/**
 * Changes the specified user's (by API key) password. The provided current password
 * must match this user's existing password in order to exit successfully.
 */
exports.changePassword = async function(opts, callback) {
    if(!opts.apiKey) return callback('Requires \'apiKey\' as an opts parameter')
    if(!opts.currentPassword) return callback('Requires \'currentPassword\' as an opts parameter')
    if(!opts.newPassword) return callback('Requires \'newPassword\' as an opts parameter')

    try {
        // Gets the specified user
        const user = await models.User.findOne({
            where: { apiKey: opts.apiKey }
        })

        // Verifies this user's current password
        if(await bcrypt.compare(opts.currentPassword, user.password)) {
            // Valid password; success
            await user.update({
                password: bcrypt.hashSync(opts.newPassword, 10),
            })
            
            callback(null, true)
        } else {
            // Invalid password; failure
            callback(null, false)
        }
    } catch (err) {
        callback(err, null)
    }
}

/**
 * Edits the specified user's (by API key) account information. This can include their
 * name, email, and/or phone number. 
 */
exports.editAccount = async function(opts, callback) {
    if(!opts.apiKey) return callback('Requires \'apiKey\' as an opts parameter')
    if(!opts.edit) return callback('Requires \'edit\' as an opts parameter')

    console.log('Editting account...')

    try {
        // Determines which attributes should be updated
        const name = opts.edit.name ? opts.edit.name : null
        const email = opts.edit.email ? opts.edit.email : null
        const phone = opts.edit.phone ? opts.edit.phone : null

        // Gets the specified user
        const user = await models.User.findOne({
            where: { apiKey: opts.apiKey }
        })

        // Edit fields
        const edit = {
            name: name,
            email: email,
            phone: phone
        }

        // Removes null/undefined edit fields
        if(name == null) delete edit.name
        if(email == null) delete edit.email
        if(phone == null) delete edit.phone

        // Update this user with all non-null edit fields
        await user.update(edit)

        callback(null, true)
    } catch (err) {
        callback(err, null)
    }
}

/**
 *  Updates the specified user's (by API Key) image source name.
 */
exports.setUserImage = async function(opts, callback) {
    if(!opts.apiKey) return callback('Requires \'apiKey\' as an opts parameter')
    if(!opts.file) return callback('Requires \'file\' as an opts parameter')

    try {
        // Finds the user that this apiKey belongs to
        const user = await models.User.findOne({
            where: { apiKey: opts.apiKey }
        })

        // Updates this user's image source name
        await user.update({ 
            imageSource: user.apiKey + '.png'
        })

        callback(null, true)
    } catch (err) {
        console.log(err)
        callback(err, null)
    }
}

// Password Reset (Forgot Password)

/**
 * Sends a password reset token (OTP) to the provided media source (email or phone). The provided media
 * source must belong to a user AND (TODO) must be a verified source.
 */
exports.sendPasswordResetToken = async function(opts, callback) {
    if(!opts.media) return callback('Requires \'reset\' as an opts parameter')

    try {
        const phone = opts.media.phone
        const email = opts.media.email

        if(phone) {
            // Send password token via phone
            const OTP = await generatePasswordResetOTP()

            // TODO send token via phone




            callback(null, true)
        } else if(email) {
            // Send password token via email
            const OTP = await generatePasswordResetOTP()

            // TODO send token via email




            callback(null, true)
        } else {
            throw new Error('Invalid media type.')
        }
    } catch (err) {
        console.log(err)
        callback(err, null)
    }
}

exports.verifyPasswordResetToken = async function(opts, callback) {

}

// Helper Functions

/**
 * Generates a new password reset token (OTP)
 */
async function generatePasswordResetOTP() {
    try {
        // Gets all existing password tokens
        const tokens = await models.PasswordResetToken.findAll({
            nest: true, raw: true
        })

        let unique = false, OTP
        while(!unique) {
            // Generates a new OTP
            OTP = Math.floor(100000 + Math.random() * 900000)

            // Checks OTP for uniqueness
            for(const [index, token] of tokens.entries()) {
                if(Number(token.OTP) === Number(OTP)) break
                if(index === tokens.length) unique = true
            }
        }

        return OTP
    } catch (err) {
        return null
    }

}