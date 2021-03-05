'use strict'
 
// Models
const models = require('../models')

/**
 * Verifies that the provided user (specified by api key) is an admin
 */
module.exports = async function(req, res, next) {
    const apiKey = req.params.apiKey

    try {
        // Finds a user that this unique api key belongs to
        const user = await models.User.findOne({
            where: { apiKey: apiKey }
        })
        if(user === null) {
            // Error; no such api key found
            return res.status(401).json({ msg: 'Unauthorized -- invalid api key' })
        } else if(user.role !== 1) {
            // Error; user is not an admin
            return res.status(401).json({ msg: 'Unauthorized -- admin permission required' })
        } else {
            next()
        }
    } catch (err) {
        res.status(500).send(err)
    }
}