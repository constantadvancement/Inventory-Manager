'use strict'

const locationService = require('../services/location.server.service')

/**
 * Updates the specified device's location. This includes its address, coordinates, 
 * location permission status, and a timestamp. 
 * 
 * Returns true on success; otherwise status 500 along with the error is returned on any failure.
 */
exports.updateLocation = async function(req, res) {
    const serialNumber = req.params.serialNumber
    const info = req.body
    const opts = {
        serialNumber: serialNumber,
        info: info
    }
    locationService.updateLocation(opts, (err, result) => {
        if(err) return res.status(500).send(err)
        res.status(200).send(result)
    })
}