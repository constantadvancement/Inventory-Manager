'use strict'

const locationService = require('../services/location.server.service')

/**
 * Registers a new device's current location at the time of setup
 */
exports.registerLocationInfo = async function(req, res) {
    const body = req.body
    const opts = {
        info: body
    }
    locationService.registerLocationInfo(opts, (err, result) => {
        if(err) return res.status(500).send(err)
        res.status(200).send(result)
    })
}