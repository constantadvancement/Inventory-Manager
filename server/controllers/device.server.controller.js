'use strict'

const deviceService = require('../services/device.server.service')

/**
 * Registers a new CA device. Saving this device's system information, location information, 
 * and "holder" (the owner) to the database.
 * 
 * Devices are uniquely identified by their serial number. 
 * 
 * Returns true on success; otherwise status 500 along with the error is returned on any failure.
 */
exports.registerDevice = async function(req, res) {
    const info = req.body
    const opts = {
        info: info
    }
    deviceService.registerDevice(opts, (err, result) => {
        if(err) return res.status(500).send(err)
        res.status(200).send(result)
    })
}