'use strict'
 
// Models
const models = require('../models')

/**
 * Verifies that the provided device uuid belongs to a trusted device uuid for some user.
 */
module.exports = async function(req, res, next) {
    const deviceUuid = req.body.deviceUuid

    try {
        console.log("Authorizing local user login request (via Face ID)...")

        // Finds a user that trusts this device using faceID
        const user = await models.User.findOne({
            where: { trustedDeviceUuid: deviceUuid }
        })
        if(user === null) {
            // Error; no such trusted device found
            return res.status(401).json({ msg: 'Unauthorized -- untrusted device uuid' })
        } else {
            res.locals.email = user.email
            next()
        }
    } catch (err) {
        res.status(500).send(err)
    }
}