'use strict'

// Models
const models = require('../models')

/**
 *  Updates the specified user (by API Key) indicating that they have a user image.
 */
exports.addUserImage = async function(opts, callback) {
    if(!opts.apiKey) return callback('Requires \'apiKey\' as an opts parameter')
    if(opts.hasImage == null) return callback('Requires \'hasImage\' as an opts parameter')

    try {
        // Finds the user that this apiKey belongs to
        const user = await models.User.findOne({
            where: { apiKey: opts.apiKey }
        })

        if(user) {
            // Updates this user's image status
            await user.update({ hasImage: opts.hasImage })

            callback(null, true)
        } else {
            callback(null, false)
        }
    } catch (err) {
        console.log(err)
        callback(err, null)
    }
}

/**
 * Called on local login success. Returns the authenticated user.
 */
exports.loginSuccess = async function(opts, callback) {
    if(!opts.email) return callback('Requires \'email\' as an opts parameter')

    try {
        // Finds the authenticated user that this email belongs to
        const user = await models.User.findOne({
            where: { email: opts.email },
            attributes: ['id', 'email', 'hasImage', 'role', 'apiKey'],
            nest: true, raw: true
        })

        if(user) {
            user.hasImage === 0 ? user.hasImage = false : user.hasImage = true

            callback(null, user)
        } else {
            throw Error('No such user found.')
        }
    } catch (err) {
        callback(err, null)
    }
}