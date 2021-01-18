'use strict'

// Models
const models = require('../models')

/**
 * Called on local login success. Returns the authenticated user.
 */
exports.loginSuccess = async function(opts, callback) {
    if(!opts.email) return callback('Requires \'info\' as an opts parameter')

    try {
        // Finds the authenticated user that this email belongs to
        const user = await models.User.findOne({
            where: { email: opts.email },
            attributes: ['id', 'email', 'role', 'apiKey']
        })

        if(user) {
            return callback(null, user)
        } else {
            throw Error('No such user found.')
        }
    } catch (err) {
        callback(err, null)
    }
}